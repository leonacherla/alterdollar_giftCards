class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :card_id
      t.string :template_category
      t.string :custom_conf
      t.string :template_image_url
      t.string :sender_username
      t.string :card_status
      t.string :card_amount

      t.timestamps null: false
    end
  end
end
