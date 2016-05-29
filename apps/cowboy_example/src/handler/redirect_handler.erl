-module(redirect_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, []) ->
  {ok, Req, undefined}.

handle(Req, State) ->
  {ok, Reply} = cowboy_req:reply(
    302,
    [{<<"Location">>, <<"http://www.baidu.com">>}],
    <<"Redirecting with Header!">>,
    Req
  ),
  {ok, Reply, State}.

terminate(_Reason, _Req, _State) ->
  ok.