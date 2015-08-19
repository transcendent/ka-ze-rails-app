class AddViewAllIncidentsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :viewAllIncidents, :boolean
  end
end
