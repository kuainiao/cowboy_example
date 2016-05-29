#!/bin/bash

rebar3 compile;

erl -sync executable auto -pa ../_build/default/lib/*/ebin -eval 'erlydtl:compile_file("../apps/cowboy_example/priv/templates/base.dtl", "base_dtl", [{out_dir,"../_build/default/lib/cowboy_example/ebin/"}])' -noshell -s init stop
erl -sync executable auto -pa ../_build/default/lib/*/ebin -eval 'erlydtl:compile_file("../apps/cowboy_example/priv/templates/included.dtl", "included_dtl", [{out_dir,"../_build/default/lib/cowboy_example/ebin/"}])' -noshell -s init stop
erl -sync executable auto -pa ../_build/default/lib/*/ebin -eval 'erlydtl:compile_file("../apps/cowboy_example/priv/templates/page.dtl", "page_dtl", [{out_dir,"../_build/default/lib/cowboy_example/ebin/"}])' -noshell -s init stop

cd ../
rebar3 shell