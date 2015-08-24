class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.string :incident_number
      t.date :closed_date
      t.string :description
      t.boolean :is_closed
      t.string :status
      t.string :subject
      t.belongs_to :account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
