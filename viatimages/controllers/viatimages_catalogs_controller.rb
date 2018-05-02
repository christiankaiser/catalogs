class ViatimagesCatalogsController < CatalogsController
  def show
    image_type = ItemType.where(catalog_id: @catalog.id).where(slug: 'images')

    # Retrieve & sort the all the corpus
    corpus_type = ItemType.where(catalog_id: @catalog.id).where(slug: 'corpus')
    @corpus_type_items = nil if corpus_type.empty?
    corpus_title_field = corpus_type.first.find_field('title')
    @corpus_type_items = Item.where(item_type_id: corpus_type.ids.first).sorted_by_field(corpus_title_field)

    # Retrieve & sort the all the domains
    domain_choice_set = ChoiceSet.where(catalog_id: @catalog.id).where(name: 'Domaines')
    domain_choice_set_items = domain_choice_set.empty? ? nil : Choice.where(choice_set_id: domain_choice_set.ids.first).sorted
    @domain_choice_set_items = {}
    domain_choice_set_items.each do |domain|
      value_slug = [I18n.locale, domain.short_name].join("-")
      link = [I18n.locale, "images?domaine=#{value_slug}"].join("/")
      @domain_choice_set_items.store(domain, link)
    end

    # Retrieve the first 20 most used keywords
    image_type_keyword_field = image_type.present? ? image_type.first.find_field('mot-cle') : nil
    keywords_attribute = image_type_keyword_field.uuid
    image_type_items_with_keywords = []
    keywords = []
    if image_type_keyword_field.present?
      image_type_items_with_keywords = Item.select("data ->> '#{keywords_attribute}' as #{keywords_attribute}")
          .where(item_type_id: image_type.ids.first)
          .where("data ->> '#{keywords_attribute}' != '[]'")
    end
    keyword_type = ItemType.where(catalog_id: @catalog.id).where(slug: 'keywords')
    image_type_items_with_keywords.each do |a|
      keywords.concat(JSON.parse(a[keywords_attribute])) if a[keywords_attribute]
    end
    keywords = Hash[keywords.group_by(&:itself).map { |k, v| [k, v.count] }.to_h.sort_by { |_, v| v }.reverse].first(20).shuffle.to_h if keywords.any?
    @keywords = {}
    keywords.each do |keyword_id, count|
      keyword = Item.where(item_type_id: keyword_type.first).where(id: keyword_id).first
      if count >= 1200
        @keywords.store(keyword, 'largest')
      elsif count >= 500
        @keywords.store(keyword, 'large')
      elsif count >= 300
        @keywords.store(keyword, 'medium')
      else
        @keywords.store(keyword, 'small')
      end
    end
    @keywords_base_url = [I18n.locale, "search?utf8=✓&type=images&q="].join("/")
  end
end
