defmodule ExMon.Trainer.CreateTest do
  use ExMon.DataCase

  alias ExMon.{Repo, Trainer}
  alias Trainer.Create

  describe "call/1" do
    test "When all params are valid, creates a trainer" do
      params = %{name: "teste", password: "123456"}
      count_before = Repo.aggregate(Trainer, :count)
      response = Create.call(params)
      count_after = Repo.aggregate(Trainer, :count)

      assert {:ok, %Trainer{name: "teste"}} = response
      assert count_after == count_before + 1
    end

    test "When there are invalid params, return a error" do
      params = %{name: "teste"}

      response = Create.call(params)

      assert {:error, changeset} = response
      assert errors_on(changeset) == %{password: ["can't be blank"]}
    end
  end
end
