mutable struct Trees
    layer1
    layer2
    vx1
    vx2
    move::Bool
    top_layer1
    top_layer2
    window_width
    window_height
end

function Trees(image1, image2; vx1 = 2, vx2 = 1, window_width= 500, window_height = 700, top_layer1 = 70, top_layer2 = 80, move = true)
    layer1 = [Actor(image1),Actor(image1)]
    layer2 = [Actor(image1),Actor(image1)]

    for i in 1:length(layer1)
        i ==1 ? layer1[i].left = 0 : layer1[i].left = layer1[i-1].right
        i ==1 ? layer2[i].left = 0 : layer2[i].left = layer2[i-1].right
        layer1[i].top = window_height - top_layer1
        layer2[i].top = window_height - top_layer2
    end
    Trees(layer1, layer2, vx1, vx2,move,
        top_layer1,
        top_layer2,
        window_width,
        window_height)
end

function draw(t::Trees)
    draw.(t.layer2)
    draw.(t.layer1)
    
end

function update(t::Trees, dt)
    if t.move
        for i in 1:length(t.layer1)
            t.layer1[i].left -= t.vx1
            t.layer2[i].left -= t.vx2

            if t.layer1[i].right < 0
                i == 1 ? t.layer1[i].left = t.layer1[end].right : t.layer1[i].left = t.layer1[i-1].right
            end
            if t.layer2[i].right < 0
                i == 1 ? t.layer2[i].left = t.layer2[end].right : t.layer2[i].left = t.layer2[i-1].right
            end
        end
    end
end

function stop(t::Trees)
    t.move = false
end