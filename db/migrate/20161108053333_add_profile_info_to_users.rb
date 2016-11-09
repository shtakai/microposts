class AddProfileInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile, :string
    add_column :users, :location, :string
    add_column :users, :url, :string
  end
end
