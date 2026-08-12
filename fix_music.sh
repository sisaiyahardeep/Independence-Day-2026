sed -i "/const songs/c\
import song1 from '../assets/song1.mp3';\n\
import song2 from '../assets/song2.mp3';\n\
import song3 from '../assets/song3.mp3';\n\
import song4 from '../assets/song4.mp3';\n\
import song5 from '../assets/song5.mp3';\n\
\n\
const songs = [song1, song2, song3, song4, song5];" src/components/MusicPlayer.tsx
