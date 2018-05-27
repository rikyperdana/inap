if Meteor.isClient

	makeRooms = (obj) ->
		attr =
			room: (doc, groupId) ->
				style: border: '1px solid white'
				class: do ->
					size = Math.round 12 / obj.rooms.length
					size += 2 if size is 1
					"m#size #{obj.color}"
				ondblclick: -> if Meteor.userId!
					state.edit = group: groupId, room: doc
					m.redraw!
		m \.row,
			m \.divider
			m \h4.center, attr.header, obj.label
			obj.rooms.map (i) ->
				m \.col, attr.room(i, obj.name),
					m \.col.m6, m \p.white-text.center, i.name
					m \.col.m6, m \p.white-text.center, "#{i.use or 0} of #{i.cap}"

	front = ->
		attr =
			form:
				bangsal: onsubmit: (e) ->
					e.preventDefault!
					Meteor.call \update, state.edit, e.target.0.value
					Meteor.call \lastUpdate
					state.edit = null; $ \#modalBangsal .modal \close
				marquee: onsubmit: (e) ->
					e.preventDefault!
					Meteor.call \marquee, text: e.target.0.value, (err, res) ->
						$ \#modalMarquee .modal \close if res
				login: onsubmit: (e) ->
					e.preventDefault!
					[username, password] = _.map e.target
					Meteor.loginWithPassword username.value, password.value, (err) ->
						$ \#modalLogin .modal \close
			reset: ondblclick: -> if Meteor.userId!
				Meteor.call \reset, (err, res) -> m.redraw! if res
			modal:
				bangsal: oncreate: -> $ \#modalBangsal .modal!modal \open
				login:
					oncreate: -> $ \#modalLogin .modal!
					onclick: -> $ \#modalLogin .modal \open
			marquee:
				oncreate: -> $ \.marquee .marquee duration: 15000
				ondblclick: -> Meteor.userId! and $ \#modalMarquee .modal!modal \open
		view: -> m \div,
			m \nav.teal, m \.nav-wrapper, m \a.brand-logo.center, 'Sistem Informasi Ketersediaan Bangsal RSUD Petala Bumi'
			m \.container,
				m \.row,
					m \h5.left, moment(coll.lastUpdate.findOne!date)format(\LT) + ' / ' + moment(coll.lastUpdate.findOne!date)?format 'D MMM YYYY'
					m \a.right, attr.modal.login, \Login
					m \a.right, attr.reset, \Reset
				if state.edit
					m \.modal#modalBangsal, attr.modal.bangsal, m \form, attr.form.bangsal,
						m \.modal-content,
							m \h4, 'Bangsal terpakai'
							m \.input-field, m \input,
								type: \text, id: state.edit.group
						m \.modal-footer,
							m \input.btn-flat, type: \submit
				m \.modal#modalLogin, m \.modal-content, m \form, attr.form.login,
					m \h5.center, 'Login Admin Bangsal'
					m \input, type: \text, id: \username, placeholder: \Username
					m \input, type: \password, id: \password, placeholder: \Password
					m \input.btn, type: \submit, value: \Login
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
