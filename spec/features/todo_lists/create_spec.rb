require 'spec_helper'

describe "creating todo lists" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:require_user) { true }
  end

  def create_todo_list(options={})
    options[:title] ||= "My Todo List"
    options[:description] ||= "This is my todo list"

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Create Todo list"
  end

  it "redirects to the todo list index page on success" do
    create_todo_list
    expect(page).to have_content("My Todo List")
  end

  it "displays an error when a todo list has no title" do
    expect(TodoList.count).to eq(0)
    create_todo_list(title: "")
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
    visit "/todo_lists"
    expect(page).to_not have_content("This is what I am doing today")
  end

  it "displays an error when a todo list has title less than 3 characters" do
    expect(TodoList.count).to eq(0)
    create_todo_list(title: "Hi")
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
    visit "/todo_lists"
    expect(page).to_not have_content("This is what I am doing today")
  end

  it "displays an error when a todo list has no description" do
    expect(TodoList.count).to eq(0)
    create_todo_list(description: "")
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
    visit "/todo_lists"
    expect(page).to_not have_content("Grocery List")
  end

  it "displays an error when a todo list has a description less than 5 characters" do
    expect(TodoList.count).to eq(0)
    create_todo_list(description: "YOLO")
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
    visit "/todo_lists"
    expect(page).to_not have_content("Grocery List")
  end
end
