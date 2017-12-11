defmodule ELS.Resources.StoriesTest do
  use ExUnit.Case

  setup_all do
    Els.Repository.update %{1 => :story, 2 => :story} 
  end

  test "GET should return all stories" do
    {:ok, %{status_code: status_code, body: body}} = HTTPoison.get("http://localhost:8000/api/stories" )
    assert status_code == 200
    assert body  == "{\"2\":\"story\",\"1\":\"story\"}"
  end

  test "GET with story id should that story" do
    {:ok, %{status_code: status_code, body: body}} = HTTPoison.get("http://localhost:8000/api/stories/1")
    assert status_code == 200
    assert body  == "\"story\""
  end

  test "GET with story id that doesn't exist should error" do
    {:ok, %{status_code: status_code, body: body}} = HTTPoison.get("http://localhost:8000/api/stories/3")
    assert status_code == 200
    assert body  == "{\"error\":\"not found\"}"
  end

  test "GET with page n should return the n paged results" do
    {:ok, %{status_code: status_code, body: body}} = HTTPoison.get("http://localhost:8000/api/stories?page[number]=2")
    assert status_code == 200
    assert body  == "{\"total-pages\":1.0,\"stories\":[]}"
  end


end
