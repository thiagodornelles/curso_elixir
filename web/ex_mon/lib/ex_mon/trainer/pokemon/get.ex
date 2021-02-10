defmodule ExMon.Trainer.Pokemon.Get do
  alias ExMon.{Repo, Trainer.Pokemon}
  alias Ecto.UUID

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> get_trainer_pokemon(uuid)
    end
  end

  defp get_trainer_pokemon(uuid) do
    case Repo.get(Pokemon, uuid) do
      nil -> {:error, %{message: "Pokemon not found", status: 404}}
      pokemon -> trainer_preload(pokemon)
    end
  end

  defp trainer_preload(pokemon) do
    IO.inspect(pokemon)
    {:ok, Repo.preload(pokemon, :trainer)}
  end
end
