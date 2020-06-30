class TasksController < ApplicationController
  before_action :forbid_unuser, only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_user_task, only: [:edit, :update, :destroy]

  def show
    board = Board.find(params[:board_id])
    @task = board.tasks.find(params[:id])
  end

  def new
    board = Board.find(params[:board_id])
    @task = board.tasks.build
  end

  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.build(user_id: current_user.id, title: params[:title], content: params[:content], expiration: params[:expiration])

    if params[:eyecatch]
      @task.image_name = "#{@task.id}.jpg"
      eyecatch = params[:eyecatch]
      File.binwrite("public/eyecatches/#{@task.image_name}", eyecatch.read)
    end

    if @task.save
      redirect_to board_path(board), notice: 'added a task!'
    else
      flash[:notice] = 'failed to add a task'
      render("tasks/new")
    end
  end

  def edit
    board = Board.find(params[:board_id])
    @task = board.tasks.find(params[:id])
  end

  def update
    board = Board.find(params[:board_id])
    @task = board.tasks.find(params[:id])
    @task.title = params[:title]
    @task.content = params[:content]
    @task.expiration = params[:expiration]

    if params[:eyecatch]
      @task.image_name = "#{@task.id}.jpg"
      eyecatch = params[:eyecatch]
      File.binwrite("public/eyecatches/#{@task.image_name}", eyecatch.read)
    end

    if @task.save
      flash[:notice] = 'successfully updated task!'
      redirect_to board_task_path(board, @task)
    else
      flash[:notice] = 'failed to update'
      render("tasks/edit")
    end
  end

  def destroy
    board = Board.find(params[:board_id])
    @task = board.tasks.find(params[:id])
    @task.destroy!
    flash[:notice] = 'successfully deleted!'
    redirect_to board_path(board)
  end

  private
  def authenticate_user_task
    board = Board.find(params[:board_id])
    task = board.tasks.find(params[:id])
    if current_user.id != task.user_id
      redirect_to board_task_path(board, task), notice: 'You don\'t have right'
    end
  end

end
