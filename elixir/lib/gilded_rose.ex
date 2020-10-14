defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(%Item{name: "Aged Brie"} = item) do
    item
    |> (fn
          %{quality: quality, sell_in: sell_in} = item when sell_in <= 0 ->
            %{item | quality: quality + 2}

          %{quality: quality} = item ->
            %{item | quality: quality + 1}
        end).()
    |> normalize_quality()
    |> decrement_sell_in()
  end

  def update_item(%Item{name: "Backstage passes to a TAFKAL80ETC concert"} = item) do
    item
    |> (fn
          %{sell_in: sell_in} = item when sell_in <= 0 ->
            %{item | quality: 0}

          %{quality: quality} = item when quality >= 50 ->
            item

          %{quality: quality, sell_in: sell_in} = item when sell_in < 6 ->
            %{item | quality: quality + 3}

          %{quality: quality, sell_in: sell_in} = item when sell_in < 11 ->
            %{item | quality: quality + 2}

          %{quality: quality} = item ->
            %{item | quality: quality + 1}
        end).()
    |> normalize_quality()
    |> decrement_sell_in()
  end

  def update_item(%Item{name: "Sulfuras, Hand of Ragnaros"} = item), do: item

  def update_item(item) do
    item
    |> (fn
          %{quality: quality, sell_in: sell_in} = item when sell_in <= 0 ->
            %{item | quality: quality - 2}

          %{quality: quality} = item ->
            %{item | quality: quality - 1}
        end).()
    |> decrement_sell_in()
    |> normalize_quality()
  end

  defp decrement_sell_in(%{sell_in: sell_in} = item), do: %{item | sell_in: sell_in - 1}

  # Quality is always between 0 and 50
  defp normalize_quality(%{quality: quality} = item) do
    %{item | quality: quality |> min(50) |> max(0)}
  end
end
