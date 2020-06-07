% Desarrolle un predicado que permita validar un NIP de una banco que
% Responde a la siguiente gramatica
% Nip ::= <Digito> ' ' <Digito> ' ' <Digito> ' ' <Digito>
% Digito ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
% Pruebas
% nip("1235").
% true.
%nip("123").
% false.
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

nip(S) :- string_length(S,R), R == 4 , preparar_string(S,O), digitos(O).

digitos([O|[]]) :- digito(O).
digitos([O|C]) :- digito(O), digitos(C).
