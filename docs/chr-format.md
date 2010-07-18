# CHR file format

Offset analysis of Jurassic Primitive War 2's CHR file.

## Image counts (4 bytes)

- Total : 0x2210
- Guard (G) : 0x2214 / 0x2250 (split)
- Move (M) : 0x2218 / 0x2270 (split)
- Attack (A) : 0x221C / 0x2290 (split)
- Death (D) : 0x2220 / 0x22B0 (split)
- Berry gather (BG) : 0x2224 / 0x22D0 (split)
- Move without berry (BME) : 0x2228 / 0x22F0 (split)
- Move with berry (BMF) : 0x222C / 0x2310 (split)
- Harvest empty (BGE) : 0x2230 / 0x2330 (split)
- Harvest full (BGF) : 0x2234 / 0x2350 (split)
- Repair (REP) : 0x2238 / 0x2370 (split)

## Sound counts (4 bytes)

- Total : 0x241C
- Select (S) : 0x2424
- Move (M) : 0x2428
- Attack (A) : 0x242C
- Attack support (L) : 0x2430
- Death (D) : 0x2434
- Berry gather (B) : 0x2438
- Water gather (W) : 0x243C
- Ready (R) : 0x2440
- Work done (X) : 0x2444

## File region offsets

- CEI : 0x0 - 0x24BB
- PNT : 0x24BC - 0x28BB
- SPZ : 0x28BC - (see SPZ header)
- WAV : end of SPZ - (see WAV header)
