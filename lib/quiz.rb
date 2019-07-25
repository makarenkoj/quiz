class Quiz
  attr_accessor :questions

  def initialize(questions = [])
    @questions = questions
  end

  def self.read_xml(doc)
    questions = []

    doc.elements.each('questions/question') do |item|
      question = Question.new

      question.time = item.attributes['minutes'].to_i
      question.question_text = item.elements['text'].text

      item.elements.each('variants/variant') do |variant|
        if variant.attributes['right'] == "true"
          question.answer_right = variant.text
        end
        question.answers << variant.text
      end

      questions << question
    end

    self.new(questions)
  end

  def question(number)
    questions[number]
  end

  def size
    questions.size
  end
end
