@coll = {}
coll.bangsal = new Meteor.Collection \coll
coll.marquee = new Meteor.Collection \marquee
coll.marquee.allow insert: -> true
