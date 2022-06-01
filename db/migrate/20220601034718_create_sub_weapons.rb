class CreateSubWeapons < ActiveRecord::Migration[5.2]
  
  def change
    create_table :sub_weapons do |t|
      t.string :name
      t.string :image
      t.timestamps
    end
  end
  
end
