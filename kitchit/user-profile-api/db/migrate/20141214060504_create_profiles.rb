class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :public_id
      t.string :name
      t.string :email
      t.string :tagline

      t.timestamps
    end
    
    add_index :profiles, :public_id
  end
end
