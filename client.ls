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
			form:
				bangsal: onsubmit: (e) ->
					e.preventDefault!
					Meteor.call \update, state.edit, e.target.0.value
					state.edit = null; $ \#modalBangsal .modal \close
				marquee: onsubmit: (e) ->
					e.preventDefault!
					Meteor.call \marquee, text: e.target.0.value, (err, res) ->
						$ \#modalMarquee .modal \close if res
			reset: ondblclick: ->
				Meteor.call \reset, (err, res) -> m.redraw! if res
			modal: bangsal: oncreate: -> $ \#modalBangsal .modal!modal \open
			marquee:
				oncreate: -> $ \.marquee .marquee duration: 15000
				ondblclick: -> $ \#modalMarquee .modal!modal \open
		view: -> m \.container,
			m \.left, m \h5, moment(new Date!)format 'D MMM YYYY'
			m \.right, m \a, attr.reset, \Reset
			if state.edit
				m \.modal#modalBangsal, attr.modal.bangsal, m \form, attr.form.bangsal,
					m \.modal-content,
						m \h4, 'Bangsal terpakai'
						m \.input-field, m \input,
							type: \text, id: state.edit.group
					m \.modal-footer,
						m \input.btn-flat, type: \submit
			coll.bangsal.find!fetch!map makeRooms
			m \.marquee, attr.marquee, m \h5, (coll.marquee.findOne!?text or 'no info')
			m \.modal#modalMarquee, m \form, attr.form.marquee,
				m \.modal-content,
					m \h4, 'Konten Marquee'
					m \.input-field, m \input,
						type: \text, id: \marquee
				m \.modal-footer,
					m \input.btn-flat, type: \submit

	Meteor.subscribe \coll, onReady: ->
		m.mount document.body, front!

	coll.bangsal.find!observe changed: -> m.redraw!
	coll.marquee.find!observe added: -> m.redraw!
