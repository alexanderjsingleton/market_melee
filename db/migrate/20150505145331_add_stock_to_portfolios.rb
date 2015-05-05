class AddStockToPortfolios < ActiveRecord::Migration
  def change
    add_column :portfolios, :stock_id, :integer
    add_index :portfolios, :stock_id
  end
end
