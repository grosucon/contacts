require_dependency 'custom_fields_helper'

module CustomFieldsHelperPatch
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable

      alias_method_chain :custom_field_type_options, :custom_tab_options
    end
  end

  module ClassMethods
  end

  module InstanceMethods

    def custom_field_type_options_with_custom_tab_options()
      cf = {:name => 'ContactCustomField', :partial => 'custom_fields/index', :label => "contact" }
      unless CustomFieldsHelper::CUSTOM_FIELDS_TABS.index { |f| f[:name] == cf[:name] }
        CustomFieldsHelper::CUSTOM_FIELDS_TABS << cf
      end
      custom_field_type_options_without_custom_tab_options()
    end

  end
end

# Apply the patch
Rails.configuration.to_prepare do
  unless CustomFieldsHelper.included_modules.include?(CustomFieldsHelperPatch)
    CustomFieldsHelper.send(:include, CustomFieldsHelperPatch)
  end
end