class BoardsController < ApplicationController

  def index
    @boards = Board.all
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(title: params[:title], content: params[:content])
    if @board.save
      flash[:notice] = 'Successfully saved'
      redirect_to('/')
    else
      flash[:notice] = 'failed to save'
      render("boards/new")
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy
  end

end
