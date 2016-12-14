class AddDoctorToPatients < ActiveRecord::Migration[5.0]
  def change
    add_column :patients, :doctor_id, :integer
    add_index :patients, :doctor_id
  end
end
