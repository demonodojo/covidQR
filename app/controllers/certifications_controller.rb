class CertificationsController < ApplicationController
  before_action :set_certification, only: %i[ show edit update destroy ]

  # GET /certifications or /certifications.json
  def index
    @certifications = Certification.all
  end

  # GET /certifications/1 or /certifications/1.json
  def show
  end

  # GET /certifications/new
  def new
    @certification = Certification.new
  end

  # GET /certifications/1/edit
  def edit
  end

  # POST /certifications or /certifications.json
  def create
    @certification = Certification.new(certification_params)

    respond_to do |format|
      if @certification.save
        format.html { redirect_to @certification, notice: "Certification was successfully created." }
        format.json { render :show, status: :created, location: @certification }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @certification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /certifications/1 or /certifications/1.json
  def update
    respond_to do |format|
      if @certification.update(certification_params)
        format.html { redirect_to @certification, notice: "Certification was successfully updated." }
        format.json { render :show, status: :ok, location: @certification }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @certification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /certifications/1 or /certifications/1.json
  def destroy
    @certification.destroy
    respond_to do |format|
      format.html { redirect_to certifications_url, notice: "Certification was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_certification
      @certification = Certification.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def certification_params
      params.require(:certification).permit(:name, :surname, :date_of_birth, :category, :qr_code, :disease_target, :vaccine_or_prophylaxis, :medicinal_product, :marketing_authorization_holder,
                                            :vaccination_country, :vaccination_date, :dose_number, :series_of_doses, :issuer_id, :uvci)
    end
end
