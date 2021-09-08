class RelationshipsController < ApplicationController
  # ——————フォロー機能を作成・保存・削除する————————————
  def create
    current_user.follow(params[:user_id])
    # ↓通知の作成
    current_user.create_notification_follow!(current_user)
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  # ————————フォロー・フォロワー一覧を表示する-————————————
  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings.page(params[:page]).reverse_order
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.page(params[:page]).reverse_order
  end
end
