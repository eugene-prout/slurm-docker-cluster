launch:
	docker compose up -d
stop:
	docker compose down
register:
	docker exec slurmctld bash -c "/usr/bin/sacctmgr --immediate add cluster name=linux" && docker-compose restart slurmdbd slurmctld
connect:
	docker exec -it slurmctld bash