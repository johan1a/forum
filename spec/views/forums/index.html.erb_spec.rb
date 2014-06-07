require 'rails_helper'

RSpec.describe "forums/index", :type => :view do
  before(:each) do
    assign(:forums, [
      Forum.create!(
        :name => "Name",
        :description => "MyText"
      ),
      Forum.create!(
        :name => "Name",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of forums" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
