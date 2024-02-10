# frozen_string_literal: true

class AddFirstAndLastNameEmailToUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users, bulk: true do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
    end
  end
end
