module ActiveRecord
  module Method
    #0
    def establish_connection(option)
      case option[:adapter]
      when 'postgresql'
        @@connection = ConnectionAdapter::PostgreSQLAdapter.new(option[:database])
      when 'sqlite'
        #TODO
      end
    end

    #0
    def connection
      @@connection
    end

    #1
    def set_column_name_to_method_attribute
      columns = self.connection.execute("SELECT column_name FROM information_schema.columns
        WHERE table_name= '#{self.table_name}'").map{|m|  m["column_name"]}
      columns.each{ |e| define_method_attribute(e) }
    end

    #1
    def define_method_attribute(name)
      class_eval <<-STR
        def #{name}
          @attributes[:#{name}] || @attributes["#{name}"]
        end

        def #{name}=(value)
          @attributes[:#{name}] = value
        end
      STR
    end

    #1
    def table_name
      name.downcase + "s"
    end

    #2
    def all
      Relation.new(self).records
    end

    #2
    def last
      all.last
    end

    #2
    def find_by_sql(sql)
      connection.execute(sql).map do |attributes|
        new(attributes)
      end
    end

    #3
    def first
      all.first
    end

    #3
    def find(id)
      find_by_sql("SELECT * FROM #{table_name} WHERE id = #{id.to_i}").first
    end

    #4
    def where(*args)
      Relation.new(self).where(*args)
    end
  end
end
