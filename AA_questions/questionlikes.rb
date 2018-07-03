require_relative 'QuestionsDatabase'

class QuestionLikes
  attr_accessor :user_id, :question_id
  
  def self.all 
    data = QuestionsDatabase.instance.execute("Select * FROM question_likes")
    data.map {|datum| Replies.new(datum)}
  end
  
  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end
  
  def self.find_by_id(id)
    raise "#{self.id} is not in database" unless @id
    question_likes_object = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
    SQL
    question_likes_object.map{|data| QuestionLikes.new(data)}
  end
end