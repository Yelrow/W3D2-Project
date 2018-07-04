require_relative 'QuestionsDatabase'
require_relative 'user.rb'
require_relative 'questions.rb'

class QuestionFollows
  attr_accessor :user_id, :question_id
  
  def self.all 
    data = QuestionsDatabase.instance.execute("Select * FROM question_follows")
    data.map {|datum| QuestionFollows.new(datum)}
  end
  
  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end
  
  def self.find_by_id(id)
    question_follows_object = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        id = ?
    SQL
    question_follows_object.map{|data| QuestionFollows.new(data)}
  end
  
  def self.followers_for_question_id(question_id)
    question_follows_object = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
      question_follows
      JOIN questions ON questions.user_id = question_follows.user_id
      JOIN users ON question_follows.user_id = users.id 
      WHERE question_id = @question_id
    SQL
    question_follows_object.map{|data| User.new(data)}
  end
  
  
  
  
  
  
  
end