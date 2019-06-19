# FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
# WORKDIR /app
# EXPOSE 80


# FROM microsoft/dotnet:2.2-sdk AS build
# WORKDIR /src
# COPY AspNetCoreWithAngular.csproj ./
# RUN dotnet restore ./AspNetCoreWithAngular.csproj
# COPY . .
# WORKDIR /src/.
# RUN dotnet build AspNetCoreWithAngular.csproj -c Release -o /app

# RUN apt-get update && apt-get install -y nodejs

# FROM build AS publish
# RUN dotnet publish AspNetCoreWithAngular.csproj -c Release -o /app

# FROM base AS final
# WORKDIR /app
# COPY --from=publish /app .


# ENTRYPOINT ["dotnet", "AspNetCoreWithAngular.dll"]

##############################

# FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
# # Setup NodeJs
# RUN apt-get update -qq && \
#     apt-get install -qq -y wget && \
#     apt-get install -qq -y gnupg2 && \
#     wget -qO- https://deb.nodesource.com/setup_8.x | bash - && \
#     apt-get install -qq -y build-essential nodejs && \
#     apt-get install -qq -y nginx
# # End setup

# WORKDIR /app

# # EXPOSE 5050

# FROM microsoft/dotnet:2.2-sdk AS build
# # Setup NodeJs
# RUN apt-get update -qq && \
#     apt-get install -qq -y wget && \
#     apt-get install -qq -y gnupg2 && \
#     wget -qO- https://deb.nodesource.com/setup_8.x | bash - && \
#     apt-get install -qq -y build-essential nodejs && \
#     apt-get install -qq -y nginx
# # End setup

# WORKDIR /src
# COPY AspNetCoreWithAngular.csproj ./
# RUN dotnet restore ./AspNetCoreWithAngular.csproj
# COPY . .

# RUN cd ClientApp \
#     && npm i --silent

# WORKDIR /src/.
# RUN dotnet build AspNetCoreWithAngular.csproj -c Release -o /app

# FROM build AS publish

# RUN dotnet publish AspNetCoreWithAngular.csproj -c Release -o /app

# FROM base AS final
# WORKDIR /app
# COPY --from=publish /app .
# ENTRYPOINT ["dotnet", "AspNetCoreWithAngular.dll"]

################################

FROM microsoft/dotnet:2.2-sdk AS builder
WORKDIR /source

RUN curl -sL https://deb.nodesource.com/setup_10.x |  bash -
RUN apt-get install -y nodejs

COPY *.csproj .
RUN dotnet restore

COPY ./ ./

RUN dotnet publish "./AspNetCoreWithAngular.csproj" --output "./dist" --configuration Release 

FROM microsoft/dotnet:2.2-aspnetcore-runtime
WORKDIR /app
COPY --from=builder /source/dist .
EXPOSE 80
ENTRYPOINT ["dotnet", "AspNetCoreWithAngular.dll"]