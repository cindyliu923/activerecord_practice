module ActiveRecord
  class Relation
    #2
    def initialize(klass)
      @klass = klass
      @where_values = []
    end

    #2
    def to_sql
      sql = "SELECT * FROM #{@klass.table_name}"
      if @where_values.any?
        sql += " WHERE " + @where_values.join(" AND ")
      end
      sql
    end

    #2
    def records
      @records ||= @klass.find_by_sql(to_sql)
    end

    #4
    def where(condition)
      @where_values += [condition]
      self
    end

    #4
    def first
      records.first
    end
  end
end
