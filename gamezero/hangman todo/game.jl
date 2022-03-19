WIDTH = 600
HEIGHT = 500
BACKGROUND = colorant"#c54245"

tree_green = colorant"#45c542"

#CRIAÇÃO DA PALAVRA
word_list = readlines(joinpath(@__DIR__, "data", "wordlist.txt")) #retorna um vetor onde cada elemento é a linha da lista
word_list = strip.(word_list) #remove espaços no fim e começo de strings
word = rand(word_list)
word_array = 
num_chars = length(word)


answer = fill(" ", num_chars)
letters = string.(collect('a':'z'))

function draw(g::Game)

    for i in 1:num_chars
        draw(Line(50*i ,450, 50*i+30,450), colorant"#ffffff")
        draw(Line(50*i ,451, 50*i+30,451), colorant"#ffffff")
    end
end

function update(g::Game)
    
end

function on_key_down(g::Game, k)
    key_pressed = lowercase(string(k))
    if key_pressed in letters
        if key_pressed in word    
end