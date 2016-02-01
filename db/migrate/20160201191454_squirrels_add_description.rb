class SquirrelsAddDescription < ActiveRecord::Migration
  def change
    add_column :squirrels, :description, :string
  end
end
