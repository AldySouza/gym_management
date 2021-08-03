defmodule Wabanex.IMC do
  def calculate(%{"filename" => filename}) do
    filename
    |> File.read()
    |> handle_file()
  end

  defp handle_file({:ok, content}) do
    data =
      content
      |> String.split("\r\n")
      |> Enum.map(fn line -> parse_line(line) end)
      |> Enum.into(%{})

      {:ok, data}
  end

  defp handle_file({:error, _reason}) do
    {:error, "Erro while opening the file"}
  end

  defp parse_line(line) do
    line
    |> String.split(",")
    |> List.update_at(1, &String.to_float/1) #mesma coisa que a função de cima 'fn line -> ...'
    |> List.update_at(2, &String.to_float/1)
    |> calculate_imc()
    |> IO.inspect()
  end

  defp calculate_imc([name, height, weight]), do: {name, weight / (height * height)}
end
