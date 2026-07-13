// Source for the README gallery images. Render with:
//   typst compile --root .. --format png --ppi 150 gallery/examples.typ gallery/g{p}.png
#import "../lib.typ": ruffini, ruffini-factor
#set page(width: 9cm, height: auto, margin: 10pt, fill: white)
#set text(11pt)

// g1 — a single division, three-row tableau, boxed remainder
#ruffini((1, -2, 0, 1), 2)
#pagebreak()

// g2 — full factorization staircase
#ruffini-factor((1, -6, 11, -6), (1, 2, 3))
#pagebreak()

// g3 — leading coefficient ≠ 1, irreducible quotient kept
#ruffini-factor((3, 2, -3, -2), (1, -1))
#pagebreak()

// g4 — Spanish labels
#ruffini((1, 0, -3, 0, 2), -1, lang: "es", color: rgb("#2b8a3e"))
#pagebreak()

// g5 — teaching trail: bring down · multiply by the root · add the column
#set page(width: auto)
#ruffini((1, -2, 0, 1), 2, trail: true)
