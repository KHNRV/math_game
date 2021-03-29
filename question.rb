class Question
  
  def initialize(min = 1, max = 10)
    @num_one = rand(min..max)
    @num_two = rand(min..max)
    @opperator = ["+", "-", "*"].sample
    @user_answer
  end

  def prompt
    return question_prompt
  end

  def answer(num)
    @user_answer = num
    return evaluate?
  end

  def evaluate?
    return expected_result == @user_answer
  end

  def correct_answer
    expected_result
  end

  private

  def expected_result
    return case @opperator
      when "+" then @num_one + @num_two
      when "-" then @num_one - @num_two
      when "/" then @num_one / @num_two
      when "%" then @num_one % @num_two
      when "*" then @num_one * @num_two
      else "ERROR: wrong opperator" 
    end
  end

  def question_prompt
    return case @opperator
      when "+" then "What does #{@num_one} plus #{@num_two} equals?"
      when "-" then "What does #{@num_one} minus #{@num_two} equals?"
      when "/" then "What does #{@num_one} divided by #{@num_two} equals?"
      when "%" then "What does #{@num_one} modulo #{@num_two} equals?"
      when "*" then "What does #{@num_one} multiplied by #{@num_two} equals?"
      else "ERROR: wrong opperator" 
    end
  end

end