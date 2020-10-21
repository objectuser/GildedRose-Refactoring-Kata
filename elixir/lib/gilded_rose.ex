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
  def update_item(%{name: "Aged Brie", quality: quality, sell_in: sell_in} = item) do
    quality_adjust =
      cond do
        sell_in <= 0 -> 2
        true -> 1
      end

    quality = compute_quality(quality, quality_adjust)

    %{item | quality: quality, sell_in: sell_in - 1}
  end

  def update_item(%{name: "Backstage passes to a TAFKAL80ETC concert", quality: quality, sell_in: sell_in} = item) do
    quality_adjust =
      cond do
        sell_in <= 0 -> 2
        sell_in <= 5 -> 3
        sell_in <= 10 -> 2
        true -> 1
      end

    quality = compute_quality(quality, quality_adjust)

    %{item | quality: quality, sell_in: sell_in - 1}
  end

  def update_item(%{name: "Conjured", quality: quality, sell_in: sell_in} = item) do
    quality_adjust =
      cond do
        sell_in <= 0 -> -4
        true -> -2
      end

    quality = compute_quality(quality, quality_adjust)

    %{item | quality: quality, sell_in: sell_in - 1}
  end

  def update_item(%{name: "Sulfuras, Hand of Ragnaros"} = item), do: item

  def update_item(%{quality: quality, sell_in: sell_in} = item) do
    quality_adjust =
      cond do
        sell_in <= 0 -> -2
        true -> -1
      end

    quality = compute_quality(quality, quality_adjust)

    %{item | quality: quality, sell_in: sell_in - 1}
  end

  defp compute_quality(quality, adjust) do
    (quality + adjust)
    |> max(0)
    |> min(50)
  end
end
