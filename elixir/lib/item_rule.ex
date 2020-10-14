defmodule ItemRule do
  def update_item(%Item{name: "Aged Brie"} = item) do
    item =
      cond do
        item.quality < 50 ->
          %{item | quality: item.quality + 1}

        true ->
          item
      end

    item = %{item | sell_in: item.sell_in - 1}

    cond do
      item.sell_in < 0 ->
        cond do
          item.quality < 50 ->
            %{item | quality: item.quality + 1}

          true ->
            item
        end

      true ->
        item
    end
  end

  def update_item(%Item{name: "Backstage passes to a TAFKAL80ETC concert"} = item) do
    item =
      cond do
        item.quality < 50 ->
          item = %{item | quality: item.quality + 1}

          item =
            cond do
              item.sell_in < 11 ->
                cond do
                  item.quality < 50 ->
                    %{item | quality: item.quality + 1}

                  true ->
                    item
                end

              true ->
                item
            end

          cond do
            item.sell_in < 6 ->
              cond do
                item.quality < 50 ->
                  %{item | quality: item.quality + 1}

                true ->
                  item
              end

            true ->
              item
          end

        true ->
          item
      end

    item = %{item | sell_in: item.sell_in - 1}

    cond do
      item.sell_in < 0 ->
        %{item | quality: item.quality - item.quality}

      true ->
        item
    end
  end

  def update_item(%Item{name: "Sulfuras, Hand of Ragnaros"} = item), do: item

  def update_item(item) do
    item =
      if item.quality > 0 do
        %{item | quality: item.quality - 1}
      else
        item
      end

    item = %{item | sell_in: item.sell_in - 1}

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
end
