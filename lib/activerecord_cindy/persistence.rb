module ActiveRecord
  module Persistence
    #1
    def initialize(attributes = {})
      self.class.set_column_name_to_method_attribute
      @attributes = attributes
      @new_record = true
    end

    #2
    def new_record?
      @new_record
    end

    #2
    def save
      if new_record?
        self.class.connection.execute("INSERT INTO #{self.class.table_name}
        (#{@attributes.keys.join(',')}) VALUES (#{"'"+@attributes.values.join("', '")+"'"})")
        @new_record = false
        true
      else
        false
      end
    end
  end
end
