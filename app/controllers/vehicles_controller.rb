class VehiclesController < ApplicationController
  def index
    result = Vehicle.search do
      with :model, "Z3" 
      adjust_solr_params do |solr_para|
        solr_para[:sfield] = 'location_ll'
        #solr_para[:pt] = "#{params[:lat]},#{params[:lng]}"
        solr_para[:pt] = "40.75,-111.88"
        #solr_para[:pt] = "37.08,-113.58"
        #solr_para[:sort] = 'geodist() asc'
        solr_para[:sort] = 'price_f desc' # for price sorting, since solr store the field as price_f, you need to give it this way
        solr_para[:fq] << '{!geofilt}'
        solr_para[:fl] = 'distance:geodist() AND doc_id:id'
        solr_para[:d] = '5'
      end
    end
    @solr_response = result.monkey_response['docs']
    #@result = @solr_response.paginate(:page=>params[:page],:per_page=>10)
  end
end
