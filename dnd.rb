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
    case stat
    when 1
      -5
    when 2..3
      -4
    when 4..5
      -3
    when 6..7
      -2
    when 8..9
      -1
    when 10..11
      0
    when 12..13
      1
    when 14..15
      2
    when 16..17
      3
    when 18..19
      4
    when 20..21
      5
    when 22..23
      6
    when 24..25
      7
    when 26..27
      8
    when 28..29
      9
    when 30
      10
    else
      30
    end
  end
end
