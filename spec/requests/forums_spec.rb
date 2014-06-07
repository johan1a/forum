require 'rails_helper'

RSpec.describe "Forums", :type => :request do
  describe "GET /forums" do
    it "works! (now write some real specs)" do
      get forums_path
      expect(response.status).to be(200)
    end
  end
end
