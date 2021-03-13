class CreateCars < ActiveRecord::Migration[6.1]
  def change
    create_table :cars do |t|
      t.string :wheels
      t.string :chassis
      t.string :laser
      t.string :computer
      t.string :engine
      t.integer :year
      t.integer :cost
      t.string :virtual_stock

      t.timestamps
    end
  end
end
