Format: 3.0 (native)
Source: fai
Binary: fai-client, fai-doc, fai-server, fai-quickstart, fai-nfsroot, fai-setup-storage
Architecture: all
Version: 6.4.2-0~202505230840~ubuntu22.04.1
Maintainer: Thomas Lange <lange@debian.org>
Homepage: https://fai-project.org
Standards-Version: 4.7.0
Vcs-Browser: https://github.com/faiproject/fai
Vcs-Git: https://github.com/faiproject/fai.git
Testsuite: autopkgtest
Testsuite-Triggers: binutils, dosfstools, mtools, qemu-utils, reprepro, squashfs-tools, tzdata, xorriso
Build-Depends: debhelper-compat (= 13), debhelper (>= 11), libgraph-perl, devscripts
Build-Depends-Indep: asciidoc-dblatex, w3m, dblatex, docbook-xsl, libparse-recdescent-perl
Package-List:
 fai-client deb admin optional arch=all
 fai-doc deb doc optional arch=all
 fai-nfsroot deb admin optional arch=all
 fai-quickstart deb admin optional arch=all
 fai-server deb admin optional arch=all
 fai-setup-storage deb admin optional arch=all
Checksums-Sha1:
 6f685ed2c684231cc6c29d8a647fae633ef58928 282032 fai_6.4.2-0~202505230840~ubuntu22.04.1.tar.xz
Checksums-Sha256:
 1f969f045d4ff155baf0e5e1f0429b204669311b4e87ede8e888152b0b9ca430 282032 fai_6.4.2-0~202505230840~ubuntu22.04.1.tar.xz
Files:
 7a5d84774283a06a5ec996db75971ef2 282032 fai_6.4.2-0~202505230840~ubuntu22.04.1.tar.xz
