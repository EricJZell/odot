require 'spec_helper'

describe "creating todo lists" do
  it "redirects to the todo list index page on success" do
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: "My Todo List"
    fill_in "Description", with: "This is what I am doing today"
    click_button "Create Todo list"
    expect(page).to have_content("My Todo List")

  end

  it "displays an error when a todo list has no title" do
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: ""
    fill_in "Description", with: "This is what I am doing today"
    click_button "Create Todo list"
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
    visit "/todo_lists"
    expect(page).to_not have_content("This is what I am doing today")
  end

  it "displays an error when a todo list has title less than 3 characters" do
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: "Hi"
    fill_in "Description", with: "This is what I am doing today"
    click_button "Create Todo list"
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
    visit "/todo_lists"
    expect(page).to_not have_content("This is what I am doing today")
  end

  it "displays an error when a todo list has no description" do
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: "Grocery List"
    fill_in "Description", with: ""
    click_button "Create Todo list"
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
    visit "/todo_lists"
    expect(page).to_not have_content("Grocery List")
  end

  it "displays an error when a todo list has a description less than 5 characters" do
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: "Grocery List"
    fill_in "Description", with: "Tots"
    click_button "Create Todo list"
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
    visit "/todo_lists"
    expect(page).to_not have_content("Grocery List")
  end
end
