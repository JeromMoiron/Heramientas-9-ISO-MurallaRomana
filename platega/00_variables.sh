#! /bin/sh
#REM moitrijer
#Ejecutar . ./script

chmod 777 *.sh

IP=172.30.0.10
GATEW=172.30.0.1
MASK=255.255.255.0
DOMINIO_COM=lpyme09.net
DOMINIO_SINP=lpyme09
DNS=$IP
NOMBRE_T=enp0s3

NOMBRE_D=LSD98-09
NOMBRE_COM=LSD98-09.$DOMINIO_COM

RED=172.30.0.0
RANGO1=172.30.0.100
RANGO2=172.30.0.119
RESER_U02=172.30.5.101
IP_CLI1=172.30.0.20
NOMBRE_CLI2=uclient02
NOMBRE_CLI1=Uc20.04-09

IP_REVER=0.30.172
IP_DB=172.30.0
IP_FIN_D=10
IP_FIN_U1=20
DATE=date


export IP
export GATEW
export MASK
export DOMINIO_COM
export DNS
export NOMBRE_D
export NOMBRE_COM
export RED
export RANGO1
export RANGO2
export RESER_U02
export NOMBRE_T
export IP_REVER
export NOMBRE_CLI1
export IP_DB
export IP_CLI1
export IP_FIN_D
export IP_FIN_U1
export DOMINIO_SINP
export DATE
