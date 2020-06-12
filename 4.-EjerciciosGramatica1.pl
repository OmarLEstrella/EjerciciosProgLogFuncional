% López Estrella Omar
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

% Desarrolle un predicado que permita validar un octeto de una ip
% Responde a la siguiente gramatica
% Octeto ::= '2'<R5><R5> | '1'<Digito><Digito> | <Digito><Digito> | <Digito>
% R5 ::= 0 | 1 | 2 | 3 | 4 | 5
% Digito ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9

%octeto_ip("255").
%true.
%octeto_ip("256").
%false

r5(N) :-
        N == "0"; N == "1"; N == "2"; N == "3"; N == "4";
        N == "5".

octeto_ip(S) :- string_length(S,R), R == 3 , preparar_string(S,O), val_inicio(O);
                string_length(S,R), R == 2 , preparar_string(S,O), oct1(O);
                string_length(S,R), R == 1 , preparar_string(S,O), oct1(O).

val_inicio([F|C]) :- F == "2", oct2([F|C]); F == "1" , oct1([F|C]).

% Para el octeto inicial con 2
oct2([O|[]]) :- r5(O).
oct2([O|C]) :- r5(O), oct2(C).
% Para el octeto inicial con 1 y el octeto con solo dos y un digito
oct1([O|[]]) :- digito(O).
oct1([O|C]) :- digito(O), oct1(C).
