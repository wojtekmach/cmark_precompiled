defmodule Cmark do
  @external_resource "README.md"

  @moduledoc "README.md"
             |> File.read!()
             |> String.split("<!-- MDOC !-->")
             |> Enum.fetch!(1)

  @html_id 1

  @doc ~S"""
  Converts a Markdown document to HTML.

  ## Examples

      iex> Cmark.to_html("*Hello*")
      "<p><em>Hello</em></p>\n"

  """
  def to_html(document, options \\ []) when is_binary(document) and is_list(options) do
    convert(document, options, @html_id)
  end

  import Bitwise, only: [<<<: 2]

  # c_src/cmark.h -> CMARK_OPT_*
  @flags %{
    sourcepos: 1 <<< 1,
    hardbreaks: 1 <<< 2,
    nobreaks: 1 <<< 4,
    normalize: 1 <<< 8,
    validate_utf8: 1 <<< 9,
    smart: 1 <<< 10,
    unsafe: 1 <<< 17
  }

  defp convert(document, options, format_id) when is_integer(format_id) do
    flag = Enum.reduce(options, 0, &(Map.fetch!(@flags, &1) + &2))
    Cmark.Nif.render(document, flag, format_id)
  end
end

defmodule Cmark.Nif do
  @moduledoc false
  @on_load :init

  @target CmarkPrecompiled.MixProject.target()

  def init do
    path = :code.priv_dir(:cmark_precompiled) ++ '/cmark-#{@target}'
    :ok = :erlang.load_nif(path, 0)
  end

  def render(_data, _options, _format) do
    :erlang.nif_error(:undefined)
  end
end
