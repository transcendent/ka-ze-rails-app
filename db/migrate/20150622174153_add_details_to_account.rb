class AddDetailsToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :account_number, :string
    add_column :accounts, :first_name, :string
    add_column :accounts, :last_name, :string
    add_column :accounts, :phone, :string
    add_column :accounts, :title, :string
  end
end
