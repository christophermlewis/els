defmodule Els.HackerNews do
  use GenServer
  require Logger
  alias Els.Repository

  def start_link(interval), do: GenServer.start_link(__MODULE__, interval, name: __MODULE__)

  def init(interval) do 
    :erlang.send_after(0, self(), :refresh)
    {:ok, interval}
  end

  def handle_info(:refresh, interval ) do
    stories = detailed_top_stories(50)
    :erlang.send_after(interval, self(), :refresh)
    Repository.update(stories)
    Logger.info("Refreshed")
    {:noreply, interval} 
  end

  def top_stories() do %{body: body} = HTTPoison.request!(:get, "https://hacker-news.firebaseio.com/v0/topstories.json") 
    body 
    |> Poison.decode!
  end

  def story(id) do
    %{body: body} = HTTPoison.request!(:get, "https://hacker-news.firebaseio.com/v0/item/#{id}.json?print=pretty")
    body 
    |> Poison.decode!
  end

  def detailed_top_stories(total) do
    top_stories()
    |> Enum.take(total)
    |> Enum.reduce(%{}, fn id, acc -> 
        Map.merge(acc, %{id => story(id)}) end)
  end
end
