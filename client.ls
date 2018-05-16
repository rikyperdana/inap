if Meteor.isClient

	makeRooms = (obj) ->
		attr = (doc, groupId) ->
			style: border: '1px solid white'
			class: do ->
				size = Math.round 12 / obj.rooms.length
				size += 2 if size is 1
				"m#size #{obj.color}"
			ondblclick: -> console.log groupId, doc
		m \.row,
			m \.divider
			m \h4.center, obj.label
			obj.rooms.map (i) ->
				m \.col, attr(i, obj._id),
					m \.col.m6, m \p.white-text.center, _.startCase i.name
					m \.col.m6, m \p.white-text.center, i.cap

	Meteor.subscribe \coll, onReady: ->
		m.render document.body, m \.container,
			coll.find!fetch!map -> makeRooms it
