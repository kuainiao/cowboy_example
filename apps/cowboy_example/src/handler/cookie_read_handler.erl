-module(cookie_read_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, []) ->
  {ok, Req, undefined}.

handle(Req, State) ->
  {CookieVal, _} = cowboy_req:cookie(<<"test_cookie">>, Req, <<"no cookie found">>),
  {ok, Req2} = cowboy_req:reply(200, [{<<"content-type">>, <<"text/html">>}], CookieVal, Req),
  {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
  ok.