class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :total_amount, default: 0
      t.integer :total_items, default: 0
      t.string  :status, default: 'Pending'

      t.timestamps
    end
  end
end
