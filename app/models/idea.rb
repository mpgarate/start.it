class Idea < ActiveRecord::Base
  include PublicActivity::Model
  include ActiveModel::Validations
  after_create :set_first_vote
  validates :phase, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :brief, presence: true, length: { maximum: 500 }
  validate :instance_validations
  validates_presence_of :category_list
  validates_presence_of :component_list
  belongs_to :user, inverse_of: :ideas
  has_many :questions, inverse_of: :idea, :dependent => :destroy
  has_many :solutions, inverse_of: :idea, :dependent => :destroy

  acts_as_taggable_on :categories, :components

  has_reputation :votes, source: :user, aggregated_by: :sum

  def image_aspect
    Aspect.find_or_create_by(title: "Image")
  end

  def instance_validations
  	validates_with MaxCategories
  end

  def set_first_vote
    self.add_or_update_evaluation(:votes, 1, self.user)
  end
end