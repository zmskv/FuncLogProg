% Предикат length/2
my_length([], 0).
my_length([_|Tail], N) :- my_length(Tail, N1), N is N1 + 1.

% Предикат member/2
my_member(X, [X|_]).
my_member(X, [_|Tail]) :- my_member(X, Tail).

% Предикат append/3
my_append([], L, L).
my_append([H|Tail], L, [H|R]) :- my_append(Tail, L, R).

% Предикат remove/3
my_remove(X, [X|Tail], Tail).
my_remove(X, [H|Tail], [H|R]) :- my_remove(X, Tail, R).

% Предикат permute/2
my_permute([], []).
my_permute(L, [H|Tail]) :- my_remove(H, L, R), my_permute(R, Tail).

% Предикат sublist/2
my_sublist(S, L) :- my_append(_, L1, L), my_append(S, _, L1).

% Предикат replace_nth/4
replace_nth(1, [H|Tail], New, [New|Tail]).
replace_nth(N, [H|Tail], New, [H|R]) :- N > 1, N1 is N - 1, replace_nth(N1, Tail, New, R).

% Предикат sum_list/2
sum_list([], 0).
sum_list([H|T], Sum) :- sum_list(T, Sum1), Sum is Sum1 + H.

% Предикат split_by_first/3
split_by_first([H|T], Less, Greater) :-
    split_by_first(T, H, Less, Greater).

split_by_first([], _, [], []).
split_by_first([H|Tail], Pivot, [H|Less], Greater) :- H =< Pivot, split_by_first(Tail, Pivot, Less, Greater).
split_by_first([H|Tail], Pivot, Less, [H|Greater]) :- H > Pivot, split_by_first(Tail, Pivot, Less, Greater).

% Предикат совместного использования предикатов
example(N, List, NewElem, Sum) :-
    replace_nth(N, List, NewElem, NewList),
    sum_list(NewList, Sum).