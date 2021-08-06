class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response


    # GET /campers
    def index
        campers = Camper.all 
        render json: campers
    end

    #GET /campers/:id
    def show
        camper = find_camper
        render json: camper
    end

    #POST /campers
    def create
        new_camper = Camper.create!(camper_params)
        render json: new_camper, status: :created
    end


    private

    def find_camper
        Camper.find(params[:id])
    end

    def camper_params
        params.permit(:name, :age)
    end

    def render_not_found_response
        render json: { error: "Camper not found" }, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
