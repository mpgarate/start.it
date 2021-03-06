class Solution < ActiveRecord::Base
  include PublicActivity::Model
  include LabReputable
  after_create :add_first_vote
  validates :brief, presence: true, length: { maximum: 1250 }
  validates :user, presence: true
  validates :aspect, presence: true
  validates :idea, presence: true
  belongs_to :aspect
  belongs_to :idea
  belongs_to :user, -> { includes :profile }
  has_many :comments, as: :commentable, :dependent => :destroy
  
  def ids
    [['Solution', self.id]]
  end

  def Solution.user_stats(idea, user)
    Solution.where(idea_id: idea.id, user_id: user.id).length
  end
end
