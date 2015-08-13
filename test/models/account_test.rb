require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @client = initialize_client
  end
  
  test "can create an account with an email, first name, last name and phone number" do
    account = Account.create!(email: 'mrtest@test.com', last_name: 'test', first_name: 'test', phone: '123 1234 1234', password: '123456pass')
    assert(account.id != nil, "account was not created in database")
    assert(account.account_number != nil, "account was not created in Salesforce.com")
    removeAccount account.id
  end
  
  test "can't create an account without an email" do
    account = Account.create(last_name: 'test', first_name: 'test', phone: '123 1234 1235', password: '123456pass')
    assert(account.id == nil, "account should not have been created")
  end
  
  def removeAccount(account_id)
    sfdc_id = @client.find('Account', account_id, 'Rails_ID__c').Id
    assert(@client.destroy('Account', sfdc_id), "account cannot be removed")
  end 

  
end
