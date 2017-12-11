defmodule ElsTest do
  use ExUnit.Case
  doctest Els

  test "greets the world" do
    assert Els.hello() == :world
  end
end
