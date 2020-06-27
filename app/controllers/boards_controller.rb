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
      render('boards/new')
    end
  end

end
