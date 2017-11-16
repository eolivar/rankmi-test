class Area < ActiveRecord::Base
	belongs_to :parent, class_name: "Area", foreign_key: "parent_id", required: false
  has_many :children, class_name: "Area", foreign_key: "parent_id"

  validates :name, presence: true
  validates :note, numericality: { greater_than_or_equal_to: 0 }

  after_commit :update_note_parent

  private

  # Updates the note attribute on every parent on each level
  def update_note_parent
    puts "HOLA #{self.id}"
    if !self.parent.nil?
      self.parent.note = self.parent.children.sum(:note) / self.parent.children.size
      puts "ID: #{self.id}"
      self.parent.save
    end
  end
end