class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      
      # NOTE: In the case 
      #         t.references :follower(ed), index: true, foreign_key
      #        it can't use on Postgres (Heroku).
      #        so, just removed.
      t.references :follower, index: true
      t.references :followed, index: true

      t.timestamps null: false
      
      t.index [:follower_id, :followed_id], unique: true
    end
  end
end
