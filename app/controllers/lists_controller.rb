class ListsController < ApplicationController
  def generateURL()
    
    url = ('a'..'z').to_a.shuffle[0..15].join
    
    until List.find_by_url(url).nil? do
      url = ('a'..'z').to_a.shuffle[0..15].join
    end
    
    return url
  end
  
  
  # GET /lists
  # GET /lists.xml
  def index
    @lists = List.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lists }
    end
  end

  # GET /lists/url
  # GET /lists/url.xml
  def show
    @list = List.find_by_url(params[:id])

    @list.lastviewed = Time.now()
    @list.save

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @list }
    end
  end

  # GET /lists/new
  # GET /lists/new.xml
  def new
    @list = List.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @list }
    end
  end
  
  # GET /lists/random/url
  def random
    @list = List.find_by_url(params[:id])
    
    names = @list.list.squeeze("\n").split("\n")
    
    @name = names[rand(names.length)]
    
    respond_to do |format|
      format.html # random.html.erb
      format.xml  { render :xml => @name }
    end
  end

  # GET /lists/url/edit
  def edit
    @list = List.find_by_url(params[:id])
  end

  # POST /lists
  # POST /lists.xml
  def create
    @list = List.new(params[:list])
    
    @list.url = generateURL()
    @list.lastedited = Time.now()
    @list.lastviewed = Time.now()
    
    

    respond_to do |format|
      if @list.save
        format.html { redirect_to(@list, :notice => 'List was successfully created. Save your URL above to get back to this list at a later date.') }
        format.xml  { render :xml => @list, :status => :created, :location => @list }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lists/url
  # PUT /lists/url.xml
  def update
    @list = List.find_by_url(params[:id])

    @list.lastedited = Time.now()

    respond_to do |format|
      if @list.update_attributes(params[:list])
        format.html { redirect_to(@list, :notice => 'List was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/url
  # DELETE /lists/url.xml
  def destroy
    @list = List.find_by_url(params[:id])
    @list.destroy

    respond_to do |format|
      format.html { redirect_to(lists_url) }
      format.xml  { head :ok }
    end
  end
end
