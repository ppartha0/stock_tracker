class Portfolio < ApplicationRecord
    belongs_to :user
    has_many :stocks, :dependent => :destroy
    
    validates :portname, :presence => true, :uniqueness => {:scope => :user_id}
end
