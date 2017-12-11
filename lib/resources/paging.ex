defmodule Els.Resources.Paging do

 def range(page,  per_page \\ 10), do: (page * per_page)..(page * per_page  + per_page - 1)
 def total_pages(total_results, per_page \\10), do: Float.ceil(total_results / per_page)
end
