class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.string :ticker
      t.decimal :price
      t.integer :portfolio_id

      t.timestamps

    end
  end
end
