
% EMERGENCY EVACUATION PLANNER
% AI Assignment - Prolog
% IC-2K23-63 Nikhil Patel 

% 1. LOCATION FACTS

location(room_a, room).
location(room_b, room).
location(corridor_1, corridor).
location(corridor_2, corridor).
location(staircase_1, staircase).
location(staircase_2, staircase).
location(exit_1, exit).
location(exit_2, exit).

% 2. CONNECTION FACTS
% Connections are bidirectional.
connected(room_a, corridor_1).
connected(corridor_1, staircase_1).
connected(corridor_1, room_b).
connected(room_b, exit_2).
connected(staircase_1, exit_1).
connected(room_a, corridor_2).
connected(corridor_2, staircase_2).
connected(staircase_2, exit_1).

% 3. BLOCKED AND UNSAFE CONDITIONS

:- dynamic blocked_connection/2.
:- dynamic blocked_location/1.
:- dynamic unavailable_exit/1.

% Sample blocked connection
blocked_connection(corridor_1, staircase_1).

% 4. EXIT AVAILABILITY
is_exit(X) :-
    location(X, exit).

available_exit(X) :-
    is_exit(X),
    \+ unavailable_exit(X),
    \+ blocked_location(X).


% 5. CHECK SAFE CONNECTION
safe_connection(A, B) :-
    (connected(A, B) ; connected(B, A)),
    \+ blocked_connection(A, B),
    \+ blocked_connection(B, A),
    \+ blocked_location(A),
    \+ blocked_location(B).

% 6. PATH SEARCH USING DFS
% Avoid revisiting locations.

safe_path(Start, Exit, Path) :-
    \+ blocked_location(Start),
    dfs(Start, Exit, [Start], ReversePath),
    reverse(ReversePath, Path).

dfs(Current, Exit, Visited, Visited) :-
    Current = Exit,
    available_exit(Exit).

dfs(Current, Exit, Visited, Path) :-
    safe_connection(Current, Next),
    \+ member(Next, Visited),
    dfs(Next, Exit, [Next|Visited], Path).

% 7. SHORTEST ROUTE SELECTION

find_best_route(Start, BestRoute) :-
    findall(
        Length-Route,
        (
            available_exit(Exit),
            safe_path(Start, Exit, Route),
            length(Route, Length)
        ),
        Routes
    ),
    keysort(Routes, [_-BestRoute|_]).

% 8. DISPLAY LOCATION NAMES

location_name(room_a, 'Room A').
location_name(room_b, 'Room B').
location_name(corridor_1, 'Corridor 1').
location_name(corridor_2, 'Corridor 2').
location_name(staircase_1, 'Staircase 1').
location_name(staircase_2, 'Staircase 2').
location_name(exit_1, 'Exit 1').
location_name(exit_2, 'Exit 2').

% 9. DISPLAY ROUTE

print_route([X]) :-
    location_name(X, Name),
    write(Name).

print_route([X|Rest]) :-
    location_name(X, Name),
    write(Name),
    write(' -> '),
    print_route(Rest).

% 10. MAIN EVACUATION PREDICATE

evacuate(Start) :-
    nl,
    write('===================================='),
    nl,
    write('    EMERGENCY EVACUATION PLANNER'),
    nl,
    write('===================================='),
    nl,

    (
        location(Start, _)
        ->
        (
            write('Starting Location: '),
            location_name(Start, Name),
            write(Name),
            nl,

            (
                find_best_route(Start, Route)
                ->
                (
                    nl,
                    write('Route Found:'),
                    nl,
                    print_route(Route),
                    nl,
                    last(Route, Destination),
                    location_name(Destination, ExitName),
                    nl,
                    write('Destination: '),
                    write(ExitName),
                    nl,
                    write('Status: Route found.')
                )
                ;
                (
                    nl,
                    write('No safe evacuation route available.'),
                    nl,
                    write('Status: Evacuation route unavailable.')
                )
            )
        )
        ;
        (
            write('Invalid starting location.'),
            nl
        )
    ),
    nl.

% 11. INTERACTIVE START

start :-
    nl,
    write('Available locations:'),
    nl,
    write('room_a, room_b, corridor_1, corridor_2,'),
    nl,
    write('staircase_1, staircase_2, exit_1, exit_2'),
    nl,
    write('Enter starting location: '),
    read(Start),
    evacuate(Start).
