# KEGG HTTP Tools (WIP)
Query KEGG for pathways from KEGG Orthologs (KOs).

## Goal
Eventually will allow more query types

## Why?
There is a MUCH more robust Bioconducter packag called [`KEGGREST`](). However, I was too impatient to figure out how to query the actual pathway names for my KOs. So, based on the [past-in KEGG page](https://www.genome.jp/kegg/ko.html), I created a few tools to use the exposed REST API that page uses.

Also, according to the [`KEGGREST` docs](http://bioconductor.org/packages/release/bioc/vignettes/KEGGREST/inst/doc/KEGGREST-vignette.html), 

>NOTE: keggGet() can only return 10 result sets at once (this limitation is on the server side). If you supply more than 10 inputs to keggGet(), KEGGREST will warn that only the first 10 results will be returned.

I have found no such limitation in the REST API these tools use.

## Example:

```
kegg_http_request = 'https://www.genome.jp/kegg-bin/search_pathway_object?org_name=ko&amp;unclassified=K02078%20K00764%20K03657'
getPathwaysFromKEGGWebpage(kegg_http_request)
#>        KO                                                     Pathway
#> 1 KO01100                                         Metabolic pathways 
#> 2 KO01130                                Biosynthesis of antibiotics 
#> 3 KO00230                                          Purine metabolism 
#> 4 KO00998  Biosynthesis of secondary metabolites - other antibiotics 
#> 5 KO03420                                 Nucleotide excision repair 
#> 6 KO01110                      Biosynthesis of secondary metabolites 
#> 7 KO00250                Alanine, aspartate and glutamate metabolism 
#> 8 KO03430                                            Mismatch repair 

kegg_http_request = createKeggHTTPRequest(c("K02078", "K00764", "K03657"))
print(kegg_http_request)
#> [1] "https://www.genome.jp/kegg-bin/search_pathway_object?org_name=ko&amp;unclassified=K02078%20K00764%20K03657"
getPathwaysFromKEGGWebpage(kegg_http_request)
#>        KO                                                     Pathway
#> 1 KO01100                                         Metabolic pathways 
#> 2 KO01130                                Biosynthesis of antibiotics 
#> 3 KO03430                                            Mismatch repair 
#> 4 KO00998  Biosynthesis of secondary metabolites - other antibiotics 
#> 5 KO00250                Alanine, aspartate and glutamate metabolism 
#> 6 KO01110                      Biosynthesis of secondary metabolites 
#> 7 KO00230                                          Purine metabolism 
#> 8 KO03420                                 Nucleotide excision repair 

getPathwaysFromKOList(c("K02078", "K00764", "K03657"))
#> [1] "https://www.genome.jp/kegg-bin/search_pathway_object?org_name=ko&amp;unclassified=K02078%20K00764%20K03657"
#>        KO                                                     Pathway
#> 1 KO01100                                         Metabolic pathways 
#> 2 KO01130                                Biosynthesis of antibiotics 
#> 3 KO03420                                 Nucleotide excision repair 
#> 4 KO00998  Biosynthesis of secondary metabolites - other antibiotics 
#> 5 KO00230                                          Purine metabolism 
#> 6 KO03430                                            Mismatch repair 
#> 7 KO01110                      Biosynthesis of secondary metabolites 
#> 8 KO00250                Alanine, aspartate and glutamate metabolism 
```
<sup>Created on 2019-11-05 by the [reprex package](https://reprex.tidyverse.org) (v0.3.0)</sup>

