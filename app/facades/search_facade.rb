class SearchFacade
  def initialize(origin)
    @origin = origin
  end

  def station
    @station ||= service.find_nearest_station
  end

  def directions
    @directions ||= service.get_directions
  end

  private

  def service
    @service ||= StationDirectionsService.new(@origin)
  end
end
