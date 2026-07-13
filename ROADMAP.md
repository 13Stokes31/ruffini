# ROADMAP — ruffini

Known limits and possible improvements. Nothing here blocks ordinary use.

## By design (not bugs)

- **It does not find the roots.** You pass them. Locating rational roots is a
  search problem (rational-root theorem + testing), not a layout one, and mixing
  it in would blur the package's job. `ruffini-factor` simply reports when a
  supplied value is not a root.
- **Linear divisors only.** Ruffini's rule divides by `(x − a)`. Dividing by a
  higher-degree polynomial is ordinary long division — out of scope.

## Possible improvements (optional)

- **A `variable` parameter** so the polynomial can be written in `t`, `z`, … as
  well as `x`.
- **Fraction display** for rational roots/coefficients (e.g. show `1/2` instead
  of `0.5`), perhaps via an optional `frac: true`.
- **More localization languages** in `_i18n` (currently `en`, `es`).
- **A colored trail** joining each result to the product it feeds, as an optional
  teaching aid for the "multiply–add" flow.
- **Reference-image tests** (e.g. `tytanic`) beyond the compile-only battery in
  `tests/regression.typ`.

## Before publishing to Typst Universe

- [x] Confirm the name `ruffini` is free in the index.
- [ ] Final visual pass on the gallery images.
- [ ] Submit a PR to `typst/packages` (`packages/preview/ruffini/0.1.0/`).
