class Question
  attr_accessor :question_text, :answers, :answer_right, :time

  def initialize
    @question_text = ''
    @answers = []
    @answer_right = ''
    @time = 0
  end

  def print_answers
    puts "Выбери ответ:"
    answers.each_with_index { |answer, i| puts "#{i + 1}) #{answer}"}
  end

  def correct_answer?(number)
    answers[number - 1] == answer_right
  end
end
