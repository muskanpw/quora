class AddDetailsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :cont_no, :integer
  end
end
