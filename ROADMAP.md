# ROADMAP — ruffini

Known limits and possible improvements. Nothing here blocks ordinary use.

## By design (not bugs)

- **It does not find the roots.** You pass them. Locating rational roots is a
  search problem (rational-root theorem + testing), not a layout one, and mixing
  it in would blur the package's job. `ruffini-factor` simply reports when a
  supplied value is not a root.
- **Linear divisors only.** Ruffini's rule divides by `(x − a)`. Dividing by a
  higher-degree polynomial is ordinary long division — out of scope.

## Done

- **`variable` parameter** — the rendered labels can use `t`, `z`, … (v0.1.0).
- **Exact fractions** — rational arithmetic throughout; ordinary fractions work as
  bare numbers, unusual ones as strings (v0.1.0).
- **Teaching trail** (`trail: true`) — overlaid bring-down / `×root` / column-sum
  arrows, native (no CeTZ), showing how the algorithm works (v0.1.0).

## Possible improvements (optional)

- **More localization languages** in `_i18n` (currently `en`, `es`).
- **Trail for `ruffini-factor`** — the trail is currently on single divisions only.
- **Trail + fractions** — the fixed-height trail cells can crowd tall fractions;
  it is tuned for integer coefficients.

## Publishing to Typst Universe

- [x] Confirm the name `ruffini` is free in the index.
- [x] Final visual pass on the gallery images.
- [x] Submit a PR to `typst/packages`: https://github.com/typst/packages/pull/5342
      (Lint / Test / package check all green; awaiting human review).
