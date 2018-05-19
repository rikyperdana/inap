if Meteor.isClient

	makeRooms = (obj) ->
		attr =
			room: (doc, groupId) ->
				style: border: '1px solid white'
				class: do ->
					size = Math.round 12 / obj.rooms.length
					size += 2 if size is 1
					"m#size #{obj.color}"
				ondblclick: ->
					state.edit = group: groupId, room: doc
					m.redraw!
		m \.row,
			m \.divider
			m \h4.center, attr.header, obj.label
			obj.rooms.map (i) ->
				m \.col, attr.room(i, obj.name),
					m \.col.m6, m \p.white-text.center, _.startCase i.name
					m \.col.m6, m \p.white-text.center, "#{i.use or 0} of #{i.cap}"

	front = ->
		attr =
			form: onsubmit: (e) ->
				e.preventDefault!
				Meteor.call \update, state.edit, e.target.0.value
				state.edit = null
				$ \#modal1 .modal \close
			reset: ondblclick: ->
				Meteor.call \reset, (err, res) -> m.redraw! if res
			modal: oncreate: -> $ \#modal1 .modal!modal \open
		view: -> m \.container,
			if state.edit
				m \.modal#modal1, attr.modal, m \form, attr.form,
					m \.modal-content,
						m \h4, 'Bangsal terpakai'
						m \.input-field, m \input,
							type: \text, id: state.edit.group
					m \.modal-footer,
						m \input.btn, type: \submit
			coll.find!fetch!map makeRooms
			m \.center, m \a, attr.reset, \Reset

	Meteor.subscribe \coll, onReady: ->
		m.mount document.body, front!

	coll.find!observe do
		changed: -> m.redraw!
