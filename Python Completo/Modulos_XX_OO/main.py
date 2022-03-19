from ContasBanco import ContaCorrente
from ContasBanco import CartaoCredito
from Agencia import AgenciaComum
from Agencia import AgenciaPremium
from Agencia import AgenciaVirtual

if __name__ == "__main__":
    agencia = AgenciaComum(45182365, 741852963963)

    print(agencia.caixa)


