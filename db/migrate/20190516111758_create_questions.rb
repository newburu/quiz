class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :category1
      t.string :category2
      t.string :category3
      t.text :msg

      t.timestamps
    end
  end
end
