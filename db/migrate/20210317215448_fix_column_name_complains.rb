class FixColumnNameComplains < ActiveRecord::Migration[6.1]
  def change
  	rename_column :customer_complains, :type, :complain_type
  end
end
