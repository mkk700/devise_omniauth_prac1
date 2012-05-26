class AddAgeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :age, :int

  end
end
