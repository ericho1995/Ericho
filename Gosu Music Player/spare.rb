def read_track (music_file, i)
track_key = i
track_name = music_file.gets
track_location = music_file.gets.chomp
track = Track.new(track_key, track_name, track_location)
return track
end

def read_tracks music_file
count = music_file.gets.to_i
tracks = Array.new()
i = 0
while i < count
track = read_track(music_file, i+1)
tracks << track
i = i + 1
end
tracks
end

def read_album(music_file, i)
album_pri_key = i
album_title = music_file.gets.chomp
album_artist = music_file.gets
album_artwork = music_file.gets
album_genre = music_file.gets.to_i
album_tracks = read_tracks(music_file)
album = Album.new(album_pri_key, album_title, album_artist,album_artwork, album_genre, album_tracks)
return album
end

def read_albums(music_file)
count = music_file.gets.to_i
albums = Array.new()
i = 0
while i < count
album = read_album(music_file, i+1)
albums << album
  
i = i + 1
end
return albums
end

def print_tracks tracks
i = 0
while i < tracks.length
print_track(tracks[i])
i = i + 1
end
end

def print_track track
printf("Track key is %d\n", track.tra_key)
puts('Track title is: ' + track.name)
puts('Track file location is: ' + track.location)
printf("\n")
end

def print_album album
printf("albums key: %s\n", album.pri_key)
printf("album title is %s\n", album.title)
printf("%s's artist is %s", album.title, album.artist)
printf("Genre is %s\n", GENRE_NAMES[album.genre])
print_tracks(album.tracks)
printf("\n")
end

def print_albums albums
if (albums)
i = 0
while i < albums.length
print_album(albums[i])
i = i + 1
end
else
printf("there is no file opened\n\n")
end
end

def print_key(album, ans)
if (album)
i = 0
while i < album.length
printf("%s key is %d\n", album[i].title, album[i].pri_key)
i+=1
end
play_album(album)
else
printf("There is no file opened\n\n")
end
end

def play_album(albums)
search_key = read_integer_in_range("Enter album key you want to Play", 1, albums.length)
i = 0
while i < albums.length
if (albums[i].pri_key == search_key)
print_tracks(albums[i].tracks)
play_tracks(albums[i], albums[i].tracks)
end
i+=1
end
end

def play_tracks(albums, tracks)
search_key = read_integer_in_range("Enter Track to be played", 1, tracks.length)
i = 0
while i< tracks.length
if (tracks[i].tra_key == search_key)
printf("playing %s from album %s by %s",tracks[i].name.chomp ,albums.title, albums.artist )
end
i+=1
end
end

music_file = File.new("file.txt", "r")
albums = read_albums(music_file)
print_albums(albums)
# Reads in an array of albums from a file and then prints all the albums in the
# array to the terminal

printf("1 - Select an Album to play\n")
ans = read_integer_in_range("Please Select an option", 1, 1)

if (ans == 1 )
print_key(albums, ans)
end
##############################################

# Detects if a 'mouse sensitive' area has been clicked on
# i.e either an album or a track. returns true or false

def area_clicked(leftX, topY, rightX, bottomY)
# complete this code
end


# Takes a String title and an Integer ypos
# You may want to use the following:
def display_track(title, ypos)
   @track_font.draw(title, TrackLeftX, ypos, ZOrder::PLAYER, 1.0, 1.0, Gosu::Color::BLACK)
end


# Takes a track index and an Album and plays the Track from the Album

def playTrack(track, album)
   # complete the missing code
           @song = Gosu::Song.new(album.tracks[track].location)
           @song.play(false)
# Uncomment the following and indent correctly:
   #   end
   # end
end


# Not used? Everything depends on mouse actions.

   def update
   end

# Draws the album images and the track list for the selected album

   def draw
       # Complete the missing code
       #draw_albums(albums)
       draw_background
   end

   def button_down(id)
       case id
   when Gosu::MsLeft
       # What should happen here?
   end
   end