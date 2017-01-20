class FavoritesController < ApplicationController
    before_action :logged_in_user
    
    def create
        @micrpost = Micropost.find(params[:micropost_id])
        favorites.find_or_create_by(user_id: current_user.id,micropost_id: @micropost)
    end
    
    def  destroy
        r = Favorite.find(params[:id])
        r.destroy if r.present?
    end    
        
end
