require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is not saved without a style" do 
    beer = Beer.create name:"Kalja"
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a name" do 
    beer = Beer.create style:"litku"
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  describe "with name and style" do 
    let(:beer){ Beer.create name:"Kalja", style:"litku"}
    
    it "is saved" do  
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end 
  end
end
