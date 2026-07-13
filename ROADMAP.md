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
- **Visual-regression (reference-image) tests.** Today `tests/regression.typ`
  only checks that everything *compiles*; the gallery PNGs are regenerated and
  eyeballed by hand (see `TESTING.md`). A reference-image harness (e.g.
  [`tytanic`](https://github.com/tingerrr/tytanic)) would store an approved image
  per case and fail CI when the rendered output drifts — catching, automatically,
  a moved arrow, a lost box or a misaligned fraction that a compile-only test
  cannot see. Steps: add `tytanic`, snapshot the current cases as references, wire
  it into a GitHub Action.

## Before publishing to Typst Universe

- [x] Confirm the name `ruffini` is free in the index.
- [ ] Final visual pass on the gallery images.
- [ ] Submit a PR to `typst/packages` (`packages/preview/ruffini/0.1.0/`).
