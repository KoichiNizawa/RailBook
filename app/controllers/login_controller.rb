class LoginController < ApplicationController
  skip_before_action :check_logined
  def index
  end

  def auth
    # 入力値がユーザー情報に存在するかどうか認証する。
    # 存在すれば、対象のオブジェクト
    # 存在しなければnil
    usr = User.authenticate(params[:userid],params[:password])
    if usr then
      # セッションの初期化
      reset_session
      # セッションに対象のユーザーのIDを保存
      session[:usr] = usr.id
      if params[:referer].present?
        # 指定のリダイレクト先へ移動
        redirect_to params[:referer]
      else
        # リダイレクト先の指定が無い場合、書籍一覧へ移動
        redirect_to controller: :books, action: :index
      end
    else
      flash.now[:referer] = params[:referer]
      @error = 'ユーザーID/パスワードが間違っています。'
      render 'index'
    end
  end
end
