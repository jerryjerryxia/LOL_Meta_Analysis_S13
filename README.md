# LOL_Meta_Analysis_S13
In this SQL-based project, I acquired a unnormalized League of Legends matches data set, cleaned it up, created a MySQL data base with it, and ran a range of meta analysis based on a few pre-defined business questions set by myself. 

To run the project, follow the following steps:
1. Run the "LOL_Meta_Analysis_Dump.sql" file on MySQL.
2. Download the "tables" folder and run the "ingestion_script.sql" file. After that, the data base is fully built. The tables are large so make sure to adjust your time out settings if needed.
3. Run the "LOL_Project_Queries.sql" file, which will generate the tables contained in the "query_results" folder.
4. To see some visual and textual analysis, run the Analysis & Viz.Rmd in RStudio. 
