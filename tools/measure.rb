require "json"

class Measure
  def self.call
    new.call
  end

  def call
    File.open("./log/access.log") do |f|
      f.each_line do |str|
        json = JSON.parse(str)

        unless @summaries.key?(json["key"])
          @summaries[json["key"]] = Summary.new
        end
        @summaries[json["key"]].add_time(json["time"])
        @all_count += 1
      rescue
        # puts "Error: #{str}"
      end
    end

    puts "key,count,sum,min,max,avg,rate,p95"
    @summaries.each do |k, v|
      puts "#{k},#{v.count},#{v.sum},#{v.min},#{v.max},#{v.avg},#{v.rate(@all_count)},#{v.p95}"
    end
  end

  def initialize
    @summaries = {}
    @all_count = 0
  end
end

class Summary
  def initialize
    @times = []
  end

  def add_time(time)
    @times << time
  end

  def count
    @times.count
  end

  def sum
    @times.sum
  end

  def min
    @times.min
  end

  def max
    @times.max
  end

  def avg
    @times.sum / count.to_f
  end

  def rate(all_count)
    count.to_f / all_count
  end

  def p95
    c = (count * 0.95).to_i
    return 0.0 if c.zero?

    @times.sort.slice(0, c).sum / c.to_f
  end
end

Measure.call
