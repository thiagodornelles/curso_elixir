defmodule ExMon.TrainerTest do
  use ExMon.DataCase
  alias ExMon.Trainer

  describe "changeset/1" do
    test "When all params are valid, returns a valid changeset" do
      params = %{name: "Thiago", password: "abc123"}
      response = Trainer.changeset(params)

      assert %Ecto.Changeset{
               changes: %{
                 name: "Thiago",
                 password: "abc123"
               },
               errors: [],
               data: %ExMon.Trainer{},
               valid?: true
             } = response
    end

    test "When there are invalid params, returns an invalid changeset" do
      params = %{name: "Thiago", password: "abc"}
      response = Trainer.changeset(params)

      assert %Ecto.Changeset{
               valid?: false
             } = response

      assert errors_on(response) == %{password: ["should be at least 6 character(s)"]}
    end
  end

  describe "build/1" do
    test "When all params are valid, returns a Trainer struct" do
      params = %{name: "Thiago", password: "abc123"}
      response = ExMon.Trainer.build(params)

      assert {:ok, %ExMon.Trainer{name: "Thiago", password: "abc123"}} = response
    end

    test "When there are params invalid, returns a error" do
      params = %{name: "Thiago", password: "abc"}
      {:error, response} = ExMon.Trainer.build(params)

      assert %Ecto.Changeset{valid?: false} = response
      assert errors_on(response) == %{password: ["should be at least 6 character(s)"]}
    end
  end
end
