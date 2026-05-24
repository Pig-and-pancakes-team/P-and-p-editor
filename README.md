# P-and-p-editor
Standalone retro-IDE &amp; fantasy console for rapid prototyping. Powered by Godot 4.
> **"Pure pixels. Raw logic. Prototyping at the speed of thought."**
> **Download: https://github.com/Pig-and-pancakes-team/P-and-p-editor/releases/tag/1.0**

Add files via upload
"To play a new game: Launch P&P Editor, press [Q] to open the folder, and drop the .sav file there. Restart the engine — and enjoy!"
> ### ⚠️ SECURITY WARNING: EXTERNAL CARTRIDGES
> P&P Editor uses a powerful native scripting engine. Since `.sav` files (cartridges) contain executable code:
> 1. **ONLY** run `.sav` files from creators you trust.
> 2. **NEVER** run a cartridge from an unknown or suspicious source.
> 3. **BUILT-IN PROTECTION**: The engine includes a native "Forbidden Command Filter" to block malicious system calls, but stay vigilant.
> 
> *The developer is not responsible for any damage caused by third-party scripts. Your system, your responsibility.*

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
### Video (Recorded on a potato):
"The video quality is 360p because I converted it using screen capture on my phone. Yes, it's a workaround. No, I don't regret it. But you can see that the editor works even in such harsh conditions! Don't be alarmed by the quality—the editor itself produces pristine pixels!"


https://github.com/user-attachments/assets/d57f6617-b377-49e6-badb-5c5d1c05d2eb


https://github.com/user-attachments/assets/80769c47-193e-426c-b70c-e79b0c67e088



https://github.com/user-attachments/assets/c4734dc6-2ea4-42a0-a063-5420329b4581



https://github.com/user-attachments/assets/211b9b1d-8198-488f-994d-f265536cc6aa




---

### Screenshots from my computer:
<img width="1920" height="1036" alt="f2 workspace screenshot" src="https://github.com/user-attachments/assets/e10998b1-844c-4f69-9e0e-4e63ac1238ed" />
<img width="1920" height="1042" alt="f1 workspace screenshot" src="https://github.com/user-attachments/assets/879d2ca5-f3d7-457b-a41c-4161202c7a18" />
<img width="1920" height="1038" alt="f3 workspace screenshot" src="https://github.com/user-attachments/assets/8d942da3-995a-4843-8c8b-67b6dee1f32c" />
<img width="1920" height="1034" alt="f4 workspace screenshot" src="https://github.com/user-attachments/assets/fed9ce26-a6e3-41bf-b184-b9c4f2dace11" />

---
### Promises (Summer 2026)
- [ ] **F8/F9 Slots**: Dedicated tabs for Enemy AI and Animation timelines.
- [ ] **P&P Hub**: A "Steam + Epic" cocktail for instant cartridge sharing.
---
### Technical Specifications:
Platform: Windows / PC.

Engine: Godot 4.

Scalability: The editor window is compact by default, but can be expanded for easier work.

---
Portability:
The entire editor and your projects weigh only a few megabytes.
### 🕹️ Current Masterpiece: **Error-blood and Jam**
* **Theme:** The Unknown
* **Special Object:** The Compass
* *A story about a Error Knight lost in a crystalline red void.*

---

**License:** MIT  
*"Because making a level should be faster than brewing your coffee."*

## ⚠️ Disclaimer:
1. **Infinite Loops:** There is no protection against infinite loops (e.g., `while true`). If your script contains one, the application will freeze. 
2. **No Liability:** The author (Pig-and-pancakes-team) is not responsible for any damage, data loss, or system crashes caused by your code executed within the editor. 
3. **Use at your own risk.**
