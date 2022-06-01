class CreateGearPowers < ActiveRecord::Migration[5.2]
  
  def change
    create_table :gear_powers do |t|
      t.string :name
      t.string :image
      t.integer :gear_category
      t.timestamps
    end
  end
  
end
