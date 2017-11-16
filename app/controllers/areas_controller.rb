class AreasController < ActionController::Base
  before_action :set_area_id, only: [:insert_child]
  before_action :set_area, only: [:update_area]

  # Method used to add a new child to a given parent
  def insert_child
    @area = Area.new(area_params)
    @area.id = @id

    if !@area.parent.nil?
      if @area.save
        render json: { status: "success", message: "Child added successfully" }
      else
        render json: { status: "failure", message: @area.errors }
      end
    else
      render json: { status: "failure", message: "Parent does not exist" }
    end
  end

  # Method used to update a given area
  def update_area
    if params[:area].present? && params[:area][:parent_id].present?
      if Area.where(id: params[:area][:parent_id]).first.nil?
        render json: { status: "failure", message: "Parent does not exist" }
        return
      elsif @area.id == params[:area][:parent_id].to_i
        render json: { status: "failure", message: "Parent should not be itself" }
        return
      end
    end

    @area.assign_attributes(area_params)

    # You shouldn't be able to change the note of an area if the children notes haven't changed
    if @area.note_changed? && !@area.children.empty?
      render json: { status: "failure", message: "Area's note shouldn't be changed if Area's children notes haven't changed" }
      return
    end

    # If an area left its parent, that portion of the company shoud be updated as well
    old_parent = nil
    if @area.parent_id_changed?
      old_parent = @area.parent_id_was
    end

    if @area.save(area_params)
      if !old_parent.nil?
        old_parent_area = Area.find(old_parent)
        old_parent_area.update_left_parent
      end
      render json: { status: "success", message: "Area updated successfully" }
    else
      render json: { status: "failure", message: @area.errors }
    end
  end

  # Returns structure with all areas
  def get_areas
    @area = Area.where(parent_id: nil)
    render json: @area, each_serializer: ShowAreaSerializer
  end

  private

  # Permitted parameters to be saved in DB
  def area_params
    params.require(:area).permit(
      :name,
      :note,
      :parent_id
    )
  end

  # I had to create this method to avoid this: "ActiveRecord::RecordNotUnique (PG::UniqueViolation: ERROR:".
  # Because seeds file has static IDs on the records, so I can accomplish the parents initial relations there.
  # I know this is not well-seen and it shouldn't be done.
  def set_area_id
    @id = Area.all.size + 1
  end

  # Initializes the area instance before working on it
  def set_area
    @area = Area.find(params[:id])
  end
end