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
end