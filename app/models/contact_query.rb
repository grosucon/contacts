class ContactQuery < Query

  self.queried_class = Contact

  self.available_columns = [
      QueryColumn.new(:id, :sortable => "#{Contact.table_name}.id", :default_order => 'desc', :caption => 'Fields'),
      QueryColumn.new(:project, :sortable => "#{Project.table_name}.name", :groupable => true),
      QueryColumn.new(:about, :sortable => "#{Contact.table_name}.about"),
      QueryColumn.new(:name, :sortable => "#{Contact.table_name}.name"),
  ]



  def initialize_available_filters
    add_available_filter "spent_on", :type => :date_past
    add_available_filter "about", :type => :text
    add_custom_fields_filters(ContactCustomField)
    add_associations_custom_fields_filters :project
  end



  def available_columns
    return @available_columns if @available_columns
    @available_columns = self.class.available_columns.dup
    @available_columns += ContactCustomField.visible.
        map {|cf| QueryCustomFieldColumn.new(cf) }
    @available_columns
  end

  def contact_count_by_group
    grouped_query do |scope|
      scope.count
    end
  end

end