FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 AS base

WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS publish
WORKDIR /src
COPY MyWebApp .
RUN dotnet publish MyWebApp.csproj -c Release -o /app

FROM base As final
WORKDIR /app
COPY --from=publish /app /app
ENTRYPOINT [ "dotnet", "MyWebApp.dll" ]
