// Constants
const messages = [
    "उन वीर शहीदों को नमन, जिनकी कुर्बानी से आज हम आज़ाद हैं। आपको स्वतंत्रता दिवस की हार्दिक शुभकामनाएँ।",
    "तिरंगे की शान हमेशा ऊँची रहे और भारत का नाम दुनिया में रोशन रहे। स्वतंत्रता दिवस की हार्दिक शुभकामनाएँ।",
    "मिट्टी की खुशबू, तिरंगे की शान और देश के वीरों की कुर्बानी को सलाम। आपको स्वतंत्रता दिवस की शुभकामनाएँ।",
    "आज़ादी सिर्फ एक दिन का जश्न नहीं, बल्कि उन वीरों की याद है जिन्होंने देश के लिए अपना जीवन न्योछावर कर दिया।",
    "भारत माता के वीर सपूतों को नमन। आपको और आपके परिवार को स्वतंत्रता दिवस की हार्दिक शुभकामनाएँ।"
];
const songs = ['song1.mp3', 'song2.mp3', 'song3.mp3', 'song4.mp3', 'song5.mp3'];
const colors = ['#FF9933', '#FFFFFF', '#138808'];

// State
let currentName = "";
let currentMessage = "";
let isAudioPlaying = false;
let audioInitialized = false;

// DOM Elements
const urlParams = new URLSearchParams(window.location.search);
const rName = urlParams.get('n');
const rMsg = urlParams.get('m');

const greetingCard = document.getElementById('greeting-card');
const senderNameEl = document.getElementById('sender-name');
const greetingTextEl = document.getElementById('greeting-text');

const inputSection = document.getElementById('input-section');
const actionButtons = document.getElementById('action-buttons');
const nameInput = document.getElementById('name-input');
const generateBtn = document.getElementById('generate-btn');
const shareBtn = document.getElementById('share-btn');
const createNewBtn = document.getElementById('create-new-btn');

const bgAudio = document.getElementById('bg-audio');
const musicToggle = document.getElementById('music-toggle');
const iconPlay = document.getElementById('icon-play');
const iconPause = document.getElementById('icon-pause');

// Prevent XSS
function sanitize(str) {
    const temp = document.createElement('div');
    temp.textContent = str;
    return temp.innerHTML;
}

// Initialization
function init() {
    setupAudio();
    startBalloons();
    
    // Check if URL has greeting params
    if (rName && rMsg) {
        currentName = sanitize(rName);
        currentMessage = sanitize(rMsg);
        showGreeting();
    }
}

// Audio Setup
function setupAudio() {
    const randomSong = songs[Math.floor(Math.random() * songs.length)];
    bgAudio.src = randomSong;
    bgAudio.volume = 0.8;

    musicToggle.addEventListener('click', toggleAudio);
    
    // Try autoplay on first interaction
    document.body.addEventListener('click', () => {
        if (!audioInitialized) {
            audioInitialized = true;
            playAudio();
        }
    }, { once: true });
}

function playAudio() {
    bgAudio.play().then(() => {
        isAudioPlaying = true;
        iconPlay.classList.add('hidden');
        iconPause.classList.remove('hidden');
    }).catch(e => console.warn("Autoplay prevented:", e));
}

function pauseAudio() {
    bgAudio.pause();
    isAudioPlaying = false;
    iconPause.classList.add('hidden');
    iconPlay.classList.remove('hidden');
}

function toggleAudio() {
    if (isAudioPlaying) {
        pauseAudio();
    } else {
        audioInitialized = true;
        playAudio();
    }
}

// Input Handling
nameInput.addEventListener('input', () => {
    generateBtn.disabled = nameInput.value.trim() === "";
});

generateBtn.addEventListener('click', () => {
    const val = nameInput.value.trim();
    if (!val) return;
    
    currentName = sanitize(val);
    currentMessage = messages[Math.floor(Math.random() * messages.length)];
    
    showGreeting();
    
    // Effects
    triggerConfetti();
    triggerRafale();
});

// Show Greeting
function showGreeting() {
    senderNameEl.innerHTML = currentName;
    greetingTextEl.innerHTML = currentMessage;
    
    inputSection.classList.add('hidden');
    greetingCard.classList.remove('hidden');
    actionButtons.classList.remove('hidden');
}

// Reset to Create New
createNewBtn.addEventListener('click', () => {
    greetingCard.classList.add('hidden');
    actionButtons.classList.add('hidden');
    inputSection.classList.remove('hidden');
    nameInput.value = "";
    generateBtn.disabled = true;
    nameInput.focus();
    
    // Clear URL params without reloading
    window.history.pushState({}, document.title, window.location.pathname);
});

// Share to WhatsApp
shareBtn.addEventListener('click', () => {
    const url = new URL(window.location.href);
    url.searchParams.set('n', currentName);
    url.searchParams.set('m', currentMessage);
    
    const text = `${currentName} की तरफ से आपके लिए स्वतंत्रता दिवस की एक खास शुभकामना!\n\n"${currentMessage}"\n\nयहाँ क्लिक करके देखें: ${url.toString()}`;
    window.open(`https://wa.me/?text=${encodeURIComponent(text)}`, '_blank');
});

// Confetti Effect
function triggerConfetti() {
    if (typeof confetti !== 'undefined') {
        const duration = 3 * 1000;
        const end = Date.now() + duration;
        
        (function frame() {
            confetti({ particleCount: 5, angle: 60, spread: 55, origin: { x: 0 }, colors: colors });
            confetti({ particleCount: 5, angle: 120, spread: 55, origin: { x: 1 }, colors: colors });
            
            if (Date.now() < end) requestAnimationFrame(frame);
        }());
    }
}

// Rafale Animation
function triggerRafale() {
    const rafale = document.getElementById('rafale-container');
    rafale.classList.remove('hidden');
    rafale.classList.remove('fly-animation');
    
    // Force reflow
    void rafale.offsetWidth;
    
    rafale.classList.add('fly-animation');
    
    setTimeout(() => {
        rafale.classList.remove('fly-animation');
        rafale.classList.add('hidden');
    }, 4000);
}

// Random Rafale Flyovers
setInterval(() => {
    // Only if document is visible and occasionally
    if (!document.hidden && Math.random() > 0.5) {
        triggerRafale();
    }
}, 20000);

// Balloons
function createBalloon() {
    if (document.hidden) return; // Don't create if tab is inactive
    
    const container = document.getElementById('balloons-container');
    const balloon = document.createElement('div');
    balloon.className = 'balloon';
    
    const c = colors[Math.floor(Math.random() * colors.length)];
    balloon.style.backgroundColor = c;
    balloon.style.left = (Math.random() * 90 + 5) + '%'; // 5% to 95%
    balloon.style.animationDuration = (12 + Math.random() * 10) + 's';
    
    // Add knot
    const knot = document.createElement('div');
    knot.className = 'balloon-knot';
    knot.style.backgroundColor = c;
    balloon.appendChild(knot);
    
    container.appendChild(balloon);
    
    // Clean up
    setTimeout(() => {
        if(balloon.parentNode) balloon.remove();
    }, 25000);
}

function startBalloons() {
    // Initial batch
    for(let i=0; i<10; i++) {
        setTimeout(createBalloon, Math.random() * 5000);
    }
    // Continuous
    setInterval(createBalloon, 2500);
}

// Run initialization
init();
