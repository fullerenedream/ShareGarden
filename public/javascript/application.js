$(document).ready(function() {

    // jQuery UI
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


    // Star
    $( ".glyphicon" ).click(function(){
        $(this).toggleClass("yellow");
        if ($(this).hasClass("yellow")) {
            $.ajax({
                type: "POST",
                url: '/spaces/addfavorites/'+$(this).attr("id")+"/1",
                data: 1,
                contentType: 'json',
                success: function(){
                    //
                },
                error: function(){
                    //
                },
                dataType: 'json'
            });
        }
        else {
            $.ajax({
                type: "POST",
                url: '/spaces/addfavorites/'+$(this).attr("id")+"/0",
                data: 0,
                contentType: 'json',
                success: function(){
                    //
                },
                error: function(){
                    //
                },
                dataType: 'json'
            });
        }
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
