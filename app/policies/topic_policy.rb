class TopicPolicy < ApplicationPolicy

  def show?
    !record.deleted? || record.board.has_moderator?(user)
  end

  def update?
    signed_in? && record.board.has_moderator?(user)
  end

  def toggle_lock?
    if record.user == user || record.board.has_moderator?(user)
      if record.lock == 0
        return true
      else
        return true if (record.lock == 1 && record.user == user) || record.board.has_moderator?(user)
      end
    end
    false
  end

  def destroy?
    update?
  end

  def resume?
    update?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
