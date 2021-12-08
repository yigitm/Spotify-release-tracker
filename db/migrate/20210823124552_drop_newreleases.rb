# frozen_string_literal: true

class DropNewreleases < ActiveRecord::Migration[6.1]
  def change
    drop_table :newreleases
  end
end
