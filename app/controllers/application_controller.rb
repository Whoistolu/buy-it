class ApplicationController < ActionController::API

  # --- Error handling ---
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid,  with: :unprocessable
  rescue_from ActionController::ParameterMissing, with: :bad_request

  private

  def not_found(e)
    render json: {
      errors: [{ code: "not_found", detail: e.message }]
    }, status: :not_found
  end

  def unprocessable(e)
    render json: {
      errors: e.record.errors.map do |error|
        { code: "validation_error", detail: error.full_message, source: error.attribute }
      end
    }, status: :unprocessable_entity
  end

  def bad_request(e)
    render json: {
      errors: [{ code: "bad_request", detail: e.message }]
    }, status: :bad_request
  end
end