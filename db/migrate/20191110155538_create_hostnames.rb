class CreateHostnames < ActiveRecord::Migration[5.2]
  def change
    create_table :hostnames do |t|
      t.string :address, null: false, default: ""
      t.timestamps
    end
  end
end
