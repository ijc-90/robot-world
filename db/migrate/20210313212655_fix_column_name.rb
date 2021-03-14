class FixColumnName < ActiveRecord::Migration[6.1]
  def change
  	rename_column :factory_queues, :type, :queue_type
  end
end
