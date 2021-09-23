require_relative "view/ruby2d"
require_relative "model/state"
require_relative "action/actions"

class App
    def initialize
        @initial_state = Model.initial_state
    end

    def start
        @view = View::Ruby2dView.new(self)
        timer_thread = Thread.new{init_timer}
        @view.start(@initial_state)
        #timer_thread.join
    end
    def init_timer
        loop do
            if @initial_state.game_finished
                puts "Juego finalizado"
                puts "Puntaje: #{ @initial_state.snake.positions.length }"
                @view.end_game(true)
            end 
            @initial_state = Actions.move_snake(@initial_state)
            @view.render_game(@initial_state)
            sleep 0.5
        end
    end

    def send_action(action, params)
        new_state = Actions.send( action, @initial_state, params )
        if new_state.hash != @initial_state
            @initial_state = new_state
            @view.render_game(@initial_state)
        end
    end
    
end

app = App.new
app.start