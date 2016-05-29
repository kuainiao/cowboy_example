-module(test_middleware).
-behaviour(cowboy_middleware).

-export([execute/2]).

%% 这个是回调函数
execute(Req, Env) ->
  io:format("in my middleware~n"),
  {ok, Req, Env}.
