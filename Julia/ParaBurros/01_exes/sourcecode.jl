function helloapp()
    while true
        clear()
        println("Hello World \n")
        println("What is your name? (blank to exit)")
        input = readline()
        if input == ""
            break
        end
        println("Hello, $input !")

        print("Digite qualquer tecla")
        input = readline()

    end
end

clear() = run(`cmd /c cls`)

