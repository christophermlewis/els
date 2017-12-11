defmodule ELS.Routes do
  alias ELS.Resources.{WebsocketStories, Stories}

  def dispatch() do 
    [
      {"/", :cowboy_static, {:priv_file, :els, "index.html"}},
      {"/api/stories/:id", Stories, []},
      {"/api/stories", Stories, []},
      {"/websocket/stories", WebsocketStories, []}
    ] 
  end
end
