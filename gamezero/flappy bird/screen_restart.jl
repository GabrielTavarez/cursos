function draw_restart(g::Game)  
    draw(clouds)
    draw(trees)
    draw.(pipes_array)
    draw(score_actor)
    draw(ground)
    draw(bird)
    draw(restart_button)
    draw(home_button)
    draw(high_score_actor)
end

function update_restart(g::Game, dt)
    update(bird, dt)

    for i in 1:length(ground.actors)
        if collide(bird.actor, ground.actors[i])
            bird.alive =false
            stop(bird)
            stop.(pipes_array)
            stop(ground)
            stop(trees)
            screen = :restart
        end
    end
end

function on_mouse_down_restart(g::Game, pos)
    global screen
    global bird
    global pipe_array
    if(press(restart_button, pos))
        screen = :game #muda tela para game
        restart_game()
        release(restart_button)
        screen = :game
    end

    if(press(home_button, pos))
        screen = :home #muda tela para game
        restart_home()
        release(home_button)
    end
end

function  on_mouse_move_restart(g, pos)
    if(mouse_in(restart_button, pos))
        semi_press(restart_button)
    else 
        release(restart_button)
    end
    if(mouse_in(home_button, pos))
        semi_press(home_button)
    else 
        release(home_button)
    end
end

function on_key_press_restart(g::Game, key)
    
end

function restart_game()
    global bird
    global pipes_array
    global ground
    global trees
    global clouds
    global score
    global score_actor

    global score = 0
    score_actor = TextActor("Score = $(score)", "freepixel", font_size = 30, color = colors[:text])
    score_actor.pos = (10,10)

    clouds.move = true
    ground.move =true
    trees.move = true

    bird = Bird(50,200,"bird1.png", "bird2.png", )
    reset_pipes()
end

function restart_home()
    global bird
    global pipes_array
    global ground
    global trees
    global clouds

    bird = Bird(50,200,"bird1.png", "bird2.png", move = false)
    clouds.move = true
    ground.move =true
    trees.move = true
    reset_pipes()
end

function reset_pipes()
    global pipes_array

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
end