defmodule ExMonTest do
  use ExUnit.Case
  alias ExMon.Player

  import ExUnit.CaptureIO

  describe "create_player/4" do
    test "returns a player" do
      expected_player = %Player{
        life: 100,
        moves: %{move_avg: :thunder_shock, move_heal: :heal, move_rnd: :thunder},
        name: "Pikachu"
      }

      player = ExMon.create_player("Pikachu", :thunder_shock, :heal, :thunder)
      assert player === expected_player
    end
  end

  describe "start game/1" do
    test "when the game is started, returns a message" do
      player = Player.build("Pikachu", :thunder_shock, :heal, :thunder)

      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      assert messages =~ "The game has started"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("Pikachu", :thunder_shock, :heal, :thunder)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      # Needs to return :ok to the test routines
      # Is possible to send data to the tests, returning a tuple as follows:
      # {:ok, some_data: data2, another_data: data2, ...}
      :ok
    end

    test "do the move and the computer makes its move" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:thunder_shock)
        end)

      assert messages =~ "The Player inflicted"
      assert messages =~ "It's computer turn"
      assert messages =~ "It's player turn"
      assert messages =~ "status: :continue"
    end

    test "do an invalid the move" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:invalid_move)
        end)

      assert messages =~ "Invalid move:"
    end

    test "try to make a move when the game is over" do
      old_state = ExMon.Game.info()
      player = %{old_state[:player] | life: 0}
      # IO.inspect(player)
      new_state = %{old_state | player: player}

      ExMon.Game.update(new_state)

      messages =
        capture_io(fn ->
          ExMon.make_move(:thunder_shock)
        end)

      assert messages =~ "Game Over"
    end
  end
end
