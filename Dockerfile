# Utilizar la imagen base de .NET SDK
FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar el resto de la aplicación y compilar
COPY src/. ./
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Utilizar la imagen base de .NET Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine AS runtime

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar los archivos compilados desde la etapa de construcción
COPY --from=build /app/out .

# Definir el comando de entrada para ejecutar la aplicación
ENTRYPOINT ["dotnet", "Shorten.dll"]