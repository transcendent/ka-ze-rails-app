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
