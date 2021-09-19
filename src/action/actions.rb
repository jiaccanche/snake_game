require_relative "../model/state"

module Actions
    def self.move_snake(state)
        next_direction = state.current_direction
        next_position = calc_next_position(state)

        if next_position_is_valid?(state, next_position)
            move_snake_to( state, next_position )
        else
            end_game(state)
        end
    end
    def self.change_direction(state, direction)
      if next_direction_is_valid?(state, direction)
        state.current_direction = direction
      else
        puts "Invalid direction"
      end
      state
    end

    def send(action, state, params)
      
    end
    
        
    private

    def self.calc_next_position(state)
            current_positions = state.snake.positions.first
            #puts current_positions
            case state.current_direction
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

    def self.next_direction_is_valid?(state, direction)
      case state.current_direction
      when Model::Direction::UP
        return true if direction != Model::Direction::DOWN
      when Model::Direction::DOWN
        return true if direction != Model::Direction::UP
      when Model::Direction::RIGHT
        return true if direction != Model::Direction::LEFT
      when Model::Direction::LEFT
        return true if direction != Model::Direction::RIGHT
      end

    end
    
    def self.end_game(state)
            state.game = true
            state
    end
end