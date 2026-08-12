cat << 'INNER_EOF' > style.css
/* Custom Styles & Animations for Independence Day App */

/* 3D Liquid Glass UI */
.glass-card {
    background: linear-gradient(135deg, rgba(255, 255, 255, 0.15), rgba(255, 255, 255, 0.05));
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border: 1px solid rgba(255, 255, 255, 0.18);
    box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37), inset 0 1px 2px rgba(255,255,255,0.4), inset 0 -1px 2px rgba(0,0,0,0.2);
    border-radius: 24px;
}

/* Waving Flag Animation */
@keyframes wave {
    0%, 100% { transform: rotate(-5deg) translateY(-2px); }
    50% { transform: rotate(5deg) translateY(2px); }
}
.waving-flag {
    display: inline-block;
    animation: wave 2s ease-in-out infinite;
    font-size: 3rem;
    filter: drop-shadow(0 4px 6px rgba(0,0,0,0.5));
}

/* Tiranga Balloons */
.balloon {
    position: absolute;
    bottom: -100px;
    width: 45px;
    height: 60px;
    border-radius: 50% 50% 50% 50% / 40% 40% 60% 60%;
    /* Tricolor Gradient */
    background: linear-gradient(to bottom, #FF9933 33.33%, #FFFFFF 33.33%, #FFFFFF 66.66%, #138808 66.66%);
    box-shadow: inset -5px -5px 15px rgba(0,0,0,0.3), inset 5px 5px 10px rgba(255,255,255,0.4), 0 4px 10px rgba(0,0,0,0.3);
    animation: floatUp linear infinite;
    z-index: 10;
}
.balloon::before {
    content: "";
    position: absolute;
    bottom: -60px;
    left: 50%;
    transform: translateX(-50%);
    width: 1px;
    height: 60px;
    background: rgba(255,255,255,0.5);
}
.balloon-knot {
    position: absolute;
    bottom: -4px;
    left: 50%;
    transform: translateX(-50%);
    width: 8px;
    height: 8px;
    background: #138808;
    clip-path: polygon(50% 0, 0 100%, 100% 100%);
}
@keyframes floatUp {
    0% { transform: translateY(110vh) translateX(0) scale(0.8); opacity: 0; }
    5% { opacity: 1; }
    33% { transform: translateY(60vh) translateX(-20px) scale(0.9); }
    66% { transform: translateY(20vh) translateX(20px) scale(0.95); }
    90% { opacity: 1; }
    100% { transform: translateY(-30vh) translateX(0) scale(1); opacity: 0; }
}

/* Rafale Flyover & Smoke */
.rafale-container {
    position: fixed;
    top: 0;
    left: 0;
    pointer-events: none;
    z-index: 40;
    opacity: 0;
}
.fly-animation {
    animation: flyRight 3.5s cubic-bezier(0.4, 0, 0.2, 1) forwards;
}
@keyframes flyRight {
    0% {
        transform: translate(-50vw, 30vh) scale(0.6) rotate(15deg);
        opacity: 0;
    }
    10% { opacity: 1; }
    90% { opacity: 1; }
    100% {
        transform: translate(150vw, -30vh) scale(1.3) rotate(15deg);
        opacity: 0;
    }
}
.smoke-trail {
    position: absolute;
    right: 85%;
    top: 50%;
    transform: translateY(-50%);
    display: flex;
    flex-direction: column;
    gap: 2px;
    opacity: 0.7;
}
.smoke {
    height: 4px;
    width: 150px;
    border-radius: 10px;
    filter: blur(2px);
}
.smoke-orange { background: linear-gradient(to right, transparent, #FF9933); }
.smoke-white { background: linear-gradient(to right, transparent, #FFFFFF); }
.smoke-green { background: linear-gradient(to right, transparent, #138808); }

@media (min-width: 768px) {
    .smoke { width: 250px; height: 6px; }
}
INNER_EOF
