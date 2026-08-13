// Product Imagery Assets & SVG Renders for Fitness App UI

const ProductAssets = {
  // Universal Fitness Expander - Hero Device
  universalExpanderSvg: `
    <svg viewBox="0 0 320 220" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg">
      <defs>
        <radialGradient id="glow" cx="50%" cy="50%" r="50%">
          <stop offset="0%" stop-color="#333333" stop-opacity="0.6"/>
          <stop offset="100%" stop-color="#171717" stop-opacity="0"/>
        </radialGradient>
        <linearGradient id="metal" x1="0%" y1="0%" x2="100%" y2="100%">
          <stop offset="0%" stop-color="#3a3a3c"/>
          <stop offset="50%" stop-color="#1c1c1e"/>
          <stop offset="100%" stop-color="#121212"/>
        </linearGradient>
        <linearGradient id="bandGrad" x1="0%" y1="0%" x2="100%" y2="0%">
          <stop offset="0%" stop-color="#2c2c2e"/>
          <stop offset="50%" stop-color="#48484a"/>
          <stop offset="100%" stop-color="#2c2c2e"/>
        </linearGradient>
        <linearGradient id="screenGrad" x1="0%" y1="0%" x2="0%" y2="100%">
          <stop offset="0%" stop-color="#000000"/>
          <stop offset="100%" stop-color="#1c1c1e"/>
        </linearGradient>
        <filter id="shadow" x="-10%" y="-10%" width="120%" height="120%">
          <feDropShadow dx="0" dy="12" stdDeviation="16" flood-color="#000000" flood-opacity="0.4"/>
        </filter>
      </defs>

      <!-- Soft Shadow Floor -->
      <ellipse cx="160" cy="195" rx="120" ry="18" fill="url(#glow)" />

      <!-- Elastic Resistance Band Arcs -->
      <path d="M 50 110 C 80 40, 240 40, 270 110" fill="none" stroke="url(#bandGrad)" stroke-width="18" stroke-linecap="round" filter="url(#shadow)"/>
      <path d="M 50 110 C 80 45, 240 45, 270 110" fill="none" stroke="#545458" stroke-width="4" stroke-linecap="round" opacity="0.6"/>

      <!-- Center Smart Control Module -->
      <g filter="url(#shadow)">
        <rect x="110" y="55" width="100" height="70" rx="18" fill="url(#metal)" stroke="#3a3a3c" stroke-width="2"/>
        
        <!-- OLED Screen -->
        <rect x="125" y="70" width="70" height="40" rx="10" fill="url(#screenGrad)" stroke="#2c2c2e" stroke-width="1.5"/>
        
        <!-- Screen Content -->
        <text x="160" y="92" font-family="-apple-system, system-ui, sans-serif" font-size="16" font-weight="700" fill="#ffffff" text-anchor="middle">LVL 12</text>
        <circle cx="140" cy="99" r="2.5" fill="#30d158"/>
        <text x="163" y="101" font-family="-apple-system, system-ui, sans-serif" font-size="7" font-weight="600" fill="#8e8e93" text-anchor="middle">READY</text>
      </g>

      <!-- Left Ergonomic Handle -->
      <g filter="url(#shadow)">
        <rect x="30" y="90" width="36" height="75" rx="12" fill="url(#metal)" stroke="#3a3a3c" stroke-width="1.5"/>
        <!-- Grip Ridges -->
        <line x1="36" y1="110" x2="60" y2="110" stroke="#48484a" stroke-width="2" stroke-linecap="round"/>
        <line x1="36" y1="122" x2="60" y2="122" stroke="#48484a" stroke-width="2" stroke-linecap="round"/>
        <line x1="36" y1="134" x2="60" y2="134" stroke="#48484a" stroke-width="2" stroke-linecap="round"/>
        <line x1="36" y1="146" x2="60" y2="146" stroke="#48484a" stroke-width="2" stroke-linecap="round"/>
      </g>

      <!-- Right Ergonomic Handle -->
      <g filter="url(#shadow)">
        <rect x="254" y="90" width="36" height="75" rx="12" fill="url(#metal)" stroke="#3a3a3c" stroke-width="1.5"/>
        <!-- Grip Ridges -->
        <line x1="260" y1="110" x2="284" y2="110" stroke="#48484a" stroke-width="2" stroke-linecap="round"/>
        <line x1="260" y1="122" x2="284" y2="122" stroke="#48484a" stroke-width="2" stroke-linecap="round"/>
        <line x1="260" y1="134" x2="284" y2="134" stroke="#48484a" stroke-width="2" stroke-linecap="round"/>
        <line x1="260" y1="146" x2="284" y2="146" stroke="#48484a" stroke-width="2" stroke-linecap="round"/>
      </g>

      <!-- Connection Glow Accent -->
      <circle cx="160" cy="62" r="3" fill="#30d158"/>
    </svg>
  `,

  // Smart Dumbbell Pro
  smartDumbbellSvg: `
    <svg viewBox="0 0 200 140" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg">
      <defs>
        <linearGradient id="dbMetal" x1="0%" y1="0%" x2="100%" y2="100%">
          <stop offset="0%" stop-color="#2c2c2e"/>
          <stop offset="100%" stop-color="#111111"/>
        </linearGradient>
      </defs>
      <!-- Shaft -->
      <rect x="60" y="60" width="80" height="20" rx="6" fill="url(#dbMetal)" stroke="#48484a"/>
      <rect x="75" y="64" width="50" height="12" rx="4" fill="#000000"/>
      <text x="100" y="73" font-family="sans-serif" font-size="8" font-weight="bold" fill="#30d158" text-anchor="middle">10.5 KG</text>
      
      <!-- Left Weights -->
      <rect x="36" y="30" width="26" height="80" rx="8" fill="url(#dbMetal)" stroke="#3a3a3c"/>
      <rect x="20" y="40" width="18" height="60" rx="6" fill="#1c1c1e"/>
      
      <!-- Right Weights -->
      <rect x="138" y="30" width="26" height="80" rx="8" fill="url(#dbMetal)" stroke="#3a3a3c"/>
      <rect x="162" y="40" width="18" height="60" rx="6" fill="#1c1c1e"/>
    </svg>
  `,

  // Smart Fitness Tracker Band
  smartBandSvg: `
    <svg viewBox="0 0 180 140" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg">
      <ellipse cx="90" cy="70" rx="65" ry="40" fill="none" stroke="#2c2c2e" stroke-width="22"/>
      <ellipse cx="90" cy="70" rx="65" ry="40" fill="none" stroke="#1c1c1e" stroke-width="18"/>
      <!-- Screen Pill -->
      <rect x="65" y="24" width="50" height="24" rx="12" fill="#000000" stroke="#3a3a3c" stroke-width="1.5"/>
      <text x="90" y="40" font-family="sans-serif" font-size="10" font-weight="bold" fill="#ffffff" text-anchor="middle">74 BPM</text>
    </svg>
  `,

  // Pulse Track Heart Sensor
  pulseSensorSvg: `
    <svg viewBox="0 0 180 140" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg">
      <rect x="30" y="55" width="120" height="30" rx="6" fill="#2c2c2e"/>
      <circle cx="90" cy="70" r="28" fill="#1c1c1e" stroke="#3a3a3c" stroke-width="2"/>
      <circle cx="90" cy="70" r="18" fill="#000000"/>
      <path d="M 80 70 L 86 70 L 89 62 L 93 78 L 96 67 L 99 70 L 102 70" fill="none" stroke="#ff453a" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
    </svg>
  `
};
