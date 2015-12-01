class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.uuid :ad_id
      t.uuid :order_id
      t.integer :adr

      t.timestamps null: false
    end
  end
end
