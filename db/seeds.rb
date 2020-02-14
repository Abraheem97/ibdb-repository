# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Run 'rake db:seed' from terminal to create an Admin User in your database

superadmin = User.new({  email: 'superadmin@ibdb.com',
               password: 'password', password_confirmation: 'password'})
    
    superadmin.toggle!(:superadmin)

    if superadmin.valid?
      superadmin.save()

    elsif superadmin.errors.any?
      superadmin.errors.full_messages.each do |msg|
        puts msg
      end
    else
      puts "****NOT VALID****"
    end

    author = Author.new(name: "Delia Owens", image_file_name: "assets/Delia.jpg", image_content_type: "image/jpeg", description: "Owens grew up in rural Georgia in the 1950s. She and her then-husband, Mark Owens, were students in biology at the University of Georgia. 
      She earned a Bachelor of Science degree in zoology from the University of Georgia and a Ph.D. in
       Animal Behavior from the University of California in Davis.They moved to Africa in 1974, worked 
       in North Luangwa National Park, and later in Mpika, Zambia in the early 1990s. ABC aired a report in 1996 entitled
        'Deadly Game: The Mark and Delia Owens Story', produced by Andrew Tkach and hosted by Meredith Vieira. The report 
        featured the controversial killing of a poacher in Zambia, allegedly committed by her stepson and husband, who are 
        wanted in Zambia for questioning. The family were also accused of having 'archaic ideas about Africans', 
        with one critic describing their views as “Nice continent. Pity about the Africans” as well as infantilising them.
         Since completing her PhD in Biology she has published her studies of African wildlife behavioral ecology in professional journals,
          including Nature, the Journal of Mammalogy, Animal Behaviour, and the African Journal of Ecology. She has also contributed articles 
          to Natural History and International Wildlife aimed at a wider audience. ")
          author.save()

    user = User.new( {email: "abraheemasad.f@gmail.com", password: 'password', password_confirmation: 'password' superadmin: false, avatar_file_name: "assets/myavatar.png", avatar_content_type: "image/png"})
    user.save()
    
    book_2 = Book.new(title: "The Kite Runner", author_name: "Delia Owens" image_file_name: "assets/kiterunner.jpg", image_content_type: "image/jpeg")
    book_2.author = author
    book_2.save()
    
    book = Book.new(title: "Mazes Of Power", author_name: "Delia Owens", image_file_name: "assets/mazes.jpg", image_content_type: "image/jpeg")
    book.author = author
    book.save()

    comment = book.comments.build (body: "Ghosted is a well-written and easy-to-read piece that flows along nicely. 
      Its focus is on Violet, a twenty-something midwife who’s 
      living in the dominating shadow of her abusive boyfriend Adrian.
       She finds the courage to break up with him - and almost immediately 
       finds herself starting a new romantic relationship with Matthew. 
       Zoe, her lifelong best friend, warns her not to go too fast.
        Soon, Zoe unexpectedly and inexplicably cuts off all contact 
        with Violet, leaving her reeling and confused.
      ")
    comment.user = user
    comment.save()