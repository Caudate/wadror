require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end
  
  it "shows in all ratings list and adds to all ratings number" do
    @ratings = ["2", "5", "6"]
    @ratings.each do |rating_score|
      visit new_rating_path
      select('iso 3', from:'rating[beer_id]')
      fill_in('rating[score]', with:rating_score)
      click_button "Create Rating"
    end
    visit ratings_path
    expect(page).to have_content "2"
    expect(page).to have_content "5"
    expect(page).to have_content "6"
    expect(page).to have_content "3"
  end

  it "shows in user's own page" do
    @ratings = ["2", "5", "6"]
    @ratings.each do |rating_score|
      visit new_rating_path
      select('iso 3', from:'rating[beer_id]')
      fill_in('rating[score]', with:rating_score)
      click_button "Create Rating"
    end
    FactoryGirl.create :rating, score: "10"
    visit user_path(user)
    expect(page).to have_content "2 " 
    expect(page).to have_content "5 "
    expect(page).to have_content "6 "
    expect(page).to_not have_content "10 "
  end

  it "can be destroyed by the user" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:"1")
    click_button "Create Rating"
    visit user_path(user)
    click_link "delete"  
    expect(user.ratings.count).to eq(0)
  end
end
