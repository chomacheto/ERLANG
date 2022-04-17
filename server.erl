-module(server).
-export([loop/1, start/1]).

start({N, Parent}) ->
    spawn(server, loop, [{N, Parent}]).

%P1(P0) -> P2(P1) -> .....PN(PN-1)

% 1. Create

loop({0, _Parent}) -> ok;

loop({N, Parent}) ->
    %receive
       %get_state -> io:format("State:~p ~n", [State]),
       %NewState = State;
       %{X, Y} -> io:format("X:~p, Y:~p ~n", [X,Y]),
       %NewState = {X, Y};
       %Any -> io:format("Any:~p~n", [Any]),
       %NewState = State
    %end,


    receive
        create_child -> Child = spawn(server, loop, [{N-1, self()}]),
                        io:format("N:~p, Child:~p~n", [N, Child]),
                        Child ! create_child;
        {do, X} -> M = X*X,
                   io:format("Me:~p N:~p, M:~p~n", [self(), N, M]),
                   Parent ! {do, M};
        Any -> Any
    end,
    loop({N-1, Parent}).


% process id to variable

% трябва да се предаде информацията нагоре от всеки процес