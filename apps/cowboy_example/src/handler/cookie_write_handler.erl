-module(cookie_write_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, []) ->
  {ok, Req, undefined}.

handle(Req, State) ->
  TestCookieVal = integer_to_list(random:uniform(1000000)),
  Req2 = cowboy_req:set_resp_cookie(<<"test_cookie">>, TestCookieVal, [{path, <<"/">>}], Req),
  {ok, Req3} = cowboy_req:reply(200, [{<<"content-type">>, <<"text/html">>}], TestCookieVal, Req2),
  {ok, Req3, State}.

terminate(_Reason, _Req, _State) ->
  ok.