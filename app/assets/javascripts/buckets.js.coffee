App.buckets = {}

App.buckets['show'] = ->
  $('#read-only-button').click (e) ->
    val = $('#bucket_read_only').val()

    if val == 'true'
      $('#bucket_read_only').val('false')
    else
      $('#bucket_read_only').val('true')

  $('#putsreq-url-input').on 'click', ->
    $(this).select()

  editor = ace.edit 'editor'
  editor.setTheme 'ace/theme/monokai'
  editor.setShowPrintMargin(false)
  editor.getSession().setMode 'ace/mode/javascript'
  editor.setReadOnly($('#bucket_read_only').val() == 'true')
  editor.getSession().on 'change', ->
    $('#bucket_response_builder').val editor.getSession().getValue()

  editor.setValue $('#response-builder-container').text()
  editor.clearSelection()

  ZeroClipboard.config
    moviePath: '/flash/ZeroClipboard.swf'

  window.client = new ZeroClipboard $('#copy-button')
  htmlBridge = '#global-zeroclipboard-html-bridge'

  tipsyConfig = title: 'Copy to Clipboard', copiedHint: 'Copied!'

  $(htmlBridge).tipsy gravity: $.fn.tipsy.autoNS
  $(htmlBridge).attr 'title', tipsyConfig.title

  client.on 'complete', (client, args) ->
    $('#putsreq-url-input').focus().blur()

    $(htmlBridge).prop('title', tipsyConfig.copiedHint).tipsy 'show'
    $(htmlBridge).attr 'original-title', tipsyConfig.title
