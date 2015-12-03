class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.string :ad_id
      t.string :order_id
      t.string :adr

      t.timestamps null: false
    end
  end
end
