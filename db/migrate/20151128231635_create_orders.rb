class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :sender
      t.string :receiver_name
      t.string :receiver_email
      t.integer :receiver_phone
      t.string :gift_card_id
      t.decimal :amount

      t.timestamps null: false
    end
  end
end
