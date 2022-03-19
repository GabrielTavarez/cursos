mutable struct  Pipes
    imagetop::String
    actortop::Actor
    imagebottom
    actorbottom::Actor
    score_box::Rect
    gapcenter
    gap
    x
    vx
    move::Bool
    scorable::Bool
    window_width::Int
    window_height::Int
    pipes_distante
    next_pipes
    show_collision_box::Bool
end

function Pipes(imagetop, imagebottom, x, gapcenter; gap=200, vx = 150, window_width = 500, window_height = 700, pipes_distante = 300, show_collision_box= false, move = true)
    actortop = Actor(imagetop)
    actortop.bottom = gapcenter - gap/2
    actortop.left = x
    score_box = Rect(x + 50 ,gapcenter -gap/2, 5, 200 )
    
    actorbottom = Actor(imagebottom)
    actorbottom.top = gapcenter + gap/2
    actorbottom.left = x
    next_pipes = Missing
    scorable = true
    

    Pipes(imagetop,
        actortop,
        imagebottom,
        actorbottom,
        score_box,
        gapcenter,
        gap,
        x,
        vx,
        move,
        scorable,
        window_width,
        window_height,
        pipes_distante,
        next_pipes,
        show_collision_box) 
end

function draw(p::Pipes)
    draw(p.actortop)
    draw(p.actorbottom)
    if p.show_collision_box
        draw(p.actorbottom.position, colorant"red")
        draw(p.actortop.position, colorant"red")
        draw(p.score_box, colorant"blue")
    end
    
end

function update(p::Pipes, dt)
    if p.move
        p.x = p.x - p.vx*dt
        p.score_box.pos = (p.x +50 ,p.score_box.pos[2])
        if (p.actorbottom.right < 0)
            reset(p)
        end

        p.actorbottom.left = p.x
        p.actortop.left = p.x 
    end

end

function reset(p::Pipes)
    p.x = p.next_pipes.x + p.pipes_distante
    p.gapcenter = rand((100:HEIGHT-100))

    p.score_box.pos = (p.x + 50 ,p.gapcenter -p.gap/2)
    p.scorable = true
    
    p.actortop.bottom = p.gapcenter - p.gap/2
    p.actorbottom.top = p.gapcenter + p.gap/2
end

function stop(p::Pipes)
    p.move = false
end