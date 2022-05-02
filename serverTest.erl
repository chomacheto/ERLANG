-module(serverTest).
-export([loop/1, start/1, startfunc/1, rpc/2]).

start(N) ->
    P0 = spawn(serverTest, loop, [{N, self(), self()}]),
    P0 ! create_server.

startfunc(F) ->
    spawn(serverTest, loop, [{my_functionality, F}]).

loop({0, Root, P0, {my_functionality, F}}) -> Root ! self();


loop({N, Root, P0, {my_functionality, F}}) ->
    State = {N, Root, P0, {my_functionality, F}},
    receive
        create_server -> NewChild = spawn(serverTest, loop, [{N-1, Root, self()}]),
                        NewState = {N, Root, NewChild},
                        io:format("N: ~p, Me:~p, NewChild: ~p~n", [N, self(), NewChild]),
                        NewChild ! create_server;

                        {Client, {change_functionality, NewF}} ->
                            NewState = {my_functionality, NewF},
                            Client ! {self(), functionality_changed};

                        {Client, Request} -> {_ ,_ ,_ , {my_functionality, F}} = State,
                                            Response = F(Request),
                                            Client ! {self(), Response},
                                            NewState = State;

        % create_child2 ->NewChild2 = spawn(serverTest, loop, [{N, Root, []}]),
        %             io:format("Child2 N: ~p, Me:~p, NewChild: ~p~n", [N, self(), NewChild2]),
        %             NewState = State;


        Any -> Any,
            NewState = State
    end,
loop(NewState).

rpc(Server, Request) ->
    Server ! {self(), Request},
    receive
        {Server, Response} -> Response
    end.
% rpc_receive(Server) ->
%     receive
%         {Server, Response} -> io:format("Response from the server:~p~n", [Response]),
%             Response;
%         Any -> io:format("Any from client:~p~n", [Any])
%     end.

% %-----------------------------------------------------------------

% client(Server, {calc, X}) ->
%     rpc(Server, {calc, X});

% client(Server, {calc, X, Y}) ->
%     rpc(Server, {calc, X, Y});

% client(Server, Request) ->
%     rpc(Server, Request).


%създаване на двуично дърво
% всеки сървър да бъде ерлангски сървърен процес
% обхождаме дървото и му порменяме функционалността