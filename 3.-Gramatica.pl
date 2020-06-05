%
% López Estrella Omar
%	Gramatica
%
%	<expr> ::= <op> <numero> <numero>
%	<op> ::= '-' | '+' | '/' | '*'
%	<numero> ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
%
%
%	ejemplo
%	+ 1 2
%
%	Defina en prolog un predicado que permita validar la gramatica
%	Anterior
%
%	expr("+",1,2).
%	true.
%
%	expr("+",11,2). % falso por que esta limitado a un solo numero
%	false.
%
%	expr("/",10,5).
%	true.
%
%	expr("+","*",2).
%	false.
%
%	Hay un predicado en prolog que te verifica si un atomo es un numero
%	number(2).
%	true.
%
%	number('+').
%	false
% Hechos
operador_A("-").
operador_B("+").
operador_C("/").
operador_D("*").
numero_A(0).
numero_B(1).
numero_C(2).
numero_D(3).
numero_E(4).
numero_F(5).
numero_G(6).
numero_H(7).
numero_I(8).
numero_J(9).
% Reglas
operador(A) :- operador_A(A); operador_B(A); operador_C(A); operador_D(A).
numero(B)   :- numero_A(B); numero_B(B); numero_C(B); numero_D(B); numero_E(B); numero_F(B); numero_G(B); numero_H(B); numero_I(B); numero_J(B).

expr(A,B,C) :- operador(A), numero(B), numero(C).
