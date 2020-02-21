class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "chat", {
    message: render_message(message)
    }
 
  end

  def render_message(message) 
    
  	CommentsController.render(
  		partial: 'comments/comment',
  		locals: {
  			comment: message
  		}
  	)
  end
end
