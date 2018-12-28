class AddPasswordResetToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :reset_token_digest, :string
    add_column :users, :manager_id, :integer
  end
end
