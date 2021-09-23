require 'ruby2d'

module View
  class Ruby2dView
    def initialize(app)
      @pixel_size = 50
      @app = app
    end

    def start(state)
      extend Ruby2D::DSL
      set(title: 'snake',
          width: @pixel_size * state.grid.cols,
          height: @pixel_size * state.grid.rows)
      on :key_down do |event|
        handle_key_event(event.key)
      end
      show
    end

    def end_game(flag)
      extend Ruby2D::DSL

      if flag
        close
        puts 'end game'
      end
    end

    def render_game(state)
      extend Ruby2D::DSL

      render_food(state)
      render_snake(state)
    end

    def render_food(state)
      @food.remove if @food
      extend Ruby2D::DSL
      food = state.food
      @food = Square.new(
        x: food.col * @pixel_size,
        y: food.row * @pixel_size,
        size: @pixel_size,
        color: 'yellow'
      )
    end

    def render_snake(state)
      @snake_positions.each(&:remove) if @snake_positions
      extend Ruby2D::DSL
      snake = state.snake
      # puts snake
      @snake_positions = snake.positions.map do |pos|
        Square.new(
          x: pos.col * @pixel_size,
          y: pos.row * @pixel_size,
          size: @pixel_size,
          color: 'green'
        )
      end
    end

    def handle_key_event(event)
      case event
      when 'up'
        @app.send_action(:change_direction, Model::Direction::UP)
      when 'left'
        @app.send_action(:change_direction, Model::Direction::LEFT)
      when 'right'
        @app.send_action(:change_direction, Model::Direction::RIGHT)
      when 'down'
        @app.send_action(:change_direction, Model::Direction::DOWN)
      end
    end
  end
end
