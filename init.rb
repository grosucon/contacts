require 'project_patch1'

Redmine::Plugin.register :contacts do
  name 'Contacts plugin'
  author 'Grosu COnstantin'
  description 'A redmine plugin with project contacts'
  version '0.0.1'

  project_module :contacts do
    permission :view_contacts, :contacts => :index
    permission :add_contacts, :contacts => :create
    permission :edit_contacts, :contacts => :update
    permission :delete_contacts, :contacts => :destroy
  end


  menu :project_menu, :contacts, { :controller => 'contacts', :action => 'index' }, :caption => 'Contacts', :before => 'Settings', :param => :project_id

end


Redmine::Search.available_search_types << 'contacts'
