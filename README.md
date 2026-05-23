# P-and-p-editor
Standalone retro-IDE &amp; fantasy console for rapid prototyping. Powered by Godot 4.
> **"Pure pixels. Raw logic. Prototyping at the speed of thought."**

`P&P Editor` is a standalone retro-IDE and fantasy console built on Godot 4. This is a tool for those who want to turn ideas into code faster than brewing a cup of coffee.

---

 is a standalone fantasy console where the barrier between an idea and its execution is thinner than a single pixel. It’s a "rusty bike" that outruns a Ferrari: no bloated menus, no loading screens—just you, your code, and the grid.

---

### 📦 What’s inside the box?

*   **Trinity Workspace:** Instant switching between **Code (F1)**, **Sprites (F2)**, and **Map (F3)**. Focus is your only currency.
*   **Hybrid Sprite Atlas:** A unique dual-purpose canvas.
    *   *Upper Zone (32x32):* High-fidelity slots for smooth hero animations.
    *   *Lower Zone (8x8):* Tight grid for environmental tiles and hazards.
*   **Seamless Map Editor:** Build your world directly "on top" of the simulation. Use the **Ghost Cursor** to see the future before you click.
*   **Micro-Cartridges:** Your entire project—code, art, and map—packs into a tiny binary `.sav` file. Your game is a literal cartridge you can hand to a friend.
*   **Data Freedom:** Press **[S]** to save reality. Access your "user folder" directly to manage your cartridges.

---

### 🖋️ Why P&P Editor?

*   **The "Hacker" Syntax:** A lightweight wrapper around GDScript. It feels like Python, thinks like C, and works like magic.
*   **Technical Art Direction:** A strictly limited palette where you don't just draw — you carve your world out of the blue void. Only 9 functional colors to keep the focus on the shape and movement.
*   **Live-Coding Pulse:** Change your jump height or world color and hit **F4**. The world rewrites itself instantly without a restart.
*   **Meta-Horror Ready:** Built-in tools for visual glitches and procedural resonance. Perfect for games that shouldn't exist.

---

### 🎮 Engine API Cheat Sheet (`_e`)

```python
_e.pset(x, y, color)      # Leave a mark in VRAM
_e.sspr(sx, sy, x, y, w, h, [flip]) # Summon pixels from the atlas
_e.mget(tx, ty)           # Ask the map what reality is made of
_e.sfx(freq, duration)    # Generate procedural square-wave sound
_e.camera(x, y)           # Shift the world's perspective
```

---

### 🚀 Roadmap (2026-2027)
*   **Error-Cipher:** Visual code distortion (for your eyes only).
*   **F6 Slot:** Dedicated "Neural Tab" for Enemy AI scripts.
*   **P&P Hub:** A community-driven gallery for instant cartridge sharing.

---

### How to code:

1. Press F1 to open the Editor.

2. Write your logic (it uses GDScript syntax).

3. You can define a func _game_loop(): — the engine will call it 60 times per second.

4. Use built-in functions directly: pset(), cls(), btn(), etc.

5. Hit F4 to see the magic.

---

### Promises (Summer 2026)
- [ ] **F8/F9 Slots**: Dedicated tabs for Enemy AI and Animation timelines.
- [ ] **P&P Hub**: A "Steam + Epic" cocktail for instant cartridge sharing.
---

### 🕹️ Current Masterpiece: **Error-blood and Jam**
*Submission for Jame Gam #58*
* **Theme:** The Unknown
* **Special Object:** The Compass
* *A story about a Error Knight lost in a crystalline red void.*

---

**License:** MIT  
*"Because making a level should be faster than brewing your coffee."*
