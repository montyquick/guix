(use-modules (gnu) (nongnu packages linux))
(use-service-modules desktop networking ssh xorg)

(operating-system
  (kernel linux)
  (firmware (list linux-firmware))
  (locale "en_GB.utf8")
  (timezone "Europe/London")
  (keyboard-layout (keyboard-layout "gb"))
  (host-name "guix")
  
  (users (cons* (user-account
                   (name "user")
                   (comment "User")
                   (group "users")
                   (home-directory "/home/user")
                   (supplementary-groups '("wheel" "netdev" "audio" "video")))
               %base-user-accounts))
  
  (services 
   (append (list (service xfce-desktop-service-type) 
   				 (service openssh-service-type) 
   				 (set-xorg-configuration 
   				  (xorg-configuration (keyboard-layout keyboard-layout))))
  (modify-services %desktop-services (guix-service-type config => (guix-configuration (inherit config)
       (substitute-urls (append (list 
                                 "https://substitutes.nonguix.org")
                         %default-substitute-urls))
        (authorized-keys (append (list (local-file
                                        "./signing-key.pub"))
                          %default-authorized-guix-keys)))))))
   
   (bootloader (bootloader-configuration
                  (bootloader grub-bootloader)
                  (targets (list "/dev/sda"))
                  (keyboard-layout keyboard layout)))
   (swap-devices (list (swap-space 
                         (target (uuid "")))))
   (file-systems (cons* (file-system (mount-point "/")
                                     (device (uuid "" 
                                             `ext4))
                                     (type "ext4")) %base-file-systems)))
