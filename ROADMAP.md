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
- **Exact fractions** — rational arithmetic throughout; rationals passed as
  strings render as fractions (v0.1.0).

## Possible improvements (optional)

- **More localization languages** in `_i18n` (currently `en`, `es`).
- **A colored trail** joining each result to the product it feeds, as an optional
  teaching aid for the "multiply–add" flow. (Diagonal ×root arrows + vertical sum
  arrows, colored, showing where each number comes from.)
- **Reference-image tests** (e.g. `tytanic`) beyond the compile-only battery in
  `tests/regression.typ`.

## Before publishing to Typst Universe

- [x] Confirm the name `ruffini` is free in the index.
- [ ] Final visual pass on the gallery images.
- [ ] Submit a PR to `typst/packages` (`packages/preview/ruffini/0.1.0/`).
