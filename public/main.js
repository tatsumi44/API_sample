$(".api").on('click',function () {
    console.log("OK")
    var date_val = $(".date").val()
    $.ajax({
        url: '/news',
        type: 'get',
        dataType: 'json',
        data: {
            date: date_val
        }
    })
        .done(function (base_json) {
            var json = base_json
            console.log(json)
            // var next_name = json["next"]
            // console.log(next_name)
            // $(".next_name").text(next_name)
        })
})