-module(session_read_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, []) ->
  {ok, Req, undefined}.

handle(Req, State) ->
  {SessionVal, Req2} = cowboy_session:get(<<"test_session">>, <<"no session found">>, Req),
  {ok, Req3} = cowboy_req:reply(200, [{<<"content-type">>, <<"text/html">>}], SessionVal, Req2),
  {ok, Req3, State}.

terminate(_Reason, _Req, _State) ->
  ok.