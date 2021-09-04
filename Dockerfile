FROM mcr.microsoft.com/dotnet/aspnet:5.0-focal AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:5.0-focal AS build
WORKDIR /src
COPY ["helloaspnetcore.csproj", "./"]
RUN dotnet restore "helloaspnetcore.csproj"
COPY . .
RUN dotnet build "helloaspnetcore.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "helloaspnetcore.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "helloaspnetcore.dll"]
