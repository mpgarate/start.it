class Part < ActiveRecord::Base
  # Used to associate image galaries from bootsy to this model
  include Bootsy::Container
  has_many :part_uploads

  belongs_to :user
  belongs_to :component

  def idea
    @idea ||= idea_build.idea
  end

  def idea_build
    @idea_build ||= component.idea_build
  end

  # Used for part edit views
  def is_design?
    self.component.instance_of?(DesignComponent)
  end

  def is_prototype?
    self.component.instance_of?(PrototypeComponent)
  end

  def is_plan?
    self.component.instance_of?(PlanComponent)
  end

  def is_started?
    self.status == 'Started'
  end

  # Used for idea_build overview views
  def display_button?(user)
    self.status != 'Accepted' and (self.status == 'Unstarted' or display_link?(user))
  end

  def display_link?(user)
    (self.status == 'Started' and self.user == user) or user.admin
  end

  def disabled_button?(user)
    self.status != 'Accepted' and not user.admin
  end

  def locked?
    ib = component.idea_build
    (ib.plan_component.parts[0].status != 'Accepted' and (not self.is_plan?)) or
    (self.name == 'Prototype' and ib.prototype_component.parts.find_by(name: 'Flowchart and Schema').status != 'Accepted') or
    (self.name == 'Mockups' and ib.design_component.parts.find_by(name: 'Wireframes').status != 'Accepted')
  end

  def button_status
    case self.status
    when 'Unstarted'
      'Start'  
    when 'Started'
      'Finish'
    when 'Finished'
      'Revew'
    when 'In Review'  
      'Accept' 
    end
  end

end
