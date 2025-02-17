# AJ-DumpsterDive
# Dumpster Dive Script for QBCore

A fun and interactive script for the QBCore framework, allowing players to search dumpsters for random loot. The script includes cooldown management, animation triggers, and an item loot table with various chances for different items. Players can collect random items from dumpsters, such as food, supplies, or even more valuable items, creating an engaging experience in your server.

## Features:
- **Dumpster Search:** Players can search dumpsters for loot with a simple interaction.
- **Cooldown System:** Prevents dumpster spam with a cooldown, ensuring fair gameplay.
- **Loot Table:** Randomly selected loot items with customizable chances and amounts.
- **Client-side Animation:** Triggers a searching animation when interacting with the dumpster.
- **Inventory Integration:** Items are added directly to the player's inventory with notification updates.
- **Fast Feedback:** Reduced notification delay to quickly inform players of their findings.

## Configuration:
- **Cooldown:** Set a customizable cooldown for each dumpster to prevent overuse.
- **Loot Table:** Easily editable loot table to define the items players can find and their drop chances.
- **Animation:** Integrates with client-side animation events for a more immersive experience.
- **Notifications:** Players are notified about their loot or if the dumpster is empty.

## Requirements:
- **QBCore Framework:** Must be running on a server that uses the QBCore framework.
- **qb-target:** This script uses qb-target for dumpster interaction detection.

## Installation:
1. Download the script files.
2. Place the script in your server resources folder.
3. Add the script to your `server.cfg` file using `start qb-dumpsterdive`.
4. Customize the loot table and cooldown in the `config.lua` file as per your needs.
5. Restart the server.
