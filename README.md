<a id="readme-top"></a>

<!-- SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

<!-- HEADER -->
<br />
<div align="center">
	<img src="assests/sprites/knight.png" alt="Enemy Hunter" width="128" />
	<h1 align="center">Enemy Hunter</h1>
	<p align="center">
		A 2D platformer made with Godot Engine (GDScript). Play as a knight, defeat enemies, collect coins, and reach the level end portal.
	</p>
</div>

<!-- CONTENTS -->
<details>
	<summary>Table of Contents</summary>
	<ol>
		<li>
			<a href="#about">About The Project</a>
			<ul>
				<li><a href="#built-with">Built Using</a></li>
			</ul>
		</li>
		<li>
			<a href="#getting-started">Getting Started</a>
			<ul>
				<li><a href="#installation">Installation</a></li>
			</ul>
		</li>
		<li><a href="#usage">Usage</a></li>
		<li><a href="#license">License</a></li>
	</ol>
</details>


<!-- ABOUT -->
## About The Project

Enemy Hunter is a small 2D platformer where you control a knight and progress through a level filled with moving platforms, coins, hazards, and patrolling enemies.

### Game features (from the project)
- Player with left/right movement, jump, attack and defend animations (`Scripts/player.gd`)
- Enemies (green) that patrol platforms and take 2 hits to die (`Scenes/green_enemy.tscn`, `Scripts/green_enemy.gd`)
- Collectible coins that increase score (`Scenes/coin.tscn`, `Scripts/coin.gd`)
- Damage zones and kill zones that hurt or instantly kill the player (`Scenes/damage_zone.tscn`, `Scripts/damage_zone.gd`, `Scenes/kill_zone.tscn`, `Scripts/kill_zone.gd`)
- Level end portal that advances to `level_selector.tscn` (`Scenes/game.tscn` with `level_end` Area2D connected to `GameManager`)
- A simple `GameManager` that tracks score and pause state (`Scripts/game_manager.gd`)

### Main scenes & scripts (key files)
- `Scenes/game.tscn` — main level scene (player, enemies, coins, platforms, UI labels)
- `Scenes/Player.tscn` — player scene used by the main scene
- `Scenes/green_enemy.tscn` — enemy scene with patrol raycasts and animations
- `Scenes/coin.tscn` — coin collectible scene
- `Scripts/player.gd` — player movement, health, and animation handling
- `Scripts/green_enemy.gd` — enemy patrol and damage handling
- `Scripts/game_manager.gd` — score and pause handling
- `Scripts/coin.gd` — coin pickup and scoring

### Controls
- Move left/right: A/D or Left/Right arrows
- Jump: Space
- Pause: Pause button shown in the HUD

### Objective
Defeat enemies (jump on them twice), collect coins to increase score, avoid hazards (damage/kill zones), and reach the level end portal to move to the next screen.

<p align="right">(<a href="#readme-top">top</a>)</p>


### Built Using
This project was built using:
- Godot Engine (GDScript)

Assets are stored in `assests/` (sprites, fonts, sounds).

<p align="right">(<a href="#readme-top">top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

### Installation
1. Clone this repository:
	```sh
	git clone https://github.com/ryukgod26/godot2d-game.git
	```
2. Open the project in Godot Engine (version 4.x recommended)
3. Run the main scene (`game.tscn`) to start playing

<p align="right">(<a href="#readme-top">top</a>)</p>

<!-- USAGE -->
## Usage

1. Move your character using the arrow keys or A/D
2. Jump with Space
3. Jump on enemies twice to defeat them
4. Collect coins to increase your score
5. Avoid hazards and keep your health above zero

<p align="right">(<a href="#readme-top">top</a>)</p>

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- URLS -->
[contributors-shield]: https://img.shields.io/github/contributors/budziot/Godot_Super-Wakatime?style=for-the-badge
[contributors-url]: https://github.com/BudzioT/Godot_Super-Wakatime/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/budziot/Godot_Super-Wakatime?style=for-the-badge
[forks-url]: https://github.com/BudzioT/Godot_Super-Wakatime/forks
[stars-shield]: https://img.shields.io/github/stars/budziot/Godot_Super-Wakatime?style=for-the-badge
[stars-url]: https://github.com/BudzioT/Godot_Super-Wakatime/stargazers
[issues-shield]: https://img.shields.io/github/issues/budziot/Godot_Super-Wakatime?style=for-the-badge
[issues-url]: https://github.com/BudzioT/Godot_Super-Wakatime/issues
[license-shield]: https://img.shields.io/github/license/budziot/Godot_Super-Wakatime?style=for-the-badge
[license-url]: https://github.com/BudzioT/Godot_Super-Wakatime/blob/master/addons/godot_super-wakatime/LICENSE
[product-screenshot]: https://cloud-j4wibbzz7-hack-club-bot.vercel.app/0image.png
[product-logo]: https://cloud-j4wibbzz7-hack-club-bot.vercel.app/2godotwaka2.png
[Godot]: https://img.shields.io/badge/Godot%20Engine-478CBF?logo=godotengine&logoColor=fff&style=flat
[Godot-url]: https://godotengine.org/
[Ouch-shield]: https://img.shields.io/badge/Ouch!-tool-blue?label=Ouch!
[Ouch-url]: https://github.com/ouch-org/ouch
[time-screenshot]: https://cloud-l88kldf50-hack-club-bot.vercel.app/0image.png
