defmodule ItemRule do
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
    item =
      if item.quality > 0 do
        %{item | quality: item.quality - 1}
      else
        item
      end

    item = decrement_sell_in(item)

    cond do
      item.sell_in < 0 ->
        cond do
          item.quality > 0 ->
            %{item | quality: item.quality - 1}

          true ->
            item
        end

      true ->
        item
    end
  end

  defp decrement_sell_in(%{sell_in: sell_in} = item), do: %{item | sell_in: sell_in - 1}

  defp normalize_quality(%{quality: quality} = item), do: %{item | quality: min(quality, 50)}
end
