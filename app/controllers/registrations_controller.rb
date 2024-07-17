class RegistrationsController < Devise::RegistrationsController

  def create
    super do |resource|
    if resource.persisted?
      @payment = Payment.new({ 
        email: params["user"]["email"],
        token: params[:payment]["token"], 
        user_id: resource.id })
        debugger
      unless @payment.valid?
        flash[:alert] = "Please check registration errors"
        redirect_to new_user_registration_path and return
      end

      begin
        customer = Stripe::Customer.create({
          email: params[:user][:email],
          source: params[:payment][:token]
        })
        
        charge = Stripe::Charge.create({
          customer: customer.id,
          amount: 50000,
          description: 'Description of your product',
          currency: 'usd'
        })
        @payment.save
      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_payment_path and return
      end
    else
      flash[:alert] = "User registration failed"
      redirect_to new_user_registration_path
    end
  end
end
private

def payment_params
  params.require(:payment).permit(:token)
end



  # def create
    
  #   build_resource(sign_up_params)
  #   resource.class.transaction do
  #   resource.save
  #   yield resource if block_given?
  #       if resource.persisted?
  #           @payment = Payment.new({ email: params["user"]["email"],
  #           token: params[:payment]["token"], user_id: resource.id })
  #           flash[:alert] = "Please check registration errors" unless @payment.valid?
  #         begin
  #           @payment.process_payment
  #           @payment.save
  #         rescue Exception => e
  #           flash[:alert] = e.message
  #           resource.destroy
  #           puts 'Payment failed'
  #           render :new and return
  #         end
  #         if resource.active_for_authentication?
  #             set_flash_message :notice, :signed_up if is_flashing_format?
  #             sign_up(resource_name, resource)
  #             respond_with resource, location: after_sign_up_path_for(resource)
  #         else
  #             set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
  #             expire_data_after_sign_in!
  #             respond_with resource, location: after_inactive_sign_up_path_for(resource)
  #         end
              
  #       else
  #         clean_up_passwords resource
  #         set_minimum_password_length
  #         respond_with resource
  #       end
              
  #   end
              
  # end
  
  
  
  
end
  