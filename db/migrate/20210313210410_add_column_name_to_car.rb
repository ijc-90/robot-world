class AddColumnNameToCar < ActiveRecord::Migration[6.1]
  def change
    add_column :cars, :model_id, :integer
  end
end
