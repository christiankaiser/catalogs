class ViatimagesCatalogsController < CatalogsController
  def show
    @pages = Page.all
  end
end
