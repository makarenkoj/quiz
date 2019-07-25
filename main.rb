# encoding - UTF-8

if (Gem.win_platform?)
	Encoding.default_external = Encoding.find(Encoding.locale_charmap)
	Encoding.default_internal = __ENCODING__

	[STDIN, STDOUT].each do |io|
		io.set_encoding(Encoding.default_external, Encoding.default_internal)
	end
end

require "rexml/document"
require_relative 'lib/question'
require_relative 'lib/quiz'

current_path = File.dirname(__FILE__) + "/data/questions.xml"

abort "Файл с вопросами не найден!" unless File.exist?(current_path)

file = File.new(current_path, "r:UTF-8")
doc = REXML::Document.new(file)
file.close

quiz = Quiz.read_xml(doc)

correct_answers = 0

puts "Приветствую!"
puts "Мини-викторина. Ответьте на вопросы теста."

quiz.questions.each do |question|
  time = question.time
  puts "\nВремени на ответ: #{time} c."
  sleep(1)
	puts question.question_text
	question.print_answers

  time_start = Time.now
  choice = STDIN.gets.to_i until (1..question.answers.size).include?(choice)

  time_finish = Time.now
  difference_time = time_finish - time_start

  if difference_time > time
    puts "Долго думаешь!"
    puts "Попробуй ещё раз."
    puts "\nПотрачено на ответ времени: #{difference_time.to_i}.c"
    sleep(1)
   break
  elsif question.correct_answer?(choice)
    puts "Верно!"
    correct_answers += 1
  else
    puts "Не правильный ответ :("
    puts "Правильный: #{question.answer_right}"
    sleep(1)
  end
end

puts "\nПравильных ответов #{correct_answers} из #{quiz.size}."
