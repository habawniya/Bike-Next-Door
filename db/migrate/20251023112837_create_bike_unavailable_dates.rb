class CreateBikeUnavailableDates < ActiveRecord::Migration[8.0]
  def change
    create_table :bike_unavailable_dates do |t|
      t.references :bike, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
