move(Input, Output):-
    append(Prefix, ['_', 'w' | Suffix], Input),
    append(Prefix, ['w', '_' | Suffix], Output).

move(Input, Output):-
    append(Prefix, ['b', '_' | Suffix], Input),
    append(Prefix, ['_', 'b' | Suffix], Output).

move(Input, Output):-
    append(Prefix, ['_', 'b', 'w' | Suffix], Input),
    append(Prefix, ['w', 'b', '_' | Suffix], Output).

move(Input, Output):-
    append(Prefix, ['b', 'w', '_' | Suffix], Input),
    append(Prefix, ['_', 'w', 'b' | Suffix], Output).

extend([Current | Path], [Next, Current | Path]):-
    move(Current, Next),
    not(member(Next, [Current | Path])).

dfs([Current | Path], Current, [Current | Path]).
dfs(Path, Goal, Result):-
    extend(Path, NewPath),
    dfs(NewPath, Goal, Result).

bfs([[Current | Path] | _], Current, [Current | Path]).
bfs([Path | QueueIn], Goal, Result):-
    findall(NewPath, extend(Path, NewPath), Extensions),
    append(QueueIn, Extensions, QueueOut),
    bfs(QueueOut, Goal, Result).
bfs([_ | Queue], Goal, Result):- bfs(Queue, Goal, Result).

iter([Current | Path], Current, [Current | Path], 0).
iter(Path, Goal, Result, Depth):-
    Depth > 0,
    extend(Path, NewPath),
    NewDepth is Depth - 1,
    iter(NewPath, Goal, Result, NewDepth).

depth_level(1).
depth_level(Level):- depth_level(Previous), Level is Previous + 1.

dfs_search(Start, Goal):-
    get_time(StartTime),
    dfs([Start], Goal, Solution),
    get_time(EndTime),
    Time is EndTime - StartTime,
    print_solution(Solution),
    writeln(''),
    length(Solution, Length), write('Solution length: '), writeln(Length),
    write('Time:'), writeln(Time), nl.

bfs_search(Start, Goal):-
    get_time(StartTime),
    bfs([[Start]], Goal, Solution),
    get_time(EndTime),
    Time is EndTime - StartTime,
    print_solution(Solution),
    writeln(''),
    length(Solution, Length), write('Solution length: '), writeln(Length),
    write('Time: '), writeln(Time), nl.

ids_search(Start, Goal):-
    get_time(StartTime),
    depth_level(Depth),
    (Depth > 100, !; iter([Start], Goal, Solution, Depth)),
    get_time(EndTime),
    Time is EndTime - StartTime,
    print_solution(Solution),
    writeln(''),
    length(Solution, Length), write('Solution length: '), writeln(Length),
    write('Time: '), writeln(Time), nl.

print_solution([]):- !.
print_solution([State | Rest]):-
    print_solution(Rest), nl, write(State).

solve:-
    StartState = ['b', 'b', 'b', 'b', '_', 'w', 'w', 'w'],
    GoalState = ['w', 'w', 'w', '_', 'b', 'b', 'b', 'b'],
    writeln('Iterative Deepening Search'),
    ids_search(StartState, GoalState),

    writeln('Depth-First Search'),
    dfs_search(StartState, GoalState),

    writeln('Breadth-First Search'),
    bfs_search(StartState, GoalState),
    !.