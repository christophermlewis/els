defmodule Els.Resource.PagingTest do
  use ExUnit.Case
  alias Els.Resources.Paging

  test "Paging should provide range" do
   assert Paging.range(0) == 0..9 
   assert Paging.range(1) == 10..19 
   assert Paging.range(2) == 20..29 
  end 

  test "Total Pages should provide pagination" do
   assert Paging.total_pages(0) == 0 
   assert Paging.total_pages(9) == 1 
   assert Paging.total_pages(10) == 1 
   assert Paging.total_pages(11) == 2 
   assert Paging.total_pages(21) == 3 
  end
end
