using Gtk


function on_button_clicked(button, event)
    println("The button " * get_gtk_property(button, :label, String) *  " has been clicked")
end


#CRIA  JANELA
win = GtkWindow("My first Gtk.jl Program")

#DEFINE LAYOUT COMO GRID ===================================
g = GtkGrid()

#CHECK BUTTON ====================
label_check = GtkLabel("Check Button")
check = GtkCheckButton("Check me!")
signal_connect(on_button_clicked ,check, "button_press_event")

#BUTÃO ========================
label_button = GtkLabel("Button")
button = GtkButton("Press Me")
signal_connect(on_button_clicked, button, "button_press_event")

#CURSOR ===============
scale = GtkScale(false, 0:10)
label_scale = GtkLabel("Scale")

#ENTRADA TEXTO ================================
label_ent = GtkLabel("Entry")
ent = GtkEntry()
#set_gtk_property!(ent, :visibility, false) caso seja uma senha

#COMBOBOX ============================
label_combo = GtkLabel("ComboBox")
comboBox =  GtkComboBoxText()

choices = ["1" "2"]
for choice in choices
    push!(comboBox, choice)
end

set_gtk_property!(comboBox, :active,0) 


g[2,1] = label_check
g[1,1] = check
g[1,2] = button
g[2,2] = label_button
g[1:2, 3] = label_scale
g[1:2, 4] = scale
g[1,5] = label_ent
g[2,5] = ent
g[1,6] = label_combo
g[2,6] = comboBox


set_gtk_property!(g, :column_homogeneous, true)
set_gtk_property!(g, :column_spacing, 15)
push!(win, g)

signal_connect(on_button_clicked, b, "button-press-event")

showall(win)

