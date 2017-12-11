defmodule Els.Repository do
  use GenServer

  def start_link(), do: GenServer.start_link(__MODULE__, [], name: __MODULE__) 
  def update(stories = %{}), do: GenServer.cast(__MODULE__, {:update, stories}) 
  def stories(id), do: GenServer.call(__MODULE__, {:stories, id}) 
  def stories(), do: GenServer.call(__MODULE__, :stories)

  def init(_), do: {:ok, %{}}

  def handle_call({:stories, id}, _from, stories = %{}) do
    case Map.has_key?(stories, id) do
      true -> {:reply, stories[id], stories}
      false -> {:reply, :error, stories}
    end
  end

  def handle_call(:stories, _from, stories) do
    {:reply, stories, stories}
  end

  def handle_cast({:update, stories}, _state) do 
   :gproc.send({:p, :l, :stories}, :repository_refreshed)
    {:noreply, stories} 
  end
end
