% López Estrella Omar
% Escriba un analizador sintactivo que pueda
% validar las siguientes sentencias simples que puedan
% ser representadas por las siguientes gramaticas
% Exp ::= "(" ' ' <Operacion> ' ' ")"
% Operacion ::= <Operador>' '<SecNumeros>
% Operador ::= '+' | '-' | '/' | '*'
% SecNumeros ::= <NumerosSigno> | <NumerosSigno> ' ' <SecNumeros>
% NumerosSigno ::= <Digitos> | <Signo> <Digitos>
% Signo ::= '+' | '-'
% Digitos ::= Digito | Digito Digitos
% Digito ::= 0 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
% ( - 9 8 )
% -1
% ( - -9 )
% 9
% ( + -9 1 10 9 -1 )
% 10
% atomo ' '
% string " "
% F = "Hola",string(F)
% F = 'Hola',atom(F)
% string_chars("Hola como estas",[F|C],string(F))
% string_chars("Hola como estas",[F|C],string_upper(F,U))
% string_chars("Hola como estas",[F|C],string_length(F,L))
% string_chars("1 Hola como estas",[F|C],number_string(F,R))
% Cambia atomo a cadena
% atom_string('1',R)
% append([P],[2,3],[1,2,3]).
% append(_,[U],[1,2,3]).
% append(_,[F|C],[1,2,3]).
% split_string("1,1,2,3,4,8",",","",L).
% split_string("( + 1 2 3)"," ","",L).
% Permite ver paso a paso con trace

latom_lstring([],[]).
latom_lstring([F|C],R) :- latom_lstring(C,S), atom_string(F,SF), append([SF],S,R).

preparar_string(Term,LS) :-
        atom(Term),
        atom_string(Term,Str),
        preparar_string(Str,LS).

preparar_string(Str,LS) :-
        string(Str),
        string_chars(Str,LAC),
        latom_lstring(LAC,LS).

digito(N) :-
        N == "0"; N == "1"; N == "2"; N == "3"; N == "4";
        N == "5"; N == "6"; N == "7"; N == "8"; N == "9".

digitos([F|[]]) :- digito(F).
digitos([F|C]) :- digito(F), digitos(C).

signo("+").
signo("-").
% signo(R) :- R == "+".
operador("*").
operador("/").
operador(O) :- signo(O).

numerosigno([F|C]) :- signo(F), digitos(C).
numerosigno([F|C]) :- digitos([F|C]).

secuencianum([F|[]]) :- preparar_string(F,LS), numerosigno(LS).
secuencianum([F|C]) :- preparar_string(F,LS), numerosigno(LS), secuencianum(C).

operacion([F|C]) :- operador(F), secuencianum(C).

% El resto de la lista puede tener +12 343 100 )
% expresion_c(["("|C]) :-

abre_parentesis(["("|_]).
cierra_parentesis([_|C]) :- append(_,[")"],C).

expre([F|C]) :- abre_parentesis([F|C]), cierra_parentesis([F|C]), append(OP, [")"],C), operacion(OP).

% append([A,B],[3],[1,2,3]).
% append([1,2],[T],[1,2,3]).
% L = [1,2,3],append(_,[3],L).
% L = [1,2,3],append(R,[3],L).

% Para corroborar que es correcto el analizador sintactico
% split_string("( * +12 343 1000 )"," "," ",L),expre(L).
