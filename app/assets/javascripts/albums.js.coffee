# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@fileUploadErrors =
  maxFileSize: 'File is too big'
  minFileSize: 'File is too small'
  acceptFileTypes: 'Filetype not allowed'
  maxNumberOfFiles: 'Max number of files exceeded'
  uploadedBytes: 'Uploaded bytes exceed file size'
  emptyResult: 'Empty file upload result'

$(document).on 'ready page:load', ->
  # Initialize the jQuery File Upload widget:
  $('#fileupload').fileupload
    paramName: 'picture[image]'

  if $('#fileupload').length > 0
    # Load existing files:
    $.getJSON $('#fileupload').prop('action'), (files) ->
      fu = $('#fileupload').data 'blueimpFileupload'
      fu._adjustMaxNumberOfFiles -files.length
      template = fu._renderDownload(files).appendTo '#fileupload .files'
      # Force reflow:
      fu._reflow = fu._transition && template.length && template[0].offsetWidth
      template.addClass 'in'
      $('#loading').remove()

  $('#modal-picture .btn-primary').click (evt) ->
    evt.preventDefault()
    form = $('#new_picture')
    $.ajax
      type: 'post'
      url: form.attr 'action'
      data: form.serialize()
      success: (rt) ->
        link = $(".picture[data-picture-id=#{form.data('picture-id')}]")
        link.data
          title: $('#picture_title').val()
          footer: $('#picture_description').val()
        $('#modal-picture').modal('hide')

  $('#modal-picture').bind 'hidden.bs.modal', ->
    form = $('#new_picture')
    form.attr 'action', ''
    form.data 'picture-id', ''
    form.trigger 'reset'

$(document).delegate '.btn-edit-picture', 'click', (evt) ->
  evt.preventDefault()
  url = $(this).attr 'href'
  $.ajax
    type: 'get'
    url: url
    success: (rj) ->
      $('#new_picture').attr
        action: url
      .data
        'picture-id': rj.id
      $('#picture_title').val rj.title
      $('#picture_description').val rj.description
      $('#modal-picture').modal()

$(document).delegate '*[data-toggle="lightbox"]', 'click', (evt) ->
  evt.preventDefault()
  $(this).ekkoLightbox()
