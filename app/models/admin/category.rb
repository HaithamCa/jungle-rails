module Admin
  # Rails looks up Category inside the Admin namespace. This file has to
  # define that constant, and it is the same catalog model shoppers use.
  Category = ::Category
end
