# frozen_string_literal: true

class DropSearches < ActiveRecord::Migration[6.1]
  def change
    drop_table :searches
  end
end
