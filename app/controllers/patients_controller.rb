class PatientsController < ApplicationController
  before_action :find_doctor_id
 
  def create
    @patient = @doctor.patients.create(patient_params)
    redirect_to doctor_path(@doctor)
  end

  def destroy
    @patient = @doctor.patients.find(patient_params)
    @patient.destroy
    redirect_to doctor_path(@doctor)
  end

  private

  def patient_params
    params.require(:patient).permit(:name, :age)
  end

  def find_doctor_id
    @doctor = Doctor.find(params[:doctor_id])
  end
end
