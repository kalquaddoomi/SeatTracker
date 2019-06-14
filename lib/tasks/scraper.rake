namespace :scrape do

  task :districts => :environment do
    scraper = Webscraper.new
    districts = scraper.get_house_districts
    districts.each do |district|
      new_district = District.where(number: district["District"]).first_or_create do |d|
        d.name = "District"
        d.number = district["District"]
        d.district_type = "House"
      end

      incumbent_name_parts = district["Incumbent"].split(',')
      incumbent_first_parts = incumbent_name_parts[1].split(' ')

      new_incumbent = Incumbent.where(district: new_district).first_or_create do |i|
        i.last_name = incumbent_name_parts[0]
        i.first_name = incumbent_first_parts[0]
        if incumbent_first_parts[1] && incumbent_first_parts[1].starts_with?('"')
          i.middle_name = ""
          i.nick_name = incumbent_first_parts[1] || ""
        else
          i.middle_name = incumbent_first_parts[1] || ""
          i.nick_name = (incumbent_first_parts[2] && incumbent_first_parts[2].starts_with?('"') ? incumbent_first_parts[2] : "")
        end
        i.district = new_district
      end
    end
  end

  task :incumbents => :environment do
    scraper = Webscraper.new
    allDistricts = District.all
    allDistricts.each do |district|
      update_data = scraper.get_house_district_details(district.number)

      incumbent = Incumbent.find_by(district: district)
      incumbent.party = update_data["Party"]
      incumbent.elected = update_data["Elected"]
      incumbent.current_term = update_data["CurrentTerm"]
      incumbent.save!
    end

  end
end
