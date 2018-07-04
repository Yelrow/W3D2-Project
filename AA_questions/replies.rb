require_relative 'QuestionsDatabase'

class Replies
  attr_accessor :user_id, :question_id
  
  def self.all 
    data = QuestionsDatabase.instance.execute("Select * FROM replies")
    data.map {|datum| Replies.new(datum)}
  end
  
  def initialize(options)
    @id = options['id']
    @answer = options['answer']
    @question_id = options['question_id']
    @user_id = options['user_id']
    @parents_id = options['parents_id']
  end
  
  def self.find_by_id(id)
    replies_object = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    replies_object.map{|data| Replies.new(data)}
  end
  
  def self.find_by_user_id(user_id)
    replies_object = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL
    replies_object.map{|data| Replies.new(data)}
  end
  
  def self.find_by_question_id(question_id)
    replies_object = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL
    replies_object.map{|data| Replies.new(data)}
  end
  
  def author
    User.find_by_id(@user_id)
  end
  
  def question
    Question.find_by_id(@question_id)
  end
  
  def parent_reply
    Replies.find_by_id(@parent_reply)
  end
  
  def child_replies
    replies_object = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parents_id = @id
    SQL
    replies_object.map{|data| Replies.new(data)}
  end
  
  
  
end