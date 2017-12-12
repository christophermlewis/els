defmodule ELS.Resources.Stories do
  alias Els.Repository
  alias Els.Resources.Paging 

  def init(_, _, _), do: {:upgrade, :protocol, :cowboy_rest}
  def content_types_provided(request, state), do: {[{"application/json", :json_request}], request, state}

  def resource_exists(request, state), do: do_exists(:cowboy_req.binding(:id, request), state)

  def do_exists({:undefined, request}, state), do: {true, request, state}
  def do_exists({id, request}, state) do
    {id, _} = Integer.parse(id)
    case Repository.stories(id) do 
      :error -> {false, request, state}
      story -> {true, request, %{story: story}}
    end
  end 

  def json_request(request, state = %{story: story}), do: {story |> Poison.encode!, request, state} 
  def json_request(request, state), do: do_json_request(:cowboy_req.qs_val("page[number]", request), state)
  def do_json_request({:undefined, request}, state) do 
    { Repository.stories()|>Poison.encode!,request, state}
  end
  def do_json_request({page, request}, state) do
    {page, _} = Integer.parse(page)
    stories = Repository.stories
    |> Enum.reduce([], fn {_id, story}, acc -> 
          [story|acc] end)
    |> Enum.reverse

    paged = stories
    |> Enum.slice(Paging.range(page))

    response = %{"total-pages": stories |> Enum.count |> Paging.total_pages, "stories": paged} 
    |> Poison.encode!
   
    {response ,request, state}
  end
end
