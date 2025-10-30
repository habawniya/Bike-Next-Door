class AddContactNumberToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :contact_number, :string
  end
end
