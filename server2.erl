-module(server2).
-export([loop/1, start/0, client/2, rpc_receive/1]).

start() -> spawn(server2, loop, [{}]).

%State = {}




loop(State) ->
    receive

        {Client, {mem_status}} -> Response = os:cmd("free"),
                                  Client ! {self(), Response};

        {Client, {calc, X}} ->  Response = X*X,
                                Client ! {self(), Response};

        {Client, {calc, X, Y}} -> Response = Y+X,
                                  Client ! {self(), Response};

        {Client, Request} -> Response = {Request},
                             Client ! {self(), Response};

        Any -> io:format("Any:~p~n", [Any])
    end,
    NewState = State,
    loop(NewState).

rpc(Server, Request) ->
    SyncPr = spawn(server2, rpc_receive, [Server]),
    io:format("SyncPr:~p~n", [SyncPr]),
    Server ! {SyncPr, Request},
    io:format("Hello from client!~n").

rpc_receive(Server) ->
    receive
        {Server, Response} -> io:format("Response from the server:~p~n", [Response]),
            Response;
        Any -> io:format("Any from client:~p~n", [Any])
    end.

%-----------------------------------------------------------------
client(Server, {mem_status}) ->
    rpc(Server, {mem_status});

client(Server, {calc, X}) ->
    rpc(Server, {calc, X});

client(Server, {calc, X, Y}) ->
    rpc(Server, {calc, X, Y});

client(Server, Request) ->
    rpc(Server, Request).

% simulate http request

%request poslednite tri reda na var/log/syslog
%ili proizvolna linux zaqvka

%bikove i kravi