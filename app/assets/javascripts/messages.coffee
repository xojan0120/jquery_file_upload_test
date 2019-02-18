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

preview_delete_icon = ->
  span = $("<span>")
  span.prop("class", "glyphicon glyphicon-trash")
  span.prop("id", "preview_delete")

clear_form = ->
  $("#send").hide()
  $(".filesize").text("0")
  $(".preview").empty()
  $("#picture").val("")

append_images = (urls) ->
  $(".images").empty()
  $.each urls, (i,url) ->
    img = $("<img>")
    img.prop("src", url)
    $(".images").append(img)

$(document).on "change", "#picture", (event) ->
  $(".result").text("")
  if get_file_count($(this)) > 0
    picture = $(this).get(0).files[0]
    reader = get_reader(picture)
    reader.addEventListener "loadend", (event) ->
      img = preview_image(reader)
      $(".preview").append(img)
      $(".preview").append(preview_delete_icon())
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
      append_images(data["images"])
      clear_form()

$(document).on "click", "#select", (event) ->
  $("#picture").click()

$(document).on "click", "#preview_delete", (event) ->
  clear_form()
