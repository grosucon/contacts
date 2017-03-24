class ContactsController < ApplicationController

  rescue_from Query::StatementInvalid, :with => :query_statement_invalid

  helper :custom_fields
  include CustomFieldsHelper
  helper :queries
  include QueriesHelper
  helper :sort
  include SortHelper
  helper :issues
  include IssuesHelper

  before_filter :find_project_by_project_id, :only => [:index, :create, :edit, :update, :new, :destroy]
  before_filter :set_contacts, :only => [:update, :edit, :destroy, :show]


  def index
    @query = ContactQuery.build_from_params(params, :name => '_')
    sort_init(@query.sort_criteria.empty? ? [['spent_on', 'desc']] : @query.sort_criteria)
    sort_update(@query.sortable_columns)


    @contacts = Contact.where(project_id: @project.id)

    @contact_count_by_group = @query.contact_count_by_group

  end

  def show
  end

  def new
    @contact = Contact.new()
    @contact.safe_attributes = params[:contact]
  end

  def edit
  end

  def create
    @contact = Contact.new

    @contact.safe_attributes = params[:contact]
    #@contact = Contact.new(contact_params)

    @contact.save_attachments(params[:attachments])
    render_attachment_warning_if_needed(@contact)

    @contact.author_id = User.current.id
    @contact.project_id = @project.id

    respond_to do |format|

      if @contact.save

        format.html { redirect_to :controller => 'contacts', :action => 'index', :project_id => @project.id }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @contact.safe_attributes = params[:contact]
    respond_to do |format|
      @contact.save_attachments(params[:attachments])
      render_attachment_warning_if_needed(@contact)

      @contact.project_id = @project.id

      if @contact.save
        format.html { redirect_to :controller => 'contacts', :action => 'index', :project_id => @project.id }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to :controller => 'contacts', :action => 'index', :project_id => @project.id }
    end
  end

  private

  # def contact_params
  #   params.require(:contact).permit(:name, :author_id, :project_id, :about)
  # end

  def set_contacts
    @contact = Contact.find(params[:id])
  end

end
