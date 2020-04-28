# Virtualisation

I've found issues with running docker and virtualbox sometimes. Therefore what
might be a good solution is to just run a linux subsystem and do all my
development there.

## Virtualisation Issues

1. Docker unable to start because hardware virtualisation must be enabled:
   1. bcdedit /set hypervisorlaunchtype auto
2. Virtual box unable to run because docker + hyperv is enabled:
   1. Go to control panel, change windows features
   2. Disable Hyper-V, Containers
   3. bcdedit /set hypervisorlaunchtype off
