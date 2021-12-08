# frozen_string_literal: true

class AddTokenToSearch < ActiveRecord::Migration[6.1]
  def change
    add_column :searches, :token, :string
  end
end
