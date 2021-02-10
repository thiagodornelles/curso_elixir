defmodule ExMon.Game.Actions.Heal do
  alias ExMon.Game
  alias ExMon.Game.Status

  @heal_power 18..25

  def heal_life(player) do
    player
    |> Game.fetch_player()
    |> Map.get(:life)
    |> calculate_heal()
    |> set_life(player)
  end

  defp calculate_heal(life), do: Enum.random(@heal_power) + life

  defp set_life(total_life, player) when total_life > 100, do: update_player_life(player, 100)
  defp set_life(total_life, player), do: update_player_life(player, total_life)

  defp update_player_life(player, life) do
    player
    |> Game.fetch_player()
    |> Map.put(:life, life)
    |> update_game(player, life)
  end

  defp update_game(player_data, player, life) do
    Game.info()
    |> Map.put(player, player_data)
    |> Game.update()
    Status.print_heal_message(player, :heal, life)
  end
end
