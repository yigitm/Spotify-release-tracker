# frozen_string_literal: true

class CreateNewreleases < ActiveRecord::Migration[6.1]
  def change
    create_table :newreleases do |t|
      t.string :artist
      t.string :album
      t.string :image
      t.string :track
      t.date :release_date

      t.timestamps
    end
  end
end
