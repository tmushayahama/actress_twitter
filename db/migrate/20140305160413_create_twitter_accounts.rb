class CreateTwitterAccounts < ActiveRecord::Migration
  def change
    create_table :twitter_accounts do |t|
      t.string :actress
      t.string :twitter_url

      t.timestamps
    end
  end
end
