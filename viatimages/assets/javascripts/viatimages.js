$( document ).ready(function() {
    $("a#titreDetailLabel").click(function() {
        if($(this).attr('class') === 'inactive') {
            $(this).attr('class', 'active');
            $('#titreDetailTradLabel').attr('class', 'inactive');
            $('#titreDetailTrad').css('display', 'none');
            $('#titreDetail').css('display', 'inline');
        }
    });

    $("a#titreDetailTradLabel").click(function() {
        if($(this).attr('class') === 'inactive') {
            $(this).attr('class', 'active');
            $('#titreDetailLabel').attr('class', 'inactive');
            $('#titreDetail').css('display', 'none');
            $('#titreDetailTrad').css('display', 'inline');
        }
    });

    $("a#caracteristiquesLabel").click(function() {
        d = $('#caracteristiques').css('display');
        if (d == 'none') {
            $('#arrowCaracteristiques').attr('src', '/assets/arrow-collapse.gif');
        } else {
            $('#arrowCaracteristiques').attr('src', '/assets/arrow-expand.gif');
        }
        $('#caracteristiques').animate({height: 'toggle'});
    });

    $("a#remarquesLabel").click(function() {
        d = $('#remarques').css('display');
        if (d == 'none') {
            $('#arrowRemarques').attr('src', '/assets/arrow-collapse.gif');
        } else {
            $('#arrowRemarques').attr('src', '/assets/arrow-expand.gif');
        }
        $('#remarques').animate({height: 'toggle'});
    });
});