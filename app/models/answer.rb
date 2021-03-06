class Answer < ActiveRecord::Base
  include PublicActivity::Model
  include LabReputable
  after_create :add_first_vote
  after_create :create_notification
  validates :brief, presence: true, length: { maximum: 1000 }
  validates :user, presence: true
  validates :question, presence: true
  belongs_to :question, inverse_of: :answers
  belongs_to :user, -> { includes :profile }, inverse_of: :answers
  has_many :comments, as: :commentable, :dependent => :destroy
  has_many :notifications

  def ids
    [['Answer', self.id]]
  end

  def Answer.user_stats(idea, user)
    questions = Question.where(idea_id: idea.id)
    count     = 0
    questions.each do |q|
      count += Answer.where(question_id: q.id, user_id: user.id).length
    end
    count
  end

  private
    def create_notification
      Notification.create(self.question, self.id, 'question_answer')
    end
end
