defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  @doc """
  Update the quality and sell in of the given items
  """
  def update_quality(items) do
    items
    |> Enum.map(&update_item/1)
  end

  @doc """
  Update the quality and sell in of the given item
  """
  def update_item(%{name: "Aged Brie", sell_in: sell_in} = item) do
    item
    |> adjust_quality(fn ->
      cond do
        sell_in <= 0 -> 2
        true -> 1
      end
    end)
    |> adjust_sell_in()
  end

  def update_item(
        %{name: "Backstage passes to a TAFKAL80ETC concert", quality: quality, sell_in: sell_in} =
          item
      ) do
    item
    |> adjust_quality(fn ->
      cond do
        sell_in <= 0 -> -quality
        sell_in <= 5 -> 3
        sell_in <= 10 -> 2
        true -> 1
      end
    end)
    |> adjust_sell_in()
  end

  def update_item(%{name: "Conjured", sell_in: sell_in} = item) do
    item
    |> adjust_quality(fn ->
      cond do
        sell_in <= 0 -> -4
        true -> -2
      end
    end)
    |> adjust_sell_in()
  end

  def update_item(%{name: "Sulfuras, Hand of Ragnaros"} = item), do: item

  def update_item(%{sell_in: sell_in} = item) do
    item
    |> adjust_quality(fn ->
      cond do
        sell_in <= 0 -> -2
        true -> -1
      end
    end)
    |> adjust_sell_in()
  end

  defp adjust_quality(%{quality: quality} = item, adjuster) do
    %{item | quality: compute_quality(quality, adjuster.())}
  end

  defp adjust_sell_in(%{sell_in: sell_in} = item) do
    %{item | sell_in: sell_in - 1}
  end

  defp compute_quality(quality, adjust) do
    (quality + adjust)
    |> max(0)
    |> min(50)
  end
end
