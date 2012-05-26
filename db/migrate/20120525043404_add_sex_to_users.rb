class AddSexToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sex, :char

  end
end
