#set the variables
   2   │ VM_ID=102
   3   │ NAME=Core44
   4   │ QCOW=fedora-coreos-44.20260419.2.1-proxmoxve.x86_64.qcow2
   5   │ IGN=core44.ign
   6   │ STORAGE="local"
   7   │ CPU=4
   8   │ MEMORY=8192
   9   │ DISK_SIZE=54G
  10   │ BIOS=ovmf
  11   │ MACHINE=q35
  12   │ #Create the VM
  13   │ qm create ${VM_ID} --name ${NAME} --cores ${CPU} --cpu host --memory ${MEMORY} --bios ${BIOS} --machine ${MACHI
       │ NE} \
  14   │     --net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-pci --description "Fedora CoreOS 44 Testing"
  15   │ qm set ${VM_ID} --efidisk0 ${STORAGE}:1,format=raw
  16   │ qm set ${VM_ID} --scsi0 ${STORAGE}:0,import-from=/var/lib/vz/import/${QCOW}
  17   │ qm set ${VM_ID} --boot order=scsi0
  18   │ qm set ${VM_ID} --serial0 socket --vga serial0
  19   │ qm set ${VM_ID} --cicustom vendor=${STORAGE}:snippets/${IGN}
  20   │ qm set ${VM_ID} --ciupgrade 0
  21   │ qm resize ${VM_ID} scsi0 +${DISK_SIZE}
  22   │ qm set ${VM_ID} --hostpci0 mapping=NVIDIA,pcie=1,x-vga=0
  23   │ qm set ${VM_ID} -args "-fw_cfg name=opt/com.coreos/config,file=/var/lib/vz/snippets/core44.ign"
  24   │ qm set ${VM_ID} --ide2 ${STORAGE}:cloudinit
