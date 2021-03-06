# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
    amenities = Amenity.create(
        [
            {name:"Pool"},
            {name:"Game Room"},
            {name:"Lounge"},
            {name:"Study Area"},
            {name:"Pet Park"}])

    metrics = Metric.create(
        [
            {name:"Overall"},
            {name:"Transportation"},
            {name:"Noise"},
            {name:"Management"},
            {name:"Location"},
            {name:"Amenities"}])

    tags = Tag.create(
        [
            {name:"Grad Student Friendly"},
            {name:"Pets Allowed"},
            {name:"Responsive Management"},
            {name:"Onsite Laundry"},
            {name:"Has Bus Route"}])

    users = User.create(
        [
            {email:"s.poncik@tamu.edu",password_digest:"testpw"},
            {email:"cmainard@tamu.edu",password_digest:"ex"},
            {email: "jhann@blinn.edu", password_digest:"jhann"}])

    apartments = Apartment.create(
        [
            {name:"The Stack"},
            {name:"The Rise"},
            {name:"Wells Hall"},
            {name:"The Wick"},
            {name:"Campus Village"}])

    admin_table = AdminTable.create(
        [
            {user_id: 1}
        ]
    )



