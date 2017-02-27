/// <reference path="../typings/index.d.ts" />

var captcha_filled = false;
var valid_email = false;
var valid_name = false;
var valid_message = false;
var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;

// Recaptcha filled in correctly
function recaptchaCallback(){
    captcha_filled = true;
    $('.submit-button').show();
    $('.g-recaptcha').hide();
};

// Recaptcha expired
function recaptchaExpiredCallback(){
    captcha_filled = false;
    $('.submit-button').hide();
    grecaptcha.reset();
}

function inputNameChange(){
    valid_name = $(this).val().length > 0 && $(this).val().length <= 255;
    if(valid_name){
        $(this).removeClass('invalid');
    } else {
        $(this).removeClass('invalid').addClass('invalid');
    }
}

function emailNameChange(){
    valid_email = $(this).val().length > 0 && $(this).val().length <= 255 && $(this).val().match(mailformat);
    if(valid_email){
        $(this).removeClass('invalid');
    } else {
        $(this).removeClass('invalid').addClass('invalid');
    }
}

function messageNameChange(){
    $('.input-count').text($(this).val().length);

    valid_message = $(this).val().length > 0 && $(this).val().length <= 5000;
    if(valid_message){
        $(this).removeClass('invalid');
    } else {
        $(this).removeClass('invalid').addClass('invalid');
    }
}



$(document).ready(function(){

    // Smooth scrolling down when the chevron is pressed.
    $('.fa-chevron-down').click( function(){
        $('html, body').animate({
            scrollTop: $("#Skills").offset().top
        }, {
            duration: 1250,
            easing: 'swing'
        });
    });

    $('.submit-button').click( function(){
        valid_email = $('#input-email').val().length > 0 && $('#input-email').val().length <= 255 && $('#input-email').val().match(mailformat);
        valid_name = $('#input-name').val().length > 0 && $('#input-name').val().length <= 255;
        valid_message = $('#input-message').val().length > 0 && $('#input-message').val().length <= 5000;

        if(captcha_filled && valid_email && valid_name && valid_message && grecaptcha.getResponse() !== null){
            $('.contact-form').css('visibility','hidden');
            $('.contact-loading').show();
            $.ajax({
                method: 'POST',
                url: 'https://www.replaceits.me/message.php',
                cache: false,
                data: "name="+encodeURIComponent($('#input-name').val())+"&email="+encodeURIComponent($('#input-email').val())+"&message="+encodeURIComponent($('#input-message').val())+"&g-recaptcha-response="+encodeURIComponent(grecaptcha.getResponse())
            }).done( function( msg ){
                $('.contact-form').hide();
                $('.contact-loading').hide();
                $('.contact-complete').show();
                $('.contact-success').show();
            }).fail( function( jqXHR, textStatus ){
                $('.contact-form').hide();
                $('.contact-loading').hide();
                $('.contact-complete').show();
                $('.contact-failure').show();
                switch(jqXHR.status){
                    case 400:
                        $('.contact-failure-status').text("Something you submitted was invalid");
                        break;
                    case 500:
                        $('.contact-failure-status').text("Our database is having troubles right now");
                        break;
                    default:
                        $('.contact-failure-status').text("We're not sure what happened...");
                        break;
                }
            });
        } else {
            if( !valid_name ){
                $('#input-name').focus();
            } else if( !valid_email ){
                $('#input-email').focus();
            } else if( !valid_message ){
                $('#input-message').focus();
            }
            if( grecaptcha.getResponse() === null ){
                grecaptcha.reset();
                $('.submit-button').hide();
                $('.g-recaptcha').show();
            }
        }
    });

    $('#input-name'   ).change( inputNameChange   ).keypress( inputNameChange   ).on( 'paste',   inputNameChange).on( 'input',   inputNameChange );
    $('#input-email'  ).change( emailNameChange   ).keypress( emailNameChange   ).on( 'paste',   emailNameChange).on( 'input',   emailNameChange );
    $('#input-message').change( messageNameChange ).keypress( messageNameChange ).on( 'paste', messageNameChange).on( 'input', messageNameChange );

    // Check if mobile device
    if(window.matchMedia("only screen and (min-device-width: 320px) and (max-device-width: 480px)").matches){
        // This will prevent the page from jumping when the address bar hides
        // by setting the content pages height to it's own height in px on document
        // load rather than having it in 'vh' units.
        $('.content-page.full').css('height',$('.content-page.full').height() + 'px').css('min-height',$('.content-page.full').height() + 'px');

        // Prevent image links from being pressed until hovering over the image.
        // This prevents accidental clicking of the image controls on mobile,
        // when touching the image. 
        $('.content-project-image-container').hover( function(){
            // On mouse enter enable the link (short delay to prevent it from 
            // enabling during a users first press in the box).
            setTimeout( function(anchor){
                anchor.children('.content-project-image-controls').children('a').unbind('click').click( function(event){
                    return true;
                });
            }, 50, $(this));
        }, function(){
            // On mouse leave disable the link
            $(this).children('.content-project-image-controls').children('a').unbind('click').click( function(event){
                return false;
            });
        }).children('.content-project-image-controls').children('a').unbind('click').click( function(event){
            // Disable all image links on first load
            return false;
        });
    }
});
