# Copyright 2015 Deloitte. Inc
# 
# This file is part of Ka-Ze-Rails-App.
#
# Ka-Ze-Rails-App is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
# 
# Ka-Ze-Rails-App  is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Ka-Ze-Rails-App.  If not, see https://github.com/transcendent/ka-ze-rails-app/blob/master/LICENSE

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
