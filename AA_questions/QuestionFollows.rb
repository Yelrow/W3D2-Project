require_relative 'QuestionsDatabase'

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
    raise "#{self.id} is not in database" unless @id
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
end