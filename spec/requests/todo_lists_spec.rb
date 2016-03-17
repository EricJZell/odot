require 'spec_helper'

describe "TodoLists" do
  describe "GET /todo_lists" do
    it "works! (now write some real specs)" do
      get todo_lists_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
