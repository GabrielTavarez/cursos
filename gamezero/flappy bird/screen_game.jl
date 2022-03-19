function draw_game(g::Game)
    draw(clouds)
    draw(trees)
    draw.(pipes_array)
    draw(score_actor)
    draw(ground)
    draw(bird)
end

function update_game(g::Game, dt)
    global score
    global score_actor
    global screen

    #move actors
    update(bird, dt)
    update.(pipes_array, dt)
    update(ground, dt)
    update(trees, dt)
    update(clouds, dt)

    #check colision with ground
    for i in 1:length(ground.actors)
        if collide(bird.actor, ground.actors[i])
            bird.alive =false
            stop_game()
            stop(bird)

            screen = :restart
        end
    end

    #check colision with celing
    if bird.y < -20 
        bird.alive =false
        screen = :restart
        stop_game()
    end

    #check pipes interactions
    for i in 1:pipes_number
        #check colisions with pipes
        if (collide(bird.actor, pipes_array[i].actortop) || collide(bird.actor, pipes_array[i].actorbottom))
            bird.alive =false
            stop_game()
            screen = :restart
            break
        #check points
        elseif (collide(bird.actor, pipes_array[i].score_box) &&  pipes_array[i].scorable)
            pipes_array[i].scorable = false
            score +=1
            score_actor = TextActor("Score = $(score)", "freepixel", font_size = 30, color = colors[:text])
            score_actor.pos =(10,10)

            
        end
    end
    

end

function on_key_down_game(g::Game, key)
    if(key == Keys.SPACE)
        fly(bird)
    end
end

function on_mouse_down_game(g::Game)
    
end

function stop_game()
    global pipes_array
    global ground
    global clouds
    global trees
    global score
    global score_actor
    global high_score
    global high_score_actor

    score > high_score ? high_score = score :  high_score = high_score
    high_score_actor = TextActor("High Score = $(high_score)", "freepixel", font_size = 30, color = colors[:text])
    high_score_actor.pos = (WIDTH/2 - high_score_actor.position.w/2, HEIGHT/2 + 200)
    
    stop.(pipes_array)
    stop(ground)
    stop(clouds)
    stop(trees)
end