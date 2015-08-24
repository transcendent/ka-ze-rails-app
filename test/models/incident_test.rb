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

class IncidentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @account = Account.find_by email: 'test_account@test.com'
  end
  
  test "can't create an incident without a subject and description" do
    incident = Incident.create(account: @account)
    assert(incident.id == nil, 'incident should not have been created without a subject and description')
  end  
  
  test "can create an incident when provided with an account, subject and description" do
    incident = Incident.create(account: @account, subject: 'a subject', description: 'a description')
    assert(incident.id != nil, 'incident should have been created when provided with account, subject and description')
  end
  
  test "can create an incident with latitude and longitude attributes" do
    incident = Incident.create(account: @account, subject: 'a subject', description: 'a description', latitude: 43.647, longitude: -79.379)
    assert(incident.id != nil, 'incident should be created with provided with a subject, description, latitude and longitude')
  end


end
