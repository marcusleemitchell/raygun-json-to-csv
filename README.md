# raygun-json-to-csv
Ruby script to convert Raygun log exports to csv per day for analysis by the included .xlsx pipeline.

# Set up
1. Export and download Export Groups from Raygun
2. Place the .7z archive in the root of this application and expand to create `assets/`
3. `ruby ./raygun_to_csv.rb` to create a `daily_csv/` dir (if none exists) and output a csv file per day from the source .json files in `assets/`
4. Open `Raygun Pipeline.xlsx`
5. Data > Launch Power Query Editor
6. Click the cog next to `Source`
7. Browse for the day's csv file, one or many
8. Click to the last Applied Step
9. Close & Load
