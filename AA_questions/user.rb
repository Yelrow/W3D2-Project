require_relative 'QuestionsDatabase'
require_relative 'questions.rb'
require_relative 'replies.rb'

class User
  attr_accessor :fname, :lname
  def self.all 
    data = QuestionsDatabase.instance.execute("Select * FROM users")
    data.map {|datum| User.new(datum)}
  end
  
  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end
  
  def create
  raise "#{self} already in database" if @id
  QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
    INSERT INTO
      users (fname, lname)
    VALUES
      (?, ?, ?)
  SQL
  @id = QuestionsDatabase.instance.last_insert_row_id
  end
  
  def update
  raise "#{self} not in database" unless @id
  QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
    UPDATE
      users
    SET
      fname = ?, lname = ?
    WHERE
      id = ?
  SQL
  end
  
  def self.find_by_id(id)
    user_object = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL
    user_object.map{|data| User.new(data)}
  end
  
  def self.find_by_name(fname, lname)
    user_object = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL
    user_object.map{|data| User.new(data)}
  end
  
  def authored_questions
    Questions.find_by_author_id(@id)
  end
  
  def authored_replies
    Replies.find_by_user_id(@id)
  end
end
