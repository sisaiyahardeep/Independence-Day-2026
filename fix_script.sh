sed -i 's/musicToggle.addEventListener('\''click'\'', toggleAudio);/musicToggle.addEventListener('\''click'\'', (e) => { e.stopPropagation(); toggleAudio(); });/g' script.js
