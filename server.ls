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

		reset: ->
			coll.remove {}
			seeder.map -> coll.insert it

		changeColor: (group, color) ->
			sel = name: group
			mod = $set: {color}
			coll.update sel, mod
