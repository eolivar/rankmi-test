class Area < ActiveRecord::Base
	# It was created a self-reference to the model to accomplish the tree structure of the company
  belongs_to :parent, class_name: "Area", foreign_key: "parent_id", required: false
  has_many :children, class_name: "Area", foreign_key: "parent_id"

  validates :name, presence: true
  validates :note, numericality: { greater_than_or_equal_to: 0 }

  after_commit :update_note_parent

  # When an area loses one child, it's checked if it left totally without children
  # If an area loses all its children, the note for it should be zero
  def update_left_parent
    if !self.children.empty?
      self.children.first.save
    else
      self.note = 0
      self.save
    end
  end

  private

  # Updates the note attribute to every parent on each level
  def update_note_parent
    if !self.parent.nil?
      self.parent.note = self.parent.children.sum(:note) / self.parent.children.size
      self.parent.save
    end
  end
end