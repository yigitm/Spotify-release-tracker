# frozen_string_literal: true

class CreateApicalls < ActiveRecord::Migration[6.1]
  def change
    create_table :apicalls do |t|
      t.string :token

      t.timestamps
    end
  end
end
