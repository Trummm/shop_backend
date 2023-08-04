class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :full_name
      t.string :address
      t.string :phone
      t.string :password_digest

      t.timestamps
    end
  end
end
