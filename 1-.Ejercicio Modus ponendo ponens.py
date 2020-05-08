"""
Omar López Estrella

# Programación  Lógica



# Modus ponendo ponens

"el modo que, al afirmar, afirma"

P → Q. P ∴ Q


Se puede encadenar usando algunas variables

P → Q.
Q → S.
S → T. P ∴ T

Ejercicio
Defina una funcion que resuelva con verdadero o falso segun corresponada

Laura esta en Queretaro
Alena esta en Paris
Claudia esta en San Francisco
Queretaro esta en Mexico
Paris esta en Francia
San Francisco esta en EUA
Mexico esta en America
Francia esta en Europa
EUA esta en America

def esta(E1,E2):
	pass


print(esta("Alena","Europa"))
# true

print(esta("Laura","America"))
# true

print(esta("Laura","Europa"))
# false

"""
Base = [
	["Laura","Queretaro"],
	["Elena","Paris"],
	["Claudia","San Francisco"],
	["Queretaro","Mexico"],
	["Paris","Francia"],
	["San Francisco","EUA"],
	["Mexico","America"],
	["Francia","Europa"],
	["EUA","America"]
]
def buscaX(MM,E1):
	if not MM:
		return []
	if len(MM):
		if E1 == MM[0][0]:
			return MM[0][1]
		else:
			return buscaX(MM[1:],E1)


def esta (E1,E2):
	R = buscaX(Base,E1)
	L = buscaX(Base, R)
	if L == E2 or R == E2:
		return True
	S = buscaX(Base, L)
	if S == E2:
		return True
	else:
		return False

print(esta("Elena","Europa"))
# true
# Alena no existe en los datos

print(esta("Laura","America"))
# true

print(esta("Laura","Europa"))
# false

print(esta("Queretaro","Mexico"))
# True

print(esta("Francia","America"))
# False
