defmodule CmarkPrecompiled.MixProject do
  use Mix.Project

  def project do
    [
      app: :cmark_precompiled,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
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
      test: ["deps.loadpaths", &copy_binary/1, "test"]
    ]
  end

  defp docs() do
    [
      main: "Cmark",
      source_url: "https://github.com/wojtekmach/cmark_precompiled",
      source_ref: "main"
    ]
  end

  defp copy_binary(_) do
    ext =
      case :os.type() do
        {:unix, _} -> "so"
        {:win32, _} -> "dll"
      end

    File.mkdir_p!("priv")
    File.cp!(Application.app_dir(:cmark, "priv/cmark.#{ext}"), "priv/cmark-#{target()}.#{ext}")
    :ok
  end

  def target() do
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
