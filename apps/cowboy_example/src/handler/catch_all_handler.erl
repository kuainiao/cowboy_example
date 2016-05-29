-module(catch_all_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, []) ->
  {ok, Req, undefined}.

handle(Req, State) ->
  {Path, _} = cowboy_req:path(Req),
  {PathList, _} = cowboy_req:path_info(Req),

  lists:foreach(
    fun(PathArg) ->
      io:format("catch_all_handler path is ~p, args ~p~n", [Path, PathArg])
    end,
    PathList
  ),
  {ok, Req, State}.

terminate(_Reason, _Req, _State) ->
  ok.