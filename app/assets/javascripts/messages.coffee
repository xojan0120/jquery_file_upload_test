# fileのDATA URLを取得
get_reader = (file) ->
  reader = new FileReader()
  reader.readAsDataURL(file)
  return reader

get_file_count = (selector) ->
  $(selector).get(0).files.length

preview_image = (reader) ->
  img = $("<img>")
  img.prop("src", reader.result)

clear_form = ->
  $("#send").hide()
  $(".filesize").text("0")
  $(".preview").empty()


$(document).on "change", "#picture", (event) ->
  if get_file_count($(this)) > 0
    clear_form()
    picture = $(this).get(0).files[0]
    reader = get_reader(picture)
    reader.addEventListener "loadend", (event) ->
      img = preview_image(reader)
      $(".preview").append(img)
      $(".filesize").text(event.total)
      $("#send").show()

$(document).on "click", "#send", (event) ->
  fd = new FormData()
  fd.append("message[picture]", $("#picture").prop("files")[0])
  fd.append("authenticity_token", $("[name=authenticity_token]").val())
  $.ajax({
    url: "/messages",
    data: fd,
    type: "POST",
    dataType: "json",
    processData: false,
    contentType: false
  }).done (data, status, xhr) ->
      $(".result").text(data["result"])
      clear_form()

$(document).on "click", "#select", (event) ->
  $("#picture").click()
