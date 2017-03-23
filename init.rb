require 'project_patch1'
require 'custom_fields_helper_patch'

Redmine::Plugin.register :contacts do
  name 'Contacts plugin'
  author 'Grosu COnstantin'
  description 'A redmine plugin with project contacts'
  version '0.0.1'

  project_module :contacts do
    permission :view_contacts, :contacts => [:index, :show]
    permission :add_contacts, :contacts => [:index, :show, :create, :new]
    permission :update_contacts, :contacts => [:index, :show, :create, :new, :update, :edit]
    permission :delete_contacts, :contacts => [:destroy, :index, :show]
  end

  menu :project_menu, :contacts, { :controller => 'contacts', :action => 'index' }, :caption => :plugin_name, :before => 'Settings', :param => :project_id

end


Redmine::Search.available_search_types << 'contacts'
