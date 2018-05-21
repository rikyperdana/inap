if Meteor.isServer

	@seeder = [
		name: \hnd
		label: 'Hang Nadim'
		color: \red
		rooms: [
			name: \laki-laki
			cap: 6
		,
			name: \perempuan
			cap: 7
		]
	,
		name: \hlk
		label: 'Hang Lekir'
		color: \blue
		rooms: [
			name: \laki-laki
			cap: 6
		,
			name: \perempuan
			cap: 6
		,
			name: \anak
			cap: 10
		]
	,
		name: \dmd
		label: 'Dang Merdu'
		color: \green
		rooms: [
			name: \dm2
			cap: 2
		,
			name: \dm3
			cap: 2
		,
			name: \dm4
			cap: 4
		,
			name: \dm5
			cap: 3
		,
			name: \dm6
			cap: 3
		,
			name: \dm8
			cap: 2
		,
			name: \dm9
			cap: 2
		,
			name: \dm10
			cap: 1
		,
			name: \dm11
			cap: 2
		,
			name: \dm13
			cap: 1
		,
			name: \dm13
			cap: 3
		,
			name: \dm14
			cap: 3
		,
			name: \isolasi
			cap: 1
		]
	,
		name: \others
		label: \Lainnya
		color: \purple
		rooms: [
			name: \perina
			cap: 3
		,
			name: \icu
			cap: 2
		,
			name: \kb
			cap: 18
		]
	]

	unless coll.bangsal.findOne!
		seeder.map -> coll.bangsal.insert it
