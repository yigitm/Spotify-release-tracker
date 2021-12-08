# frozen_string_literal: true

class AddAlbumIdToNewrelease < ActiveRecord::Migration[6.1]
  def change
    add_column :newreleases, :album_id, :string
  end
end
