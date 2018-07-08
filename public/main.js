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
            var parsed_json = JSON.parse(json)
            console.log(parsed_json[0]["name"])
            // var next_name = json["next"]
            // console.log(next_name)
            // $(".next_name").text(next_name)
        })
})