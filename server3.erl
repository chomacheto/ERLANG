-module(server3).
-export([func_name/1, start/1, rpc/2, loop/1]).

start() -> spawn(server, loop, [{my_functionality, F}]).


%-------------------------------------------------
func_name(0) ->
    ok;

func_name({F}) ->
    F(10);

func_name(_X) ->
    F = fun(Y) -> Y + 10;
            ([_Y]) -> 0;
            (1) -> 1
        end,
    F.
%----------------------------------------------------------------

%State = {my_functionality, F}

loop(State) ->
    receive

        {Client, Request} -> {my_functionality, F} = State,
                             Response = F(Request),
                             Client ! {self(), Response},
                             NewState = State;
                             Any -> io:format("Any:~p~n", [Any]),
                             NewState = State
    end,
    loop(NewState).

rpc(Server, Request) ->
    Server ! {self(), Request},
    receive
        {Server, Response} -> Response
    end.