class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :stock_symbol
      t.references :portfolio, index: true

      t.timestamps null: false
    end
    add_foreign_key :stocks, :portfolios
  end
end
