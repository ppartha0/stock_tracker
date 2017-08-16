class Stock < ApplicationRecord
    belongs_to :portfolio
    belongs_to :user
    
    validates :portfolio_id, :presence => true
    validates :price, :presence => true, :numericality => true
    validates :ticker, :presence => true, :uniqueness => {:scope => [:price, :portfolio_id]}
end
