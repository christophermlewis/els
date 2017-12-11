defmodule Els.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  use Supervisor 

  def start(_type, _args) do
    dispatch = :cowboy_router.compile([{:_, ELS.Routes.dispatch()}])    
    :cowboy.start_http(:http, 10,
      [port: 8000], [env: [dispatch: dispatch]]) 

    result = {:ok, sup} = Supervisor.start_link(__MODULE__, [])
    start_workers(sup)
    result
  end

  @repository_refresh 300000
  def start_workers(sup) do
    {:ok, _} =  Supervisor.start_child(sup, worker(Els.Repository, [])) 
    {:ok, _} = Supervisor.start_child(sup, supervisor(Els.SubSupervisor, [@repository_refresh]))
  end
  def init(_), do: supervise [], [strategy: :one_for_one, name: Els.Supervisor]
end
