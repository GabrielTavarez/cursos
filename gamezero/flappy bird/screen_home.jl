function draw_home(g::Game)
    draw(clouds)
    draw(trees)
    draw(ground)
    draw(bird)
    draw(start_button)
    draw(high_score_actor)
end

function update_home(g::Game, dt)
    global high_score_actor
    global high_score
    high_score_actor = TextActor("High Score = $(high_score)", "freepixel", font_size = 30, color = colors[:text])
    high_score_actor.pos = (WIDTH/2 - high_score_actor.position.w/2, HEIGHT/2 + 200)
    update(bird, dt)
    update(ground, dt)
    update(trees, dt)
    update(clouds, dt)
end

function on_mouse_down_home(g::Game, pos)
    global screen
    if(press(start_button, pos))
        screen = :game #muda tela para game
        release(start_button)
        global score = 0
        global score_actor
        score_actor = TextActor("Score = $(score)", "freepixel", font_size = 30, color = colors[:text])
        score_actor.pos = (10,10)

        if bird.alive
            bird.move = true
        end
    end
end

function on_key_press_home(g::Game, key)
    
end

function  on_mouse_move_home(g, pos)
    if(mouse_in(start_button, pos))
        semi_press(start_button)
    else 
        release(start_button)
    end
end