class ViatimagesAdvancedSearchesController < AdvancedSearchesController
  def new
    super
    @available_slugs = %w{corpus images etablissements geo-feature keywords}
  end
  def show
    super
  end
end
