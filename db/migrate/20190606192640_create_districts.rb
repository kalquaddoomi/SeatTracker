class CreateDistricts < ActiveRecord::Migration[5.2]
  def change
    create_table :districts do |t|
      t.string :name
      t.integer :number
      t.string :district_type


      t.timestamps
    end
  end
end
