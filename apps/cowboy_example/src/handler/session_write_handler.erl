-module(session_write_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, []) ->
  {ok, Req, undefined}.

handle(Req, State) ->
  TestCookieVal = integer_to_list(random:uniform(1000000)),
  {ok, Req2} = cowboy_session:set(<<"test_session">>, TestCookieVal, Req),
  {ok, Req3} = cowboy_req:reply(200, [{<<"content-type">>, <<"text/html">>}], TestCookieVal, Req2),
  {ok, Req3, State}.

terminate(_Reason, _Req, _State) ->
  ok.