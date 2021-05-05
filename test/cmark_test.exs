defmodule CmarkTest do
  use ExUnit.Case, async: true

  test "to_html/2" do
    assert Cmark.to_html("*Hello*") == "<p><em>Hello</em></p>\n"
  end
end
