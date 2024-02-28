lsb_release -cd  ; getconf LONG_BIT ; lsb_release -a
sudo pacman -S vsftpd
sudo vim /etc/vsftpd.conf
write_enable=YES
local_enable=YES
ascii_upload_enable=YES
ascii_download_enable=YES
chroot_local_user=YES
chroot_list_enable=YES
chroot_list_file=/etc/vsftpd.chroot_list
ls_recurse_enable=YES

# add to the end : specify chroot directory
# if not specified, users' home directory equals FTP home directory
local_root=public_html
# turn off seccomp filter if cannot login normally
seccomp_sandbox=NO

vim /etc/vsftpd.chroot_list
# add users you allow to move over their home directory
user
systemctl restart vsftpd ; systemctl status vsftpd
ftp://192.168.128.134 
