class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.text :name, :null => false
      t.text :token, :null => false
      t.datetime :last_request_at, :null => false

      t.timestamps
    end
    
    add_index :devices, :token, unique: true
  end
end
