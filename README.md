# CmarkPrecompiled

A drop-in replacement for [cmark.ex](https://github.com/asaaki/cmark.ex) that ships with
pre-compiled binaries.

## Usage

```elixir
iex> Mix.install([{:cmark_precompiled, github: "wojtekmach/cmark_precompiled"}])
iex> Cmark.to_html("*Hello*")
"<p><em>Hello</em></p>\n"
```

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
