@coll = {}
coll.bangsal = new Meteor.Collection \bangsal
coll.marquee = new Meteor.Collection \marquee
coll.marquee.allow insert: -> true
coll.lastUpdate = new Meteor.Collection \lastUpdate
coll.lastUpdate.allow insert: -> true
