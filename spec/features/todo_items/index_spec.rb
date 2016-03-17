require 'spec_helper'

describe "viewing todo items" do

  before do
    allow_any_instance_of(ApplicationController).to receive(:require_user) { true }
  end

  let!(:todo_list) { TodoList.create(title: "Groceries", description: "List of Groceries") }

  it "displays the title of the todo list" do
    visit_todo_list(todo_list)
    within("h1.title") do
      expect(page).to have_content(todo_list.title)
    end
  end

  it "displays no items when todo list is empty" do
    visit_todo_list(todo_list)
    expect(page.all("table.todo_items li").size).to eq(0)
  end

  it "displays item content when a todo list has items" do
    todo_list.todo_items.create(content: "Milk")
    todo_list.todo_items.create(content: "Eggs")
    visit_todo_list(todo_list)
    expect(page.all("tbody.todo_items tr").size).to eq(2)
    within("table.todo_items") do
      expect(page).to have_content("Milk")
      expect(page).to have_content("Eggs")
    end
  end

end
