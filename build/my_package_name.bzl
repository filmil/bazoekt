# Copyright 2020 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Example rules to show package naming techniques."""

load("@rules_pkg//pkg:providers.bzl", "PackageVariablesInfo")

#
# Using a command line build setting to name a package.
#
def _name_part_from_command_line_naming_impl(ctx):
    values = {"name_part": ctx.build_setting_value}

    # Just pass the value from the command line through. An implementation
    # could also perform validation, such as done in
    # https://github.com/bazelbuild/bazel-skylib/blob/master/rules/common_settings.bzl
    return PackageVariablesInfo(values = values)

#
# Creating this build_setting defines a flag the user can set.
#
name_part_from_command_line = rule(
    implementation = _name_part_from_command_line_naming_impl,
    # Note that the default value comes from the rule instantiation.
    build_setting = config.string(flag = True),
)
