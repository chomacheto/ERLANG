%% ------------------------------------------------------------- %%
%% @author Ivan Chomakov
%% Task: 1. Create binary tree
%%       2. client-server model
%% ------------------------------------------------------------- %%
-module(binarytree).
% -compile(export_all).
-export([start/1, loop/4]).

% start(N) ->
%   Start = spawn(binarytree, loop, [{N, self(), fun(X) -> X * X end}]),
%   Start ! create_child,
%   receive
%     {last_process, Pid, First} ->
%       Last = Pid
%   end,
%   Last.

start(N) ->
    P = spawn(binarytree, loop, [N, self(), self(), self()]),
    P ! create_nodes.

% client(Server, {start}) ->
%   Server ! create_child,
%   receive
%     {get, X} ->
%       State = X
%   end,
%   State.

% rpc(State = {N, FirstPid, LastPid}) ->
%   receive
%     start ->
%       NewStart = spawn(binarytree, loop, [{N, self(), []}]),
%       NewStart ! create_child,
%       NewState = {N, NewStart, LastPid};
%     {setState, X} ->
%       NewState = {N, FirstPid, X};
%     {setRing} ->
%       NewState = State,
%       LastPid ! {changeChild, FirstPid},
%       client ! {get, FirstPid}
%   end,
% rpc(State).

% loop({0, Client, _Child, _Fun}) -> Client ! {setRing};
loop(0, _Root, _LeftNode, _RightNode) ->
  ok;
loop(N, Root, LeftNode, RightNode) ->
 receive
  create_nodes ->
    MyPid = self(),
    NewRightNode = spawn(binarytree, loop, [N-1, MyPid, "", ""]),
    io:format("Right node:~p~n", [NewRightNode]),
    NewLeftNode = spawn(binarytree, loop, [N-1, MyPid, "", ""]),
    io:format("Left node:~p~n", [NewLeftNode]),
    NewRightNode ! create_nodes,
    NewLeftNode ! create_nodes,
    loop(N, Root, NewLeftNode, NewRightNode);

  _ -> ok
end,
loop(N, Root, LeftNode, RightNode).

% loop(State = {N, Client, Child, Fun}) ->
%   receive
%     create_child -> NewChild = spawn(binarytree, loop, [{N-1, Client, Child, Fun}]),
%       NewState = {N, Client, NewChild, Fun},
%       io:format("N: ~p Me: ~p NewChild: ~p LINE: ~p~n", [N, self(), Child, ?LINE]),
%       Client ! {setState, NewChild},
%       NewChild ! create_child;
%     {do, X} ->
%       io:format("N:~p Me:~p NewChild:~p LINE: ~p~n", [N, self(), Child, ?LINE]),
%       A = Fun(X),
%       Child ! {do, X},
%       NewState = State;
%     {changeFun, F} ->
%       NewState = {N, Client, Child, F},
%       Child ! {changeFun, F};
%     {changeChild, X} ->
%       io:format("N: ~p CurrentChild: ~p NewChild:~p~n", [N, Child, X]),
%       NewState = {N, Client, X, Fun};
%     Any -> Any,
%       NewState = State
%   end,
%   loop(NewState).

