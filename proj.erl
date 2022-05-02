%% --------------------------------------------------------------------- %%
%% @author Alper K.
%% Task: 1. nishka ot procesi
%%       2. vseki edin porces ot tazi nishka da bude server proces
%% --------------------------------------------------------------------- %%

-module(proj).
-export([start_server/1, server/3, printer/1]).

server(Server, P1, P2) ->
  receive
    finished ->
      exit(normal);
    {Message} ->
      P1 !  {Message},
      P2 !  {Message},
      server(Server, P1, P2)
    end.

printer(ServerPid) ->
    receive
        finished->
            exit(normal);
        {Message} ->
            io:format("printer received msg ~p~n", [Message]),
            ServerPid ! finished
     end.
start_server(Server) ->
  P1 =  spawn(proj, printer, [self()]),
  P2 =  spawn(proj, printer, [self()]),
  spawn(proj, server, [Server, P1, P2]).