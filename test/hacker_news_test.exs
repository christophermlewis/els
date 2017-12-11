defmodule Els.HackerNewsTest do
  use ExUnit.Case, async: true
  alias Els.HackerNews

  #was returning top 500, site now is hsowing 450 at this point in time
  test "should get the ids of the top stories" do
    assert HackerNews.top_stories() |> length > 0 
  end

  test "should get a story for a given id" do
    assert HackerNews.story(1) ==  %{"by" => "pg", "descendants" => 15, "id" => 1,
              "kids" => [487171, 15, 234509, 454410, 82729], "score" => 61,
              "time" => 1160418111, "title" => "Y Combinator",
              "type" => "story", "url" => "http://ycombinator.com"} 
  end

  test "should get details of the top N stories" do
    assert HackerNews.detailed_top_stories(2) |> Enum.count == 2   
  end


  end
