class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    # POST /signups
    def create
        new_signup = Signup.create!(signup_params)
        # byebug
        render json: new_signup.activity, status: :created
    end


    private

    def find_signup
        Signup.find(params[:id])
    end

    def signup_params
        params.permit(:camper_id, :activity_id, :time)
    end

    def render_not_found_response
        render json: { error: "Signup not found" }, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
