class TV:
    cor = 'preta'
    def __init__(self): #inicia o objeto
        self.ligada = False
        self.tamanho = 55
        self.canal = 'Netflix'
        self.volume = 10

    def mudar_canal(self):
        self.canal = 'disney'

    def mudar_canal(self, canal):
        self.canal = canal

#main
tv_sala = TV()
print(tv_sala.cor)
TV.cor = 'branco'
tv_quarto = TV()


print(tv_sala.cor)
print(tv_quarto.cor)