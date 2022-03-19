
mutable struct Food
    x::Int #coordenada
    y::Int #cordenada
    grid::Int #tamanho do grid das comidas
end

#construtor
function Food(;grid = 10)
    x = 0 #floor(rand()*600/grid)*grid
    y = 0 #floor(rand()*600/grid)*grid
    Food(x,y,grid)
end

#desenha a comida na tela
function draw(f::Food)
    color = colorant"#d8523d"
    draw(Rect(f.x ,f.y, f.grid,f.grid),color, fill = true)
end

#sorteia uma nova posição para a comida
function change_position!(f::Food, s::Snake)
    x=0
    y=0
    validposition = false
    #checa se a posição sorteada é corpo da cobra
    while !(validposition)
        x = floor(rand()*600/f.grid)*f.grid
        y = floor(rand()*600/f.grid)*f.grid
        for i in 1:s.total
            if(x==s.body[i].x && y == s.body[i].y)
                validposition = false
                break
                i = s.total+1
            else
                validposition = true
            end
        end
    end
    f.x = x
    f.y = y
end