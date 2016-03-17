require 'spec_helper'

describe "editing todo lists" do
  let(:user) { create(:user) }

  before do
    sign_in(user, password: "treehouse1")
  end

  let!(:todo_list) { TodoList.create(title: "Groceries", description: "Grocery List") }

  def update_todo_list(options={})
    options[:title] ||= "My New Title"
    options[:description] ||= "My New Description"
    visit "/todo_lists"
    todo_list = options[:todo_list]
    within "#todo_list_#{todo_list.id}" do
      click_link "Edit"
    end
    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Update Todo list"
  end

  it "Updates a todo list successfully with correct information" do
    update_todo_list({ todo_list: todo_list, title: "My New Title", description: "My New Description" })
    todo_list.reload
    expect(page).to have_content("Todo list was successfully updated")
    expect(todo_list.title).to eq("My New Title")
    expect(todo_list.description).to eq("My New Description")
  end

  it "Displays an error if no title is entered" do
    update_todo_list({ todo_list: todo_list, title: "", description: "My New Description" })
    title = todo_list.title
    description = todo_list.description
    todo_list.reload
    expect(page).to have_content("error")
    expect(todo_list.title).to eq(title)
    expect(todo_list.description).to eq(description)
  end

  it "Displays an error if title is less than three characters" do
    update_todo_list({ todo_list: todo_list, title: "Hi", description: "My New Description" })
    title = todo_list.title
    description = todo_list.description
    todo_list.reload
    expect(page).to have_content("error")
    expect(todo_list.title).to eq(title)
    expect(todo_list.description).to eq(description)
  end

  it "Displays an error if no description is entered" do
    update_todo_list({ todo_list: todo_list, title: "My New Title", description: "" })
    title = todo_list.title
    description = todo_list.description
    todo_list.reload
    expect(page).to have_content("error")
    expect(todo_list.title).to eq(title)
    expect(todo_list.description).to eq(description)
  end

  it "Displays an error if description is less than five characters" do
    update_todo_list({ todo_list: todo_list, title: "My New Title", description: "YOLO" })
    title = todo_list.title
    description = todo_list.description
    todo_list.reload
    expect(page).to have_content("error")
    expect(todo_list.title).to eq(title)
    expect(todo_list.description).to eq(description)
  end

end
