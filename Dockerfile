FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /app
# copy csproj and restore as distinct layers
# COPY *.sln .
COPY ./*.csproj ./lyrics-app/
# copy everything else and build app
COPY . ./lyrics-app/
WORKDIR /app/lyrics-app
RUN dotnet restore
RUN dotnet publish -c Release -o out
FROM microsoft/dotnet:2.1-aspnetcore-runtime AS runtime
WORKDIR /app
COPY --from=build /app/lyrics-app/out ./
ENTRYPOINT ["dotnet", "lyrics-app.dll"]