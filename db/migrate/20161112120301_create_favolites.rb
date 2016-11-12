class CreateFavolites < ActiveRecord::Migration
  def change
    create_table :favolites do |t|
      # removed foreign_key_true for heroku/pg
      t.references :user, index: true
      t.references :micropost, index: true

      t.timestamps null: false
      t.index [:user_id, :micropost_id], unique: true
    end
  end
end
