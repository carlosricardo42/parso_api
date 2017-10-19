Class Api::V1::ApiKeysController < Api::V1::BaseController

  # #GET /api/v1/find_duplicates
  # #GET /api/v1/find_duplicates.json
  def find_duplicates
    binding.pry
    @api_key = ApiKey.find_by(api_key: params[:api_key])
    @data = params[:data]
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
end
