class ApiKeysController < ApplicationController
  before_action :set_api_key, only: [:show, :edit, :update, :destroy]
  before_action :set_md5_api_key, only: [:create, :update]
  # rescue_from StandardError, with: :standard_error
  # rescue_from ActiveRecord::RecordNotFound, with: :n  ot_found

  # GET /api_keys
  # GET /api_keys.json
  def index
    @api_keys = ApiKey.all
  end

  # GET /api_keys/1
  # GET /api_keys/1.json
  def show
  end

  # GET /api_keys/new
  def new
    @api_key = ApiKey.new
  end

  # GET /api_keys/1/edit
  def edit
  end

  # POST /api_keys
  # POST /api_keys.json
  def create
    @api_key = ApiKey.new(api_key_params)
    respond_to do |format|
      if @api_key.save
        format.html { redirect_to @api_key, notice: 'Api key was successfully created.' }
        format.json { render :show, status: :created, location: @api_key }
      else
        format.html { render :new }
        format.json { render json: @api_key.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api_keys/1
  # PATCH/PUT /api_keys/1.json
  def update
    respond_to do |format|
      if @api_key.update(api_key_params)
        format.html { redirect_to @api_key, notice: 'Api key was successfully updated.' }
        format.json { render :show, status: :ok, location: @api_key }
      else
        format.html { render :edit }
        format.json { render json: @api_key.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api_keys/1
  # DELETE /api_keys/1.json
  def destroy
    @api_key.destroy
    respond_to do |format|
      format.html { redirect_to api_keys_url, notice: 'Api key was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def find_duplicates
    # puts "#{@response}"
    binding.pry
    @key = params[:api_key]
    @api_key = ApiKey.find_by(api_key: params[:api_key])
    @data = params[:data]
    binding.pry
    respond_to do |format|
      if @api_key.blank?
        format.json { render json: {code: '401', status: :unauthorized}, status: :unauthorized }
        format.html { redirect_to api_keys_path, status: :unauthorized }
      else
        @duplicates = @api_key.get_duplicates(@data)
        @api_key.set_requests
        format.json { render json: {code: '200', status: :success, duplicates: @duplicates}, status: :ok}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_key
      @api_key = ApiKey.find(params[:id])
    end

    #Use Digest to set the api_key parameter
    def set_md5_api_key
      email =   params[:api_key][:email]
      params[:api_key][:api_key] = Digest::MD5.hexdigest(email) unless email.blank?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_key_params
      params.require(:api_key).permit(:email, :api_key, :requests, :data)
    end

    protected
    #Render standar error
    def standard_error(error)
      render status: :bad_request, json: { error: error.message }
    end
    #Render not found error
    def not_found(error)
      render status: :not_found, json: { error: error.message }
    end
end
