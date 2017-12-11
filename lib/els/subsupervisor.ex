defmodule Els.SubSupervisor do
  use Supervisor

  def start_link(interval) do
    {:ok, _pid} = Supervisor.start_link(__MODULE__, interval, name: __MODULE__)
  end
  def init(interval) do
    children = [worker(Els.HackerNews, [interval], restart: :temporary)]
    supervise children, [strategy: :one_for_one]
  end
end
