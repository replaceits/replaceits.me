/// <reference path="../typings/index.d.ts" />

$(document).ready(function(){

    // Smooth scrolling down when the chevron is pressed.
    $('.fa-chevron-down').click(function(){
        $('html, body').animate({
            scrollTop: $("#Skills").offset().top
        }, {
            duration: 1250,
            easing: 'swing'
        });
    });
    
    // Prevent image links from being pressed until hovering over the image.
    // This prevents accidental clicking of the image controls on mobile,
    // when touching the image. 
    $('.content-project-image-container').hover(function(){
        // On mouse enter enable the link
        setTimeout(function(anchor){
            anchor.children('.content-project-image-controls').children('a').unbind('click').click(function(event){
                return true;
            });
        },50,$(this));
    },function(){
        // On mouse leave disable the link
        $(this).children('.content-project-image-controls').children('a').unbind('click').click(function(event){
            return false;
        });
    }).children('.content-project-image-controls').children('a').unbind('click').click(function(event){
        // Disable all image links on first load
        return false;
    });
});