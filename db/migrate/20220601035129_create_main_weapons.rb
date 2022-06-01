class CreateMainWeapons < ActiveRecord::Migration[5.2]
  
  def change
    create_table :main_weapons do |t|
      t.string :name
      t.string :image
      t.references :weapon_category, foreign_key: true
      t.references :sub_weapon, foreign_key: true
      t.references :special_weapon, foreign_key: true
      t.timestamps
    end
  end
  
end
