mutable struct Clouds
    actors
    vx
    move::Bool
    window_width::Int
    window_height::Int
end

function Clouds(image; vx = 30, window_width = 500, window_height = 700, move = true)
    actors = [Actor(image),Actor(image)]

    for i in 1:length(actors)
        i == 1 ? actors[i].left = 0 : actors[i].left = actors[i-1].right
    end

    Clouds(actors,
        vx,
        move,
        window_width, 
        window_height) 
end

function draw(c::Clouds)
    draw.(c.actors)    
end

function update(c::Clouds, dt)
    if c.move
        for i in 1:length(c.actors)
            c.actors[i].left -= c.vx*dt
            
            if c.actors[i].right < 0
                i == 1 ? c.actors[i].left = c.actors[end].right :  c.actors[i].left = c.actors[i-1].right
            end
        end
    end
end

function stop(c::Clouds)
    c.move = false
    
end