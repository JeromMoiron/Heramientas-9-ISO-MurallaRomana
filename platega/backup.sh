#! /bin/sh
#REM moitrijer

ORDENADOR='hostname'

BACKUP_DIR="backup"

#DIRECTORIOS="/dir1/sub /dir2"

DIRECTORIOS="dir1 dir2"

N_C_D=""

COMPRESOR=.lzma

N_DIA_SEMANA_COPIA_TOTAL=5

N_MES='date +%m'

MES_ABREV='date +%b'

N_DIA_MES='date +%d'

N_DIA_SEMANA='date +%u'

DIA_SEMANA_ABREV='date +%a'

COPIA_MENSUAL='N'

ANO='date +%Y'

BACKUP_DIR=$BACKUP_DIR"/"$ANO

F_METADATOS_ULTIMA_TOTAL=$BACKUP_DIR/$SNAR/$ORDENADOR-00-ULTIMA_TOTAL.snar

REXISTRO_COPIAS=$BACKUP_DIR/$SNAR/rexistro.txt

if ! test -d "$BACKUP_DIR/$SNAR";then
	mkdir -p "$BACKUP_DIR/$SNAR"
fi


if [ $N_DIA_SEMANA = $N_DIA_SEMANA_COPIA_TOTAL ]; then

	case $N_DIA_MES in

		0[1-7])		SEMANA=semana_1;;

		08|09|1[0-4])	SEMANA=semana_2;;

		1[5-9]|20|21)	SEMANA=semana_3;;

		2[2-8])		SEMANA=semana_4;;

			if [ $N_MES !='date -d "7 days" +%m' ]
			then
				COPIA_MENSUAL='S'
			fi;;

		29|30|31)	SEMANA=semana_5;
				COPIA_MENSUAL='S';;
esac

if [ $COPIA_MENSUAL = 'S' ];then
	echo 'date' "Avó	:$ORDENADOR - INICIO: Total mensual $MES_ABREV">>$REXISTRO_COPIAS

F_BACKUP=$BACKUP_DIR/$ORDENADOR-01-Total-Mes-$N_MES-$MES_ABREV.tar$COMPRESOR

F_METADATOS=$BACKUP_DIR/$SNAR/$ORDENADOR-01-Total-Mes-$N_MES-$MES-$MES_ABREV.snar
	else
		echo 'date' "Pai	:$ORDENADOR - INICIO: Total $SEMANA">>$REXISTRO_COPIAS

F_BACKUP=$BACKUP_DIR/$ORDENADOR-02-Total-$SEMANA.tar$COMPRESOR

F_METADATOS=$BACKUP_DIR/$SNAR/$ORDENADOR-02-Total-$SEMANA.snar
	fi


	if test -f "$F_METADATOS";then
		rm $F_METADATOS
	fi

	tar cfa $F_BACKUP -g $F_METADATOS $N_C_D $DIRECTORIOS
	cp $F_METADATOS $F_METADATOS_ULTIMA_TOTAL

	echo 'date' "Avó-Pai :$ORDENADOR - FIN	:Total">>$REXISTRO_COPIAS
	echo >>$REXISTRO_COPIAS


	if [ $COPIA_MENSUAL = 'S' ];then
		echo >>$REXISTRO_COPIAS
		echo >>$REXISTRO_COPIAS
		echo ---------- MES de 'date -d "7 days" +%B'------------->>$REXISTRO_COPIAS
	fi

elif ! test -f "$F_METADATOS_ULTIMA_TOTAL";then

	echo 'date' "Primera:$ORDENADOR - INICIO: Total. $DIA_SEMANA_ABREV">>$REXISTRO_COPIAS

F_BACKUP=$BACKUP_DIR/$ORDENADOR-00-Primeira-$DIA_SEMANA_ABREV.tar$COMPRESOR
	F_METADATOS=$F_METADATOS_ULTIMA_TOTAL


	tar cfa $F_BACKUP -g $F_METADATOS $N_C_D $DIRECTORIOS

	echo 'date' "Primeira:$ORDENADOR - FIN	:Total. $DIAS_SEMANA_ABREV">>$REXISTRO_COPIAS
	echo >>$REXISTRO_COPIAS

elif [ $N_DIA_SEMANA -lt $N_DIA_SEMANA_COPIA_TOTAL ];then

	echo 'date' "Fillo	:$ORDENADOR - INICIO: Diferencial. Día $DIA_SEMANA_ABREV">>$REXISTRO_COPIAS
F_BACKUP=$BACKUP_DIR/$ORDENADOR-03-Dif$N_DIA_SEMANA-$DIA_SEMANA_ABREV.tar$COMPRESOR

F_METADATOS=$BACKUP_DIR/$SNAR/$ORDENADOR-03-Dif$N_DIA_SEMANA-$DIA_SEMANA_ABREV.snar

	cp $F_METADATOS_ULTIMA_TOTAL $F_METADATOS
	tar cfa $F_BACKUP -g $F_METADATOS $N_C_D $DIRECTORIOS

	echo 'date' "Fillo	:$ORDENADOR -FIN	:Diferencial. Día $DIA_SEMANA_ABREV">>$REXISTRO_COPIAS
	echo >>$REXISTRO_COPIAS

else

	echo 'date' "Non	:$ORDENADOR - Ós $DIA_SEMANA_ABREV non se realizan backups">>$REXISTRO_COPIAS
	echo $REXISTRO_COPIAS
fi
