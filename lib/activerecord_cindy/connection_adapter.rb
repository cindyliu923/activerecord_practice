module ActiveRecord
  module ConnectionAdapter
    class PostgreSQLAdapter
      def initialize(dbname)
        require 'pg'
        @db = PG.connect(dbname: dbname)
      end

      def execute(sql)
        @db.exec(sql)
      end
    end
  end
end
