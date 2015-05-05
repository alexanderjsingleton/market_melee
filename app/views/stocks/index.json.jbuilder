json.array!(@stocks) do |stock|
  json.extract! stock, :id, :stock_symbol, :portfolio_id
  json.url stock_url(stock, format: :json)
end
