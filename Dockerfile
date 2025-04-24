FROM mcr.microsoft.com/dotnet/sdk:8.0 AS BASE

COPY . /app

WORKDIR /app

RUN dotnet build myapp.csproj
RUN dotnet publish myapp.csproj -c Debug -o buildapp

FROM mcr.microsoft.com/dotnet/sdk:8.0
WORKDIR /finalapp
COPY --from=BASE /app/buildapp /finalapp

EXPOSE 55003
ENV ASPNETCORE_ENVIRONMENT=Development
ENV ASPNETCORE_URLS=http://+:5000

ENTRYPOINT [ "dotnet", "myapp.dll" ]