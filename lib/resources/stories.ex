defmodule ELS.Resources.Stories do
  alias Els.Repository
  alias Els.Resources.Paging 

  def init(_, _, _), do: {:upgrade, :protocol, :cowboy_rest}
  def content_types_provided(request, state), do: {[{"application/json", :json_request}], request, state}
  def json_request(request, state), do: do_json_request(:cowboy_req.binding(:id, request), :id, state)

  def do_json_request({:undefined, request}, :id, state), do: do_json_request(:cowboy_req.qs_val("page[number]", request), state)
  def do_json_request({id, request}, :id ,state) do 
    {id, _} = Integer.parse(id)
    case Repository.stories(id) do 
      :error -> {%{error: "not found"} |>Poison.encode! ,request, state}
      story -> {story |> Poison.encode!, request, state}
    end
  end
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
