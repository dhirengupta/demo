class Vehicle < ActiveRecord::Base
  searchable do 
    integer :id
    integer :year
    string :make
    string :model
    string :trim
    string :body
    string :zipcode
    float :price
    float :miles do
      miles.to_f
    end
    date :date
    string :drivetrain
    string :transmission
    string :robot
    
    #double :lat do
    #  latitude.to_f
    #end
    #double :lng do
    #  longitude.to_f
    #end
    
    #location :coords do
    #  Sunspot::Util::Coordinates.new latitude, longitude
    #end
    
    latlon(:location) { Sunspot::Util::Coordinates.new(latitude.to_f, longitude.to_f) }
  end

  def index_it
    self.solr_index
  end

  def index_it!
    self.solr_index! # index and commit immidiately
  end

  def remove_from_index
    self.solr_remove_from_index
  end

  def remove_from_index!
    self.solr_remove_from_index! #remove and commit immidiately
  end

  # add the following lines in solr_config file : path /example/solr/conf

  # <autoCommit>
  #   <maxDocs>100</maxDocs>
  #   <maxTime>60000</maxTime>
  #   <openSearcher>true</openSearcher>
  # </autoCommit>


end
