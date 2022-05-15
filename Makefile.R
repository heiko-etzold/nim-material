# Change these setting for your language and version

language <- "de"

title <- "Nim-Spiel -- Handreichung für Lehrerinnen und Lehrer"
shortTitle <- "Nim-Handreichung"
description <- "Anleitungen und Hinweise zur Nutzung der Nim-App"

versionText <- "Version"
guideVersion <- "1.0"
appVersion <- "1.0"
optimizedTextA <- "; angepasst an Version "
optimizedTextB <- " der Nim-App"

authors <- "Heiko Etzold, Günter Krauthausen"
authorsForCitation <- "Etzold, H. & Krauthausen, G."
citeText <- "zitiere als"
gitHubName <- "heiko-etzold"
gitHubProject <- "nim-material"



# Keep these settings and run the hole R file


filePath<-file("index.Rmd")

muh<-grepl("---",x=readLines(filePath))
firstLine <- 0
lastLine <- 0
index <- 0
for(bool in muh){
  index <- index+1
  if(bool == TRUE && firstLine == 0){
    firstLine = index
  }
  if(bool == TRUE && firstLine != 0){
    lastLine = index
  }
}

oldText <- readLines(filePath)[-(firstLine:lastLine)]


file.create(filePath)
sink(filePath)
cat("---\n")
cat(sprintf("title: \"%s\"\n",title))
cat(sprintf("description: \"%s\"\n",description))
cat(sprintf("author: \"%s\"\n",authors))
cat(sprintf("date: |\n  %s %s, \`r format(Sys.time(), '%%B %%Y')\`%s%s%s\n\n", versionText, guideVersion, optimizedTextA, appVersion, optimizedTextB))

cat("site: bookdown::bookdown_site\n")
cat("output:\n")
cat("  bookdown::gitbook:\n")
cat("    config:\n")
cat("      toc:\n")
cat("        before:\n")
cat(sprintf("          <li><a href=\"index.html\"><b>%s</b></a></li>\n",shortTitle))
cat("        after:\n")
cat("          <li><a href=\"https://creativecommons.org/licenses/by-sa/4.0/\"><img src=\"pictures/by-sa.png\" height=\"20px\"/></a></li>\n")
cat("      sharing:\n")
cat("        facebook: false\n")
cat("        twitter: false\n")
cat("        all: false\n")
cat("        github: true\n")
cat("      info: false\n")
cat("    css: \"own.css\"\n")
cat("    split_bib: false\n")
cat("  bookdown::pdf_book:\n")
cat("    toc: true\n")
cat("    includes:\n")
cat("      in_header: \"in_header.tex\"\n")
cat("      before_body: \"before_body.tex\"\n")
cat("    latex_engine: xelatex\n")
cat("documentclass: scrbook\n")
cat("lang: de-DE\n")
cat(sprintf("github-repo: \"%s/%s/tree/%s.%s\"\n",gitHubName, gitHubProject, language, guideVersion))
cat("bibliography: \"references.bib\"\n")
cat("csl: \"apa.csl\"\n")
cat("link-citations: yes\n")
cat(sprintf("url: \"https://%s.github.io/%s/%s/%s\"\n",gitHubName, gitHubProject, language, guideVersion))

cat("---\n")

writeLines(oldText)
sink()

close(filePath)



yamlFilePath<-file("_bookdown.yml")
file.create(yamlFilePath)
sink(yamlFilePath)
cat("book_filename: 'Nim-Handreichung'\n")
cat(sprintf("view: \"https://github.com/%s/%s/blob/%s.%s/%%s\"\n", gitHubName, gitHubProject, language, guideVersion))
cat(sprintf("output_dir: \"docs/%s/%s\"\n", language, guideVersion))
cat("language:\n")
cat("  label:\n")
cat("    fig: 'Abb. '\n")

sink()
close(yamlFilePath)



