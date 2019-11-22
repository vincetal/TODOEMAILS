class TasksController < ApplicationController
before_action :authenticate_user!
  def new
    @categories = Category.all
  end

  def create
    @task = Task.new(task_params)
    @category = Category.find(category_params)
    @task.category = @category
    @category_html_id = @category.title.gsub(/ /,'-')

    respond_to do |format|
      if @task.save
        format.html { redirect_to root_path, notice: 'Task created.' }
        format.js { }
      else
        format.html {  redirect_to root_path, notice: 'Please try again.'  }
        format.js { }
      end
    end

  end

  def edit
    @task = Task.find(params[:id])
    @categories = Category.all

  end

  def update
    @task = Task.find(params[:id])
    #@task.update(task_params)
    if params[:share]
      #@task.update(status: true)
      @task.status = true
    else
      #@task.update(status: false)
      @task.status = false
    end

    respond_to do |format|
      if @task.save
        format.html { redirect_to root_path, notice: 'Task edited.' }
        format.js { }
      else
        format.html {  redirect_to root_path, notice: 'Please try again.'  }
        format.js { }
      end
    end
    #redirect_to tasks_path
    #flash[:notice] = "Task edited"
  end

  def index
    @tasks = Task.all
  end

  def destroy
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.destroy
        format.html { redirect_to root_path, notice: 'Task edited.' }
        format.js { }
      else
        format.html {  redirect_to root_path, notice: 'Please try again.'  }
        format.js { }
      end
    end
  end


  private

  def task_params
    params.permit(:title, :deadline, :description, :share)
  end

  def category_params
    params.require(:Category)
  end

end
