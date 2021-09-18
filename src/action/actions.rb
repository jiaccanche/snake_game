require_relative "../model/state"

module Actions
    def self.move_snake(state)
        next_direction = state.next_direction
        next_position = calc_next_position(state)

        if next_position_is_valid?(state, next_position)
            move_snake_to( state, next_position )
        else
            end_game(state)
        end
    end  
        
    private

    def self.calc_next_position(state)
            current_positions = state.snake.positions.first
            puts current_positions
            case state.next_direction
            when Model::Direction::UP
              return new_position = Model::Coord.new(
                  current_positions.row-1,
                  current_positions.col
              )
            when Model::Direction::RIGHT
              return new_position = Model::Coord.new(
                    current_positions.row,
                    current_positions.col+1
                )
            when Model::Direction::LEFT
              return new_position = Model::Coord.new(
                    current_positions.row,
                    current_positions.col-1
                )
            when Model::Direction::DOWN
              return new_position = Model::Coord.new(
                    current_positions.row+1,
                    current_positions.col
                )
            end
    end

    def self.next_position_is_valid?(state, position)
        # verificar q este en la grilla
      is_invalid = ((position.row >= state.grid.rows ||
        position.row < 0) || 
        (position.col >= state.grid.cols ||
        position.col < 0))
      return false if is_invalid
      # verificar q no este superponiendo a la serpiente
      return !(state.snake.positions.include? position)
    end

    def self.move_snake_to(state, next_position)
            state.snake.positions
            new_positions = [next_position] + state.snake.positions[0...-1]
            state.snake.positions = new_positions
            state
    end
    def self.end_game(state)
            state.game = true
            state
    end
end