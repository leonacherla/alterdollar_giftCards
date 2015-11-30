class CreateAdcheques < ActiveRecord::Migration
  def change
    create_table :adcheques do |t|
      t.uuid :ad_id
      t.uuid :order_id
      t.decimal :amount
      t.uuid :ad_code
      t.string :redemption_status

      t.timestamps null: false
    end
  end
end
