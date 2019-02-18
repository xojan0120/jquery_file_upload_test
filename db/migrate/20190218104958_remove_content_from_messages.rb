class RemoveContentFromMessages < ActiveRecord::Migration[5.1]
  def change
    remove_column :messages, :content, :string
  end
end
