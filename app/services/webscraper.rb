require 'Nokogiri'
require 'ap'
require 'HTTParty'

class Webscraper
  def initialize
  end

  def get_house_districts
    ap "Scraping Districts"
    doc = HTTParty.get('http://house.louisiana.gov/H_Reps/H_Reps_ByDistrict.aspx')
    parsedPage ||= Nokogiri::HTML(doc)

    districtTable = parsedPage.css("#body_ListView1_groupPlaceholderContainer").css("th")
    districtLines = districtTable.children.map {|data| data.text.strip}
    districtLines = districtLines.reject {|l| l.empty?}
    districts = []
    districtLines.each_with_index do |value, index|
      if value == "District:"
         district = districtLines[index + 1]
         incumbent = districtLines[index + 2]
         districts << {"District" => district.to_i, "Incumbent" => incumbent}
      end
    end
    return districts
  end

  def get_house_district_details(district)
    doc = HTTParty.get("http://house.louisiana.gov/H_Reps/members.aspx?ID=#{district}")
    parsedPage ||= Nokogiri::HTML(doc)
    incumbentNameBlock = parsedPage.css('#body_FormView5').text.strip.split("\n")
    incumbentElected = parsedPage.css('#body_FormView4_YEARELECTEDLabel').text
    incumbentFinalTerm = parsedPage.css('#body_FormView4_FINAL_TERMLabel').text

    current_term = (2019 - incumbentElected.to_i) / 4

    incumbentData = {
      "Name" => incumbentNameBlock[0].chomp,
      "Party" => incumbentNameBlock[2].chomp,
      "Elected" => incumbentElected,
      "FinalTerm" => incumbentFinalTerm,
      "CurrentTerm" => current_term
    }
    return incumbentData
  end
end