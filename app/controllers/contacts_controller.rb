class ContactsController < ApplicationController

  before_filter :find_project, :only => :index
  before_filter :set_contacts, :only => [:update, :edit, :destroy]


  def index
    @contacts = Contact.where(project_id: @project.id)
  end

  def show
  end

  def new
    @contact = Contact.new
  end

  def edit
  end

  def create
    @contact = Contact.new(contact_params)

    @contact.save_attachments(params[:attachments])
    render_attachment_warning_if_needed(@contact)

    @contact.author_id = User.current.id

    respond_to do |format|

      if @contact.save

        format.html { redirect_to :controller => 'contacts', :action => 'index', :project_id => @contact.project_id }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      @contact.save_attachments(params[:attachments])
      render_attachment_warning_if_needed(@contact)

      if @contact.update(contact_params)
        format.html { redirect_to :controller => 'contacts', :action => 'index', :project_id => @contact.project_id }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to :controller => 'contacts', :action => 'index', :project_id => @contact.project_id }
    end
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def contact_params
    params.require(:contact).permit(:name, :author_id, :project_id)
  end

  def set_contacts
    @contact = Contact.find(params[:id])
  end

end
