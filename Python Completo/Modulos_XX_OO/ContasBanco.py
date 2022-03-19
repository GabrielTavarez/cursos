from datetime import datetime
import pytz
import random

class ContaCorrente():

    @staticmethod
    def _data_hora():
        fuso_BR = pytz.timezone('Brazil/East')
        horario_BR = datetime.now(fuso_BR)
        return horario_BR.strftime('%d/%m/%Y %H:%M:%S')

    def __init__(self, nome, cpf, agencia, conta):
        self.nome = nome
        self.cpf = cpf
        self._saldo = 0
        self._limite = None
        self._agencia = agencia
        self._conta = conta
        self._transacoes = []
        self.cartoes = []


    def consultar_saldo(self):
        print(f"Seu saldo é de R$ {self._saldo}")

    def depositar(self, valor):
        self._saldo += valor
        self._transacoes.append((valor, self._saldo, self._data_hora()))

    def _limite_conta(self):
        self._limite = -1000
        return self._limite

    def sacar_dinheiro(self, valor):
        if self._saldo - valor < self._limite_conta():
            print('Saldo insuficiente')
        else:
            self._saldo -= valor
            self._transacoes.append((-valor, self._saldo, self._data_hora()))

    def consultar_historico_transacoes(self):
        print("Historico:")
        print("(Valor trans | Saldo | Data e Hora)")
        for transacao in self._transacoes:
            print(transacao)
        print('')

    def transferir(self, valor, conta_destino):
        self._saldo -= valor
        self._transacoes.append((-valor, self._saldo, self._data_hora()))

        conta_destino._saldo += valor
        conta_destino._transacoes.append((-valor, self._saldo, self._data_hora()))


class CartaoCredito:

    @staticmethod
    def _data_hora():
        fuso_BR = pytz.timezone('Brazil/East')
        horario_BR = datetime.now(fuso_BR)
        return horario_BR

    def __init__(self, titular, conta_corrente):
        self.numero = random.randint(1000,9999)
        self.titular = titular
        self.validade = '{}/{}'.format(CartaoCredito._data_hora().month, CartaoCredito._data_hora().year+4)
        self.cvc = '{}{}{}'.format(random.randint(0,9),random.randint(0,9),random.randint(0,9))
        self.limite = 1000
        self.senha = '1234'
        self.conta_corrente = conta_corrente
        conta_corrente.cartoes.append(self)

    @property
    def senha(self):
        return self._senha

    @senha.setter
    def senha(self, valor):
        if (len(valor) == 4 and valor.isnumeric()):
            self._senha = valor
        else:
            print('senha iválida')

