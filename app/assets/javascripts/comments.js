// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
function openCommentModal(id, comment, username){
    $('#parent_id').val(id);
    var parentcomment = jQuery.trim(comment).substring(0, 160)
                          .trim(this) + "...";
    $('#parent_comment').html("<h2>" + username + " says</h2>"  + parentcomment);
    $('#replyModal').modal();
}

function saveReply(book_id){
    var parent_id = $('#parent_id').val();
    var user_id = $('#user_id').val();
    var comment = $('#comment').val();
    
   
   

    var url = "/books/" + book_id + "/comments"
    $.ajax({

        url: url,
        type: "post",
        data: { comment: { book_id: book_id, parent_id: parent_id, user_id: user_id, body: comment} }

      }).fail(function() {

        alert('Something went wrong.');

      });
}

