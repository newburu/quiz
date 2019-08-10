class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.references :question, foreign_key: true
      t.string :slack_ts
      t.integer :status

      t.timestamps
    end
  end
end
