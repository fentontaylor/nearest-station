class SearchController < ApplicationController
  def index
    @facade = SearchFacade.new(params['location'])
  end
end
