# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Area.delete_all
@areas = [
  {
    id: 1,
    name: "Gerencia general",
    note: 0,
    parent_id: nil
  },
  {
    id: 2,
    name: "Gerencia finanzas",
    note: 0,
    parent_id: 1
  },
  {
    id: 3,
    name: "Gerencia operaciones",
    note: 0,
    parent_id: 1
  },
  {
    id: 4,
    name: "Gerencia tecnología",
    note: 0,
    parent_id: 1
  },
  {
    id: 5,
    name: "Contabilidad",
    note: 21.3968,
    parent_id: 2
  },
  {
    id: 6,
    name: "Análisis",
    note: 8,
    parent_id: 3
  },
  {
    id: 7,
    name: "Consultoría",
    note: 16.26,
    parent_id: 3
  },
  {
    id: 8,
    name: "Desarrollo",
    note: 92.345,
    parent_id: 4
  },
  {
    id: 9,
    name: "QA",
    note: 13,
    parent_id: 4
  }
]
@areas.each_with_index { |area, index| Area.create!(id: area[:id], name: area[:name], note: area[:note], parent_id: area[:parent_id]) }