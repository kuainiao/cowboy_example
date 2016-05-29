-module(cowboy_example_app).

-behaviour(application).

-export([start/2, stop/1]).

-define(C_ACCEPTORS, 100).

start(_StartType, _StartArgs) ->
    application:start(crypto),
    application:start(cowlib),
    application:start(ranch),
    application:start(cowboy),

    application:start(gproc),
    application:start(uuid),
    application:start(cowboy_session),

    Routes = route_helper:get_routes(),
    Dispatch = cowboy_router:compile(Routes),
    Port = 8080,
    ProtoOpts = [
        {env, [
            {dispatch, Dispatch}]},
        {middlewares, [cowboy_router, test_middleware, cowboy_handler]}
    ],

  TransOpts = [{port, Port}],
  cowboy:start_http(http, ?C_ACCEPTORS, TransOpts, ProtoOpts).

%%    PrivDir = "/Users/mmc/Projects/erlang",
%%    TransOpts = [
%%        {port, Port},
%%        {cacertfile, PrivDir ++ "/ssl/cowboy-ca.crt"},
%%        {certfile, PrivDir ++ "/ssl/server.crt"},
%%        {keyfile, PrivDir ++ "/ssl/server.key"}
%%    ],
%%    cowboy:start_https(https, ?C_ACCEPTORS, TransOpts, ProtoOpts).

stop(_State) ->
    ok.