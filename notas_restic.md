# Uso RESTIC

Se utilizara RESTIC contra un servidor STFP

Iniciando repositorio:

	./restic init -r sftp://usuario@192.168.0.2:2222//srv/backups/mi-backup

Haciendo copia de seguridad

	./restic -r sftp://usuario@192.168.0.2:2222//srv/backups/mi-backup --verbose backup ~/trabajo
	
Comprobación backup

	./restic -r sftp://usuario@192.168.0.2:2222//srv/backups/mi-backup --verbose check
	
Comprobación completa de todos los datos (para verificar que no están corruptos)
	
	./restic -r sftp://usuario@192.168.0.2:2222//srv/backups/mi-backup --verbose check --read-data

Listado de las instantáneas (snapshots)
	
	./restic -r sftp://usuario@192.168.0.2:2222//srv/backups/mi-backup  --verbose list snapshots
	
Borrar las instantáneas (snapshots)
	
	./restic -r sftp://usuario@192.168.0.2:2222//srv/backups/mi-backup   --verbose forget --keep-monthly 6 --keep-daily 7 --keep-weekly 5
	
Borrar los datos que ya no están asociados a ninguna instantánea

	./restic -r sftp://usuario@192.168.0.2:2222//srv/backups/mi-backup   --verbose prune

Borrar las instantáneas y los datos asociados añadiendo: 

	"--prune"
	
Backup a un servidor compatible S3:

	export AWS_ACCESS_KEY_ID="AKIAJNFRE7YAHGDUMD"
	export AWS_SECRET_ACCESS_KEY="EtE7mGPqcbjyPT4KLXX1qVDUkAVhA"
	./restic -r s3:https://s3.amazonaws.com/BUCKET_NAME --verbose backup  ~/trabajo 
