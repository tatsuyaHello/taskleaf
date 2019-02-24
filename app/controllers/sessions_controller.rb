class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    # &.演算子はメソッドを呼び出されたオブジェクトがnilでない場合はその結果を、nilだった場合はnilを返す。
    # authenticateメソッドは has_secure_password を記述した時点で自動で追加された認証のためのメソッド。
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'ログインしました。'
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました。'
  end

  private
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
