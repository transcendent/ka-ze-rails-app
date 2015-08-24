json.array!(@incidents) do |incident|
  json.extract! incident, :id, :incident_number, :closed_date, :description, :is_closed, :status, :subject, :account_id, :latitude, :longitude
  json.extract! incident.account, :first_name, :last_name
  json.url incident_url(incident, format: :json)
end
