if Meteor.isServer

	Meteor.publish \coll, -> coll.find {}

	Meteor.methods do
		update: (obj, num) ->
			find = coll.findOne name: obj.group
			sel = _id: find._id
			mod = $set: rooms: do ->
				index = _.findIndex find.rooms, -> it.name is obj.room.name
				find.rooms[index]cap = parseInt num
				find.rooms
			coll.update sel, mod

	seeder = [
		name: \hnd
		label: 'Hang Nadim'
		color: \red
		rooms: [
			name: \laki-laki
			cap: 0
		,
			name: \perempuan
			cap: 0
		]
	,
		name: \hlk
		label: 'Hang Lekir'
		color: \blue
		rooms: [
			name: \laki-laki
			cap: 0
		,
			name: \perempuan
			cap: 0
		,
			name: \anak
			cap: 0
		]
	,
		name: \dmd
		label: 'Dang Merdu'
		color: \green
		rooms: [
			name: \dm2
			cap: 0
		,
			name: \dm3
			cap: 0
		,
			name: \dm4
			cap: 0
		,
			name: \dm5
			cap: 0
		,
			name: \dm6
			cap: 0
		,
			name: \dm8
			cap: 0
		,
			name: \dm9
			cap: 0
		,
			name: \dm10
			cap: 0
		,
			name: \dm11
			cap: 0
		,
			name: \dm13
			cap: 0
		,
			name: \dm13
			cap: 0
		,
			name: \dm14
			cap: 0
		,
			name: \isolasi
			cap: 0
		]
	,
		name: \prn
		label: 'Perina'
		color: \purple
		rooms: [
			name: \prn
			cap: 0
		]
	,
		name: \icu
		label: 'ICU'
		color: \pink
		rooms: [
			name: \icu
			cap: 0
		]
	,
		name: \dpr
		label: 'Dang Purnama'
		color: \teal
		rooms: [
			name: \kb
			cap: 0
		]
	]

	unless coll.findOne!
		seeder.map -> coll.insert it
