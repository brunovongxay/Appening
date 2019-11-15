class CreateParticipations < ActiveRecord::Migration[5.2]
  def change
    create_table :participations do |t|
      t.string :stripe_customer_id
      t.references :participant, index: true
      t.references :event, foreign_key: true, index: true


      t.timestamps
    end
  end
end
