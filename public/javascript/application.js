$(document).ready(function() {

    $( "#button" ).button();
    $( "#radioset" ).buttonset();

    // Hover states on the static widgets
    $( "#dialog-link, #icons li" ).hover(
        function() {
            $( this ).addClass( "ui-state-hover" );
        },
        function() {
            $( this ).removeClass( "ui-state-hover" );
        }
    );

    
    $( ".glyphicon" ).click(function(){
        $(this).toggleClass("yellow");
        /*var data = "1"
        $.ajax({
            type: "GET",
            url: '/spaces/addfavorites',
            data: JSON.stringify(data),
            contentType: 'json',
            success: function(data) {
                alert("yay");
            },
            error: function(err, response){
                alert(err);
            },
            dataType: 'json'
        });*/

        
    });

});
