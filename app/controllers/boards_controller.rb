class BoardsController < ApplicationController

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
      flash[:notice] = 'Successfully saved'
      redirect_to('/')
    else
      flash[:notice] = 'failed to save'
      render("boards/edit")
    end
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    redirect_to('/')
  end

end
