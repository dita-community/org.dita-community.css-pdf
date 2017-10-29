# DITA Community CSS PDF Transform

Experimental Open Toolkit plugin that uses HTML + CSS for pagination using any CSS pagination engine (Antenna House, Prince, Vivliostyle, etc.).

## Processing Approach

This transform generates a single-chunk HTML result from the input map, augmented as needed to support paged layout (mostly generating elements to fill running heads and feet).

The base transform type is HTML5 as the input to the CSS pagination process is HTML5, not the DITA XML in some pre-digested form. 

This approach of using HTML5 simplifies the CSS styling requirements and satisfies the limitations of CSS processors that only accept HTML as input. This also allows sharing of CSS between Web and print deliverables.

## Transtype Details

Transtype name: dc-css-pdf

### Options

- TBD
