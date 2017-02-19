defmodule TravelClient.API do
  @user_agent [ {"User-agent", "test-client"} ]
  @api_endpoint "https://api.skypicker.com"
  @default_duration 7

  def fetch(from, to, from_date, to_date) do
    format_dates(from_date, to_date)
    |> flights_url(from, to)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def format_dates(from, to) do
    from_formatted = Timex.format!(from, "%d/%m/%Y", :strftime)
    to_formatted = Timex.format!(to, "%d/%m/%Y", :strftime)
    { from_formatted, to_formatted }
  end

  def flights_url({from_date, to_date}, from, to) do
    "#{@api_endpoint}/flights?flyFrom=#{from}&to=#{to}" <>
    "&daysInDestinationFrom=#{@default_duration}" <>
    "&daysInDestinationTo=#{@default_duration}" <>
    "&dateFrom=#{from_date}&dateTo=#{to_date}" <>
    "&partner=picky"
  end

  def handle_response({ :ok, %{status_code: 200, body: body}}) do
    Poison.Parser.parse(body)
  end

  def handle_response({ _, %{status_code: _, body: body}}) do
    { :error, Poison.Parser.parse(body) }
  end
end
