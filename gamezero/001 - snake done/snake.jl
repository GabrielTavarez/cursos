
#################################################################################################################################################
#######################################SNAKE DEFINITIONS#########################################################################################
mutable struct Snake
    x::Float64 #coord continua da cabeça
    y::Float64 #coord continua da cabeca
    xh::Int  #coord discreta da cabeça no drig
    yh::Int #coord discreta da cabeca no grid
    head::Point #coordenada ca cabeça
    body::Array{Point} #array com a coordenada de cada parte do corpo da cobra
    tail_end::Point #coordenada que guarda a ponta da cobra para o caso de crescimento
    grid #tamanho do grid que a cobra irá se movimentar
    speedx::Int #indica a direção da velocidade nesse eixo
    speedy::Int #indica a direção da velocidade nesse eixo
    total::Int #numero de pedaços de corpo
    vel::Float64 #velocidade de movimento da cobra
    alive::Bool #indica se a cobra estpa ou não viva
end

#construtor
function Snake(x_ini,y_ini; grid = 10 , vel = 1)
    head = Point(x_ini,y_ini)
    ini_total = 2
    ini_speedx = 0
    ini_speedy = 1
    
    
    body = [head, Point(head.x,head.y-grid)] #desenha corpo inicial da cobra
    tail_end = Point(head.x,head.y-grid)
    alive = true

    velocity = vel
    return Snake(x_ini, y_ini, x_ini, y_ini, head, body, tail_end, grid, ini_speedx,ini_speedy ,ini_total,velocity, alive)
end

#desenha a cobra inteira na tela
function draw(s::Snake)
    draw(Rect(s.xh, s.yh, s.grid,s.grid), colorant"#648a64" ,fill=true ) #desenha a cabeça
    
    #desenha o corpo
    if s.total > 1
        for i in 2:s.total
            draw(Rect(s.body[i].x, s.body[i].y, s.grid,s.grid), colorant"#6da67a" ,fill=true ) 
        end
    end
    
    #desenha ponteiro da cobra
    #draw(Rect(s.x,s.y,1,1), colorant"red", fill=true)
end

#atualiza a posição de cada parte da cobra
function update!(s::Snake)
    if(!(s.alive))
        return
    end
    #atualiza ponteiro
    s.x = s.x + s.speedx*s.vel*s.grid/30
    s.y = s.y + s.speedy*s.vel*s.grid/30
    
    #verifica bordas
    if(s.y > HEIGHT-1)
        s.y = HEIGHT-1
    end
    if(s.y < 0)
        s.y = 0
    end
    if(s.x > WIDTH-1)
        s.x = WIDTH - 1
    end
    if(s.x < 0)
        s.x = 0
    end

    #move a cabeça caso o ponteiro tenha saido de um rid para outr
    s.xh = floor(s.x/s.grid)*s.grid
    s.yh = floor(s.y/s.grid)*s.grid

    #caso a cabeça tenha mudado de posição, irá movimentar o corpo todo
    if(s.xh != s.body[1].x || s.yh != s.body[1].y)
        if(s.total>1)
            s.tail_end = s.body[end]
            for i in s.total:-1:2
                s.body[i] = s.body[i-1]
            end
        end
        s.body[1] = Point(s.xh,s.yh)
    end
    
    #checa colisão da cabeça com o corpo
    for i in 2:s.total
        if(s.xh == s.body[i].x && s.yh == s.body[i].y)
            s.alive = false
        end
    end
end

#muda a direção do movimento da cobra
function dir!(s::Snake, xspeed, yspeed)
    #checa se o movimento desejado é válido
    #ex: ela não pode ir para direita, se estava andando para a esquerda
    if(s.xh + grid*xspeed != s.body[2].x && s.yh + grid*yspeed != s.body[2].y)
        s.speedy = yspeed
        s.speedx = xspeed
    end
end

#aumenta o tamanho da cobra
function grow!(s::Snake)
    s.total= s.total+1
    push!(s.body, s.tail_end)  
end

#reinicia os parâmetros da cobra
#mantem volocidade setada no inicio
function reset(s::Snake)
    global snake = Snake(300,300, vel = snake.vel, grid=s.grid)
end

