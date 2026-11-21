# Bloqueo acceso internet para niños

Si se utiliza un ordenador para que puedan utilizarlos los niños, pero se desea bloquear que puedan acceder a Internet, es posible en el caso de utilizar Linux.

Preparación:

- Debe haber un usuario con permisos de administrador (sudo), por ejemplo PADRE.

- Se crea un script en el directorio del PADRE, llamado: red_bloquear.sh, con sel siguiente contenido:

    systemctl stop NetworkManager.service
    systemctl disable NetworkManager.service
    systemctl mask NetworkManager.service

- Se crea un script en el directorio del PADRE, llamado: red_desbloquear.sh, con sel siguiente contenido:

    systemctl unmask NetworkManager.service
    systemctl enable NetworkManager.service
    systemctl start NetworkManager.service

Uso:

- Para bloquear:

    - Acceder a la cuenta del padre.

    - Ejecutar el siguiente comando:

        sudo ./red_bloquear.sh

- Para desbloquear:

    - Acceder a la cuenta del padre.

    - Ejecutar el siguiente comando:

        sudo ./red_desbloquear.sh


