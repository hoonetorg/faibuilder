FAI executes hooks **before** the corresponding task is run.  As the guide states:

> “Hooks let you specify functions or programs which are run at certain steps of the installation process. **Before a task is called**, FAI searches for existing hooks for this task and executes them.”

Hooks are simple plugins you drop into your configuration space under `$FAI_CONFIGDIR/hooks` (or, for the very first “confdir” stage, in the nfsroot under `$FAI/hooks`).  They follow this naming scheme:

* **`<task>.<CLASS>`**   – an executable (binary or script) run in a subprocess
* **`<task>.<CLASS>.sh`** – a Bourne‐shell script that FAI **sources**, so it can set or override variables in the installing shell 

Files named with the extra **“.source”** suffix were simply the **old way** to tell FAI “please source this shell fragment into your own shell (so you can set or override variables),” but that convention is now deprecated in favor of “.sh.”

**`$FAI/hooks/<task>.<class>.source`**
   – legacy hook‐fragment that FAI would source.

**`$FAI/hooks/<task>.<class>.sh`**
   – Bourne‐shell script (must be executable).  FAI will **source** this into its installation shell, so any `export`, function definitions or calls to `skiptask()` persist.

**`$FAI/hooks/<task>.<class>`**
   – any executable (script or binary).  FAI will run it as a subprocess, passing along the `-d` debug flag if appropriate.

Beyond that you also get two “global” hook points:

* **`hooks/subroutines`** – sourced *once* before each task’s hooks run, so you can define helper functions or override FAI’s built-in subroutines.
* **`hooks/$FAI_ACTION`** – if you set a custom `$FAI_ACTION`, FAI will look for a hook file with exactly that name and execute it as your “extra” action.

---

You can define hooks for every built-in FAI task.  The default installation sequence (with hook points) is:

FAI runs its built-in installation tasks in this exact order on an install client:

[https://fai-project.org/fai-guide/#_a_id_terms_a_important_terms]

tasks

The installation of a client consists of several parts, which are called tasks. Tasks are predefined subroutines which perform a certain part of the FAI. The following FAI tasks are performed during an installation on the install clients.

```
confdir               # get the config space
setup                 # some initialization, start sshd on demand
defclass              # define FAI classes
defvar                # define variables
action                # evaluate FAI_ACTION
install               # Start the installation
partition             # partition the harddisks, create file systems
mountdisks            # mount the file systems
extrbase              # extract the base.tar.xz
debconf               # do the Debian debconf preseeding
repository            # prepare access to the package repository
updatebase            # Set up package tools and update packages
instsoft              # install software packages
configure             # call customization scripts
finish                # do some cleanup, show installation statistics
tests                 # call tests if defined
chboot                # call fai-chboot on the install server
savelog               # save log files to local and remote location
faiend                # reboot host, eject CD if needed

These are tasks, which are only executed when a different action is performed

dirinstall           # install a chroot environment
softupdate           # only do the system configuration
sysinfo              # print detailed system information
inventory            # print short hardware inventory list
```

If you’ve set `$FAI_ACTION` to something else, only the corresponding task (e.g. **dirinstall**, **softupdate**, **sysinfo** or **inventory**) will run in place of “install”

Finally, there is a special **`confdir`** hook stage at the very beginning—these hooks run *before* the configuration space is even mounted and can only use the classes `DEFAULT`, `$(uname -s | tr a-z A-Z)`, `$HOSTNAME`, and `LAST`. 





* `.source` files are for sourcing variables/functions—but they’re deprecated.
* You should rename them to `.sh`.
* Otherwise, FAI only recognizes “no extension” (exec) and “.sh” (sourced) hooks.


