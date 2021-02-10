defmodule ExMon.Trainer.Pokemon.Delete do
  alias ExMon.{Repo, Trainer.Pokemon}
  alias Ecto.UUID

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> delete_pokemon(uuid)
    end
  end

  defp delete_pokemon(uuid) do
    case fetch_pokemon(uuid) do
      nil -> {:error, %{message: "Pokemon not found", status: 404}}
      pokemon -> Repo.delete(pokemon)
    end
  end

  defp fetch_pokemon(uuid) do
    Repo.get(Pokemon, uuid)
  end
end
