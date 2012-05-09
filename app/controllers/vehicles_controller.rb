class VehiclesController < ApplicationController
  def index
    result = Vehicle.search do
      adjust_solr_params do |solr_para|
        solr_para[:sfield] = 'location_ll'
        #solr_para[:pt] = "#{params[:lat]},#{params[:lng]}"
        solr_para[:pt] = "40.66,-111.88"
        #solr_para[:pt] = "37.08,-113.58"
        solr_para[:sort] = 'geodist() asc'
        solr_para[:fq] << '{!geofilt}'
        solr_para[:fl] = 'distance:geodist() AND doc_id:id'
        solr_para[:d] = '5'
      end
      paginate :page => 1, :per_page => 1000
    end
    @solr_response = result.monkey_response
  end
end
