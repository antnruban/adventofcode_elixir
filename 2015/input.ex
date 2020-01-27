defmodule Input do
  @input_file_path "./input"

  def read do
    {:ok, content} = File.read(@input_file_path)
    content
  end
end
