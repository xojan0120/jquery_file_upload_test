#$ ->
#  $('#upload').fileupload
#    dataType: 'json'
#    done: (e, data) ->
#      $.each data.result.files, (index, file) ->
#        $('<p/>').text(file.name).appendTo document.body
#        return
#      return
#    submit: (e, data) ->
#      console.log("upload!")
#      return
#  return

$(document).on "change", "#upload", (event) ->
  event.currentTarget.submit()

$(document).on "click", "#btn", (event) ->
  $("#select").click()
