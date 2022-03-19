#initialize screen
WIDTH = 600
HEIGHT = 600
BACKGROUND = colorant"#e1edb9"
RATE = 100
grid = 10

game_include("point.jl")
game_include("snake.jl")
game_include("button.jl")
game_include("food.jl")

#verifica se a coordenada da cabeça da cobra e da comida são iguais
function eat(s::Snake, f::Food)
    if(s.xh == f.x && s.yh == f.y)
        return true
    end
    return false
end

#################################################################################################################################################
##################################GAME ACTORS###########################################################################################################3
#define  initial states of actors actors
screens = [:home, :game, :restart]
screen = screens[1] #:home
grid = 50

colors = Dict([(:button, colorant"#f4fad2"),
                (:border_color, colorant"#e0deab"),
                (:font_color, [49,44,32,255]),
                (:semipresscolor, colorant"#d8ddbc"),
                (:text,[109,166,212,255] )
                ])

#HOME ACTORS=============================================================================================
title = TextActor("SNAKE", "freepixel", font_size = 200, color = [109,166,122,255])
title.pos = (WIDTH/2 - 240, 50)

highscore = 0
highscore_text = TextActor("HighScore = $(highscore)", "freepixel", font_size = 25, color = colors[:text])
highscore_text.pos = (WIDTH/2 - 80, HEIGHT/2 + 50)

#BOTÕES
startbutton_size = (250,80)
startbutton = Button(WIDTH/2-startbutton_size[1]/2,HEIGHT/2-startbutton_size[2]/2, startbutton_size[1],startbutton_size[2],"Start", font_size = 60, text_left_border = 50, text_upper_border = 10, color = colors[:button], border = true, border_stroke = 2,border_color = colors[:border_color], font_color = colors[:font_color], semipresscolor = colors[:semipresscolor]) 

exitsize = (100,30)
exitbuttom = Button(WIDTH/2-exitsize[1]/2,HEIGHT/2-exitsize[2]/2+250, exitsize[1],exitsize[2],"Exit", font_size = 30, text_left_border = 20, text_upper_border = 2, color = colors[:button], border = true, border_stroke = 2,border_color =colors[:border_color], font_color = colors[:font_color], semipresscolor = colors[:semipresscolor]) 

easy_size = (110,30)
easybutton = Button(WIDTH/2-easy_size[1]/2 - 200 ,HEIGHT/2+100, easy_size[1],easy_size[2],"Easy", text_left_border = 20, text_upper_border = 2,font_size = 30, color = colors[:button], border = true, border_stroke = 2,border_color = colors[:border_color], font_color = colors[:font_color], semipresscolor = colors[:semipresscolor]) 
latch(easybutton)

medium_size = (110,30)
meadiumbutton = Button(WIDTH/2-easy_size[1]/2, HEIGHT/2+100, easy_size[1],easy_size[2],"Meadium", text_left_border = 2, text_upper_border = 2, font_size = 30,  color = colors[:button], border = true, border_stroke = 2,border_color = colors[:border_color], font_color = colors[:font_color], semipresscolor = colors[:semipresscolor]) 

hard_size = (110,30)
hardbuttom = Button(WIDTH/2-easy_size[1]/2 + 200, HEIGHT/2+100, easy_size[1],easy_size[2],"Hard", font_size = 30, text_left_border = 25, text_upper_border = 2, color = colors[:button], border = true, border_stroke = 2,border_color = colors[:border_color], font_color = colors[:font_color], semipresscolor = colors[:semipresscolor]) 

small_size = (110,30)
smallbutton = Button(WIDTH/2-small_size[1]/2 - 200, HEIGHT/2+150, small_size[1],small_size[2],"Small", font_size = 30, text_left_border = 25, text_upper_border = 2, color = colors[:button], border = true, border_stroke = 2,border_color = colors[:border_color], font_color = colors[:font_color], semipresscolor = colors[:semipresscolor]) 

big_size = (110,30)
bigbutton = Button(WIDTH/2-big_size[1]/2, HEIGHT/2+150, big_size[1],big_size[2],"Big", font_size = 30, text_left_border = 25, text_upper_border = 2, color = colors[:button], border = true, border_stroke = 2,border_color = colors[:border_color], font_color = colors[:font_color], semipresscolor = colors[:semipresscolor]) 
latch(bigbutton)

huge_size = (110,30)
hugebuttom = Button(WIDTH/2-huge_size[1]/2 + 200, HEIGHT/2+150, huge_size[1],huge_size[2],"Huge", font_size = 30, text_left_border = 25, text_upper_border = 2, color = colors[:button], border = true, border_stroke = 2,border_color = colors[:border_color], font_color = colors[:font_color], semipresscolor = colors[:semipresscolor]) 
#GAME ACTORS============================================================================================================================
snake = Snake(floor(WIDTH/2/grid)*grid,floor(HEIGHT/2/grid)*grid,grid=grid)
food =  Food(grid=grid)
score = 0
scoretext = TextActor("Score = $(score)", "freepixel", font_size = 30, color = colors[:text])
scoretext.pos=(10,10)
#RESTART ACTORS============================================================================================================================
finalscore = TextActor("Score", "freepixel")

restartbutton_size = (130,40)
restartbutton = Button(WIDTH/2-restartbutton_size[1]/2, HEIGHT/2 - 100, restartbutton_size[1],restartbutton_size[2], "Restart" , font_size = 30, text_left_border = 13, text_upper_border = 5, color = colors[:button], border = true, border_stroke = 2,border_color = colors[:border_color], font_color = colors[:font_color], semipresscolor = colors[:semipresscolor]) 

homebutton_size = (70,30)
homebutton = Button(WIDTH/2-homebutton_size[1]/2 ,HEIGHT/2+-50, homebutton_size[1],homebutton_size[2], "Home" , font_size = 30, text_left_border = 5, text_upper_border = 2, color = colors[:button], border = true, border_stroke = 2,border_color = colors[:border_color], font_color = colors[:font_color], semipresscolor = colors[:semipresscolor]) 


#

function draw(g::Game)
    if(screen == :home)
        draw_home()
    end
    if(screen == :game)
        draw_game()
    end
    if(screen == :restart)
        draw_restart()
    end
end

function update(g::Game, dt)
    if(screen == :home)
        update_home(g)
    end
    if(screen == :game)
        update_game(g)
    end
    if(screen == :restart)
        update_restart()
    end
end

#Desenha os atores na tela home
function draw_home()
    draw(startbutton)
    draw(title)
    draw(highscore_text)
    draw(easybutton)
    draw(meadiumbutton)
    draw(hardbuttom)
    draw(exitbuttom)
    draw(smallbutton)
    draw(bigbutton)
    draw(hugebuttom)

end

#Desenha os atores na tela game
function draw_game()
    if(snake.alive)
        draw(snake)
        draw(food)
    end
    draw(scoretext)
end

#Desenha os atores na tela restar
function draw_restart()
    draw(finalscore)
    draw(restartbutton)
    draw(homebutton)
    draw(highscore_text)
end

function update_home(g::Game)
    #not used
end

function update_game(g::Game)
    global score
    update!(snake) #move de snake pointer

    if(!snake.alive) #caso cobra esteja morta
        global finalscore = TextActor("Final Score: $(score)", "freepixel", font_size = 20, color = colors[:text])
        finalscore.pos = (WIDTH/2-60,HEIGHT/2 )
        
        global highscore
        if score > highscore
            highscore =  score
            global highscore_text = TextActor("HighScore = $(highscore)", "freepixel", font_size = 25, color =colors[:text])
            global highscore_text.pos = (WIDTH/2 - 80, HEIGHT/2 + 50)
        end

        score = 0 #reinicia score para novo jogo
        global screen = :restart #muda a tela
    end

    if(eat(snake, food)) #nova posição é de comida
        change_position!(food, snake)
        grow!(snake)
        score += 1
        global scoretext = TextActor("Score = $(score)", "freepixel", font_size = 30, color = colors[:text])
        scoretext.pos=(10,10)
    end
end
    
function update_restart()
    #not used
end

function on_mouse_down(g::Game, pos, button)
    #TELA HOME==============================
    if(screen == :home)
        if(press(startbutton, pos))
            global screen = screens[2] #muda tela para game
            reset(snake)
            change_position!(food, snake)
            release(startbutton)
        end
        if(press(easybutton, pos))
            global snake.vel = 1 
            latch(easybutton)
            unlatch(meadiumbutton)
            unlatch(hardbuttom)
        end
        if(press(meadiumbutton, pos))
            global snake.vel = 2
            latch(meadiumbutton)
            unlatch(easybutton)
            unlatch(hardbuttom)
        end
        if(press(hardbuttom, pos))
            global snake.vel = 3 
            latch(hardbuttom)
            unlatch(meadiumbutton)
            unlatch(easybutton)
        end
        if(press(smallbutton, pos))
            global food.grid = 100
            global snake.grid = 100
            latch(smallbutton)
            unlatch(bigbutton)
            unlatch(hugebuttom)
        end
        if(press(bigbutton, pos))
            global food.grid = 50
            global snake.grid = 50 
            latch(bigbutton)
            unlatch(smallbutton)
            unlatch(hugebuttom)
        end
        if(press(hugebuttom, pos))
            global food.grid = 20
            global snake.grid = 20 
            latch(hugebuttom)
            unlatch(bigbutton)
            unlatch(smallbutton)
        end

        if(press(exitbuttom, pos))
            exit() #fecha jogo
        end
    elseif screen == :game #TELA RESTART==============================
        #grow!(snake) #feito para testes
    end

    #TELA RESTART==============================
    if screen == :restart
        reset(snake)
        if(press(restartbutton, pos))
            change_position!(food, snake)
            global score = 0
            global screen = screens[2] #muda tela para game
            release(restartbutton)
        end
        if(press(homebutton, pos))
            global screen = screens[1] #muda tela para home
            release(homebutton)
        end
    end
end

#função que irá deixar os botões como semipressed
function on_mouse_move(g::Game, pos)
    if(screen == :home)
        if(mouse_in(startbutton, pos))
            semi_press(startbutton)
        else 
            release(startbutton)
        end
        if(mouse_in(exitbuttom,pos))
            semi_press(exitbuttom)
        else
            release(exitbuttom)
        end
    end
    if screen == :restart
        if(mouse_in(restartbutton, pos))
            semi_press(restartbutton)
        
        else
            release(restartbutton)
        end
        if(mouse_in(homebutton, pos))
            semi_press(homebutton)
        
        else
            release(homebutton)
        end
    end
    
end

#função para movimentos da cobra durante tela GAME
function on_key_down(g, key)
    #cada tecla altera a direção da cobra
    if(key == Keys.UP)
        dir!(snake, 0,-1)
    end
    if(key == Keys.DOWN)
        dir!(snake, 0,1)
    end
    if(key == Keys.LEFT)
        dir!(snake, -1,0)
    end
    if(key == Keys.RIGHT)
        dir!(snake, 1,0)
    end
end