defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(%Item{name: "Aged Brie"} = item) do
    item
    |> quality_adjust(fn
          %{sell_in: sell_in} when sell_in <= 0 ->
            2

          _ ->
            1
        end)
    |> roll_day()
  end

  def update_item(%Item{name: "Backstage passes to a TAFKAL80ETC concert"} = item) do
    item
    |> quality_adjust(fn
          %{quality: quality, sell_in: sell_in} when sell_in <= 0 ->
            -quality

          %{sell_in: sell_in} when sell_in < 6 ->
            3

          %{sell_in: sell_in} when sell_in < 11 ->
            2

          _ ->
            1
        end)
    |> roll_day()
  end

  def update_item(%Item{name: "Sulfuras, Hand of Ragnaros"} = item), do: item

  def update_item(item) do
    item
    |> quality_adjust(fn
          %{sell_in: sell_in} when sell_in <= 0 ->
            -2

          _ ->
            -1
        end)
    |> roll_day()
  end

  def quality_adjust(%{quality: quality} = item, adjustment) do
    %{item | quality: quality + adjustment.(item)}
  end

  # normalize data and roll to the next day
  defp roll_day(item) do
    item
    |> decrement_sell_in()
    |> normalize_quality()
  end

  defp decrement_sell_in(%{sell_in: sell_in} = item), do: %{item | sell_in: sell_in - 1}

  # Quality is always between 0 and 50
  defp normalize_quality(%{quality: quality} = item) do
    %{item | quality: quality |> min(50) |> max(0)}
  end
end
