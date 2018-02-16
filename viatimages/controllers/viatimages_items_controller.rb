class ViatimagesItemsController < ItemsController
  def index
    super
    # If corpus id request parameter is available, send corresponding corpus item to view
    if params['corpus'].present?
      corpus_id = params['corpus']
      @corpus = Item.where(id: corpus_id).first
    end
  end
  def show
    super
    @corpus_item_type_slug = "corpus"
    @image_item_type_image_slug = "images"

    # Prepare some objects for the view according to the item type slug
    if @item_type.slug == @corpus_item_type_slug
      @item.applicable_fields.each do |field|
        @lieu_edition = field if field.slug == "lieu-edition"
        @tome_volume = field if field.slug == "tome-volume"
        @langue_ouvrage = field if field.slug == "langue-ouvrage"
        @collection_ouvrage = field if field.slug == "collection-ouvrage"
        @autre_editions = field if field.slug == "autres-editions"
      end
      @etablissement = @item.get_value('etablissement')
    end
  end
end
