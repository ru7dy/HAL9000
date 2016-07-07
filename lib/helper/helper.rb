class Helper
  def self.get_emoticon(age, gender)
    if age < 25
      if gender == "female"
        ":girl:"
      else
        ":boy:"
      end
    elsif age < 30
      if gender == "female"
        ":woman:"
      else
        ":man:"
      end
    else
      if gender == "female"
        ":older_woman::skin-tone-3:"
      else
        ":older_man:"
      end
    end
  end
end
