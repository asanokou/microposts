class FavoritesController < ApplicationController
    before_action :logged_in_user
    
    def create
        @micropost = Micropost.find(params[:micropost_id])
        current_user.favorites.find_or_create_by(micropost_id: @micropost.id)
    end
    
    def  destroy
        @micropost = Favorite.find(params[:id]).micropost
        r = Favorite.find(params[:id])
        r.destroy if r.present?
    end    
        
end
