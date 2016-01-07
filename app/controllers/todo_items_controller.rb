class TodoItemsController < ApplicationController

  def index
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def new
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_item = @todo_list.todo_items.new
  end

  def create
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_item = @todo_list.todo_items.new(todo_item_params)
    if @todo_item.save
      flash[:success] = "Added todo list item."
      redirect_to todo_list_todo_items_path(@todo_list)
    else
      flash[:error] = "There was a problem adding the todo item."
      render :new
    end
  end

  def edit
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_item = TodoItem.find(params[:id])
  end

  def update
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_item = TodoItem.find(params[:id])
    if @todo_item.update(todo_item_params)
      flash[:success] = "Todo item updated successfully."
      redirect_to todo_list_todo_items_path(@todo_list)
    else
      flash[:error] = "There was a problem updating the todo item."
      render :edit
    end
  end

  private
  def todo_item_params
    params[:todo_item].permit(:content)
  end

end
