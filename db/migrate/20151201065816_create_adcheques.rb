class CreateAdcheques < ActiveRecord::Migration
  def change
    create_table :adcheques do |t|
      t.string :ad_id
      t.string :order_id
      t.decimal :amount
      t.string :adcode
      t.string :redemption_status

      t.timestamps null: false
    end
  end
end
