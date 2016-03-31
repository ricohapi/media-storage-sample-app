class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :identifier, null: false
      t.string :access_token, null: false
      t.string :refresh_token
      t.timestamps null: false
    end
    add_index :accounts, :identifier, unique: true
  end
end
