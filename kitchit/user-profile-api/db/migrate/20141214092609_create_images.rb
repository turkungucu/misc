class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :profile, index: true
      t.string :public_id
      t.attachment :avatar

      t.timestamps
    end
    
    add_index :images, :public_id
  end
end
