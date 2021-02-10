defmodule ExMon.Trainer.Update do
  alias ExMon.{Repo, Trainer}
  alias Ecto.UUID

  def call(%{"id" => uuid} = params) do
    case UUID.cast(uuid) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, _uuid} -> update_trainer(params)
    end
  end

  defp update_trainer(%{"id" => uuid} = params) do
    case fetch_trainer(uuid) do
      nil -> {:error, "Trainer not found"}
      trainer -> update_changeset(trainer, params)
    end
  end

  defp update_changeset(trainer, params) do
    trainer
    |> Trainer.changeset(params)
    |> Repo.update()
  end

  defp fetch_trainer(uuid) do
    Repo.get(Trainer, uuid)
  end
end
