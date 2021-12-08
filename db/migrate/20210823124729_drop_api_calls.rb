# frozen_string_literal: true

class DropApiCalls < ActiveRecord::Migration[6.1]
  def change
    drop_table :apicalls
  end
end
