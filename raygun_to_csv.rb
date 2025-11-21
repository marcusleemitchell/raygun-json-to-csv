require "json"
require "csv"
require "time"
require "pry"

INPUT_DIR = "./assets"      # change to your directory
OUTPUT_DIR = "./daily_csv"       # directory for generated CSVs

Dir.mkdir(OUTPUT_DIR) unless Dir.exist?(OUTPUT_DIR)

# Hash: { "2025-11-11" => [ [className, url, occurredOn], ... ] }
daily = Hash.new { |h, k| h[k] = [] }

Dir.glob(File.join(INPUT_DIR, "*.json")).each do |file|
  p file
  data = JSON.parse(File.read(file))

  class_name    = data.dig("error", "className")
  message       = data.dig("error", "message")
  occurred_on   = data["OccurredOn"]
  simphony_url  = data.dig("userCustomData", "revenue_center", "simphony_url") ||
                  data.dig("userCustomData", "simphony_url")

  p occurred_on

  # Skip files missing anything important
  next unless class_name && occurred_on && simphony_url

  date = Time.parse(occurred_on).strftime("%Y-%m-%d")

  daily[date] << [class_name, message, simphony_url, occurred_on]
end

# Write one CSV per day
daily.each do |date, rows|
  csv_path = File.join(OUTPUT_DIR, "#{date}.csv")
  CSV.open(csv_path, "w") do |csv|
    csv << ["className", "message", "simphony_url", "occurredOn"]
    rows.each { |row| csv << row }
  end
end

puts "Done! Created #{daily.keys.size} CSV files in #{OUTPUT_DIR}/"
