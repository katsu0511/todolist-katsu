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
    @board = current_user.boards.build(title: params[:title], content: params[:content])
    if @board.save
      flash[:notice] = 'successfully saved a board!'
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
      flash[:notice] = 'successfully updated a board!'
      redirect_to('/')
    else
      flash[:notice] = 'failed to update'
      render("boards/edit")
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

end
