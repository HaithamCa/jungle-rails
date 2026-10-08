// Live password validation for signup form
$(document).on('turbolinks:load', function() {
  var $password = $('#user_password');
  var $confirmation = $('#user_password_confirmation');
  var $feedback = $('#password-match-feedback');
  var $submitBtn = $('#signup-submit');

  function checkPasswordMatch() {
    var password = $password.val();
    var confirmation = $confirmation.val();
    
    // Don't show feedback until they start typing confirmation
    if (confirmation.length === 0) {
      $feedback.removeClass('text-success text-danger').html('');
      $submitBtn.prop('disabled', false);
      return;
    }
    
    // Check if passwords match and meet minimum length
    if (password === confirmation) {
      if (password.length >= 5) {
        $feedback.removeClass('text-danger').addClass('text-success')
          .html('<i class="fa fa-check-circle"></i> Passwords match');
        $submitBtn.prop('disabled', false);
      } else {
        $feedback.removeClass('text-success').addClass('text-danger')
          .html('<i class="fa fa-exclamation-circle"></i> Password must be at least 5 characters');
        $submitBtn.prop('disabled', true);
      }
    } else {
      $feedback.removeClass('text-success').addClass('text-danger')
        .html('<i class="fa fa-times-circle"></i> Passwords do not match');
      $submitBtn.prop('disabled', true);
    }
  }

  // Trigger validation on input
  if ($password.length && $confirmation.length) {
    $password.on('input', checkPasswordMatch);
    $confirmation.on('input', checkPasswordMatch);
  }
});
