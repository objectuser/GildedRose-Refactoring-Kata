defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(%Item{name: "Aged Brie", sell_in: sell_in} = item) do
    item
    |> quality_rules_adjuster([{0, 2}, {sell_in, 1}])
    |> roll_day()
  end

  def update_item(%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: sell_in} = item) do
    item
    |> quality_rules_adjuster([{1, -item.quality}, {5, 3}, {10, 2}, {sell_in, 1}])
    |> roll_day()
  end

  def update_item(%Item{name: "Sulfuras, Hand of Ragnaros"} = item), do: item

  def update_item(%Item{name: "Conjured", sell_in: sell_in} = item) do
    item
    |> quality_rules_adjuster([{0, -4}, {sell_in, -2}])
    |> roll_day()
  end

  def update_item(%{sell_in: sell_in} = item) do
    item
    |> quality_rules_adjuster([{0, -2}, {sell_in, -1}])
    |> roll_day()
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

  defp quality_rules_adjuster(item, rules) do
    rules
    |> Enum.reduce_while(item, fn {sell_in, adjust}, item ->
      cond do
        item.sell_in <= sell_in -> {:halt, %{item | quality: item.quality + adjust}}
        true -> {:cont, item}
      end
    end)
  end
end
