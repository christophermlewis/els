defmodule ELS.Resources.WebsocketStories do
  alias Els.Repository
  def init(_, _, _), do: {:upgrade, :protocol, :cowboy_websocket}
  def websocket_init(_TransportName, request, _opt) do
    :gproc.reg({:p, :l, :stories})
    :erlang.send_after(0, self(), :broadcast) 
    {:ok, request, :state}
  end
  def websocket_terminate(_, _, _), do: :ok
  def websocket_info(_, request, state) do 
    {:reply, {:text, Repository.stories()|> Poison.encode!}, request, state}
  end
end

