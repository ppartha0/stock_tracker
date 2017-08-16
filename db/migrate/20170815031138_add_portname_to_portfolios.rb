class AddPortnameToPortfolios < ActiveRecord::Migration[5.0]
  def change
    add_column :portfolios, :portname, :string
  end
end
