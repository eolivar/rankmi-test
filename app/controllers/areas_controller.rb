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
    if @area.update(area_params)
      render json: { status: "success", message: "Area updated successfully" }
    else
      render json: { status: "failure", message: @area.errors }
    end
  end

  # Returns structure with all areas
  def get_areas
    @area = Area.where(parent_id: nil).first
    render json: @area
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
  # Because seeds file has static IDs on the records, so I can accomplish the parent's relation there.
  # I know this is not well-seen and it shouldn't be done.
  def set_area_id
    @id = Area.all.size + 1
  end

  # Initializes the area instance before working on it
  def set_area
    @area = Area.find(params[:id])
  end
end