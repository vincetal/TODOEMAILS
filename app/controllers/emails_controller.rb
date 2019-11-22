class EmailsController < ApplicationController
  def index
    @emails = Email.all
  end

  def create
    @email = Email.new(object: Faker::Book.title, body: Faker::ChuckNorris.fact, read: false)

    respond_to do |format|
      if @email.save
        format.html { redirect_to root_path, notice: 'email created.' }
        format.js { }
      else
        format.html {  redirect_to root_path, notice: 'Please try again.'  }
        format.js { }
      end
    end
  end

  def show
    @email = Email.find(params[:id])
    @email.read = true

    respond_to do |format|
      if @email.save
        format.js { }
      end
    end

  end

  def destroy
    @email = Email.find(params[:id])

    respond_to do |format|
      if @email.destroy
        format.html { redirect_to root_path, notice: 'Email destroyed.' }
        format.js { }
      else
        format.html {  redirect_to root_path, notice: 'Please try again.'  }
        format.js { }
      end
    end
  end

  def update

    @email = Email.find(params[:id])

    @email.read = update_status_params[:read]

    respond_to do |format|
      if @email.save
        format.html { redirect_to root_path, notice: 'Email status changed.' }
        format.js { }
      else
        format.html {  redirect_to root_path, notice: 'Please try again.'  }
        format.js { }
      end
    end
  end

  private

  def update_status_params
    params.permit(:read, :id)
  end

end
