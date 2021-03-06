class CreateApiKeys < ActiveRecord::Migration[5.1]
  def change
    create_table :api_keys do |t|
      t.string :email
      t.string :key
      t.integer :requests, default: 0

      t.timestamps
    end
  end
end
