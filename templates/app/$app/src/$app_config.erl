-module($app_config).

-behaviour(common_config).

-include_lib("id3as_common/include/record_mapper.hrl").

%% API
-export([
         start_link/0,
         web_port/0
        ]).

%% common_config callbacks
-export([
         init/0,
         commit_config/2,
         get/2,
         terminate/2,
         code_change/3
        ]).

-define(SERVER, ?MODULE).
-define(APPLICATION, $app).

-record($app_config, {
          web_port :: integer()
         }).
-type $app_config() :: #$app_config{}.

-export_type([$app_config/0]).

-record($app_config_state, {
         }).
%%------------------------------------------------------------------------------
%% API
%%------------------------------------------------------------------------------
start_link() ->
  common_config:start_link({local, ?SERVER}, #{application => ?APPLICATION,
                                               module => ?MODULE,
                                               record_definition => $app_config:record_definition(#$app_config{})}).

web_port() -> auto_get_value(web_port).

%%------------------------------------------------------------------------------
%% gen_server callbacks
%%------------------------------------------------------------------------------
init() ->
    {ok, #$app_config_state{}}.

commit_config(_Config, State) ->
  {ok, State}.

get(not_implemented, State) ->
  {ok, undefined, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%------------------------------------------------------------------------------
%% Internals
%%------------------------------------------------------------------------------
auto_get_value(Name) -> common_config:auto_get_value(?SERVER, Name).
