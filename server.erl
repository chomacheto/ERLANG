-module(server).
-export([loop/1, start/1]).

start({N}) ->
    spawn(server, loop, [{N, self()}]) ! create_child,
    receive
        {getPid, Any} -> io:format("Any:~p~n", [Any])
    end.

%P1(P0) -> P2(P1) -> .....PN(PN-1)

% 1. Create

loop({0, Parent}) -> Parent ! {getPid, Parent};


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
        {getPid, X} -> Parent ! {getPid, X};

        Any -> Any
    end,
    loop({N, Parent}).


% process id to variable

% трябва да се предаде информацията нагоре от всеки процес