# CmarkPrecompiled

<!-- MDOC !-->

A drop-in replacement for [cmark.ex](https://github.com/asaaki/cmark.ex) that uses pre-compiled binaries.

## Usage

(Optionally, run inside a Docker container: `$ docker run --rm -it elixir:1.12 iex`)

```elixir
iex> Mix.install([{:cmark_precompiled, github: "wojtekmach/cmark_precompiled"}])
iex> Cmark.to_html("*Hello*")
"<p><em>Hello</em></p>\n"
```

<!-- MDOC !-->

## How does it work?

This projects works in two modes: in development and as a dependency.

In development, `:dev` and `:test` Mix environments, we depend on and compile the `cmark.ex` library and we copy its `cmark.so`. On CI, we upload `cmark.so` to a GitHub release, per supported OS.

When used as a dependency, `:prod` Mix environment, when compiling the project, we download the OS-specific shared library from the GitHub release.

## License

Copyright (c) 2021 Wojtek Mach

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
