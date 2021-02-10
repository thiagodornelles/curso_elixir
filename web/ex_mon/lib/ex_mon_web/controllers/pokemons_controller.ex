defmodule ExMonWeb.PokemonsController do
  use ExMonWeb, :controller

  action_fallback ExMonWeb.FallbackController

  def show(conn, %{"name" => name}) do
    name
    |> ExMon.fetch_pokemon()
    |> handle_response(conn)
  end

  defp handle_response({:ok, pokemon}, conn) do
    conn
    |> put_status(:ok)
    # Needs to add @derive Jason.Encoder in Pokemon Struct
    |> json(pokemon)
  end

  defp handle_response({:error, _reason} = error, _conn), do: error
end
