class ShowAreaSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :note,
             :children

  def children
    ActiveModelSerializers::SerializableResource.new(object.children, each_serializer: ShowAreaSerializer)
  end
end
