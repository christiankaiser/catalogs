class ViatimagesCatalogsController < CatalogsController
  def show
    @corpus_type_id = ItemType.where(catalog_id: @catalog.id).where(slug: 'corpus').ids
    @corpus_type_items = Item.where(item_type_id: @corpus_type_id.first)

    @domaines_choice_set_id = ChoiceSet.where(catalog_id: @catalog.id).where(name: 'Domaines').ids
    @domaines_choice_set_items = Choice.where(choice_set_id: @domaines_choice_set_id.first)

    @keywords_type_id = ItemType.where(catalog_id: @catalog.id).where(slug: 'keywords').ids
    @keywords_type_items = Item.where(item_type_id: @keywords_type_id.first)
  end
end
