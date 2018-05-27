if Meteor.isServer

	Meteor.publish \coll, -> [
		coll.bangsal.find {}
		coll.marquee.find {}
		coll.lastUpdate.find {}
	]

	Meteor.methods do
		update: (obj, num) ->
			find = coll.bangsal.findOne name: obj.group
			sel = _id: find._id
			mod = $set: rooms: do ->
				index = _.findIndex find.rooms, -> it.name is obj.room.name
				find.rooms[index]use = parseInt num
				find.rooms
			coll.bangsal.update sel, mod

		reset: ->
			coll.bangsal.remove {}
			coll.marquee.remove {}
			seeder.map -> coll.bangsal.insert it

		marquee: (obj) ->
			coll.marquee.remove {}
			coll.marquee.insert text: obj.text

		lastUpdate: ->
			coll.lastUpdate.remove {}
			coll.lastUpdate.insert date: new Date()
