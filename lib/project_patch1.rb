module ProjectPatch1

  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      has_many :contacts
    end
  end

  module InstanceMethods
  end

end

Project.send(:include, ProjectPatch1)