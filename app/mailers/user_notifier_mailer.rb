class UserNotifierMailer < ApplicationMailer
    default :from => 'any_from_address@example.com'
  
    # send an email to the user, pass in the user object that contains the user's email address
    def send_confirmation_email(email, action)
      @action = action
      mail( :to => email,
      :action => 'send confirmation email' )
    end
end
