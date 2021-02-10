defmodule ExMonWeb.TrainersController do
  use ExMonWeb, :controller

  action_fallback ExMonWeb.FallbackController

  alias ExMonWeb.Auth.Guardian

  def create(conn, params) do
    with {:ok, trainer} <- ExMon.create_trainer(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(trainer) do
      conn
      |> put_status(:created)
      |> render("create.json", %{trainer: trainer, token: token})
    end
  end

  def sign_in(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", token: token)
    end
  end

  def delete(conn, %{"id" => id}) do
    id
    |> ExMon.delete_trainer()
    |> handle_delete_response(conn)
  end

  def show(conn, %{"id" => id}) do
    id
    |> ExMon.get_trainer()
    |> handle_response(conn, "show.json", :ok)
  end

  def update(conn, params) do
    params
    |> ExMon.update_trainer()
    |> handle_response(conn, "update.json", :ok)
  end

  defp handle_response({:ok, trainer}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, trainer: trainer)
  end

  defp handle_response({:error, _changeset} = error, _conn, _view, _status), do: error

  defp handle_delete_response({:ok, _trainer}, conn) do
    conn
    |> put_status(:no_content)
    |> text("")
  end

  defp handle_delete_response({:error, _reason} = error, _conn), do: error
end
