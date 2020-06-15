% López Estrella Omar
% Desarrollo una gramatica bnf (como la del video) para validar una
% direccion ipv4 asi como una mascara de red.
% https://es.wikipedia.org/wiki/M%C3%A1scara_de_red#Tabla_de_m%C3%A1scaras_de_red
% Realice la implementacion de dicha gramatica en prolog donde
% se pueda validar la cadena donde esta esa ip o mascara ejemplo


% ip("192.168.1.1").
% true.
% ip("256.168.1.1").
% false.
% maskR("255.255.255.0").
% true.
% maskR("255.255.255.1").
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

r5(N) :-
        N == "0"; N == "1"; N == "2"; N == "3"; N == "4";
        N == "5".

r_esp(N) :-
        N == "0"; N == "1"; N == "2"; N == "4";
        N == "5"; N == "8".

oct([O|[]]) :- r5(O).
oct([O|C]) :- r5(O), oct(C).

oct_masc([O|[]]) :- r_esp(O).
oct_masc([O|C])  :- r_esp(O), oct_masc(C).

op2([O|[]]) :- digito(O).
op2([O|C])  :- digito(O), op2(C).

% Validación de IP
ip(IP) :- split_string(IP,".",",",L), separa_ip(L).

separa_ip([O|[]]) :- valida_inicioip(O).
separa_ip([O|C])  :- valida_inicioip(O), separa_ip(C).

valida_inicioip(S) :- string_length(S,R), R == 3 , preparar_string(S,RS), op1(RS);
                      string_length(S,R), R == 2 , preparar_string(S,RS), op2(RS);
                      string_length(S,R), R == 1 , preparar_string(S,RS), op2(RS).

op1([F|C]) :- F == "2", oct_masc([F|C]); F == "1", op2([F|C]).


% Validar Mascara de Red
maskR(MASC) :- split_string(MASC,".",",",M), separa_masc(M).

separa_masc([F|[]])  :- valida_iniciomasc(F).

separa_masc([F|C])  :- valida_iniciomasc(F), separa_masc(C).

valida_iniciomasc(S) :- string_length(S,R), R == 3, preparar_string(S,RS), op1_masc(RS);
                        string_length(S,R), R == 2, preparar_string(S,RS), op2_masc(RS);
                        string_length(S,R), R == 1, si(S).

op1_masc([O|C])  :- O == "2", oct_masc([O|C]);
                    O == "1", op2_masc([O|C]).

op2_masc([O|[]]) :- digito(O).
op2_masc([O|C])  :- digito(O), op2_masc(C).

si(O) :- O == "0".
