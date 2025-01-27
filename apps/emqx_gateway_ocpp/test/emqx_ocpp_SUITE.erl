%%--------------------------------------------------------------------
%% Copyright (c) 2022 EMQ Technologies Co., Ltd. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%--------------------------------------------------------------------

-module(emqx_ocpp_SUITE).

-compile(export_all).
-compile(nowarn_export_all).

-include_lib("emqx/include/emqx.hrl").

-include_lib("eunit/include/eunit.hrl").
-include_lib("common_test/include/ct.hrl").

all() ->
    emqx_common_test_helpers:all(?MODULE).

init_per_suite(Conf) ->
    emqx_ct_helpers:start_apps([emqx_gateway_ocpp], fun set_special_cfg/1),
    Conf.

end_per_suite(_Config) ->
    emqx_ct_helpers:stop_apps([emqx_gateway_ocpp]).

set_special_cfg(emqx) ->
    application:set_env(emqx, allow_anonymous, true),
    application:set_env(emqx, enable_acl_cache, false),
    LoadedPluginPath = filename:join(["test", "emqx_SUITE_data", "loaded_plugins"]),
    application:set_env(
        emqx,
        plugins_loaded_file,
        emqx_ct_helpers:deps_path(emqx, LoadedPluginPath)
    );
set_special_cfg(_App) ->
    ok.

%%--------------------------------------------------------------------
%% Testcases
%%---------------------------------------------------------------------
