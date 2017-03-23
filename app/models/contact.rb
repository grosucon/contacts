class Contact < ActiveRecord::Base

  include Redmine::SafeAttributes

  belongs_to :user
  belongs_to :project

  attr_protected :id
  # attr_accessible :custom_field_values, :name, :author_id, :about, :custom_fields, :project_id

  acts_as_customizable

  acts_as_attachable

  acts_as_event :datetime => :updated_at,
                :description => :about,
                :title => Proc.new { |o| "#{l(:label_title_contacts)} ##{o.id} - #{o.name}" },
                :url => Proc.new { |o| { :controller => 'contacts', :action => 'show', :id => o.id, :project_id => o.project_id } }

  acts_as_searchable :columns => [ "#{table_name}.about", "#{table_name}.name" ],
                     :scope => joins(:project),
                     :date_column => :created_at


  safe_attributes 'name',
                  'author_id',
                  'project_id',
                  'about',
                  'custom_field_values',
                  'custom_fields'


end
