class IncidentsController < ApplicationController
  before_action :authenticate_account!
  before_action :set_incident, only: [:show, :edit, :update, :destroy]


  # GET /incidents
  # GET /incidents.json
  def index
    if current_account.viewAllIncidents
      @incidents = Incident.all
    else
      @incidents = Incident.where(account: current_account)
    end
    # render 'layouts/front_test'
  end

  # GET /incidents/1
  # GET /incidents/1.json
  def show
  end

  # GET /incidents/new
  def new
    @incident = Incident.new
  end

  # GET /incidents/1/edit
  def edit
  end

  # POST /incidents
  # POST /incidents.json
  def create
    @incident = Incident.new(incident_params)
    @incident.account = current_account
    @incident.status = "Pending"
    respond_to do |format|
      if @incident.save
        create_incident_record_sfdc
        format.html { redirect_to @incident, notice: 'Incident was successfully created.' }
        format.json { render :show, status: :created, location: @incident }
      else
        format.html { render :new }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incidents/1
  # PATCH/PUT /incidents/1.json
  def update
    # make sure that the account isn't inadvertently changed.
    incident_params[:account] = Incident.find(params[:id]).account
    # back to regular processing
    respond_to do |format|
      if @incident.update(incident_params)
        format.html {
          update_incident_record_sfdc
        redirect_to @incident, notice: 'Incident was successfully updated.' }
        format.json {
          update_incident_record_sfdc
          render :show, status: :ok, location: @incident
        }
      else
        @incident.error.each do |message|
          puts message
        end
        format.html { render :edit }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incidents/1
  # DELETE /incidents/1.json
  def destroy
    @incident.destroy
    respond_to do |format|
      format.html { redirect_to incidents_url, notice: 'Incident was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_incident
    @incident = Incident.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def incident_params
    params.require(:incident).permit(:incident_number, :closed_date, :description, :is_closed, :status, :subject, :account_id, :latitude, :longitude)
  end

  def update_incident_record_sfdc
    client = initialize_client
    client.upsert!('Case','Rails_ID__c', Rails_ID__c: @incident.id, Description: @incident.description, Subject: @incident.subject, AccountId: @incident.account.account_number, location__latitude__s: @incident.latitude, location__longitude__s: @incident.longitude)
  end

  def create_incident_record_sfdc
    client = initialize_client
    randomize_incident_id
    # don't forget to include the external ID
    client.create!('Case', Rails_ID__c: @incident.id, Description: @incident.description, Subject: @incident.subject, AccountId: @incident.account.account_number, location__latitude__s: @incident.latitude, location__longitude__s: @incident.longitude)
    @incident.incident_number =  client.find('Case', @incident.id, 'Rails_ID__c').CaseNumber
    @incident.save!
  end

  def randomize_incident_id
    @incident.id = Time.now.to_i
  end

end
