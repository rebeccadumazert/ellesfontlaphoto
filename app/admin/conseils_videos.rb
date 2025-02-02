ActiveAdmin.register ConseilsVideo do

  permit_params :title, :subtitle, :format, :objectif, :lecture_time, :contenu_explication, :liens_utiles, :protagoniste, :video, :image, :category_list, :type_list

  before_create do |conseils_video|
    categories = []
    params["conseils_video"]["category_list"].reject{ |c| c.empty? }.each do |category|
      categories << category
    end
    conseils_video.category_list = categories
    conseils_video.tag_list = params["conseils_video"]["tag_list"]
    if params["conseils_video"]["video"].present?
      conseils_video.video = params["conseils_video"]["video"]
    end
    if params["conseils_video"]["image"].present?
      conseils_video.image = params["conseils_video"]["image"]
    end
  end

  before_update do |conseils_video|
    categories = []
    params["conseils_video"]["category_list"].reject{ |c| c.empty? }.each do |category|
      categories << category
    end
    conseils_video.category_list = categories
    conseils_video.tag_list = params["conseils_video"]["tag_list"]
    if params["conseils_video"]["video"].present?
      conseils_video.video = params["conseils_video"]["video"]
    end
    if params["conseils_video"]["image"].present?
      conseils_video.image = params["conseils_video"]["image"]
    end
  end

  filter :title
  filter :tags
  filter :category_list
  filter :protagoniste
  filter :objectif
  filter :created_at
  filter :updated_at

  controller do
    def scoped_collection
      super.includes :notation_conseils_video # prevents N+1 queries to your database
    end
  end

  index do
    id_column
    column :title
    column :subtitle
    column :objectif
    column :protagoniste
    column :created_at
    column :updated_at
    column :category_list
    column :tag_list
    column :utile, sortable: 'notation_conseils_video.utile' do |conseils_video|
      if NotationConseilsVideo.find_by(conseils_video: conseils_video)
        NotationConseilsVideo.find_by(conseils_video: conseils_video).utile
      else
        0
      end
    end
    column :inutile, sortable: 'notation_conseils_video.inutile' do |conseils_video|
      if NotationConseilsVideo.find_by(conseils_video: conseils_video)
        NotationConseilsVideo.find_by(conseils_video: conseils_video).inutile
      else
        0
      end
    end
    actions
  end

  show do
    attributes_table do
      row :title
      row :subtitle
      row :category_list
      row :format
      row :objectif
      row :lecture_time
      row :contenu_explication
      row :liens_utiles
      row :protagoniste
      row :tag_list
    end
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs "Bandeau" do
      f.input :category_list, :as => :check_boxes, \
        :collection => ConseilsVideo::CONSEIL_CATEGORIES, label: "Categorie List"
      f.input :tag_list, :as => :check_boxes, \
        :collection => ConseilsVideo::CONSEIL_TAGS
      f.input :title, label: "Titre"
      f.input :format, as: :select, collection: ConseilsVideo::VIDEO_FORMAT.keys
      f.input :protagoniste
      f.input :lecture_time, label: "Temps de Lecture"
      f.input :objectif
    end
    f.inputs "Multimedias" do
      if f.object.video.attached?
        f.input :video, as: :file, :hint => image_tag(f.object.video)
      else
        f.input :video, as: :file
      end
      if f.object.image.attached?
        f.input :image, as: :file, :hint => image_tag(f.object.image), label: "Image (dans le catalogue)"
      else
        f.input :image, as: :file, label: "Image (dans le catalogue)"
      end
    end
    f.inputs "Description" do
      f.input :subtitle, label: "Description"
    end
    f.inputs "Protagoniste" do
      f.input :contenu_explication, as: :quill_editor, label: "Contenu explication"
    end
    f.inputs "Liens utiles" do
      f.input :liens_utiles, as: :quill_editor, label: "Liens utiles"
    end
    f.actions
  end

  csv do
    column :title
    column :subtitle
    column(:tag_list) { |conseils_video| conseils_video.tags.map { |c| c.name } }
    column(:category_list) { |conseils_video| conseils_video.category.map { |c| c.name } }
    column :format
    column :objectif
    column :lecture_time
    column :contenu_explication
    column :protagoniste
    column :created_at
    column :updated_at
    column :liens_utiles
  end
end

