defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    items
  end

  def update_item(%{name: "Conjured", quality: quality, sell_in: sell_in} = item) do
    quality_adjust =
      cond do
        sell_in <= 0 -> -4
        true -> -2
      end

    quality = max(quality + quality_adjust, 0)

    %{item | quality: quality, sell_in: sell_in - 1}
  end

  def update_item(%{name: "Sulfuras, Hand of Ragnaros"} = item), do: item

  def update_item(%{quality: quality, sell_in: sell_in} = item) do
    quality_adjust =
      cond do
        sell_in <= 0 -> -2
        true -> -1
      end

    quality = max(quality + quality_adjust, 0)

    %{item | quality: quality, sell_in: sell_in - 1}
  end
end
