# TESTING — ruffini

Manual verification checklist. Automated coverage is the compile-only battery in
`tests/regression.typ`; this file is for the things a human should eyeball.

Render the battery with:

```sh
typst compile --root . tests/regression.typ tests/regression.pdf
```

Then check, page by page:

- [ ] **Canonical division** (`x³−2x²+1 ÷ (x−2)`) — three rows; middle products
  row shows `2  0  0`; result row `1  0  0  [1]`; remainder `1` is boxed;
  line reads `Quotient: C(x) = x²` / `Remainder: R = 1`.
- [ ] **Divide by (x+1)** (`root = -1`) — exact, remainder `0`.
- [ ] **Nonzero remainder** (`x²+1 ÷ (x−3)`) — `C(x) = x + 3`, `R = 10`.
- [ ] **Fractional root** (`0.5`) — arithmetic correct; numbers display cleanly.
- [ ] **Options off** — `show-result: false` hides the line; `highlight-remainder:
  false` removes the box.
- [ ] **Spanish** — Cociente / Resto.
- [ ] **Color override** — L-rule and box pick up the given color.
- [ ] **Full factorization** (`x³−6x²+11x−6`, roots `1,2,3`) — staircase with the
  L-rule and shrinking horizontal rules; line `P(x) = (x−1)(x−2)(x−3)`.
- [ ] **Leading coefficient ≠ 1** (roots `1,−1`) — `P(x) = (x−1)(x+1)(3x+2)`.
- [ ] **Irreducible quotient remains** (`x³−x²−x−2`, root `2`) —
  `P(x) = (x−2)(x²+x+1)`.
- [ ] **Inexact** (a supplied value is not a root) — line reads "not an exact
  division (nonzero remainder)".
- [ ] **Factor + Spanish** — Factorización.

## Gallery

- [ ] `gallery/g1.png … g4.png` match the current output after any code change:
  `typst compile --root . --format png --ppi 150 gallery/examples.typ gallery/g{p}.png`
