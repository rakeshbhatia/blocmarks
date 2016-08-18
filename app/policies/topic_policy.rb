class TopicPolicy < ApplicationPolicy
  def destroy?
    false
  end
end
