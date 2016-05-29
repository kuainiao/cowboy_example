-module(route_helper).

-export([get_routes/0]).

get_routes() ->
	[
		{'_', [
			{"/cookie_read", cookie_read_handler, []},
			{"/cookie_write", cookie_write_handler, []},
			{"/session_read", session_read_handler, []},
			{"/session_write", session_write_handler, []},

			{"/get", get_handler, []},
			{"/post", post_handler, []},

			{"/redirect", redirect_handler, []},

			{"/dtl", dtl_handler, []},

			{"/restful", restful_handler, []},

			{"/static/index", cowboy_static, {priv_file, cowboy_example, "my_static/index.html"}},
%%			{"/static/[...]", cowboy_static, {dir, "/var/www/assets"}},
%%          直接访问http://127.0.0.1:8080/assets/video.html
			{"/assets/[...]", cowboy_static, {priv_dir, cowboy_example, "my_static"}}
		]}
	].