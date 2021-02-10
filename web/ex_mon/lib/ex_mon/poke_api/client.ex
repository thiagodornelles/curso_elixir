defmodule ExMon.PokeAPI.Client do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://pokeapi.co/api/v2"
  plug Tesla.Middleware.JSON

  def get_pokemon(name) do
    "/pokemon/#{name}"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Tesla.Env{status: 200, body: body}}), do: {:ok, body}
  defp handle_get({:ok, %Tesla.Env{status: 404}}), do: {:error, %{message: "Pokémon not found.", status: 404}}
  defp handle_get({:ok, %Tesla.Env{status: 400}}), do: {:error, %{message: "Bad request", status: 400}}
  defp handle_get({:error, reason}), do: reason
end
