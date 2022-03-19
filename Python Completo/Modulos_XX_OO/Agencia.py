import random

class Agencia:

    def __init__(self, telefone, cnpj, numero):
        self.telefone = telefone
        self.cnpj = cnpj
        self.numero = numero
        self.cliente = []
        self.caixa = 0
        self.emprestimos = []

    def verifica_caixa(self):
        if self.caixa < 1000000:
            print(f'Caixa abaixo do nivel recomendado. Caixa atual : R${self.caixa}')
        else:
            print(f'Valor de caixa ok. Valor atual: R${self.caixa}')

    def emprestar_dinheiro(self, valor, cpf, juros):
        if self.caixa > valor:
            self.emprestimo.append((valor, cpf, juros))
        else:
            print('Empréstimo inválido. Caixa baixo')

    def adicionar_cliente(self, nome, cpf, patrimonio):
        self.cliente.append( (nome, cpf, patrimonio) )


class AgenciaVirtual(Agencia):

    def __init__(self, site, telefone, cnpj):
        self.site = site
        super().__init__(telefone, cnpj, 1000)
        self.caixa = 1_000_000
        self.caixa_paypal = 0

    def depositar_paypal(self, valor):
        self.caixa -= valor
        self.caixa_paypal += valor

    def sacar_paypal(self, valor):
        self.caixa += valor
        self.caixa_paypal -= valor

class AgenciaComum(Agencia):
    def __init__(self, telefone, cnpj):
        super().__init__(telefone, cnpj, numero=random.randint(1000,9999))
        self.caixa = 1_000_000

class AgenciaPremium(Agencia):
    def __inti__(self, telefone, cnpj):
        super().__init__(telefone, cnpj, numero=random.randint(1000, 9999))
        self.caixa = 10_000_000

    def adicionar_cliente(self, nome, cpf, patrimonio):
        if patrimonio > 1_000_000:
            super().adicionar_cliente(nome, cpf, patrimonio)
        else:
            print('Não é possivel adicionar o clinete. O cliente é pobre')