﻿class LoginController < ApplicationController
  skip_before_action :check_logined
  def index
  end

  def auth
    # 入力値がユーザー情報に存在するかどうか認証する。
    ## 存在すれば、対象のオブジェクト
    ## 存在しなければnil
    usr = User.authenticate(params[:userid],params[:password])
    if usr then
      # セッションの初期化
      reset_session
      # セッションに対象のユーザーIDを保存
      session[:usr] = usr.id
      #セッションに対象のユーザーネームを保存
      session[:usrn] = usr.username
      # 指定のリダイレクト先へ移動
      #redirect_to params[:referer]
      redirect_to books_url
     else
      flash.now[:referer] = params[:referer]
      @error = 'ユーザーのID/パスワードが間違っています。'
      render 'index'
     end
  end
end
