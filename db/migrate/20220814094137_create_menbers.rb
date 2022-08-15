class CreateMenbers < ActiveRecord::Migration[6.1]
  def change
    create_table :menbers do |t|

      t.timestamps
    end
  end
end
