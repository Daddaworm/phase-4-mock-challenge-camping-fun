class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    
    # GET /activities
    def index
        activites = Activity.all 
        render json: activites
    end

    # DELETE /activites/:id
    def destroy
        activity = find_activity
        activity.destroy
        head :no_content
    end


    private

    def find_activity
        Activity.find(params[:id])
    end

    def activity_params
        params.permit(:name, :difficulty)
    end

    def render_not_found_response
        render json: { error: "Activity not found" }, status: :not_found
    end

end
