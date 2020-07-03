class BoardsController < ApplicationController
  before_action :forbid_unuser, only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:edit, :update, :destroy]

  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = current_user.boards.build
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to root_path, notice: 'successfully saved a board!'
    else
      flash.now[:error] = 'failed to save'
      render :new
    end
  end

  def edit
    @board = current_user.boards.find(params[:id])
  end

  def update
    @board = current_user.boards.find(params[:id])
    if @board.update(board_params)
      redirect_to root_path, notice: 'successfully updated a board!'
    else
      flash.now[:error] = 'failed to update'
      render :edit
    end
  end

  def destroy
    @board = current_user.boards.find(params[:id])
    @board.destroy!
    redirect_to root_path, notice: 'successfully deleted a board!'
  end

  private
  def authenticate_user
    board = Board.find(params[:id])
    if current_user.id != board.user_id
      redirect_to root_path, notice: 'You don\'t have right'
    end
  end

  def board_params
    params.require(:board).permit(:title, :content)
  end

end
