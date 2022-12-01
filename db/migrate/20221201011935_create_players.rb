class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :salary
      t.boolean :citizen
      t.boolean :trade_eligible
      t.integer :contract_length_months
      t.timestamps
    end
  end
end
