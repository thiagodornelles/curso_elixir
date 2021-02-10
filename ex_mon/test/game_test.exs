defmodule ExMon.GameTest do
  use ExUnit.Case
  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Pikachu", :thunder_shock, :heal, :thunder)
      computer = Player.build("Bulbasaur", :vine_whip, :heal, :razor_leaf)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Pikachu", :thunder_shock, :heal, :thunder)
      computer = Player.build("Bulbasaur", :vine_whip, :heal, :razor_leaf)
      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :vine_whip, move_heal: :heal, move_rnd: :razor_leaf},
          name: "Bulbasaur"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :thunder_shock, move_heal: :heal, move_rnd: :thunder},
          name: "Pikachu"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "test the updated game state" do
      player = Player.build("Pikachu", :thunder_shock, :heal, :thunder)
      computer = Player.build("Bulbasaur", :vine_whip, :heal, :razor_leaf)
      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :vine_whip, move_heal: :heal, move_rnd: :razor_leaf},
          name: "Bulbasaur"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :thunder_shock, move_heal: :heal, move_rnd: :thunder},
          name: "Pikachu"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()

      new_state = %{
        computer: %Player{
          life: 80,
          moves: %{move_avg: :vine_whip, move_heal: :heal, move_rnd: :razor_leaf},
          name: "Bulbasaur"
        },
        player: %Player{
          life: 75,
          moves: %{move_avg: :thunder_shock, move_heal: :heal, move_rnd: :thunder},
          name: "Pikachu"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)
      expected_response = %{new_state | status: :continue, turn: :computer}
      assert expected_response == Game.info()
    end
  end
end
