mutable struct Ground
    image::String
    actors
    top
    vx
    move::Bool
    window_width::Int
    window_height::Int
end

function Ground(image; vx = 150, top = 15, window_width = 500, window_height =700, move=true )
    actors = [Actor(image),Actor(image)]

    for i in 1:length(actors)
        actors[i].top = window_height - top
    end

    actors[1]. left = 0
    actors[2].left = actors[1].position.x + actors[1].position.w-1

    Ground(image,
        actors,
        top,
        vx,
        move,
        window_width,
        window_height)
end

function draw(g::Ground)
    draw.(g.actors)
end

function update(g::Ground, dt)
    if g.move
        for i in 1:length(g.actors)
            
            g.actors[i].pos = (g.actors[i].pos[1] - g.vx*dt, g.actors[i].pos[2])

            if g.actors[i].right < 0
                i > 1 ? g.actors[i].left = g.actors[i-1].right -1 : g.actors[i].left = g.actors[end].right -1
            end
        end
    end
end

function stop(g::Ground)
    g.move = false
end