class RenameColumnKeyToApiKey < ActiveRecord::Migration[5.1]
  def change
    rename_column :api_keys, :key, :api_key
  end
end
