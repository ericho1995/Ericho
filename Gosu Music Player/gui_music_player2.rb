require 'rubygems'
require 'gosu'
require './input_functions'

TOP_COLOR = Gosu::Color.new(0xFF1EB1FA)
BOTTOM_COLOR = Gosu::Color.new(0xFF1D4DB5)

module ZOrder
  BACKGROUND, PLAYER, UI = *0..2
end

module Genre
	POP, HIPHOP, SOUL, RNB = *1..4
end

Genre_names = ['Null', 'Pop', 'Hip-Hop', 'Soul', 'RnB']

class ArtWork
	attr_accessor :art

	def initialize (file)
		@art = Gosu::Image.new(file)
	end
end

class Track
    
	attr_accessor :number, :name, :location
    def initialize (number, name, location)
	  @number = number
      @name = name
      @location = location
  end
end

class Album
	# NB: you will need to add tracks to the following and the initialize()
		attr_accessor :id, :icon , :genre, :title, :artist , :tracks
	
	# complete the missing code:
		def initialize (id, title, icon, artist, genre, tracks)
			# insert lines here
			@id = id
			@title = title
			@artist = artist
			@icon = icon
			@genre = genre
			@tracks = tracks
			
		end
end

class Song
	attr_accessor :song
	def initialize (file)
		@song = Gosu::Song.new(file)
	end
 end

# Put your record definitions here


WIN_WIDTH = 1200
WIN_HEIGHT = 1000

class MusicPlayerMain < Gosu::Window

	def initialize
	    super WIN_WIDTH, WIN_HEIGHT
		self.caption = "Music Player"
		@font = Gosu::Font.new(25)
		@babyfont = Gosu::Font.new(10)
		@medfont = Gosu::Font.new(18)
		@locs = [60,60]
		@album_number = 0
		@index = 0
		#albums = load_albums()
		#display_album(albums)
		# Reads in an array of albums from a file and then prints all the albums in the
		# array to the terminal
	end


  # Put in your code here to load albums and tracks
  def load_albums()
	

	#read in music_file
	def read_files(music_file)
		count = music_file.gets.to_i
		albums = Array.new()
		x = 1
		while (x <= count)
		  album = read_file(music_file , x)
		  albums << album
		  x += 1
		end
		return albums
	end

    #singular album reads
	def read_file(music_file, x)
		album_id = x.to_s
		number_of_tracks = music_file.gets.to_i
		album_title = music_file.gets.chomp
		album_icon = music_file.gets.chomp
		album_artist = music_file.gets.chomp
		genre = music_file.gets.to_i
		album_genre = Genre_names[genre]
		album_tracks = read_tracks(music_file, number_of_tracks)
		album = Album.new(album_id, album_title, album_icon, album_artist, album_genre, album_tracks)
		return album
	end

	#read in singular tracks
	def read_track(music_file,x)
		track_number = x
		track_name = music_file.gets.chomp
		track_location = music_file.gets.chomp
		track = Track.new(track_number, track_name, track_location)
		
		return track
	end
	
	#read an array of tracks
    def read_tracks(music_file,number_of_tracks)
		tracks = Array.new()
		x = 1 
		while ( x <= number_of_tracks)
			track = read_track(music_file,x)
			tracks << track
			x += 1
		end
		return tracks
	end
	music_file = File.new("albums.txt", "r")
	albums = read_files(music_file)
    return albums
   end

  # Draws the artwork on the screen for all the albums
    #show the album photos
	def draw_albums(albums)
		
	    @art = Gosu::Image.new(albums[0].icon)#drake
	    @art.draw(50, 50 ,  ZOrder::PLAYER)
		
	    @art = Gosu::Image.new(albums[1].icon)
		@art.draw(50, 340,  ZOrder::PLAYER)#nectar

	    @art= Gosu::Image.new(albums[2].icon)#slow dancing
	    @art.draw(310, 50 ,  ZOrder::PLAYER)
   
	    @art = Gosu::Image.new(albums[3].icon)
		@art.draw(310, 340,  ZOrder::PLAYER)#marvins room
		
		@art = Gosu::Image.new(albums[4].icon)
		@art.draw(570, 50,  ZOrder::PLAYER)#league of legends
		
	end
	
	def click(mouse_x, mouse_y)
		if ((mouse_x >50 && mouse_x < 306)&& (mouse_y > 50 && mouse_y < 306 ))
			@album_number = 1
			@index = 1
			play_track(@album_number, @index)
			
		
		elsif ((mouse_x > 310 && mouse_x < 566) && (mouse_y > 50 && mouse_y <306))
			@album_number = 3
			@index = 1
			play_track(@album_number, @index)
		    
		elsif ((mouse_x > 310 && mouse_x < 566) && (mouse_y > 340 && mouse_y <596))
			@album_number = 4
			@index = 1
			play_track(@album_number, @index)
		    
		elsif ((mouse_x > 50 && mouse_x < 306) && (mouse_y > 340 && mouse_y <596))
			@album_number = 2
			@index = 1
			play_track(@album_number, @index)
		    
		elsif ((mouse_x > 570 && mouse_x < 826) && (mouse_y > 50 && mouse_y <306))
			@album_number = 5
			@index = 1
			play_track(@album_number, @index)
			
		elsif ((mouse_x >350 && mouse_x < 575)&& (mouse_y > 700 && mouse_y < 925 ))
			if (@index == 0)
				puts "You are currently pausing nothing. Random song playing..."
				@album_number = rand(1..5)
				@index = 1
			    play_track(@album_number, @index)
			end
			@song.pause
			puts "pause"
		elsif ((mouse_x >600 && mouse_x < 825)&& (mouse_y > 700 && mouse_y < 925 ))
			if (@index == 0)
				puts "you are currently stopping nothing. Random song playing..."
				@album_number = rand(1..5)
				@index = 1
				play_track(@album_number, @index)
				
			end
			@song.stop
			@album_number=0
			@index = 0
			@song.pause #this is so that the update doesnt get confused. As there's no song.stopped? function
		    puts "stop"
		elsif ((mouse_x >100 && mouse_x < 325)&& (mouse_y > 700 && mouse_y < 925 ))
			if (@index == 0)
				puts "You are currently playing nothing. Random song playing..."
				@album_number = rand(1..5)
				@index = 1
			    play_track(@album_number, @index)
			end
			@song.play
			puts "play"
		elsif ((mouse_x >850 && mouse_x < 1075)&& (mouse_y > 700 && mouse_y < 925 ))
			if (@index == 0)
				puts "What are you nexting? Random song playing..."
				@album_number = rand(1..5)
				@index = 1
			    play_track(@album_number, @index)
			end
			puts "next"
			@index += 1
			play_track(@album_number, @index)
		end  
	end

	def play_track(album_number, index)
		albums = load_albums()
		x = 0
		while x < albums.length
			if (albums[x].id == album_number.to_s)
				tracks = albums[x].tracks
				y = 0			
						while y < tracks.length
								if (tracks[y].number == index)					
									@song = Gosu::Song.new(tracks[y].location)
									@song.play(false)
								end
								y+=1
						end
			end
			x+=1
		end
	 
	 end

  # Detects if a 'mouse sensitive' area has been clicked on
  # i.e either an album or a track. returns true or false
     def draw_button()
	   @art = Gosu::Image.new("images/play.png")
	   @art.draw(100, 700, z = ZOrder::UI)

       @art = Gosu::Image.new("images/pause.png")
	   @art.draw(350, 700, z = ZOrder::UI)

	   @art = Gosu::Image.new("images/stop.png")
	   @art.draw(600, 700, z = ZOrder::UI)

	   @art = Gosu::Image.new("images/next.png")
	   @art.draw(850, 700, z = ZOrder::UI)
     end

  def area_clicked(leftX, topY, rightX, bottomY)
     # complete this code
  end


  # Takes a String title and an Integer ypos
  # You may want to use the following:

# Draw a coloured background using TOP_COLOR and BOTTOM_COLOR

	def draw_background
        Gosu.draw_rect(0, 0, WIN_WIDTH, WIN_HEIGHT, Gosu::Color::WHITE, ZOrder::BACKGROUND, mode=:default)
	end

# Not used? Everything depends on mouse actions.
    #code that plays next song automatically
    def update
		if (@song)
			if (!@song.playing?)
				@index+=1
				if (@song.paused?) 
				@index -= 1
				else
				play_track(@album_number, @index)
				end
			end
		end
	end

 # Draws the album images and the track list for the selected album

	def draw
		# Complete the missing code
		albums = load_albums()
		draw_background
		draw_albums(albums)
		draw_button
        fonts(albums)
	end

	def fonts(albums)
		x = 0
		y = 310
		if (!@song) or (@album_number == 0)
			@font.draw("Eric's Albums!", 580 , y+=20, ZOrder::UI, 1.0, 1.0, Gosu::Color::RED)
			while x < albums.length
				@font.draw("#{albums[x].title}", 580 , y+=50, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
				x+=1
			end
		else
			while x < albums[@album_number-1].tracks.length
				@font.draw("#{albums[@album_number-1].tracks[x].name}", 580 , y+=50, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
				if (albums[@album_number-1].tracks[x].number == @index)
					@babyfont.draw("Now Playing:",580 , y-20, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
					draw_line(580, y+30, Gosu::Color::BLACK, 750, y+30, Gosu::Color::RED, ZOrder::BACKGROUND, mode=:default)
					@font.draw("Album Details:", 800 , 330, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
					z = 340
					@medfont.draw("Artist: #{albums[@album_number-1].artist}", 800 , z+=20, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
					@medfont.draw("Title: #{albums[@album_number-1].title}", 800 , z+=20, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
					@medfont.draw("Genre: #{albums[@album_number-1].genre}", 800 , z+=20, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
					@medfont.draw("Currently listening to Track #: #{@index}", 800 , z+=20, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
				end
				x +=1
			end
		end
	end

 	def needs_cursor?; true; end

	
	def button_down(id)
		case id
		when Gosu::MsLeft
			@locs = [mouse_x, mouse_y]
			click(mouse_x, mouse_y)
	    	# What should happen here?
	    end
	end

	

end



# Show is a method that loops through update and draw

MusicPlayerMain.new.show if __FILE__ == $0
