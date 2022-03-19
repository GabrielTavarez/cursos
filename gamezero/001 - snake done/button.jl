
###############################################################################################################################################33
###################################BUTTON DEFINITIONS######################################################################################################3
mutable struct Button
    x::Int #coordenada do canto superior esquerda
    y::Int ##coordenada do canto superior esquerda
    width #tamanho do botaõ
    height #tamanho do botaõ
    text::Actor #texto inserido dentro do botão
    color #cor do fundo do botão
    border::Bool #verifica se há ou não borda
    border_stroke #grossura da borda
    border_color #cor da borda
    semipresscolor #cor de quando o botão estiver semipressionado
    releasecolor #cor do botão solto. igual a color
    latch::Bool #indica se o botão ficara pressionado um vez que clicado
end

#construtor
function Button(x, y, width, height, text = "" ; font = "freepixel", font_size = 20, font_color = [0,0,0,255], color = colorant"white", border = false, border_stroke = 0, border_color=colorant"black", text_left_border = 10 , text_upper_border = 10, semipresscolor = RGB(0,0,0), latch = false)

    text_actor =  TextActor(text, font, font_size = font_size, color = font_color)
    text_actor.pos = (x + text_left_border, y +  text_upper_border)
    releasecolor = color
    
    return Button(x, y, width, height, text_actor, color, border, border_stroke, border_color, semipresscolor,releasecolor,latch)
end

#desenha o botão
function draw(b::Button)
    if b.border==true
        draw(Rect(b.x - b.border_stroke,b.y - b.border_stroke, b.width + b.border_stroke*2 , b.height+b.border_stroke*2), b.border_color, fill = true)
    end
    draw(Rect(b.x,b.y,b.width, b.height), b.color, fill = true)
    draw(b.text)
end

#verifica se a coordenada POS está dentro do botão 
function press(b::Button, pos)
    if(b.x<pos[1]<b.x+b.width && b.y<pos[2]<b.y + b.height)
        return true
    end
    return false
end

#verifica se a coordenada POS está dentro do botão 
function mouse_in(b::Button, pos)
    if(b.x<pos[1]<b.x+b.width && b.y<pos[2]<b.y + b.height)
        return true
    end
    return false
end

#altera a cor do fundo para a cor de pressionado
function semi_press(b::Button)
    b.color = b.semipresscolor
end

#retorna a cor do botão para a cor original
function release(b::Button)
    b.color = b.releasecolor
end

#fixa a cor do botão na cor pressionado
function latch(b::Button)
    b.color = b.semipresscolor
end

#retorna a cor do botão para a cor original
function unlatch(b::Button)
    b.color = b.releasecolor
end

