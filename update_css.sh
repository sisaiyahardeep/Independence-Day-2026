cat << 'CSS_EOF' > style.css
@tailwind base;
@tailwind components;
@tailwind utilities;

/* Custom Styles & Animations */

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
    animation: wave 2.5s ease-in-out infinite;
    filter: drop-shadow(0 4px 6px rgba(0,0,0,0.5));
}

/* Tiranga Balloons */
.balloon {
    position: absolute;
    bottom: -100px;
    width: 45px;
    height: 60px;
    border-radius: 50% 50% 50% 50% / 40% 40% 60% 60%;
    background: linear-gradient(to bottom, #FF9933 33.33%, #FFFFFF 33.33%, #FFFFFF 66.66%, #138808 66.66%);
    box-shadow: inset -5px -5px 15px rgba(0,0,0,0.3), inset 5px 5px 10px rgba(255,255,255,0.4), 0 4px 10px rgba(0,0,0,0.3);
    animation: floatUp linear infinite forwards;
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
    95% { opacity: 1; }
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
.fly-right-animation {
    animation: flyRight 6s cubic-bezier(0.4, 0, 0.2, 1) forwards;
}
.fly-left-animation {
    animation: flyLeft 6s cubic-bezier(0.4, 0, 0.2, 1) forwards;
}
.flip-horizontal {
    transform: scaleX(-1);
}
@keyframes flyRight {
    0% { transform: translate(-50vw, 30vh) scale(0.6) rotate(15deg); opacity: 0; }
    10% { opacity: 1; }
    90% { opacity: 1; }
    100% { transform: translate(150vw, -30vh) scale(1.3) rotate(15deg); opacity: 0; }
}
@keyframes flyLeft {
    0% { transform: translate(150vw, 30vh) scale(0.6) rotate(-15deg); opacity: 0; }
    10% { opacity: 1; }
    90% { opacity: 1; }
    100% { transform: translate(-50vw, -30vh) scale(1.3) rotate(-15deg); opacity: 0; }
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
.fly-left-animation .smoke-trail {
    right: auto;
    left: 85%;
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

.fly-left-animation .smoke-orange { background: linear-gradient(to left, transparent, #FF9933); }
.fly-left-animation .smoke-white { background: linear-gradient(to left, transparent, #FFFFFF); }
.fly-left-animation .smoke-green { background: linear-gradient(to left, transparent, #138808); }

@media (min-width: 768px) {
    .smoke { width: 250px; height: 6px; }
}
CSS_EOF
