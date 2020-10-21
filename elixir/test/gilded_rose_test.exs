defmodule GildedRoseTest do
  use ExUnit.Case

  test "update list of items" do
    assert [
             %Item{name: "squab", quality: 16, sell_in: 2},
             %Item{name: "squab", quality: 14, sell_in: 1}
           ] ==
             [
               %Item{name: "squab", quality: 17, sell_in: 3},
               %Item{name: "squab", quality: 15, sell_in: 2}
             ]
             |> GildedRose.update_quality()
  end

  test "update brie" do
    assert %Item{
             name: "Aged Brie",
             quality: 2,
             sell_in: 8
           } ==
             %Item{name: "Aged Brie", quality: 1, sell_in: 9}
             |> GildedRose.update_item()
  end

  test "update brie past due" do
    assert %Item{
             name: "Aged Brie",
             quality: 3,
             sell_in: -2
           } ==
             %Item{name: "Aged Brie", quality: 1, sell_in: -1}
             |> GildedRose.update_item()
  end

  test "update brie high quality" do
    assert %Item{
             name: "Aged Brie",
             quality: 50,
             sell_in: -2
           } ==
             %Item{name: "Aged Brie", quality: 51, sell_in: -1}
             |> GildedRose.update_item()
  end

  test "update backstage pass" do
    assert %Item{
             name: "Backstage passes to a TAFKAL80ETC concert",
             quality: 2,
             sell_in: 19
           } ==
             %Item{name: "Backstage passes to a TAFKAL80ETC concert", quality: 1, sell_in: 20}
             |> GildedRose.update_item()
  end

  test "update backstage pass totally hyped" do
    assert %Item{
             name: "Backstage passes to a TAFKAL80ETC concert",
             quality: 50,
             sell_in: 4
           } ==
             %Item{name: "Backstage passes to a TAFKAL80ETC concert", quality: 49, sell_in: 5}
             |> GildedRose.update_item()
  end

  test "update backstage pass super quality" do
    assert %Item{
             name: "Backstage passes to a TAFKAL80ETC concert",
             quality: 8,
             sell_in: 4
           } ==
             %Item{name: "Backstage passes to a TAFKAL80ETC concert", quality: 5, sell_in: 5}
             |> GildedRose.update_item()
  end

  test "update backstage pass getting close" do
    assert %Item{
             name: "Backstage passes to a TAFKAL80ETC concert",
             quality: 6,
             sell_in: 9
           } ==
             %Item{name: "Backstage passes to a TAFKAL80ETC concert", quality: 4, sell_in: 10}
             |> GildedRose.update_item()
  end

  test "update backstage pass after event" do
    assert %Item{
             name: "Backstage passes to a TAFKAL80ETC concert",
             quality: 0,
             sell_in: -2
           } ==
             %Item{name: "Backstage passes to a TAFKAL80ETC concert", quality: 4, sell_in: -1}
             |> GildedRose.update_item()
  end

  test "update sulfuras" do
    assert %Item{
             name: "Sulfuras, Hand of Ragnaros",
             quality: 80,
             sell_in: 9
           } ==
             %Item{name: "Sulfuras, Hand of Ragnaros", quality: 80, sell_in: 9}
             |> GildedRose.update_item()
  end

  test "update sulfuras past date" do
    assert %Item{
             name: "Sulfuras, Hand of Ragnaros",
             quality: 80,
             sell_in: -1
           } ==
             %Item{name: "Sulfuras, Hand of Ragnaros", quality: 80, sell_in: -1}
             |> GildedRose.update_item()
  end

  test "update squab" do
    assert %Item{name: "squab", quality: 19, sell_in: 2} ==
             %Item{name: "squab", quality: 20, sell_in: 3}
             |> GildedRose.update_item()
  end

  test "update squab after sell in" do
    assert %Item{name: "squab", quality: 18, sell_in: -1} ==
             %Item{name: "squab", quality: 20, sell_in: 0}
             |> GildedRose.update_item()
  end

  test "update squab after sell in with low quality" do
    assert %Item{name: "squab", quality: 0, sell_in: -1} ==
             %Item{name: "squab", quality: 0, sell_in: 0}
             |> GildedRose.update_item()
  end

  test "update conjured" do
    assert %Item{name: "Conjured", quality: 18, sell_in: 2} ==
             %Item{name: "Conjured", quality: 20, sell_in: 3}
             |> GildedRose.update_item()
  end

  test "update conjured after sell in" do
    assert %Item{name: "Conjured", quality: 16, sell_in: -3} ==
             %Item{name: "Conjured", quality: 20, sell_in: -2}
             |> GildedRose.update_item()
  end
end
