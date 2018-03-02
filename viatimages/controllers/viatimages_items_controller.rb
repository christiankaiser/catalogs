class ViatimagesItemsController < ItemsController
  include FieldsHelper

  def index
    super

    # If corpus id request parameter is available, send corresponding corpus item to view
    @corpus = Item.where(id: params['corpus']).first if params['corpus'].present?
  end
  def show
    super

    @corpus_item_type_slug = "corpus"
    @image_item_type_image_slug = "images"

    # Prepare some objects for the view according to the item type slug
    case @item_type.slug
      when @corpus_item_type_slug
        # objects for the "corpus" item type
        @item.applicable_fields.each do |field|
          @title = field if field.slug == "title"
          @titre_trad = field if field.slug == "title-trad"
          @title_long = field if field.slug == "title-long"
          @lieu_edition = field if field.slug == "lieu-edition"
          @siecle_edition = field if field.slug == "siecle-edition"
          @siecle_voyage = field if field.slug == "siecle-voyage"
          @date_edition = field if field.slug == "date-edition"
          @tome_volume = field if field.slug == "tome-volume"
          @nbre_illustrations = field if field.slug == "nbre-illustrations"
          @cote = field if field.slug == "cote"
          @url_catalogue = field if field.slug == "url-catalogue"
          @comment = field if field.slug == "comment"
          @collection_ouvrage = field if field.slug == "collection-ouvrage"
          @langue_ouvrage = field if field.slug == "langue-ouvrage"
          @autre_editions = field if field.slug == "autres-editions"
          @provenance_collection = field if field.slug == "provenance"
          @description_collection = field if field.slug == "description"
        end
        @etablissement = @item.get_value('etablissement')
        fields_and_item_references(@item) do |_, browse| @images_count = browse.total_count end
      when @image_item_type_image_slug
        # objects for the "images" item type
        @item.applicable_fields.each do |field|
          @image_id = field if field.slug == "image-id"
          @image = field if field.slug == "image"
          @texte_image = field if field.slug == "texte-image"
          @titre_orig = field if field.slug == "orig-title"
          @titre = field if field.slug == "title"
          @illustrateurs = field if field.slug == "personne-associee"
          @corpus = field if field.slug == "corpus"
          @description = field if field.slug == "description"
          @remarque = field if field.slug == "remarque"
          @lieu_edition_image = field if field.slug == "lieu-edition"
          @date_evenement = field if field.slug == "date-evenement"
          @planche_depliante = field if field.slug == "planche-depliante"
          @en_couleur = field if field.slug == "en-couleurs"
          @largeur = field if field.slug == "largeur"
          @hauteur = field if field.slug == "hauteur"
          @emplacement_ouvrage = field if field.slug == "emplacement-ouvrage"
          @genre = field if field.slug == "genre"
          @critere_technique = field if field.slug == "critere-technique"
          @location = field if field.slug == "location"
          @domaine = field if field.slug == "domaine"
          @keyword = field if field.slug == "keyword"
          @geographie = field if field.slug == "geographie"
          @texte_legende = field if field.slug == "texte-legende"
          @chercheur = field if field.slug == "chercheur"
        end
        @yes = ["Oui","Ja","Yes","Si"]
    end
  end
end
