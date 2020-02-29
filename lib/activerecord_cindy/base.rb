module ActiveRecord
  class Base
    include Persistence
    extend Method
  end
end
