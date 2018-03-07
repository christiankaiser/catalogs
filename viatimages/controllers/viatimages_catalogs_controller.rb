class ViatimagesCatalogsController < CatalogsController
  def show
    image_type = ItemType.where(catalog_id: @catalog.id).where(slug: 'images')

    # Retrieve & sort the all the corpuses
    corpus_type = ItemType.where(catalog_id: @catalog.id).where(slug: 'corpus')
    @corpus_type_items = nil if corpus_type.empty?
    corpus_title_field = corpus_type.first.find_field('title')
    @corpus_type_items = Item.where(item_type_id: corpus_type.ids.first).sorted_by_field(corpus_title_field)

    # Retrieve & sort the all the domains
    domain_choice_set = ChoiceSet.where(catalog_id: @catalog.id).where(name: 'Domaines')
    domain_choice_set_items = domain_choice_set.empty? ? nil : Choice.where(choice_set_id: domain_choice_set.ids.first).sorted
    @domain_choice_set_items = Hash.new
    domain_choice_set_items.each do |domain|
      value_slug = [I18n.locale, domain.short_name].join("-")
      link = [I18n.locale, "images?domaine=#{value_slug}"].join("/")
      @domain_choice_set_items.store(domain, link)
    end

    # Retrieve & sort the first 20 most used keywords
    image_type_keyword_field = image_type.present? ? image_type.first.find_field('keyword') : nil
    image_type_items_with_keywords = image_type_keyword_field.present? ? Item.where(item_type_id: image_type.ids.first).where("data ->> '#{image_type_keyword_field.uuid}' != '[]'") : []
    keywords = Array.new
    image_type_items_with_keywords.each do |a|
      a.get_value('keyword').each do |b|
        keywords.push(b.item_type.primary_text_field.raw_value(b))
      end
    end
    # Count duplicates keywords
    @keywords_count = keywords.inject({}) { |a,e| a[e] = (a[e] || 0) + 1; a }
    # Sort keywords by count, keep first 20 and shuffle the array
    @keywords_count = @keywords_count.sort_by(&:last).reverse!.first(20).shuffle
    # Replace keyword count with css classes
    @keywords_count = @keywords_count.map { |keyword, count|
      if count >= 8
        {keyword => 'largest'}
      elsif count >= 4
        {keyword => 'large'}
      elsif count >= 2
        {keyword => 'medium'}
      else
        {keyword => 'small'}
      end
    }.reduce(:merge)
  end
end
