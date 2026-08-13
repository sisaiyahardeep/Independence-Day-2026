// Constants
const messages = [
    "Happy Independence Day! 🇮🇳 Veer shahidon ko naman.",
    "2026 Independence Day par Tiranga hamesha uncha rahe! 🇮🇳",
    "Mitti ki khushbu, Tirange ki shaan. Happy Independence Day! 🇮🇳",
    "Azaadi ka jashn 2026! Jai Hind, Jai Bharat! 🇮🇳",
    "Bharat Mata ki Jai! Wishing you a proud Independence Day! 🇮🇳"
];
const songs = ['./song1.mp3', './song2.mp3', './song3.mp3', './song4.mp3', './song5.mp3', './song6.mp3'];
const colors = ['#FF9933', '#FFFFFF', '#138808'];

// State
let currentName = "";
let currentMessage = "";
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
    bgAudio.load();
    
    document.body.addEventListener('click', () => {
        if (!audioInitialized) {
            audioInitialized = true;
            playAudio();
        }
    }, { once: true });
}

function playAudio() {
    bgAudio.play().catch(e => { 
        console.warn("Autoplay prevented:", e); 
    });
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
    
    audioInitialized = true;
    playAudio();
    
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
    
    window.history.pushState({}, document.title, window.location.pathname);
});

// Share to WhatsApp
shareBtn.addEventListener('click', () => {
    const url = new URL(window.location.href);
    url.searchParams.set('n', currentName);
    url.searchParams.set('m', currentMessage);
    
    const text = `🇮🇳✨ Happy Independence Day 2026 ✨🇮🇳\n\nजब आपके घर में खुशियाँ होती हैं, तो दिल मुस्कुराता है...\nऔर जब हमारा 🇮🇳 तिरंगा गर्व से लहराता है, तो पूरा देश अपना परिवार सा लगता है। ❤️\n\nआज की खुशी सिर्फ़ एक त्योहार की नहीं, बल्कि उस आज़ादी की है जिसने हमें सपने देखने, आगे बढ़ने और खुलकर जीने का हक़ दिया। 🕊️✨\n\nआप और आपके परिवार का जीवन खुशियों, सम्मान और सफलता से भरा रहे। 🌸💫\n\n🧡🤍💚 तिरंगे का मान, भारत की शान 🧡🤍💚\n\n🇮🇳 जय हिन्द • वंदे मातरम् 🇮🇳\n\n👇 *${currentName} ne aapke liye ek Vishesh tohfa bheja hai, yahan click karke dekhein:* 👇\n${url.toString()}`;
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
    const rafaleImg = rafale.querySelector('img');
    
    rafale.classList.remove('hidden', 'fly-right-animation', 'fly-left-animation');
    rafaleImg.classList.remove('flip-horizontal');
    
    void rafale.offsetWidth;
    
    const flyFromLeft = Math.random() > 0.5;
    if (flyFromLeft) {
        rafale.classList.add('fly-right-animation');
    } else {
        rafale.classList.add('fly-left-animation');
        rafaleImg.classList.add('flip-horizontal');
    }
    
    setTimeout(() => {
        rafale.classList.remove('fly-right-animation', 'fly-left-animation');
        rafale.classList.add('hidden');
    }, 6500);
}

setInterval(() => {
    if (!document.hidden && Math.random() > 0.5) {
        triggerRafale();
    }
}, 20000);

// Balloons
function createBalloon() {
    if (document.hidden) return; 
    
    const container = document.getElementById('balloons-container');
    const balloon = document.createElement('div');
    balloon.className = 'balloon';
    
    balloon.style.left = (Math.random() * 90 + 5) + '%'; 
    balloon.style.animationDuration = (12 + Math.random() * 6) + 's'; 
    
    const knot = document.createElement('div');
    knot.className = 'balloon-knot';
    balloon.appendChild(knot);
    container.appendChild(balloon);
    
    balloon.addEventListener('animationend', () => {
        balloon.remove();
    });
}

function startBalloons() {
    for(let i=0; i<25; i++) {
        setTimeout(createBalloon, Math.random() * 3000);
    }
    setInterval(createBalloon, 800);
}

init();
