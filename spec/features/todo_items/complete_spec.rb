require 'spec_helper'

describe "Completing a todo item" do
  let!(:user) { create(:user) }
  let!(:todo_list) { user.todo_lists.create(title: "Groceries", description: "List of Groceries") }
  let!(:todo_item) { todo_list.todo_items.create(content: "Milk") }


  before do
    sign_in(user, password: "treehouse1")
  end

  it "is successful when marking a single item complete" do
    expect(todo_item.completed_at).to be_nil
    visit_todo_list(todo_list)
    within dom_id_for(todo_item) do
      click_link "Mark Complete"
    end
    todo_item.reload
    expect(page).to have_content("Item marked as complete")
    expect(todo_item.completed_at).to_not be_nil
  end

  context "with completed items" do
    let!(:completed_todo_item) { todo_list.todo_items.create(content: "Eggs", completed_at: 5.minutes.ago) }

    it "shows the completed items as complete" do
      visit_todo_list(todo_list)
      within dom_id_for(completed_todo_item) do
        expect(page).to have_content(completed_todo_item.completed_at)
      end

    end

    it "does not give the option to mark complete" do
      visit_todo_list(todo_list)
      within dom_id_for(completed_todo_item) do
        expect(page).to_not have_content("Mark Complete")
      end
    end

  end
end
