defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    items
  end

  def update_item(%{quality: quality, sell_in: sell_in} = item) do
    %{item | quality: quality - 1, sell_in: sell_in - 1}
  end
end
