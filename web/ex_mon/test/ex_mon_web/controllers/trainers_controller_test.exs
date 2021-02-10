defmodule ExMonWeb.Controllers.TrainersControllerTest do
  use ExMonWeb.ConnCase
  import ExMonWeb.Auth.Guardian

  alias ExMon.Trainer

  describe "show/2" do

    #Setting up the authentication bearer of the new Trainer into the connection
    setup %{conn: conn} do
      params = %{name: "teste", password: "123456"}
      {:ok, trainer} = ExMon.create_trainer(params)
      {:ok, token, _claims} = encode_and_sign(trainer)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")
      {:ok, conn: conn}
    end

    test "when there is a trainer with the given id, returns the trainer", %{conn: conn} do
      params = %{name: "teste", password: "123456"}

      {:ok, %Trainer{id: id}} = ExMon.create_trainer(params)

      response =
        conn
        |> get(Routes.trainers_path(conn, :show, id))
        |> json_response(:ok)

      assert %{"id" => _id, "inserted_at" => _inserted_at, "name" => "teste"} = response
    end

    test "when there is an error, returns the error", %{conn: conn} do
      response =
        conn
        |> get(Routes.trainers_path(conn, :show, "12345"))
        |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid ID format!"}
      assert response == expected_response
    end
  end
end