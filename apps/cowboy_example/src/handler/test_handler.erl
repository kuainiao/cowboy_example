-module(test_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, [Options]) ->
  io:format("options ~p~n", [Options]),
  {ok, Req, undefined}.

handle(Req, State) ->
  {PathInfo, _} = cowboy_req:path(Req),
  {Arg1, _} = cowboy_req:binding(aa, Req),
  {Arg2, _} = cowboy_req:binding(bb, Req),
  io:format("test_handler path is ~p, arg1 ~p,arg2 ~p~n", [PathInfo, Arg1, Arg2]),
  {ok, Req, State}.

terminate(_Reason, _Req, _State) ->
  ok.