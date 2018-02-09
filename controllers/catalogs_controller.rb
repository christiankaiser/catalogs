class Viatimages::CatalogsController < App::CatalogsController
  def show
    @pages = Page.all
  end
end