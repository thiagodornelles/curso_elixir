defmodule ExMon.Trainer.Pokemon.Update do
  alias ExMon.{Repo, Trainer.Pokemon}
  alias Ecto.UUID

  def call(%{"id" => uuid} = params) do
    case UUID.cast(uuid) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, _uuid} -> update_pokemon(params)
    end
  end

  defp update_pokemon(%{"id" => uuid} = params) do
    case fetch_pokemon(uuid) do
      nil -> {:error, "Pokemon not found"}
      pokemon -> update_changeset(pokemon, params)
    end
  end

  defp update_changeset(pokemon, params) do
    pokemon
    |> Pokemon.update_changeset(params)
    |> Repo.update()
  end

  defp fetch_pokemon(uuid) do
    Repo.get(Pokemon, uuid)
  end
end
