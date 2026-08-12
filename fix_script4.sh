cat << 'INNER_EOF' > script.js
// Constants
const messages = [
    "Happy Independence Day 2026! 🇮🇳 Un veer shahidon ko naman, jinki kurbani se aaj hum azaad hain.",
    "2026 Independence Day par, let's pledge to keep the Tiranga flying high. Jai Hind! 🇮🇳",
    "Mitti ki khushbu, Tirange ki shaan. Wishing you a very Happy Independence Day 2026! 🇮🇳",
    "Azaadi ka jashn 2026! Let's remember the heroes who gave us our freedom. Happy Independence Day!",
    "Bharat Mata ke veer saputon ko naman. Wishing you and your family a proud Independence Day 2026! 🇮🇳"
];
const songs = ['./song1.mp3', './song2.mp3', './song3.mp3', './song4.mp3', './song5.mp3'];
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
    bgAudio.load();
    
    // Try autoplay on first interaction
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
    
    // Play song on generate click
    audioInitialized = true;
    playAudio();
    
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
    
    const text = `${currentName} ki taraf se aapke liye Independence Day ki ek khas shubhkamna!\n\n"${currentMessage}"\n\nYahan click karke dekhein: ${url.toString()}`;
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
    
    // Random horizontal positioning and float duration
    balloon.style.left = (Math.random() * 90 + 5) + '%'; // 5% to 95%
    balloon.style.animationDuration = (15 + Math.random() * 10) + 's'; // Slower float (15-25s)
    
    // Add knot
    const knot = document.createElement('div');
    knot.className = 'balloon-knot';
    balloon.appendChild(knot);
    
    container.appendChild(balloon);
    
    // Clean up
    setTimeout(() => {
        if(balloon.parentNode) balloon.remove();
    }, 30000);
}

function startBalloons() {
    // Initial batch
    for(let i=0; i<8; i++) {
        setTimeout(createBalloon, Math.random() * 5000);
    }
    // Continuous
    setInterval(createBalloon, 3000);
}

// Run initialization
init();
INNER_EOF
