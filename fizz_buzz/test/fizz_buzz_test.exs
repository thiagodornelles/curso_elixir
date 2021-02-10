defmodule FizzBuzzTest do
  use ExUnit.Case

  describe "build/1" do
    test "when a valid file is provided, returns the converted list" do
      expected = {:ok, [1, 2, :fizz, 4, :buzz, :buzz, :fizzbuzz, :buzz, :fizzbuzz, :fizzbuzz]}
      assert FizzBuzz.build("numbers.txt") == expected
    end

    test "when an invalid file is provided, returns the converted list" do
      expected = {:error, "Error reading file: enoent"}
      assert FizzBuzz.build("invalid.txt") == expected

      # IN THE CASE OF CHECKING ONLY FILE READING STATUS
      # {status, _} = FizzBuzz.build("invalid.txt")
      # assert status == :error
    end
  end
end
