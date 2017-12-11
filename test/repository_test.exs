defmodule Els.RepositoryTest do
  use ExUnit.Case
   alias Els.Repository 

  test "Stories" do
    Repository.update %{a: :story}
    assert Repository.stories == %{a: :story}
  end

  test "Stories by id" do
    Repository.update %{a: :story}
    assert Repository.stories(:a) == :story 
    assert Repository.stories(:not_there) == :error 
  end

  test "refreshes repository" do
    :gproc.reg({:p, :l, :stories})
    Repository.update %{a: :story}
    :timer.sleep 1000
    assert_received :repository_refreshed
  end

end
