# C# Notes

## How to see what dependencies are installed

`dotnet list package`

## How to remove a dependency

`dotnet remove package (package name)`

## Reverse engineering a remote database

There are some
[tools](https://docs.microsoft.com/en-us/ef/core/miscellaneous/cli/dotnet) which
allow us to reverse engineer the models defined in our database. To to this
ensure that you have the tool installed `dotnet tool install --global dotnet-ef` and then
run the command:  
`dotnet ef dbcontext scaffold "server=localhost:3306;database=Wiki;user=root;password=muhR00T!" Pomelo.EntityFrameworkCore.MySql -o Model`