class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.uuid :order_id
      t.string :receiver_name
      t.string :receiver_email
      t.integer :receiver_phone
      t.string :card_id
      t.decimal :amount
      t.string :order_status

      t.timestamps null: false
    end
  end
end
