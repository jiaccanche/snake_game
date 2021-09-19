require_relative "view/ruby2d"
require_relative "model/state"
require_relative "action/actions"

class App
    def initialize
        @initial_state = Model.initial_state
    end

    def start
        view = View::Ruby2dView.new
        Thread.new{ init_timer(view) }
        view.start(@initial_state)
    end
    def init_timer(view)
        loop do
            @initial_state = Actions::move_snake(@initial_state)
            view.render_game(@initial_state)
            sleep 0.5
        end
    end
end

app = App.new
app.start