-module(dtl_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, []) ->
  {ok, Req, undefined}.

handle(Req, State) ->
%%     这里的page_dtl是我们编译好的模板名
%%     erlydtl:compile_file("../templates/page.dtl", page_dtl).
%%     编译一个，included和base都会被编译，是因为同一个模板里面都引用了
  {ok, Body} = page_dtl:render([
    {client, <<"Client123">>},
    {server, <<"Server123">>}
  ]),
  {ok, Req2} = cowboy_req:reply(200,
    [{<<"content-type">>, <<"text/html">>}],
    Body, Req),
  {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
  ok.
