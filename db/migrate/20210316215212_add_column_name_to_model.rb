class AddColumnNameToModel < ActiveRecord::Migration[6.1]
  def change
    add_column :models, :cost, :float
    add_column :models, :price, :float
  end
end
