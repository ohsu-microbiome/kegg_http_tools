library(rvest)
library(tidyverse)
library(magrittr)

createKeggHTTPRequest = function(ko_list)
{
  base = "https://www.genome.jp/kegg-bin/search_pathway_object?org_name=ko&amp;unclassified="
  paste0(base, paste0(ko_list, collapse="%20"))
}

getPathwaysFromKEGGWebpage = function(str)
{
  scraped = read_html(kegg_http_request)
  li_nodes = scraped %>% html_node('.box2') %>% html_nodes('li')

  df = data.frame(KO=character(), Pathway=character())

  for (node in li_nodes)
  {
    # print(node)

    ko_id =
      node %>%
      html_node('a') %>%
      html_text() %>%
      toupper()

    pathway_name =
      node %>%
      sub(".*/a>(.*?)\\(<a.*", '\\1', .)

    df %<>% add_row(KO=ko_id, Pathway=pathway_name)

  }

  return(df)

}

getPathwaysFromKOList = function(ko_list)
{

  kegg_http_request = createKeggHTTPRequest(ko_list)
  print(kegg_http_request)

  scraped = read_html(kegg_http_request)
  li_nodes = scraped %>% html_node('.box2') %>% html_nodes('li')

  df = data.frame(KO=character(), Pathway=character())

  for (node in li_nodes)
  {
    # print(node)

    ko_id =
      node %>%
      html_node('a') %>%
      html_text() %>%
      toupper()

    pathway_name =
      node %>%
      sub(".*/a>(.*?)\\(<a.*", '\\1', .)

    df %<>% add_row(KO=ko_id, Pathway=pathway_name)

  }

  return(df$Pathway)

}
