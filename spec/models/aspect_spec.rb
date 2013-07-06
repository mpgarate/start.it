require 'spec_helper'

describe Aspect do
  it "is not valid without a brief and a user" do
    article = Aspect.create(brief: nil)
    article.should_not be_valid
    #make sure that a user exists
  end
  it "is not valid without a brief" do
    article = Aspect.create(brief: nil)
    article.should_not be_valid
  end
  it "is not valid without a user" do
    article = Aspect.create(brief: "Valid brief")
    article.should_not be_valid
  end
  it "is valid with a brief" do
    article = Aspect.create(brief: "Valid brief")
    article.should be_valid
  end

  it { should have_foreign_key_for(:ideas) }
end