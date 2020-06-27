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
    @board = Board.find(params[:id])
  end

  def update
    @board = Board.find(params[:id])
    @board.title = params[:title]
    @board.content = params[:content]
    @board.save
    redirect_to('/')
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    redirect_to('/')
  end

end
