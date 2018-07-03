require_relative 'QuestionsDatabase'

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
    raise "#{self.id} is not in database" unless @id
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
end