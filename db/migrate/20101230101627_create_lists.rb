class CreateLists < ActiveRecord::Migration
  def self.up
    create_table :lists do |t|
      t.string :url
      t.string :list
      t.datetime :lastedited
      t.datetime :lastviewed

      t.timestamps
    end
  end

  def self.down
    drop_table :lists
  end
end
