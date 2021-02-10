defmodule FizzBuzz do
  def hello() do
    :world
  end

  def build(file_name) do
    # case File.read(file_name) do
    #   {:ok, result} -> result
    #   {:error, reason} -> reason
    # end
    file_name
    |> File.read()
    |> handle_file_read()
  end

  defp convert_and_evaluate_number(element) do
    element
    |> String.to_integer()
    |> evaluate_number()

    # if rem(number, 3) == 0 do
    #   :fizz
    # else if rem(number, 5) == 0
    #   :buzz
    # ...
    # end
  end

  # GUARDS
  defp evaluate_number(number) when rem(number, 3) == 0 and rem(number, 5) == 0, do: :fizzbuzz
  defp evaluate_number(number) when rem(number, 3) == 0, do: :fizz
  defp evaluate_number(number) when rem(number, 5) == 0, do: :buzz
  defp evaluate_number(number), do: number

  defp handle_file_read({:ok, result}) do
    result =
      result
      |> String.split(",")
      # |> Enum.map(fn number -> String.to_integer(number) end)
      |> Enum.map(&convert_and_evaluate_number/1)

    {:ok, result}
  end

  defp handle_file_read({:error, reason}), do: {:error, "Error reading file: #{reason}"}
end
