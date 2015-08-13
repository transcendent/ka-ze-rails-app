require 'test_helper'

class IncidentsControllerTest < ActionController::TestCase

include Devise::TestHelpers

  setup do
    sign_in Account.find_by email: 'test_account@test.com'
    @incident = incidents(:one)
    @incident.account = Account.find_by email: 'test_account@test.com'
    @client = initialize_client
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:incidents)
    assert(assigns(:incidents).length == 2, 'expecting two incidents for the test_account@test.com user, got ' + assigns(:incidents).length.to_s)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create and update incident" do
    assert_difference('Incident.count') do
      post :create, incident: { closed_date: @incident.closed_date, description: 'hello',is_closed: @incident.is_closed, status: @incident.status, subject: @incident.subject}
    end
    assert_redirected_to incident_path(assigns(:incident))
    
    # check that the incident was created
    new_incident = Incident.find_by description: 'hello'
    assert(new_incident.incident_number != nil, 'Incident number should be set by SFDC')

    # check that we can update
    sfdc_id = @client.find('Case', new_incident.incident_number, 'CaseNumber').Id
    assert(sfdc_id != nil, 'SFDC id should not be nil')
    assert(new_incident.account != nil, 'Account should not be nil')
    patch :update, id: new_incident, incident: {account_id: @incident.account.id, closed_date: @incident.closed_date, description: 'goodbye', incident_number: @incident.incident_number, is_closed: @incident.is_closed, status: @incident.status, subject: @incident.subject }

    sfdc_incident = @client.find('Case', new_incident.incident_number, 'CaseNumber')
    assert(sfdc_incident.Description == 'goodbye', 'case in SFDC should be updated')
    remove_incident(new_incident.id)
  end

  test "should show incident" do
    get :show, id: @incident
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @incident
    assert_response :success
  end

#  test "should update incident" do
#    patch :update, id: @incident, incident: {closed_date: @incident.closed_date, description: 'goodbye', incident_number: @incident.incident_number, is_closed: @incident.is_closed, status: @incident.status, subject: @incident.subject }
#    assert_response :success
#    assert_not(new_incident == nil, 'Incident should be updated in SFDC')
#    description = @client.find('Case', new_incident.incident_number, 'Rails_ID__c').description
#    assert(description == 'goodbye', 'case in SFDC should be updated')  
#  end

  test "should destroy incident" do
    assert_difference('Incident.count', -1) do
      delete :destroy, id: @incident
    end

    assert_redirected_to incidents_path
  end
  
  test "should create an incident when provided with latitude and longitude" do
    assert_difference('Incident.count', 1) do
      post :create, incident: { closed_date: @incident.closed_date, description: @incident.description, is_closed: @incident.is_closed, status: @incident.status, subject: @incident.subject, latitude: 43.647, longitude: -79.379 }
    end
    assert_redirected_to incident_path(assigns(:incident))
  end

  
  def remove_incident(incident_id)
    sfdc_id = @client.find('Case', incident_id, 'Rails_ID__c').Id
    assert(@client.destroy('Case', sfdc_id), "case cannot be removed")
  end

end
