-module(get_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, []) ->
  {ok, Req, undefined}.

handle(Req, State) ->
  {Method, _} = cowboy_req:method(Req),
  {Val, _} = cowboy_req:qs_val(<<"test_get">>, Req),
  {ok, Req2} = handle_params(Method, Val, Req),
  {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
  ok.

%% private
handle_params(<<"GET">>, undefined, Req) ->
  cowboy_req:reply(400, [], <<"Missing echo parameter.">>, Req);
handle_params(<<"GET">>, Val, Req) ->
  cowboy_req:reply(200, [
    {<<"content-type">>, <<"text/plain; charset=utf-8">>}
  ], Val, Req);
handle_params(_, _, Req) ->
  %% Method not allowed.
  cowboy_req:reply(405, Req).