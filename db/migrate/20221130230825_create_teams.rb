class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :city
      t.string :owner
      t.boolean :title_holder
      t.integer :titles_won
      t.timestamps
    end
  end
end
