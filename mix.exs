defmodule CmarkPrecompiled.MixProject do
  use Mix.Project

  @version "0.1.0-dev"

  def project do
    [
      app: :cmark_precompiled,
      version: @version,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      compilers: [:cmark | Mix.compilers()],
      deps: deps(),
      aliases: aliases(),
      docs: docs()
    ]
  end

  defp deps do
    [
      {:cmark, "~> 0.10.0", only: [:dev, :test, :docs]},
      {:ex_doc, ">= 0.0.0", only: :docs}
    ]
  end

  defp aliases() do
    [
      "compile.cmark": &compile/1,
      nif_filename: &nif_filename/1
    ]
  end

  defp docs() do
    [
      main: "Cmark",
      source_url: "https://github.com/wojtekmach/cmark_precompiled",
      source_ref: "main"
    ]
  end

  defp compile(_) do
    if Mix.env() in [:dev, :test, :docs] do
      copy_binary()
    else
      download_binary()
    end
  end

  defp nif_filename(_) do
    IO.puts(nif_filename())
  end

  defp copy_binary() do
    ext = nif_ext()
    src = :code.priv_dir(:cmark) ++ '/cmark.#{ext}'
    dest = Mix.Project.app_path() <> "/priv/cmark.#{ext}"
    File.mkdir_p!(Path.dirname(dest))
    File.cp!(src, dest)
  end

  defp download_binary() do
    repo = "wojtekmach/cmark_precompiled"
    ext = nif_ext()
    url = "https://github.com/#{repo}/releases/download/v#{@version}/#{nif_filename()}"
    dest = Mix.Project.app_path() <> "/priv/cmark.#{ext}"
    File.mkdir_p!(Path.dirname(dest))
    download(url, dest)
    :ok
  end

  defp download(url, dest) do
    0 = Mix.shell().cmd("curl --fail -L #{url} > #{dest}")
  end

  defp nif_filename() do
    "cmark-#{target()}.#{nif_ext()}"
  end

  defp nif_ext() do
    case :os.type() do
      {:unix, _} -> "so"
      {:win32, _} -> "dll"
    end
  end

  defp target() do
    case :string.split(:erlang.system_info(:system_architecture), '-', :all) do
      [cpu, _vendor, os | _] ->
        os = if List.starts_with?(os, 'darwin'), do: 'darwin', else: os
        cpu = if os == 'darwin' and List.starts_with?(cpu, 'arm'), do: 'aarch64', else: cpu
        "#{cpu}-#{os}"

      ['win32'] ->
        "x86_64-windows"
    end
  end
end
