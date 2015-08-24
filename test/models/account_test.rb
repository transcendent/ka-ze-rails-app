# Copyright 2015 Deloitte. Inc
# 
# This file is part of Ka-Ze-Rails-App.
#
# Ka-Ze-Rails-App is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
# 
# Ka-Ze-Rails-App is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Ka-Ze-Rails-App.  If not, see https://github.com/transcendent/ka-ze-rails-app/blob/master/LICENSE

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
