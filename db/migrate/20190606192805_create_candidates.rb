class CreateCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :candidates do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :nick_name
      t.string :party
      t.string :status
      t.references :district, foreign_key: true
      t.date :election

      t.timestamps
    end
  end
end
