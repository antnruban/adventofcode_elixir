defmodule Input do
  @input_file_path "./input"

  def read do
    {:ok, content} = File.read(@input_file_path)
    content
  end
end

defmodule Solution do
  @lift_up_char "("
  @lift_down_char ")"
  @basement_floor -1

  def resolve do
    Input.read()
    |> String.graphemes
    |> Enum.with_index
    |> Enum.reduce(0, fn(element, floor) -> handle_condition(element, floor) end)
  end

  def handle_condition({char, index}, floor) when char == @lift_up_char do
    detect_basement(floor, index)
    floor + 1
  end

  def handle_condition({char, index}, floor) when char == @lift_down_char do
    detect_basement(floor, index)
    floor - 1
  end

  def handle_condition(_, floor), do: floor

  def detect_basement(floor, index) when floor == @basement_floor do
    IO.puts("Alright...Basement on POSITION: #{index}")
  end

  def detect_basement(_,_) do
  end
end

#######
# IO.inspect(
#   Solution.resolve
# )
