class AddFirstkanaToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :firstkana, :string
  end
end