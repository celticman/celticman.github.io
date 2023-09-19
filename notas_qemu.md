# Notas QEMU

## Portapapeles con una máquina virtual Linux (Ubuntu)

### Desde la máquina virtual al host

Para habilitar la función de portapapeles de **Maquina Virtual** -> **Host** se debe instalar el siguiente paquete:

		sudo apt install spice-vdagent
		
Es necesario habilitarlo:

		sudo systemctl enable spice-vdagent
		sudo systemctl start spice-vdagent

		
### Desde el host a la máquina virtual

Para habilitar la función de portapapeles de **Host** -> **Maquina Virtual** se debe instalar el siguiente paquete:

		sudo apt install qemu-guest-agent

Es necesario habilitarlo:

		sudo systemctl enable qemu-guest-agent
		systemctl start qemu-guest-agent
		
