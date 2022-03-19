#TODO
#Windows
#restart
#home
#highscore

WIDTH = 500
HEIGHT = 700
BACKGROUND = colorant"#afe9ed"

game_include("Bird.jl")
game_include("Pipes.jl")
game_include("game_functions.jl")
game_include("Ground.jl")
game_include("Trees.jl")
game_include("Clouds.jl")
game_include("button.jl")
game_include("screen_game.jl")
game_include("screen_home.jl")
game_include("screen_restart.jl")

colors = Dict([(:button, colorant"#c1d2e8"),
                (:border_color, colorant"#194278"),
                (:font_color, [7,30,61,255]),
                (:semipresscolor, colorant"#6a819e"),
                (:text,[40,124,130,255] )
                ])


screens = [:home, :game, :restart]
screen = :home


# HOME ACTORS ==================================================================
bird = Bird(50,200,"bird1.png", "bird2.png", move = false)

star_button_size = (200,70)
start_button = Button(WIDTH/2-star_button_size[1]/2,HEIGHT/2-star_button_size[2]/2, star_button_size[1],star_button_size[2],"Start", font_size = 60, color = colors[:button], border = true, border_stroke = 2,border_color = colors[:border_color], font_color = colors[:font_color], semipresscolor = colors[:semipresscolor]) 

ground = Ground("ground.png")
trees = Trees("trees.png","trees.png")
clouds = Clouds("clouds.png")

high_score = 0
high_score_actor = TextActor("High Score = $(high_score)", "freepixel", font_size = 30, color = colors[:text])
high_score_actor.pos = (WIDTH/2 - high_score_actor.position.w/2, HEIGHT/2 + 200)


#GAME ACTORS ================================================
score = 0
score_actor = TextActor("Score = $(score)", "freepixel", font_size = 30, color = colors[:text])
score_actor.pos = (10,10)


pipes_array =[]
pipes_distance = 300
pipes_number = 3
for i in 1:pipes_number
     push!(pipes_array, Pipes("pipe_top.png", "pipe_bottom.png", WIDTH + pipes_distance*(i-1), rand((100:HEIGHT-100)),pipes_distante = pipes_distance ,show_collision_box=false))
end
for i in 1:pipes_number
    if i < 2
        pipes_array[i].next_pipes = pipes_array[end]
    else
        pipes_array[i].next_pipes = pipes_array[i-1]
    end
end

#RESTART ACTOR======================================================================

restart_button_size = (150,60)
restart_button = Button(WIDTH/2-restart_button_size[1]/2,HEIGHT/2-restart_button_size[2]/2, restart_button_size[1],restart_button_size[2],"Restart", font_size = 40, color = colors[:button], border = true, border_stroke = 2,border_color = colors[:border_color], font_color = colors[:font_color], semipresscolor = colors[:semipresscolor]) 

home_button_size = (100,50)
home_button = Button(WIDTH/2-home_button_size[1]/2,HEIGHT/2-home_button_size[2]/2 + 100, home_button_size[1],home_button_size[2],"Home", font_size = 40, color = colors[:button], border = true, border_stroke = 2,border_color = colors[:border_color], font_color = colors[:font_color], semipresscolor = colors[:semipresscolor]) 



#==========================================================================#

function draw(g::Game)
    if screen == :home
        draw_home(g::Game)
    elseif screen == :game
        draw_game(g)
    elseif screen == :restart
        draw_restart(g)
    end
end

function update(g::Game, dt)
    if screen == :home
        update_home(g,dt)
    elseif screen == :game
        update_game(g, dt)
    elseif screen == :restart
        update_restart(g,dt)
    end
end

function on_mouse_down(g::Game, pos)
    if screen == :home
        on_mouse_down_home(g,pos)
    elseif screen == :game
        on_mouse_down_game(g)
    elseif screen == :restart
        on_mouse_down_restart(g,pos)
    end
end

function on_mouse_move(g::Game, pos)
    if screen == :home
        on_mouse_move_home(g, pos)
    elseif screen == :game
        #on_mouse_move_game(g)
    elseif screen == :restart
        on_mouse_move_restart(g,pos)
    end
end

function on_key_down(g::Game, key)
    if screen == :home

    elseif screen == :game
        on_key_down_game(g,key)
    elseif screen == :restart

    end
end



#println(fieldnames(typeof(ground.part1.position)))
#println(ground.part1.position)