class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :database_authenticatable
  
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :phone, :presence => true
  
  has_many :incidents, dependent: :destroy
  after_create :upsert_account_record_sfdc
  include ApplicationHelper
  
  protected
    def upsert_account_record_sfdc
      client = initialize_client
      # don't forget to include the external ID
      client.upsert!('Account', 'Rails_ID__c', Rails_ID__c: id, FirstName: first_name, LastName: last_name, PersonEmail: email, PersonTitle: title, Phone: phone)
      # lookup the record to get the account number
      account_number_will_change!
      self.account_number = client.find('Account', id, 'Rails_ID__c').Id
      self.save!
    end
  
end
