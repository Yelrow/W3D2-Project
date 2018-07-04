require_relative 'QuestionsDatabase'
require_relative 'user.rb'
require_relative 'replies.rb'

class Questions
  attr_accessor :title, :body, :user_id
  
  def self.all 
    data = QuestionsDatabase.instance.execute("Select * FROM questions")
    data.map {|datum| Questions.new(datum)}
  end
  
  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end
  
  def self.find_by_id(id)
    questions_object = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL
    questions_object.map{|data| Questions.new(data)}
  end
  
  def self.find_by_author_id(user_id)
    questions_object = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        questions
      WHERE
        user_id = ?
    SQL
    questions_object.map{|data| Questions.new(data)}
  end
  
  def author
    User.find_by_id(@user_id)
    # questions_object = QuestionsDatabase.instance.execute(<<-SQL, @user_id)
    #   SELECT
    #     *
    #   FROM
    #     users
    #   WHERE
    #     id = @user_id
    # SQL
    # questions_object.map{|data| User.new(data)}
  end
  
  def replies
    Replies.find_by_question_id(@id)
  end
  
  
end