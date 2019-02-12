use strict;
use warnings FATAL => 'all';
use Test::Nginx::Socket::Lua;
use t::Util;

$ENV{TEST_NGINX_NXSOCK} ||= html_dir();

plan tests => repeat_each() * (blocks() * 3);

run_tests();

__DATA__

=== TEST 1: request.get_subsystem() returns http on regular http requests
--- http_config eval: $t::Util::HttpConfig
--- config
    location = /t {
        access_by_lua_block {
            local PDK = require "kong.pdk"
            local pdk = PDK.new()

            local subsystem = pdk.request.get_subsystem()

            ngx.say("subsystem=", subsystem)
        }
    }
--- request
GET /t
--- response_body
subsystem=http
--- no_error_log
[error]

=== TEST 2: returns http on error-handling requests from http
--- http_config eval
qq{
    $t::Util::HttpConfig

    server {
        server_name kong;
        listen unix:$ENV{TEST_NGINX_NXSOCK}/nginx.sock;

        error_page 400 /error_handler;

        location = /error_handler {
          internal;

          content_by_lua_block {
              local PDK = require "kong.pdk"
              local pdk = PDK.new()
              local subsystem = pdk.request.get_subsystem()
              local msg = "get_subsystem: '" .. subsystem .. "', type: " .. type(subsystem)
              -- must change the status to 200, otherwise nginx will
              -- use the default 400 error page for the body
              return pdk.response.exit(200, msg)
          }
        }

        location / {
          content_by_lua_block {
            error("This should never be reached on this test")
          }
        }
    }
}
--- config
    location = /t {
        content_by_lua_block {
            local sock = ngx.socket.tcp()
            sock:connect("unix:$TEST_NGINX_NXSOCK/nginx.sock")
            sock:send("invalid http request")
            ngx.print(sock:receive("*a"))
        }
    }

--- request
GET /t
--- response_body_like chop
HTTP.*? 200 OK(\s|.)+get_subsystem: 'http', type: string
--- no_error_log
[error]
