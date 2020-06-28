class BoardsController < ApplicationController
  before_action :forbid_unuser, only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:edit, :update, :destroy]

  def index
    @boards = Board.all
  end

  def new
    @board = current_user.boards.build
  end

  def create
    @board = current_user.boards.build(title: params[:title], content: params[:content])
    if @board.save
      flash[:notice] = 'Successfully saved'
      redirect_to('/')
    else
      flash[:notice] = 'failed to save'
      render("boards/new")
    end
  end

  def edit
    @board = current_user.boards.find(params[:id])
  end

  def update
    @board = current_user.boards.find(params[:id])
    @board.title = params[:title]
    @board.content = params[:content]
    if @board.save
      flash[:notice] = 'Successfully updated'
      redirect_to('/')
    else
      flash[:notice] = 'failed to update'
      render("boards/edit")
    end
  end

  def destroy
    @board = current_user.boards.find(params[:id])
    @board.destroy!
    redirect_to root_path, notice: 'Successfully deleted'
  end

  private
  def forbid_unuser
    if !user_signed_in?
      redirect_to new_user_session_path, notice: 'You need to sign in'
    end
  end

  def authenticate_user
    board = Board.find(params[:id])
    if current_user.id != board.user_id
      redirect_to root_path, notice: 'You don\'t have right'
    end
  end

end
