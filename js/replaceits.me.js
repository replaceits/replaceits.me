$(document).ready(function(){
    $('.fa-chevron-down').click(function(){
        $('html, body').animate({
            scrollTop: $("#Skills").offset().top
        }, {duration: 1250, easing: 'swing'});
    });
});