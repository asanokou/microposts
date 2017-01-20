class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :followings, :followers]
  before_action :compare_user, only:[:edit, :update]
  
  def show
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def followings
    @users = @user.following_users.order(created_at: :desc)
  end
  
  def followers
    @users = @user.follower_users.order(created_at: :desc)
  end
  
  def show_favorites
    @microposts = @user.favorite_microposts.order(created_at: :des)
  end
    
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save # saveにバリデーションで失敗すると、falseを返す。そのとき、
                  # @user.errorsに値が入る。
      flash[:success] = "Welcom to the sample App!"
      redirect_to @user
      # @userみたいなActiveRecord::BaseのインスタンスがURLヘルパーで渡される場合、
      # showアクションに該当するURLヘルパーが使われる。
      # redirect_to user_path(@user) と同じ。
      # link_to 'ユーザーの詳細画面へ', @user
      # 一度UsersControllerのインスタンスを破棄して、アクセスをし直す。
      # @~~~~はインスタンス変数なので、@~~~も一緒になくなる。
    else
      render 'new'
      # ビューのレンダリングをして、ブラウザに結果を返す
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to @user , notice: 'プロフィールを変更しました'
    else
      render 'edit'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(
      :name, :email, 
      :password, :password_confirmation,
      :profile, :location
    )
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def compare_user
    redirect_to root_path if @user != current_user
  end
  
end
