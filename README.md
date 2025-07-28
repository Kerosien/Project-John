# 🧠 Top-Down Shooter: Game Design Document

> A fast-paced top-down shooter built in **Godot 4.4** with wave-based enemy encounters, ammo management, and progressive level difficulty.

---

## 🎮 Game Overview
- **Title**: *[To Be Determined]*
- **Genre**: Top-Down Shooter
- **Engine**: Godot 4.4
- **Target Platform**: PC
- **Player Experience Goal**: Tactical shooting, resource management, and increasingly intense gameplay against enemy waves.

---

## 🕹️ Core Gameplay

### ✅ Player Mechanics
- WASD movement
- Sprint (with cooldown)
- Shoot in direction of aim
- Reload system (clip + reserve)
- Ammo pickups
- Health system (dot-based UI)
- Death + respawn system

### 👾 Enemy Mechanics
- Zombie AI follows and damages player
- Dies on bullet impact
- Spawn within polygon bounds
- Planned: multiple enemy types & wave scaling

---

## ⌨️ Controls

| Action  | Key               | Description               |
|---------|------------------|---------------------------|
| Move    | WASD             | Directional movement      |
| Shoot   | Left Mouse Button| Fire current weapon       |
| Reload  | R                | Reload the weapon         |
| Sprint  | Shift            | Temporary speed boost     |

---

## 🧩 UI Elements
- **Health**: Dot indicators (top-left)
- **Ammo**: `Clip / Reserve` (lower-left)
- **Reload Prompt**: Center screen flash text
- **Death Screen**: Dark overlay with respawn button

---

## ⚙️ Core Systems

### 🧿 Spawning
- Uses `CollisionPolygon2D`
- Enemies & ammo randomly spawn inside bounds

### 🔫 Ammo System
- Clip/reserve ammo logic
- Prevents over-reload
- Uses Timer node with `One Shot`

### 🌊 Wave System
- Hybrid: time-based & kill-based
- Difficulty scales with each wave

---

## 🎨 Art & Audio
- **Visuals**: Kenney.nl top-down assets
- **FX**: Muzzle flash, damage flash, planned reload animation
- **Sound**: (Planned)

---

## 🧱 Scenes & Scripts

### 🔧 Scenes
- `Main.tscn`: Root scene
- `Player.tscn`: Player logic
- `Enemy.tscn`: Enemy AI
- `AmmoPickup.tscn`: Collectible ammo
- `HUD.tscn`: UI layout

### 📜 Scripts
- `Player.gd`: Input, combat, reload
- `Enemy.gd`: Pathfinding + damage
- `Spawner.gd`: Random spawning
- `WaveManager.gd`: (In progress)

---

## 🚧 Future Features / Wishlist
- Multiple enemy types (ranged, tank)
- Boss waves
- Weapon/health/speed upgrades
- Sound effects + music
- Pause/settings menu
- Save/load support

---

## 🛠 Technical Notes
- Built with **Godot 4.4**
- `CollisionPolygon2D` used for spawn area
- Timer nodes for reload delay (`One Shot`)
- Modular scene setup

---

## 🗺️ Level Design
- Levels change every X waves
- Enemies get harder each level
- Hard limit with end goal planned
- Levels load dynamically

---

## 🧟 Enemy Types
- **Zombie**: Melee chaser
- **Shooter**: Ranged attacks

---

## 🧪 Upgrade System
- **Weapon Swaps**: Shotgun, rifle, SMG
- **Powerups**: Dropped by enemies — health, ammo, damage, speed

---

## 💡 Suggested Additions
- Wave/difficulty tracker
- Enemy spawn indicators
- Dynamic music intensity
- Achievements & challenges
- Post-run stats (kills, accuracy, time)
- Difficulty modes (Easy/Normal/Hard)

---

## 🔫 Weapon Stats

| Weapon   | Damage | Fire Rate | Range | Ammo Capacity | Notes                  |
|----------|--------|-----------|-------|----------------|------------------------|
| Pistol   | Medium | Average   | Mid   | Low            | Default weapon         |
| Shotgun  | High   | Low       | Short | Very Low       | High burst damage      |
| SMG      | Low    | High      | Low   | High           | Great for close combat |
| Rifle    | High   | Medium    | Long  | Medium         | Balanced and accurate  |
| Sniper   | Very High | Very Low | Very Long | Very Low   | Long reload, planned   |

---

## 🧠 Enemy Behaviors
- **Zombie**: Basic chaser with collision damage
- **Fast Zombie**: Runs quickly, low health
- **Tank Zombie**: High health, resistant to knockback
- **Shooter**: Keeps distance and fires projectiles
- **Boss (Planned)**: Mix of attacks, can summon minions

---

## 🧱 Visual Mockups (Text Descriptions)
- **HUD**: Dots for health (top-left), ammo (lower-left), reload text (center)
- **Gameplay**: Top-down view, visible spawn boundaries, glowy pickups
- **Death**: Dark screen + "You Died" + respawn
- **Wave Transitions**: Flash message with break period
- **Level Transitions**: Fade in/out between maps

---

> *Last updated: July 2025*
