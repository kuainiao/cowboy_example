-module(post_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, []) ->
  {ok, Req, undefined}.

handle(Req, State) ->
  {Method, _} = cowboy_req:method(Req),
  HasBody = cowboy_req:has_body(Req),
  {ok, Req2} = handle_params(Method, HasBody, Req),
  {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
  ok.

%% private
handle_params(<<"POST">>, true, Req) ->
  {ok, PostVals, Req2} = cowboy_req:body_qs(Req),
  Echo = proplists:get_value(<<"echo">>, PostVals),
  echo(Echo, Req2);
handle_params(<<"POST">>, false, Req) ->
  cowboy_req:reply(400, [], <<"Missing body.">>, Req);
handle_params(_, _, Req) ->
  %% Method not allowed.
  cowboy_req:reply(405, Req).

echo(undefined, Req) ->
  cowboy_req:reply(400, [], <<"Missing echo parameter.">>, Req);
echo(Echo, Req) ->
  cowboy_req:reply(200, [
    {<<"content-type">>, <<"text/plain; charset=utf-8">>}
  ], Echo, Req).