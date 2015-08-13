class Incident < ActiveRecord::Base
  belongs_to :account
    
  validates :account, :presence => true
  validates :description, :presence => true
  validates :subject, :presence => true
    
end
