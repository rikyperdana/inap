if Meteor.isServer

	@seeder = [
		name: \hnd
		label: 'Ruangan Hang Nadim'
		color: \red
		rooms: [
			name: \Laki-laki
			cap: 6
		,
			name: \Perempuan
			cap: 7
		]
	,
		name: \hlk
		label: 'Ruangan Hang Lekir'
		color: \blue
		rooms: [
			name: \Laki-laki
			cap: 6
		,
			name: \Perempuan
			cap: 6
		,
			name: \Anak
			cap: 10
		]
	,
		name: \dmd
		label: 'Ruangan Dang Merdu'
		color: \green
		rooms: [
			name: \DM2
			cap: 2
		,
			name: \DM3
			cap: 2
		,
			name: \DM4
			cap: 4
		,
			name: \DM5
			cap: 3
		,
			name: \DM6
			cap: 3
		,
			name: \DM8
			cap: 2
		,
			name: \DM9
			cap: 2
		,
			name: \DM10
			cap: 1
		,
			name: \DM11
			cap: 2
		,
			name: \DM12
			cap: 1
		,
			name: \DM13
			cap: 3
		,
			name: \DM14
			cap: 3
		,
			name: \Isolasi
			cap: 1
		]
	,
		name: \others
		label: 'Ruangan Lainnya'
		color: \purple
		rooms: [
			name: \Perina
			cap: 3
		,
			name: \ICU
			cap: 2
		,
			name: 'Dang Purnama'
			cap: 18
		]
	]

	unless coll.bangsal.findOne!
		seeder.map -> coll.bangsal.insert it
