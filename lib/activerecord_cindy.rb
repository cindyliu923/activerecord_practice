require "activerecord_cindy/version"

module ActiveRecord
  autoload :Base, "activerecord_cindy/base"
  autoload :Method, "activerecord_cindy/method"
  autoload :Relation, "activerecord_cindy/relation"
  autoload :Persistence, "activerecord_cindy/persistence"
  autoload :ConnectionAdapter, "activerecord_cindy/connection_adapter"
end
