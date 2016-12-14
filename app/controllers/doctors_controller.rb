class DoctorsController < ApplicationController
  before_action :find_id, only: [:show, :destroy]

  def index
    @doctors = Doctor.all
  end

  def show; end

  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)

    if @doctor.save
      redirect_to @doctor
    else
      render 'new'
    end
  end

  def destroy
    @doctor.destroy
    redirect_to doctors_path
  end

  private

  def doctor_params
    params.require(:doctor).permit(:name, :specialization)
  end

  def find_id
    @doctor = Doctor.find(params[:id])
  end
end
