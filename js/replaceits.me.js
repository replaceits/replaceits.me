/// <reference path="../typings/index.d.ts" />

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

    // Check if mobile device
    if(window.matchMedia("only screen and (min-device-width: 320px) and (max-device-width: 480px)")){

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
