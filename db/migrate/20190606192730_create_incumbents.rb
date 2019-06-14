class CreateIncumbents < ActiveRecord::Migration[5.2]
  def change
    create_table :incumbents do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :nick_name
      t.string :party
      t.date :elected
      t.integer :current_term
      t.references :district, foreign_key: true

      t.timestamps
    end
  end
end
