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




# 🛣️ Project John: Development Roadmap
---

## ✅ Phase 1: Core Mechanics
- [✅] Implement basic player movement (WASD)
- [✅] Add sprint with cooldown
- [✅] Implement basic shooting and bullets
- [✅] Create player health system with dot-based UI
- [✅] Add player death and respawn logic
- [✅] Create basic zombie enemy with chase behavior
- [✅] Add basic ammo system: clip, reserve, reload

---

## 🧱 Phase 2: Systems & UI
- [✅] Design and implement HUD (health, ammo)
- [✅] Add reload prompt that flashes on screen
- [✅] Add ammo pickup and integration into reserve
- [✅] Implement enemy spawner using CollisionPolygon2D
- [] Create and manage wave system (hybrid kill/time-based)
- [] Add a second enemy type

---

## 🌍 Phase 3: Level Progression
- [] Create multiple map layouts
- [] Load new level after X waves
- [] Add scaling difficulty system per level
- [] Implement end-game or final wave scenario
- [] Smooth transitions between levels

---

## 🔫 Phase 4: Weapons & Upgrades
- [] Implement multiple weapons (Shotgun, SMG, Rifle)
- [] Add weapon swap system
- [] Create powerup drops from enemies (health, ammo, speed, damage)
- [] Visual feedback for pickups
- [] Add inventory or weapon indicator in UI

---

## 👾 Phase 5: Enemy Variety
- [] Add fast zombie (low HP, high speed)
- [] Add tank zombie (high HP, knockback resistant)
- [] Add shooter enemy (ranged behavior)
- [] Add boss enemy type (special abilities)
- [] Balance enemies across waves

---

## 🧠 Phase 6: Polish & Feedback
- [] Add muzzle flash and reload animation
- [] Improve enemy spawn indicators
- [] Add visual and audio feedback for damage
- [] Flash effect when player hit
- [] Add wave/level tracking UI elements

---

## 🪙 Phase 7: Extra Features
- [] Create pause menu and settings
- [] Add difficulty modes (Easy/Normal/Hard)
- [] Implement statistics summary after game ends
- [] Add achievements system
- [] Add basic saving/loading system
  
---

## 📦 Phase 8: Packaging & Documentation
- [] Clean and optimize scripts
- [] Finalize README and LICENSE
- [] Export builds for PC
- [] Prepare project for public GitHub release

---

> This roadmap will evolve as development progresses. 
