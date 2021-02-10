defmodule ExMonWeb.FallbackController do
  use ExMonWeb, :controller

  def call(conn, {:error, %{message: _message, status: status = result}}) do
    # IO.puts("Status fallback")
    conn
    |> put_status(status)
    |> put_view(ExMonWeb.ErrorView)
    |> render("400.json", result: result)
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(ExMonWeb.ErrorView)
    |> render("401.json", message: "Trainer unauthorized")
  end

  def call(conn, {:error, result}) do
    # IO.puts("Default fallback")
    conn
    |> put_status(:bad_request)
    |> put_view(ExMonWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
