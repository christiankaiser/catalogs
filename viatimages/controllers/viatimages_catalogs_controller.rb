class ViatimagesCatalogsController < CatalogsController
  def show
    @corpus_type = ItemType.where(catalog_id: @catalog.id).where(slug: 'corpus')
    @corpus_title_field = @corpus_type.first.find_field('title')
    @corpus_type_items = Item.where(item_type_id: @corpus_type.ids.first).sorted_by_field(@corpus_title_field)

    @domain_choice_set = ChoiceSet.where(catalog_id: @catalog.id).where(name: 'Domaines')
    @domain_choice_set_items = Choice.where(choice_set_id: @domain_choice_set.ids.first).sorted

    @keyword_type = ItemType.where(catalog_id: @catalog.id).where(slug: 'keywords')
    @keyword_type_items = Item.where(item_type_id: @keyword_type.ids.first)
  end
end
