require "minitest/autorun"
require "minitest/mock"
require_relative "../src/model/state"
require_relative "../src/action/actions"

class ActionTest < Minitest::Test

    def setup
        @initial_state = Model::State.new(
            Model::Snake.new([
                Model::Coord.new(1,1),
                Model::Coord.new(0,1)
            ]),
            Model::Food.new(4, 4),
            Model::Grid.new(8, 12),
            Model::Direction::DOWN,
            false
        )
    end
    

    def test_move_snake
        expected_state = @initial_state = Model::State.new(
            Model::Snake.new([
                Model::Coord.new(2,1),
                Model::Coord.new(1,1)
            ]),
            Model::Food.new(4, 4),
            Model::Grid.new(8, 12),
            Model::Direction::DOWN,
            false
        )
        
        actual_state = Actions.move_snake(@initial_state)
        assert_equal actual_state, expected_state
    end

    def test_change_direction
        expected_state = Model::State.new(
            Model::Snake.new([
                Model::Coord.new(1,1),
                Model::Coord.new(0,1)
            ]),
            Model::Food.new(4, 4),
            Model::Grid.new(8, 12),
            Model::Direction::LEFT,
            false
        )
        actual_state = Actions.change_direction(@initial_state, Model::Direction::LEFT)
        assert_equal actual_state, expected_state
    end

    def test_grow_snake
        initial_state = Model::State.new(
            Model::Snake.new([
                Model::Coord.new(1,1),
                Model::Coord.new(0,1)
            ]),
            Model::Food.new(2, 1),
            Model::Grid.new(8, 12),
            Model::Direction::DOWN,
            false
        )
        expected_state = Model::State.new(
            Model::Snake.new([
                Model::Coord.new(2,1),
                Model::Coord.new(1,1),
                Model::Coord.new(0,1)
            ]),
            Model::Food.new(4, 4),
            Model::Grid.new(8, 12),
            Model::Direction::DOWN,
            false
        )
        actual_state = Actions.move_snake(initial_state)
        assert_equal actual_state.snake.positions, expected_state.snake.positions
    end

    def test_generate_food
        initial_state = Model::State.new(
            Model::Snake.new([
                Model::Coord.new(1,1),
                Model::Coord.new(0,1)
            ]),
            Model::Food.new(2, 1),
            Model::Grid.new(8, 12),
            Model::Direction::DOWN,
            false
        )
        expected_state = Model::State.new(
            Model::Snake.new([
                Model::Coord.new(2,1),
                Model::Coord.new(1,1),
                Model::Coord.new(0,1)
            ]),
            Model::Food.new(0, 0),
            Model::Grid.new(8, 12),
            Model::Direction::DOWN,
            false
        )
        Actions.stub(:rand, 0) do
          actual_state = Actions.move_snake(initial_state)
          assert_equal actual_state, expected_state
        end
        
    end
    
end