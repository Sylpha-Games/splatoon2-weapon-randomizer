class CreateSpecialWeapons < ActiveRecord::Migration[5.2]
  
  def change
    create_table :special_weapons do |t|
      t.string :name
      t.string :image
      t.timestamps
    end
  end
  
end
