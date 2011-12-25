$ = jQuery

class iPhoneWindow extends google.maps.OverlayView
	defaults:
		timestamp: true
		arrow: false
		arrowdown: true
	restoreDefaults: ()->
		$.extend(@options, @default)
	constructor: (@body, @tsub, @options)->
		$.extend(@options, @default, @options)
		@div = null
		@isOpen = false
		@buildDOM()
	buildDOM: ()->
		# body
		@bdiv = $(document.createElement('div')).addClass('iPhoneWindowTestHover').html(@body) # height test must be deferred until these are added to the DOM
		# tsub
		@tabbr = $(document.createElement('abbr')).addClass('iPhoneWindowTsub').html(@timestamp.toString())
		if @options.timestamp
			# attach easydate
			@tabbr.addClass('easydate')
			@tabbr.easydate()
		# arrow
		if @options.arrow
			@adiv = $(document.createElement('img')).addClass('iPhoneWindowArrow').attr('src', 'assets/arrow.png')
			if @options.arrowdown
				@adiv.addClass('iPhoneWindowArrowDown')
		# window
		@wdiv = $(document.createElement('div')).hide().addClass('iPhoneWindow').append(@tabbr).append(@adiv).append(@bdiv)
		# shadow
		@sdiv = $(document.createElement('div')).hide().addClass('iPhoneWindowShadow')
	onAdd: ()->
		# attach window
		panes = @getPanes()
		$(panes.floatPane).append(@wdiv)
		# set proper height now that they are added
		if @bdiv.height() > 16
			@bdiv.removeClass('iPhoneWindowTestHover').addClass('iPhoneWindowBodyHover')
		else
			@bdiv.removeClass('iPhoneWindowTestHover').addClass('iPhoneWindowBody')
		# attach shadow
		$(panes.floatShadow).append(@sdiv)
	onRemove: ()->
		@wdiv.detach()
	draw: ()->
		proj = @getProjection()
		if not proj
			return
		latlng = @get('position')
		if not latlng
			return
		pos = proj.fromLatLngToDivPixel(latlng)
		# position window
		top = (pos.y - @wdiv.height() - @getAnchorHeight())
		@wdiv.css('top', top)
		left = (pos.x - @wdiv.width()*0.75)
		@wdiv.css('left', left)
		# position shadow
		@sdiv.css('top', top - @getAnchorHeight()/2)
		@sdiv.css('left', left)
		width = @wdiv.width()
		@sdiv.width(width)
		height = @wdiv.height()
		@sdiv.height(height)
	open: (map, anchor)->
		if map
			@setMap(map)
		if anchor
			@set('anchor', anchor)
			@bindTo('anchorPoint', anchor)
			@bindTo('position', anchor)
		# show
		@wdiv.show()
		@sdiv.show()
		@isOpen = true
	close: ()->
		# hide
		@wdiv.hide()
		@sdiv.hide()
		@isOpen = false
	getAnchorHeight: () ->
		(-1*@get('anchorPoint').y)

# export to google.maps.iPhoneWindow()
obj.iPhoneWindow = iPhoneWindow
$.extend(google.maps, obj)