module DnD
  CRIT_SET = [20]
  def self.roll(die_string)
    die_string.downcase!
    die_string.chomp!
    number, die = die_string.split("d").map(&:to_i)
    number * ( 1 + rand(die) )
  end

  def self.stat
    4.times.map {
      roll("1d6")
    }.max(3).inject(&:+)
  end

  def self.stats_array
    6.times.map { stat }
  end

  def self.roll_attack(mod, status=:normal)
    result = case status
             when :normal
               roll("1d20")
             when :advantage
               2.times.map {
                 roll("1d20")
               }.max
             when :disadvantage
               2.times.map {
                 roll("1d20")
               }.min
             end

    if CRIT_SET.include?(result)
      "CRITICAL HIT!!"
    elsif result == 1
      "CRITICAL MISS!"
    else
      result + mod
    end
  end

  def self.roll_check(mod, status=:normal)
    result = case status
             when :normal
               roll("1d20")
             when :advantage
               2.times.map {
                 roll("1d20")
               }.max
             when :disadvantage
               2.times.map {
                 roll("1d20")
               }.min
             end

    result + mod
  end

  def self.roll_damage(die, mod)
    roll(die) + mod
  end


  def self.ability_score_for(stat)
    if stat < 1 || stat > 30
      raise ArgumentError, "must be within 1-30"
    end
    ( ( stat - 10.0) / 2 ).floor
  end
end
