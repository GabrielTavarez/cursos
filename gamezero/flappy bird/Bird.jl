mutable struct Bird 
    actor::Actor
    images
    wing_speed::Int
    wing_state::Int
    wing_move::Bool
    x
    y
    angle
    alive::Bool
    vy::Float64
    gravity::Float64
    move::Bool
    fly_power
    max_speed
    show_collision_box::Bool
end

function Bird(x_,y_, image_1::String, image_2::String; 
                wing_speed = 25, wing_move = true , show_collision_box = false, gravity = 400, fly_power = 270, max_speed = 400, move= true )
                images = [image_1, image_2]
    actor = Actor(images[1])
    actor.scale = [1.2,1.2]
    wing_state = 0

    actor.pos = (x_,y_)
    alive = true
    angle = 0

    vy=0.0  

    Bird(actor,
        images,
        wing_speed,
        wing_state,
        wing_move,
        x_,
        y_,
        angle,
        alive,
        vy,
        gravity,
        move,
        fly_power,
        max_speed,
        show_collision_box)
    
end

function draw(b::Bird)
    if b.show_collision_box
        draw(b.actor.position, colorant"red", fill =false)
    end
    draw(b.actor)
end

function update(b::Bird, dt)
    if b.move
        #update positions 
        b.y = b.y + b.vy*dt
        b.vy = b.vy + b.gravity*dt
    
        if b.vy > b.max_speed
            b.vy = b.max_speed
        end
    end
        #update the wings flap
        if b.wing_move
            if(b.wing_state < b.wing_speed/2)
                b.actor.image = b.images[1]
                b.wing_state+=1
            elseif b.wing_state < b.wing_speed
                b.actor.image = b.images[2]
                b.wing_state+=1
            elseif b.wing_state >= b.wing_speed
                b.wing_state = 0
            end
        end

        #update angle
        b.angle = map_between(-b.vy, b.fly_power,-b.max_speed, -20,45)       

        #set image propertys
        b.actor.pos = (b.x, b.y)
        b.actor.angle = b.angle
    
end

function fly(b::Bird)
    if !b.alive
        return
    end
    b.vy = -b.fly_power
end

function map_between(input, min_input, max_input, min_output, max_output)
    output = (input - min_input)*(max_output-min_output)/(max_input-min_input) + min_output
    return output
end

function stop(b::Bird)
    b.move = false
    b.wing_move = false
    b.vy = 0   
end