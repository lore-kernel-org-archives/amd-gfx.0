From: Fengguang Wu <fengguang.wu@intel.com>
Subject: [drm/ttm] cf6c467d67 kernel BUG at include/linux/mm.h:460!
Date: Sat, 11 Mar 2017 13:48:46 +0800
Message-ID: <20170311054846.dgkwzzybpllnbz2o@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2efbkydmiu3cpayg"
Content-Transfer-Encoding: 8bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, "Roger.He" <Hongbo.He@amd.com>, amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, LKP <lkp@01.org>
List-Id: amd-gfx.lists.freedesktop.org


--2efbkydmiu3cpayg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit cf6c467d67d319e239aec57d7ba31cb9946f29bf
Author:     Christian König <christian.koenig@amd.com>
AuthorDate: Tue Jan 10 14:08:28 2017 +0100
Commit:     Alex Deucher <alexander.deucher@amd.com>
CommitDate: Fri Jan 27 12:20:33 2017 -0500

     drm/ttm: add BO priorities for the LRUs
     
     This way the driver can specify a priority for a BO which has the effect that
     a BO is only evicted when all other BOs with a lower priority are evicted
     first.
     
     Reviewed-by: Sinclair Yeh <syeh@vmware.com>
     Signed-off-by: Christian König <christian.koenig@amd.com>
     Reviewed-by: Roger.He <Hongbo.He@amd.com>
     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

2ee7fc92cf  drm/ttm: remove allow_errors parameter from ttm_bo_force_list_clean
cf6c467d67  drm/ttm: add BO priorities for the LRUs
+-----------------------------------------------------------------------+------------+------------+
|                                                                       | 2ee7fc92cf | cf6c467d67 |
+-----------------------------------------------------------------------+------------+------------+
| boot_successes                                                        | 0          | 0          |
| boot_failures                                                         | 179        | 26         |
| WARNING:at_drivers/gpu/drm/drm_mode_config.c:#drm_mode_config_cleanup | 179        | 26         |
| WARNING:at_arch/x86/mm/dump_pagetables.c:#note_page                   | 179        |            |
| kernel_BUG_at_include/linux/mm.h                                      | 0          | 26         |
| invalid_opcode:#[##]SMP                                               | 0          | 26         |
| EIP:put_page_testzero                                                 | 0          | 26         |
| Kernel_panic-not_syncing:Fatal_exception                              | 0          | 26         |
+-----------------------------------------------------------------------+------------+------------+

[    4.819359] [drm] Initialized vgem 1.0.0 20120112 for virtual device on minor 0
[    4.820591] [drm] Found bochs VGA, ID 0xb0c0.
[    4.821198] [drm] Framebuffer size 16384 kB @ 0xfd000000, mmio @ 0xfebf0000.
[    4.822357] [TTM] Zone  kernel: Available graphics memory: 135446 kiB
[    4.823200] [TTM] Initializing pool allocator
[    4.823900] [TTM] Initializing DMA pool allocator
[    4.826964] bochsdrmfb: enable CONFIG_FB_LITTLE_ENDIAN to support this framebuffer
[    4.828024] [drm] Initialized bochs-drm 1.0.0 20130925 for 0000:00:02.0 on minor 1
[    4.829168] ------------[ cut here ]------------
[    4.829805] WARNING: CPU: 0 PID: 1 at drivers/gpu/drm/drm_mode_config.c:458 drm_mode_config_cleanup+0x178/0x1e3
[    4.831403] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.0-rc1-next-20170309 #1
[    4.832417] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-20161025_171302-gandalf 04/01/2014
[    4.833814] Call Trace:
[    4.834154]  dump_stack+0x55/0x6e
[    4.834608]  ? drm_mode_config_cleanup+0x178/0x1e3
[    4.835230]  __warn+0xad/0xc4
[    4.835623]  warn_slowpath_null+0x11/0x16
[    4.836144]  drm_mode_config_cleanup+0x178/0x1e3
[    4.836750]  bochs_kms_fini+0x17/0x21
[    4.837232]  bochs_unload+0x18/0x38
[    4.837694]  drm_dev_unregister+0x32/0x9d
[    4.838219]  drm_put_dev+0x3b/0x47
[    4.838686]  bochs_pci_remove+0xe/0x10
[    4.839197]  pci_device_remove+0x1c/0x44
[    4.839755]  driver_probe_device+0x121/0x25c
[    4.840367]  __driver_attach+0x51/0x6d
[    4.840880]  bus_for_each_dev+0x4e/0x6b
[    4.841426]  driver_attach+0x14/0x16
[    4.841892]  ? driver_probe_device+0x25c/0x25c
[    4.842487]  bus_add_driver+0xb3/0x18c
[    4.842973]  driver_register+0x6f/0xa4
[    4.843467]  __pci_register_driver+0x45/0x48
[    4.844020]  drm_pci_init+0x3a/0xad
[    4.844492]  ? qxl_init+0x5a/0x5a
[    4.844946]  bochs_init+0x3a/0x51
[    4.845405]  do_one_initcall+0xaa/0x1c5
[    4.845908]  ? repair_env_string+0x25/0x89
[    4.846452]  ? parse_args+0x1c3/0x28f
[    4.846950]  kernel_init_freeable+0x124/0x1e9
[    4.847557]  ? rest_init+0xaa/0xaa
[    4.848043]  kernel_init+0x8/0xd0
[    4.848524]  ret_from_fork+0x21/0x30
[    4.849022] ---[ end trace df6b9e3a91551133 ]---
[    4.849666] page:d25a75ec count:0 mapcount:0 mapping:ffffffff index:0x0 compound_mapcount: 0
[    4.850788] flags: 0x8000000()
[    4.851263] raw: 08000000 ffffffff 00000000 ffffffff 00000000 d25a75c9 00010001 00000000
[    4.852329] raw: 00000000
[    4.852692] page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
[    4.853653] ------------[ cut here ]------------
[    4.854264] kernel BUG at include/linux/mm.h:460!
[    4.855127] invalid opcode: 0000 [#1] SMP
[    4.855693] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.11.0-rc1-next-20170309 #1
[    4.856901] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-20161025_171302-gandalf 04/01/2014
[    4.858239] task: d1c18000 task.stack: d1c26000
[    4.858827] EIP: put_page_testzero+0xd/0xf
[    4.859456] EFLAGS: 00210246 CPU: 0
[    4.859914] EAX: 00000000 EBX: d12631fc ECX: c1accb1d EDX: d8022869
[    4.860722] ESI: d25a75ec EDI: d124f3a0 EBP: d1c27dc8 ESP: d1c27dc8
[    4.861549]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[    4.862294] CR0: 80050033 CR2: 00000000 CR3: 01df6000 CR4: 000006b0
[    4.863165] Call Trace:
[    4.863531]  __free_pages+0xf/0x2b
[    4.863996]  kfree+0x6b/0x6f
[    4.864409]  bochs_user_framebuffer_destroy+0x1c/0x1f
[    4.865071]  drm_framebuffer_free+0x1c/0x20
[    4.865621]  drm_mode_config_cleanup+0x195/0x1e3
[    4.866222]  bochs_kms_fini+0x17/0x21
[    4.866701]  bochs_unload+0x18/0x38
[    4.867156]  drm_dev_unregister+0x32/0x9d
[    4.867693]  drm_put_dev+0x3b/0x47
[    4.868156]  bochs_pci_remove+0xe/0x10
[    4.868673]  pci_device_remove+0x1c/0x44
[    4.869180]  driver_probe_device+0x121/0x25c
[    4.869752]  __driver_attach+0x51/0x6d
[    4.870270]  bus_for_each_dev+0x4e/0x6b
[    4.870806]  driver_attach+0x14/0x16
[    4.871338]  ? driver_probe_device+0x25c/0x25c
[    4.871950]  bus_add_driver+0xb3/0x18c
[    4.872468]  driver_register+0x6f/0xa4
[    4.872964]  __pci_register_driver+0x45/0x48
[    4.873523]  drm_pci_init+0x3a/0xad
[    4.873978]  ? qxl_init+0x5a/0x5a
[    4.874418]  bochs_init+0x3a/0x51
[    4.874849]  do_one_initcall+0xaa/0x1c5
[    4.875364]  ? repair_env_string+0x25/0x89
[    4.875915]  ? parse_args+0x1c3/0x28f
[    4.876421]  kernel_init_freeable+0x124/0x1e9
[    4.876996]  ? rest_init+0xaa/0xaa
[    4.877445]  kernel_init+0x8/0xd0
[    4.877895]  ret_from_fork+0x21/0x30
[    4.878387] Code: 0f 0b 8b 50 10 85 d2 74 0c ba f2 9d ac c1 e8 c5 70 01 00 0f 0b c7 40 10 01 00 00 00 5d c3 55 ba bf fe aa c1 89 e5 e8 ad 70 01 00 <0f> 0b 55 89 e5 53 89 c3 e8 6b 53 10 00 84 c0 74 0a 8b 13 8b 43
[    4.880964] EIP: put_page_testzero+0xd/0xf SS:ESP: 0068:d1c27dc8
[    4.881844] ---[ end trace df6b9e3a91551134 ]---
[    4.882460] Kernel panic - not syncing: Fatal exception
[    4.883333] Kernel Offset: disabled

git bisect start c3230be0c56d1502b5e8f32191cfb2cf4b4f7254 c470abd4fde40ea6a0846a2beab642a578c0b8cd --
git bisect  bad eac824197dedb2425ae4718a3fdef51dc1e0d2ce  # 19:13      0-      1  Merge 'linux-review/Matthias-Schiffer/vxlan-correctly-validate-VXLAN-ID-against-VXLAN_VID_MASK/20170223-233547' into devel-catchup-201702241708
git bisect  bad 0e7ba4c534671d65fa5eec880343daa57990a9e5  # 19:21      0-      2  Merge 'linux-review/Tan-Xiaojun/perf-core-Fix-to-check-perf_cpu_time_max_percent/20170223-135907' into devel-catchup-201702241708
git bisect  bad 0c46677444bd90a036d4d95feeeeab8b63fc3a83  # 20:29      0-     26  Merge 'linux-review/Colin-King/rtlwifi-fix-spelling-mistake-conuntry-country/20170223-074137' into devel-catchup-201702241708
git bisect  bad 197b8825b45e9e8fcd0ee05966cc6a90f8adad80  # 20:36      0-      5  Merge 'linux-review/Trond-Myklebust/nfsd-Allow-enabling-NFSv4-x-without-also-requiring-NFSv4-0/20170223-034632' into devel-catchup-201702241708
git bisect  bad e46fc8214a1eb1a740ffac8b91fbb35185bbff58  # 23:04      0-     26  Merge 'ostr/for-linus-4.11' into devel-catchup-201702241708
git bisect  bad 55e8f4615bb48578e91a8e3eab7f202432065b20  # 23:19      0-      5  Merge 'linux-review/Krzysztof-Kozlowski/Documentation-Update-path-to-sysrq-txt/20170224-164713' into devel-catchup-201702241708
git bisect good be8ab0f3f33b3bd4e716c6071b1e60b9292531f0  # 00:15     20+     24  0day base guard for 'devel-catchup-201702241708'
git bisect good 2057e15945a8b5d867c086371a5fb946fd8221da  # 01:26     21+     23  Input: cros_ec_keyb - drop unnecessary call to dev_set_drvdata and other changes
git bisect good 31d7677b91307e2771b6922fd9920542a92d376d  # 06:50     22+     48  net: mvpp2: fix indentation of MVPP2_EXT_GLOBAL_CTRL_DEFAULT
git bisect good 6bce1974f64aba108ad344cb2ef0110d9c09ebd2  # 07:47     20+     22  soc: samsung: pm_domains: Add new Exynos5433 compatible
git bisect good feef2a7cb93e532bde3c7682ec7b1bce99cc8be5  # 09:18     20+     24  drm/i915: re-use computed offset bias for context pin
git bisect good 98a5f361b8625c6f4841d6ba013bbf0e80d08147  # 10:58     21+     23  powerpc: Add new cache geometry aux vectors
git bisect good 1a8dded1a3fcfb0c865a35688c86aa45bac37393  # 12:44     21+     47  staging: lustre: fid: Change positional struct initializers to C99
git bisect good b5baa68773150772c275b4af1bb31327200cfc05  # 14:32     20+     24  KVM: PPC: Book3S HV: KVM-HV HPT resizing implementation
git bisect good 07cc189d160ba962c5d9078453929ffac0e739f3  # 19:42     22+     26  hwmon: (dme1737) Fix overflows seen when writing into limit attributes
git bisect good 0e5a47a8d346c798bbb1801c7c5852b652155b72  # 01:59     22+     26  scripts/checkstack.pl: add support for nios2
git bisect good 54fff785db6e44208478ae3b0e5c56b853b3e10d  # 02:45     21+     21  Merge tag 'armsoc-defconfig' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect  bad 33b7bfdf918af4dc6585afe6d21f5e6b7613de1b  # 02:54      0-      1  Merge tag 'gvt-next-2017-02-15' of https://github.com/01org/gvt-linux into drm-intel-next-fixes
git bisect good 3875623c561f9e83181d9621e0a963ed457c4bf6  # 03:15     21+     21  Merge tag 'drm-misc-next-2017-01-23' of git://anongit.freedesktop.org/git/drm-misc into drm-next
git bisect  bad 29a73d906bd386839015602c4bd35ef2e3531abc  # 03:23      0-      2  Merge branch 'drm-next-4.11' of git://people.freedesktop.org/~agd5f/linux into drm-next
git bisect  bad cf6c467d67d319e239aec57d7ba31cb9946f29bf  # 03:23      0-     27  drm/ttm: add BO priorities for the LRUs
git bisect good 41c360f6a6ccd477481a3309608e9b3388bdd83d  # 03:47     22+     22  drm/amdgpu: add get clockgating_state method for sdma v3
git bisect good 3149d9da12263b696d6123f90e44968ebde2115d  # 04:02     21+     21  drm/amdgpu: request/release full gpu access if device is vf
git bisect good a1970a6382b8781380de9494b2e256aa85814b79  # 04:21     20+     20  drm/amdgpu: refine ci uvd dpm code.
git bisect good 714fbf80392248170c2e67cd77062e2cab0d8a82  # 11:43     22+     48  drm/amdgpu:set cond_exec polling value to 1 in ring_init
git bisect good 9a9993590d03794a56365d6025cf694fd1a8f6da  # 17:16     22+     26  drm/amd/amdgpu: Add PCI info to gca_config debugfs
git bisect good 63d24f8846b0095cbbd94746b6fc8a6acbda8f5e  # 17:58     22+     24  drm/amdgpu/vi: fix mailbox irq mistake
git bisect good 2ee7fc92cfd327fe41377f64a7f04ddc30c851e7  # 18:17     20+    112  drm/ttm: remove allow_errors parameter from ttm_bo_force_list_clean
# first bad commit: [cf6c467d67d319e239aec57d7ba31cb9946f29bf] drm/ttm: add BO priorities for the LRUs
git bisect good 2ee7fc92cfd327fe41377f64a7f04ddc30c851e7  # 19:23     60+    172  drm/ttm: remove allow_errors parameter from ttm_bo_force_list_clean
# extra tests with CONFIG_DEBUG_INFO_REDUCED
git bisect  bad cf6c467d67d319e239aec57d7ba31cb9946f29bf  # 19:23      0-     70  drm/ttm: add BO priorities for the LRUs
# extra tests on HEAD of linux-devel/devel-catchup-201702241708
git bisect  bad c3230be0c56d1502b5e8f32191cfb2cf4b4f7254  # 19:23      0-     35  0day head guard for 'devel-catchup-201702241708'
# extra tests on tree/branch linus/master
# extra tests on tree/branch linux-next/master

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--2efbkydmiu3cpayg
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-quantal-lkp-hsw01-49:20170225132539:i386-randconfig-b0-02241556:4.10.0-rc5-00883-gcf6c467:3.gz"
Content-Transfer-Encoding: base64

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

--2efbkydmiu3cpayg
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-quantal-lkp-hsw01-10:20170225104217:i386-randconfig-b0-02241556:4.10.0-rc5-00882-g2ee7fc9:2.gz"
Content-Transfer-Encoding: base64

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
8AEACg==

--2efbkydmiu3cpayg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-quantal-lkp-hsw01-49:20170225132539:i386-randconfig-b0-02241556:4.10.0-rc5-00883-gcf6c467:3"

#!/bin/bash

kernel=$1
initrd=quantal-core-i386.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/initrd/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu kvm64
	-kernel $kernel
	-initrd $initrd
	-m 512
	-smp 2
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	console=tty0
	vga=normal
	rw
	drbd.minor_count=8
)

"${kvm[@]}" -append "${append[*]}"

--2efbkydmiu3cpayg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.10.0-rc5-00883-gcf6c467"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.10.0-rc5 Kernel Configuration
#
# CONFIG_64BIT is not set
CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_32_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DEBUG_RODATA=y
CONFIG_PGTABLE_LEVELS=3
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_KERNEL_LZ4=y
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_FHANDLE=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
# CONFIG_IRQ_DOMAIN_DEBUG is not set
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_TREE_RCU_TRACE=y
# CONFIG_RCU_EXPEDITE_BOOT is not set
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_NMI_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_NAMESPACES is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_INITRAMFS_COMPRESSION=".gz"
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
# CONFIG_POSIX_TIMERS is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_BPF_SYSCALL=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
# CONFIG_ADVISE_SYSCALLS is not set
# CONFIG_USERFAULTFD is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_MEMBARRIER is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
# CONFIG_PROFILING is not set
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_JUMP_LABEL=y
CONFIG_STATIC_KEYS_SELFTEST=y
# CONFIG_UPROBES is not set
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
CONFIG_HAVE_CC_STACKPROTECTOR=y
CONFIG_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
CONFIG_CC_STACKPROTECTOR_REGULAR=y
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
# CONFIG_HAVE_ARCH_HASH is not set
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
# CONFIG_CPU_NO_EFFICIENT_FFS is not set
# CONFIG_HAVE_ARCH_VMAP_STACK is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
# CONFIG_FREEZER is not set

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_FAST_FEATURE_TESTS=y
CONFIG_X86_MPPARSE=y
CONFIG_X86_BIGSMP=y
# CONFIG_GOLDFISH is not set
# CONFIG_INTEL_RDT_A is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_LGUEST_GUEST is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
CONFIG_MGEODEGX1=y
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=4
CONFIG_X86_L1_CACHE_SHIFT=4
# CONFIG_X86_PPRO_FENCE is not set
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_MINIMUM_CPU_FAMILY=5
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
CONFIG_NR_CPUS=32
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_X86_LEGACY_VM86 is not set
# CONFIG_VM86 is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX32=y
CONFIG_TOSHIBA=y
CONFIG_I8K=y
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=y
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=3
CONFIG_ARCH_HAVE_MEMORY_PRESENT=y
CONFIG_NEED_NODE_MEMMAP_SIZE=y
CONFIG_ARCH_DISCONTIGMEM_ENABLE=y
CONFIG_ARCH_DISCONTIGMEM_DEFAULT=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_DISCONTIGMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_DISCONTIGMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
# CONFIG_CLEANCACHE is not set
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_ZPOOL is not set
CONFIG_ZBUD=y
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_FRAME_VECTOR=y
CONFIG_HIGHPTE=y
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
# CONFIG_X86_PAT is not set
# CONFIG_ARCH_RANDOM is not set
CONFIG_X86_SMAP=y
# CONFIG_X86_INTEL_MPX is not set
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
# CONFIG_SCHED_HRTICK is not set
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_HOTPLUG_CPU is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_PM is not set
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
# CONFIG_ACPI_DEBUGGER_USER is not set
# CONFIG_ACPI_PROCFS_POWER is not set
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
CONFIG_ACPI_EC_DEBUGFS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
# CONFIG_ACPI_THERMAL is not set
# CONFIG_ACPI_NUMA is not set
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_EINJ=y
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=y
CONFIG_X86_ACPI_CPUFREQ=y
# CONFIG_X86_ACPI_CPUFREQ_CPB is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_POWERNOW_K8 is not set
CONFIG_X86_AMD_FREQ_SENSITIVITY=y
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=y
CONFIG_X86_SPEEDSTEP_SMI=y
CONFIG_X86_P4_CLOCKMOD=y
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
CONFIG_X86_LONGRUN=y
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_GOBIOS=y
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_BIOS=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_BUS_ADDR_T_64BIT=y
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
# CONFIG_PCI_STUB is not set
CONFIG_HT_IRQ=y
CONFIG_PCI_ATS=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI host controller drivers
#
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=y
# CONFIG_SCx200HR_TIMER is not set
# CONFIG_ALIX is not set
CONFIG_NET5501=y
CONFIG_GEOS=y
CONFIG_AMD_NB=y
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_RAPIDIO is not set
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_PMC_ATOM=y
CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_NET_KEY is not set
# CONFIG_INET is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NET_PTP_CLASSIFY is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
# CONFIG_DNS_RESOLVER is not set
# CONFIG_BATMAN_ADV is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_HSR is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_STREAM_PARSER is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set
# CONFIG_LIB80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_RFKILL_REGULATOR is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_NFC is not set
# CONFIG_LWTUNNEL is not set
# CONFIG_DST_CACHE is not set
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_FIRMWARE_IN_KERNEL is not set
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
CONFIG_CMA_SIZE_SEL_PERCENTAGE=y
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
CONFIG_MTD=y
# CONFIG_MTD_REDBOOT_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_AR7_PARTS=y

#
# User Modules And Translation Layers
#
CONFIG_MTD_OOPS=y
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_CFI_INTELEXT is not set
# CONFIG_MTD_CFI_AMDSTD is not set
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
CONFIG_MTD_SCx200_DOCFLASH=y
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_GPIO_ADDR is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y
# CONFIG_MTD_LATCH_ADDR is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_DATAFLASH=y
CONFIG_MTD_DATAFLASH_WRITE_VERIFY=y
# CONFIG_MTD_DATAFLASH_OTP is not set
CONFIG_MTD_SST25L=y
CONFIG_MTD_SLRAM=y
CONFIG_MTD_PHRAM=y
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# CONFIG_MTD_NAND is not set
# CONFIG_MTD_ONENAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# CONFIG_MTD_SPI_NOR is not set
# CONFIG_MTD_UBI is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
# CONFIG_PARPORT_PC is not set
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_AX88796=y
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
CONFIG_IBM_ASM=y
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
CONFIG_ICS932S401=y
# CONFIG_ENCLOSURE_SERVICES is not set
CONFIG_CS5535_MFGPT=y
CONFIG_CS5535_MFGPT_DEFAULT_IRQ=7
CONFIG_CS5535_CLOCK_EVENT_SRC=y
CONFIG_HP_ILO=y
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
CONFIG_TI_DAC7512=y
# CONFIG_VMWARE_BALLOON is not set
# CONFIG_PCH_PHUB is not set
CONFIG_USB_SWITCH_FSA9480=y
CONFIG_LATTICE_ECP3_CONFIG=y
# CONFIG_SRAM is not set
CONFIG_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
CONFIG_C2PORT=y
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=y
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=y
CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=y

#
# Altera FPGA firmware download module
#
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
# CONFIG_INTEL_MEI_ME is not set
CONFIG_INTEL_MEI_TXE=y
CONFIG_VMWARE_VMCI=y

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# VOP Bus Driver
#

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_ECHO is not set
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_SCSI_DMA is not set
# CONFIG_SCSI_NETLINK is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
CONFIG_FIREWIRE_NOSY=y
CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
# CONFIG_NETDEVICES is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
CONFIG_TOUCHSCREEN_ADS7846=y
CONFIG_TOUCHSCREEN_AD7877=y
CONFIG_TOUCHSCREEN_AD7879=y
CONFIG_TOUCHSCREEN_AD7879_I2C=y
CONFIG_TOUCHSCREEN_AD7879_SPI=y
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
# CONFIG_TOUCHSCREEN_ATMEL_MXT_T37 is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
CONFIG_TOUCHSCREEN_BU21013=y
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
# CONFIG_TOUCHSCREEN_CYTTSP_I2C is not set
CONFIG_TOUCHSCREEN_CYTTSP_SPI=y
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
# CONFIG_TOUCHSCREEN_CYTTSP4_I2C is not set
CONFIG_TOUCHSCREEN_CYTTSP4_SPI=y
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
CONFIG_TOUCHSCREEN_FUJITSU=y
CONFIG_TOUCHSCREEN_GOODIX=y
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=y
CONFIG_TOUCHSCREEN_WACOM_W8001=y
CONFIG_TOUCHSCREEN_WACOM_I2C=y
# CONFIG_TOUCHSCREEN_MAX11801 is not set
CONFIG_TOUCHSCREEN_MCS5000=y
CONFIG_TOUCHSCREEN_MMS114=y
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
CONFIG_TOUCHSCREEN_MTOUCH=y
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
CONFIG_TOUCHSCREEN_PENMOUNT=y
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
CONFIG_TOUCHSCREEN_TOUCHWIN=y
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=y
# CONFIG_TOUCHSCREEN_PIXCIR is not set
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
CONFIG_TOUCHSCREEN_WM97XX=y
# CONFIG_TOUCHSCREEN_WM9705 is not set
# CONFIG_TOUCHSCREEN_WM9712 is not set
# CONFIG_TOUCHSCREEN_WM9713 is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_MC13783=y
CONFIG_TOUCHSCREEN_TOUCHIT213=y
CONFIG_TOUCHSCREEN_TSC_SERIO=y
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
CONFIG_TOUCHSCREEN_TSC2004=y
CONFIG_TOUCHSCREEN_TSC2005=y
CONFIG_TOUCHSCREEN_TSC2007=y
CONFIG_TOUCHSCREEN_PCAP=y
CONFIG_TOUCHSCREEN_RM_TS=y
CONFIG_TOUCHSCREEN_SILEAD=y
CONFIG_TOUCHSCREEN_SIS_I2C=y
CONFIG_TOUCHSCREEN_ST1232=y
CONFIG_TOUCHSCREEN_SURFACE3_SPI=y
# CONFIG_TOUCHSCREEN_SX8654 is not set
CONFIG_TOUCHSCREEN_TPS6507X=y
CONFIG_TOUCHSCREEN_ZFORCE=y
CONFIG_TOUCHSCREEN_ROHM_BU21023=y
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
# CONFIG_RMI4_F11 is not set
# CONFIG_RMI4_F12 is not set
# CONFIG_RMI4_F30 is not set
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_USERIO=y
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_ROCKETPORT=y
# CONFIG_CYCLADES is not set
CONFIG_MOXA_INTELLIO=y
CONFIG_MOXA_SMARTIO=y
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
CONFIG_SYNCLINK_GT=y
CONFIG_NOZOMI=y
# CONFIG_ISI is not set
CONFIG_N_HDLC=y
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_DEVMEM is not set
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_DMA is not set
# CONFIG_SERIAL_8250_PCI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
# CONFIG_SERIAL_8250_FSL is not set
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
# CONFIG_SERIAL_8250_MID is not set
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_MAX3100=y
CONFIG_SERIAL_MAX310X=y
CONFIG_SERIAL_UARTLITE=y
CONFIG_SERIAL_UARTLITE_CONSOLE=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_SCCNXP=y
# CONFIG_SERIAL_SCCNXP_CONSOLE is not set
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
# CONFIG_SERIAL_SC16IS7XX_SPI is not set
CONFIG_SERIAL_TIMBERDALE=y
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS=y
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_IFX6X60=y
CONFIG_SERIAL_PCH_UART=y
# CONFIG_SERIAL_PCH_UART_CONSOLE is not set
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
CONFIG_SERIAL_RP2=y
CONFIG_SERIAL_RP2_NR_UARTS=32
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
CONFIG_TTY_PRINTK=y
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=y
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=y
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=y
# CONFIG_HW_RANDOM_VIRTIO is not set
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_NVRAM=y
CONFIG_R3964=y
CONFIG_APPLICOM=y
CONFIG_SONYPI=y
CONFIG_MWAVE=y
CONFIG_SCx200_GPIO=y
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_SPI=y
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
CONFIG_TCG_NSC=y
CONFIG_TCG_ATMEL=y
CONFIG_TCG_INFINEON=y
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=y
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
CONFIG_TCG_TIS_ST33ZP24_SPI=y
CONFIG_TELCLOCK=y
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
# CONFIG_I2C_MUX is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=y
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=y
CONFIG_I2C_AMD756=y
# CONFIG_I2C_AMD756_S4882 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=y
# CONFIG_I2C_NFORCE2 is not set
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=y
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA_PCI is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_PARPORT_LIGHT=y
CONFIG_I2C_TAOS_EVM=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_CROS_EC_TUNNEL=y
CONFIG_SCx200_ACB=y
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=y
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_DESIGNWARE=y
# CONFIG_SPI_DW_PCI is not set
# CONFIG_SPI_DW_MMIO is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
CONFIG_SPI_OC_TINY=y
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
CONFIG_SPI_ROCKCHIP=y
CONFIG_SPI_SC18IS602=y
CONFIG_SPI_TOPCLIFF_PCH=y
CONFIG_SPI_XCOMM=y
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
# CONFIG_SPI_TLE62X0 is not set
CONFIG_SPMI=y
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y

#
# PPS support
#
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_PARPORT is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PINCTRL=y

#
# Pin controllers
#
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_SX150X=y
# CONFIG_PINCTRL_BAYTRAIL is not set
CONFIG_PINCTRL_CHERRYVIEW=y
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_BROXTON=y
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_GPIOLIB=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_LYNXPOINT=y
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_VX855=y

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=y
CONFIG_GPIO_104_IDIO_16=y
# CONFIG_GPIO_104_IDI_48 is not set
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_GPIO_MM=y
# CONFIG_GPIO_IT87 is not set
CONFIG_GPIO_SCH=y
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WS16C48=y

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_SX150X=y
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ARIZONA is not set
# CONFIG_GPIO_CRYSTAL_COVE is not set
# CONFIG_GPIO_CS5535 is not set
CONFIG_GPIO_KEMPLD=y
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_PALMAS=y
# CONFIG_GPIO_TIMBERDALE is not set
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS65218=y
# CONFIG_GPIO_TPS65912 is not set
# CONFIG_GPIO_TWL6040 is not set
# CONFIG_GPIO_WHISKEY_COVE is not set
# CONFIG_GPIO_WM8350 is not set
CONFIG_GPIO_WM8994=y

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
CONFIG_GPIO_RDC321X=y

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX7301 is not set
CONFIG_GPIO_MC33880=y
# CONFIG_GPIO_PISOSR is not set

#
# SPI or I2C GPIO expanders
#
CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
# CONFIG_W1_SLAVE_SMEM is not set
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
# CONFIG_W1_SLAVE_DS2760 is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_BQ27000=y
CONFIG_POWER_AVS=y
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_PDA_POWER=y
# CONFIG_WM8350_POWER is not set
CONFIG_TEST_POWER=y
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
# CONFIG_BATTERY_DS2782 is not set
CONFIG_BATTERY_WM97XX=y
CONFIG_BATTERY_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9150=y
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=y
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_MAX14577=y
CONFIG_CHARGER_MAX77693=y
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_SMB347=y
# CONFIG_CHARGER_TPS65090 is not set
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=y
CONFIG_SENSORS_AD7314=y
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_K8TEMP=y
CONFIG_SENSORS_K10TEMP=y
CONFIG_SENSORS_FAM15H_POWER=y
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ARM_SCPI=y
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DS620=y
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=y
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=y
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=y
# CONFIG_SENSORS_IBMAEM is not set
# CONFIG_SENSORS_IBMPEX is not set
CONFIG_SENSORS_I5500=y
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=y
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC4151=y
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=y
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX31722=y
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6642=y
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=y
CONFIG_SENSORS_ADCXX=y
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM70=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=y
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT7802=y
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
# CONFIG_SENSORS_ADM1275 is not set
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LTC2978=y
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX16064 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX34440 is not set
CONFIG_SENSORS_MAX8688=y
CONFIG_SENSORS_TPS40422=y
CONFIG_SENSORS_UCD9000=y
# CONFIG_SENSORS_UCD9200 is not set
# CONFIG_SENSORS_ZL6100 is not set
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=y
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
# CONFIG_SENSORS_SCH5627 is not set
CONFIG_SENSORS_SCH5636=y
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS1015=y
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_ADS7871=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=y
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=y
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=y
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_WM8350=y

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
CONFIG_THERMAL_HWMON=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_THERMAL_EMULATION=y
CONFIG_INTEL_POWERCLAMP=y
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=y
CONFIG_ACPI_THERMAL_REL=y
CONFIG_INT3406_THERMAL=y
CONFIG_INTEL_BXT_PMIC_THERMAL=y
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
CONFIG_DA9062_WATCHDOG=y
# CONFIG_MENF21BMC_WATCHDOG is not set
CONFIG_WDAT_WDT=y
# CONFIG_WM8350_WATCHDOG is not set
# CONFIG_XILINX_WATCHDOG is not set
CONFIG_ZIIRAVE_WATCHDOG=y
CONFIG_CADENCE_WATCHDOG=y
CONFIG_DW_WATCHDOG=y
CONFIG_MAX63XX_WATCHDOG=y
# CONFIG_RETU_WATCHDOG is not set
CONFIG_ACQUIRE_WDT=y
CONFIG_ADVANTECH_WDT=y
CONFIG_ALIM1535_WDT=y
CONFIG_ALIM7101_WDT=y
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=y
CONFIG_SP5100_TCO=y
# CONFIG_GEODE_WDT is not set
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=y
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
CONFIG_IE6XX_WDT=y
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=y
CONFIG_IT87_WDT=y
CONFIG_HP_WATCHDOG=y
CONFIG_KEMPLD_WDT=y
CONFIG_HPWDT_NMI_DECODING=y
CONFIG_SC1200_WDT=y
CONFIG_SCx200_WDT=y
CONFIG_PC87413_WDT=y
CONFIG_NV_TCO=y
# CONFIG_60XX_WDT is not set
CONFIG_SBC8360_WDT=y
# CONFIG_SBC7240_WDT is not set
CONFIG_CPU5_WDT=y
CONFIG_SMSC_SCH311X_WDT=y
# CONFIG_SMSC37B787_WDT is not set
CONFIG_VIA_WDT=y
CONFIG_W83627HF_WDT=y
CONFIG_W83877F_WDT=y
CONFIG_W83977F_WDT=y
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=y
CONFIG_INTEL_MEI_WDT=y
CONFIG_NI903X_WDT=y
CONFIG_MEN_A21_WDT=y

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y

#
# Broadcom specific AMBA
#
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
# CONFIG_BCMA_HOST_SOC is not set
# CONFIG_BCMA_DRIVER_PCI is not set
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_CROS_EC=y
CONFIG_MFD_CROS_EC_I2C=y
CONFIG_MFD_CROS_EC_SPI=y
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
# CONFIG_LPC_ICH is not set
CONFIG_LPC_SCH=y
CONFIG_INTEL_SOC_PMIC=y
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_EZX_PCAP=y
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RTSX_PCI is not set
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=y
# CONFIG_MFD_SYSCON is not set
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS65217 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TPS65218=y
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_MFD_TPS65912_SPI=y
CONFIG_MFD_TPS80031=y
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
CONFIG_MFD_TIMBERDALE=y
# CONFIG_MFD_TMIO is not set
CONFIG_MFD_VX855=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_ARIZONA_SPI=y
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_AB3100=y
# CONFIG_REGULATOR_ARIZONA is not set
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_DA9062=y
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX14577 is not set
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
# CONFIG_REGULATOR_MAX8907 is not set
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MT6311=y
# CONFIG_REGULATOR_MT6323 is not set
# CONFIG_REGULATOR_MT6397 is not set
CONFIG_REGULATOR_PALMAS=y
CONFIG_REGULATOR_PCAP=y
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
# CONFIG_REGULATOR_QCOM_SPMI is not set
CONFIG_REGULATOR_RT5033=y
CONFIG_REGULATOR_S2MPA01=y
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_SKY81452=y
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=y
# CONFIG_REGULATOR_TPS65090 is not set
# CONFIG_REGULATOR_TPS6524X is not set
CONFIG_REGULATOR_TPS65912=y
# CONFIG_REGULATOR_TPS80031 is not set
# CONFIG_REGULATOR_WM8350 is not set
CONFIG_REGULATOR_WM8994=y
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_RC_SUPPORT=y
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_MEDIA_CEC_DEBUG is not set
CONFIG_MEDIA_CEC_EDID=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_VIDEO_DEV=y
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=y
# CONFIG_VIDEO_ADV_DEBUG is not set
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_VIDEO_PCI_SKELETON=y
CONFIG_VIDEO_TUNER=y
CONFIG_V4L2_MEM2MEM_DEV=y
CONFIG_VIDEOBUF_GEN=y
CONFIG_VIDEOBUF_DMA_SG=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=y
# CONFIG_TTPCI_EEPROM is not set

#
# Media drivers
#
CONFIG_RC_CORE=y
# CONFIG_RC_MAP is not set
# CONFIG_RC_DECODERS is not set
# CONFIG_RC_DEVICES is not set
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
CONFIG_VIDEO_SOLO6X10=y
# CONFIG_VIDEO_TW5864 is not set
CONFIG_VIDEO_TW68=y
CONFIG_VIDEO_TW686X=y
# CONFIG_VIDEO_ZORAN is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=y
CONFIG_VIDEO_IVTV_ALSA=y
# CONFIG_VIDEO_FB_IVTV is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
CONFIG_VIDEO_HEXIUM_ORION=y
CONFIG_VIDEO_MXB=y
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=y
# CONFIG_VIDEO_CX88_ALSA is not set
CONFIG_VIDEO_CX88_BLACKBIRD=y
CONFIG_VIDEO_CX88_MPEG=y
CONFIG_VIDEO_BT848=y
CONFIG_VIDEO_SAA7134=y
# CONFIG_VIDEO_SAA7134_ALSA is not set
CONFIG_VIDEO_SAA7134_RC=y
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
CONFIG_V4L_TEST_DRIVERS=y
CONFIG_VIDEO_VIVID=y
# CONFIG_VIDEO_VIVID_CEC is not set
CONFIG_VIDEO_VIVID_MAX_DEVS=64
CONFIG_VIDEO_VIM2M=y

#
# Supported MMC/SDIO adapters
#
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=y
CONFIG_RADIO_SI470X=y
# CONFIG_I2C_SI470X is not set
CONFIG_RADIO_SI4713=y
# CONFIG_PLATFORM_SI4713 is not set
CONFIG_I2C_SI4713=y
CONFIG_RADIO_MAXIRADIO=y
# CONFIG_RADIO_TEA5764 is not set
CONFIG_RADIO_SAA7706H=y
CONFIG_RADIO_TEF6862=y
CONFIG_RADIO_TIMBERDALE=y
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#
CONFIG_VIDEO_CX2341X=y
CONFIG_VIDEO_TVEEPROM=y
CONFIG_VIDEO_SAA7146=y
CONFIG_VIDEO_SAA7146_VV=y
CONFIG_VIDEO_V4L2_TPG=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
CONFIG_VIDEO_IR_I2C=y

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=y
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
CONFIG_VIDEO_TEA6415C=y
CONFIG_VIDEO_TEA6420=y
CONFIG_VIDEO_MSP3400=y
CONFIG_VIDEO_CS3308=y
# CONFIG_VIDEO_CS5345 is not set
CONFIG_VIDEO_CS53L32A=y
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_WM8775=y
CONFIG_VIDEO_WM8739=y
CONFIG_VIDEO_VP27SMPX=y
CONFIG_VIDEO_SONY_BTF_MPX=y

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set

#
# Video decoders
#
CONFIG_VIDEO_ADV7183=y
CONFIG_VIDEO_BT819=y
CONFIG_VIDEO_BT856=y
# CONFIG_VIDEO_BT866 is not set
CONFIG_VIDEO_KS0127=y
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_AD5820 is not set
CONFIG_VIDEO_SAA7110=y
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_TVP514X=y
CONFIG_VIDEO_TVP5150=y
CONFIG_VIDEO_TVP7002=y
CONFIG_VIDEO_TW2804=y
CONFIG_VIDEO_TW9903=y
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=y
CONFIG_VIDEO_CX25840=y

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=y
CONFIG_VIDEO_SAA7185=y
CONFIG_VIDEO_ADV7170=y
CONFIG_VIDEO_ADV7175=y
CONFIG_VIDEO_ADV7343=y
# CONFIG_VIDEO_ADV7393 is not set
CONFIG_VIDEO_AK881X=y
CONFIG_VIDEO_THS8200=y

#
# Camera sensor devices
#
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV7640 is not set
CONFIG_VIDEO_OV7670=y
CONFIG_VIDEO_VS6624=y
CONFIG_VIDEO_MT9M111=y
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_SR030PC30 is not set

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
CONFIG_VIDEO_AS3645A=y
CONFIG_VIDEO_LM3560=y
CONFIG_VIDEO_LM3646=y

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=y
CONFIG_VIDEO_UPD64083=y

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
CONFIG_VIDEO_M52790=y

#
# Sensors used on soc_camera driver
#

#
# SPI helper chips
#
CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=y
# CONFIG_MEDIA_TUNER_TDA8290 is not set
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
# CONFIG_MEDIA_TUNER_MSI001 is not set
# CONFIG_MEDIA_TUNER_MT20XX is not set
CONFIG_MEDIA_TUNER_MT2060=y
CONFIG_MEDIA_TUNER_MT2063=y
# CONFIG_MEDIA_TUNER_MT2266 is not set
CONFIG_MEDIA_TUNER_MT2131=y
CONFIG_MEDIA_TUNER_QT1010=y
# CONFIG_MEDIA_TUNER_XC2028 is not set
# CONFIG_MEDIA_TUNER_XC5000 is not set
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MXL5005S=y
CONFIG_MEDIA_TUNER_MXL5007T=y
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_MAX2165=y
CONFIG_MEDIA_TUNER_TDA18218=y
CONFIG_MEDIA_TUNER_FC0011=y
# CONFIG_MEDIA_TUNER_FC0012 is not set
CONFIG_MEDIA_TUNER_FC0013=y
CONFIG_MEDIA_TUNER_TDA18212=y
CONFIG_MEDIA_TUNER_E4000=y
CONFIG_MEDIA_TUNER_FC2580=y
CONFIG_MEDIA_TUNER_M88RS6000T=y
CONFIG_MEDIA_TUNER_TUA9001=y
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_IT913X=y
CONFIG_MEDIA_TUNER_R820T=y
CONFIG_MEDIA_TUNER_MXL301RF=y
CONFIG_MEDIA_TUNER_QM1D1C0042=y

#
# Customise DVB Frontends
#

#
# Tools to develop new frontends
#

#
# Graphics support
#
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
CONFIG_AGP_AMD=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_NVIDIA=y
CONFIG_AGP_SIS=y
CONFIG_AGP_SWORKS=y
CONFIG_AGP_VIA=y
CONFIG_AGP_EFFICEON=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
# CONFIG_DRM_DEBUG_MM_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_VM=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
CONFIG_DRM_I2C_SIL164=y
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=y
CONFIG_DRM_I915_ALPHA_SUPPORT=y
CONFIG_DRM_I915_CAPTURE_ERROR=y
# CONFIG_DRM_I915_COMPRESS_ERROR is not set
# CONFIG_DRM_I915_USERPTR is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
CONFIG_DRM_VGEM=y
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_AST is not set
CONFIG_DRM_MGAG200=y
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_QXL=y
CONFIG_DRM_BOCHS=y
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_HISI_HIBMC=y
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
CONFIG_DRM_R128=y
CONFIG_DRM_I810=y
CONFIG_DRM_MGA=y
CONFIG_DRM_SIS=y
CONFIG_DRM_VIA=y
CONFIG_DRM_SAVAGE=y
# CONFIG_DRM_LIB_RANDOM is not set

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_DDC=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA is not set
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
CONFIG_FB_BIG_ENDIAN=y
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_SVGALIB=y
# CONFIG_FB_MACMODES is not set
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_FB_N411=y
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=y
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
CONFIG_FB_I740=y
CONFIG_FB_I810=y
CONFIG_FB_I810_GTF=y
CONFIG_FB_I810_I2C=y
CONFIG_FB_LE80578=y
CONFIG_FB_CARILLO_RANCH=y
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=y
CONFIG_FB_RADEON_I2C=y
CONFIG_FB_RADEON_BACKLIGHT=y
# CONFIG_FB_RADEON_DEBUG is not set
# CONFIG_FB_ATY128 is not set
CONFIG_FB_ATY=y
# CONFIG_FB_ATY_CT is not set
# CONFIG_FB_ATY_GX is not set
# CONFIG_FB_ATY_BACKLIGHT is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
CONFIG_FB_VIA=y
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
CONFIG_FB_3DFX=y
CONFIG_FB_3DFX_ACCEL=y
CONFIG_FB_3DFX_I2C=y
CONFIG_FB_VOODOO1=y
# CONFIG_FB_VT8623 is not set
CONFIG_FB_TRIDENT=y
CONFIG_FB_ARK=y
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
# CONFIG_FB_GEODE is not set
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_VIRTUAL=y
CONFIG_FB_METRONOME=y
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
CONFIG_FB_MB862XX_I2C=y
# CONFIG_FB_BROADSHEET is not set
CONFIG_FB_AUO_K190X=y
# CONFIG_FB_AUO_K1900 is not set
CONFIG_FB_AUO_K1901=y
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_L4F00242T03 is not set
CONFIG_LCD_LMS283GF05=y
CONFIG_LCD_LTV350QV=y
# CONFIG_LCD_ILI922X is not set
CONFIG_LCD_ILI9320=y
# CONFIG_LCD_TDO24M is not set
CONFIG_LCD_VGG2432A4=y
CONFIG_LCD_PLATFORM=y
# CONFIG_LCD_S6E63M0 is not set
CONFIG_LCD_LD9040=y
CONFIG_LCD_AMS369FG06=y
CONFIG_LCD_LMS501KF03=y
CONFIG_LCD_HX8357=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
CONFIG_BACKLIGHT_LM3533=y
# CONFIG_BACKLIGHT_CARILLO_RANCH is not set
CONFIG_BACKLIGHT_PWM=y
CONFIG_BACKLIGHT_APPLE=y
CONFIG_BACKLIGHT_PM8941_WLED=y
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=y
CONFIG_BACKLIGHT_SKY81452=y
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_VGASTATE=y
CONFIG_HDMI=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
# CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_PCM_ELD=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_COMPRESS_OFFLOAD=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
# CONFIG_SND_PCM_OSS_PLUGINS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_VERBOSE is not set
# CONFIG_SND_PCM_XRUN_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_RAWMIDI_SEQ=y
CONFIG_SND_OPL3_LIB_SEQ=y
# CONFIG_SND_OPL4_LIB_SEQ is not set
# CONFIG_SND_SBAWE_SEQ is not set
CONFIG_SND_EMU10K1_SEQ=y
CONFIG_SND_MPU401_UART=y
CONFIG_SND_OPL3_LIB=y
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_DRIVERS=y
# CONFIG_SND_DUMMY is not set
CONFIG_SND_ALOOP=y
CONFIG_SND_VIRMIDI=y
CONFIG_SND_MTPAV=y
CONFIG_SND_MTS64=y
CONFIG_SND_SERIAL_U16550=y
CONFIG_SND_MPU401=y
CONFIG_SND_PORTMAN2X4=y
# CONFIG_SND_AC97_POWER_SAVE is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
CONFIG_SND_ALS300=y
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
CONFIG_SND_ASIHPI=y
CONFIG_SND_ATIIXP=y
CONFIG_SND_ATIIXP_MODEM=y
# CONFIG_SND_AU8810 is not set
CONFIG_SND_AU8820=y
CONFIG_SND_AU8830=y
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
CONFIG_SND_CA0106=y
CONFIG_SND_CMIPCI=y
CONFIG_SND_OXYGEN_LIB=y
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5530 is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
CONFIG_SND_DARLA24=y
CONFIG_SND_GINA24=y
# CONFIG_SND_LAYLA24 is not set
CONFIG_SND_MONA=y
CONFIG_SND_MIA=y
CONFIG_SND_ECHO3G=y
CONFIG_SND_INDIGO=y
CONFIG_SND_INDIGOIO=y
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
CONFIG_SND_INDIGODJX=y
CONFIG_SND_EMU10K1=y
CONFIG_SND_EMU10K1X=y
CONFIG_SND_ENS1370=y
# CONFIG_SND_ENS1371 is not set
CONFIG_SND_ES1938=y
# CONFIG_SND_ES1968 is not set
CONFIG_SND_FM801=y
# CONFIG_SND_FM801_TEA575X_BOOL is not set
# CONFIG_SND_HDSP is not set
CONFIG_SND_HDSPM=y
CONFIG_SND_ICE1712=y
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=y
CONFIG_SND_INTEL8X0M=y
CONFIG_SND_KORG1212=y
CONFIG_SND_LOLA=y
CONFIG_SND_LX6464ES=y
CONFIG_SND_MAESTRO3=y
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=y
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=y
CONFIG_SND_RIPTIDE=y
CONFIG_SND_RME32=y
CONFIG_SND_RME96=y
CONFIG_SND_RME9652=y
CONFIG_SND_SIS7019=y
CONFIG_SND_SONICVIBES=y
# CONFIG_SND_TRIDENT is not set
CONFIG_SND_VIA82XX=y
# CONFIG_SND_VIA82XX_MODEM is not set
CONFIG_SND_VIRTUOSO=y
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
# CONFIG_SND_HDA_INTEL is not set
CONFIG_SND_HDA_CORE=y
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=y
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_SPI=y
CONFIG_SND_SOC=y
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_AMD_ACP=y
CONFIG_SND_ATMEL_SOC=y
CONFIG_SND_DESIGNWARE_I2S=y
CONFIG_SND_DESIGNWARE_PCM=y

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
CONFIG_SND_SOC_FSL_SAI=y
CONFIG_SND_SOC_FSL_SSI=y
CONFIG_SND_SOC_FSL_SPDIF=y
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
CONFIG_SND_SOC_IMG=y
CONFIG_SND_SOC_IMG_I2S_IN=y
CONFIG_SND_SOC_IMG_I2S_OUT=y
CONFIG_SND_SOC_IMG_PARALLEL_OUT=y
CONFIG_SND_SOC_IMG_SPDIF_IN=y
CONFIG_SND_SOC_IMG_SPDIF_OUT=y
CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=y
CONFIG_SND_SST_MFLD_PLATFORM=y
CONFIG_SND_SST_IPC=y
CONFIG_SND_SST_IPC_ACPI=y
CONFIG_SND_SOC_INTEL_SST=y
CONFIG_SND_SOC_INTEL_SST_ACPI=y
CONFIG_SND_SOC_INTEL_SST_MATCH=y
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=y
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=y
# CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH is not set
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=y
CONFIG_SND_SOC_INTEL_SKYLAKE=y
# CONFIG_SND_SOC_INTEL_SKL_RT286_MACH is not set
CONFIG_SND_SOC_XTFPGA_I2S=y
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
CONFIG_SND_SOC_AC97_CODEC=y
CONFIG_SND_SOC_ADAU1701=y
CONFIG_SND_SOC_ADAU7002=y
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
CONFIG_SND_SOC_AK4642=y
# CONFIG_SND_SOC_AK5386 is not set
CONFIG_SND_SOC_ALC5623=y
CONFIG_SND_SOC_BT_SCO=y
CONFIG_SND_SOC_CS35L32=y
CONFIG_SND_SOC_CS35L33=y
# CONFIG_SND_SOC_CS35L34 is not set
CONFIG_SND_SOC_CS42L42=y
CONFIG_SND_SOC_CS42L51=y
CONFIG_SND_SOC_CS42L51_I2C=y
CONFIG_SND_SOC_CS42L52=y
CONFIG_SND_SOC_CS42L56=y
CONFIG_SND_SOC_CS42L73=y
# CONFIG_SND_SOC_CS4265 is not set
CONFIG_SND_SOC_CS4270=y
CONFIG_SND_SOC_CS4271=y
CONFIG_SND_SOC_CS4271_I2C=y
CONFIG_SND_SOC_CS4271_SPI=y
CONFIG_SND_SOC_CS42XX8=y
CONFIG_SND_SOC_CS42XX8_I2C=y
CONFIG_SND_SOC_CS4349=y
CONFIG_SND_SOC_CS53L30=y
CONFIG_SND_SOC_DA7219=y
CONFIG_SND_SOC_DMIC=y
CONFIG_SND_SOC_ES8328=y
CONFIG_SND_SOC_GTM601=y
CONFIG_SND_SOC_HDAC_HDMI=y
CONFIG_SND_SOC_INNO_RK3036=y
CONFIG_SND_SOC_MAX98357A=y
CONFIG_SND_SOC_MAX98504=y
CONFIG_SND_SOC_MAX9860=y
CONFIG_SND_SOC_MSM8916_WCD_ANALOG=y
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=y
CONFIG_SND_SOC_PCM1681=y
CONFIG_SND_SOC_PCM179X=y
CONFIG_SND_SOC_PCM179X_I2C=y
CONFIG_SND_SOC_PCM179X_SPI=y
CONFIG_SND_SOC_PCM3168A=y
# CONFIG_SND_SOC_PCM3168A_I2C is not set
CONFIG_SND_SOC_PCM3168A_SPI=y
CONFIG_SND_SOC_PCM512x=y
CONFIG_SND_SOC_PCM512x_I2C=y
# CONFIG_SND_SOC_PCM512x_SPI is not set
CONFIG_SND_SOC_RL6231=y
CONFIG_SND_SOC_RL6347A=y
CONFIG_SND_SOC_RT298=y
CONFIG_SND_SOC_RT5616=y
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5651=y
# CONFIG_SND_SOC_RT5677_SPI is not set
CONFIG_SND_SOC_SGTL5000=y
CONFIG_SND_SOC_SIGMADSP=y
CONFIG_SND_SOC_SIGMADSP_I2C=y
CONFIG_SND_SOC_SIRF_AUDIO_CODEC=y
CONFIG_SND_SOC_SPDIF=y
CONFIG_SND_SOC_SSM2602=y
CONFIG_SND_SOC_SSM2602_SPI=y
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=y
CONFIG_SND_SOC_STA32X=y
# CONFIG_SND_SOC_STA350 is not set
CONFIG_SND_SOC_STI_SAS=y
CONFIG_SND_SOC_TAS2552=y
CONFIG_SND_SOC_TAS5086=y
# CONFIG_SND_SOC_TAS571X is not set
CONFIG_SND_SOC_TAS5720=y
# CONFIG_SND_SOC_TFA9879 is not set
CONFIG_SND_SOC_TLV320AIC23=y
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
CONFIG_SND_SOC_TLV320AIC23_SPI=y
CONFIG_SND_SOC_TLV320AIC31XX=y
CONFIG_SND_SOC_TLV320AIC3X=y
CONFIG_SND_SOC_TS3A227E=y
CONFIG_SND_SOC_WM8510=y
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8580 is not set
CONFIG_SND_SOC_WM8711=y
CONFIG_SND_SOC_WM8728=y
# CONFIG_SND_SOC_WM8731 is not set
CONFIG_SND_SOC_WM8737=y
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
CONFIG_SND_SOC_WM8776=y
CONFIG_SND_SOC_WM8804=y
CONFIG_SND_SOC_WM8804_I2C=y
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
CONFIG_SND_SOC_WM8960=y
CONFIG_SND_SOC_WM8962=y
# CONFIG_SND_SOC_WM8974 is not set
CONFIG_SND_SOC_WM8978=y
CONFIG_SND_SOC_WM8985=y
CONFIG_SND_SOC_NAU8810=y
CONFIG_SND_SOC_TPA6130A2=y
# CONFIG_SND_SIMPLE_CARD is not set
# CONFIG_SOUND_PRIME is not set
CONFIG_AC97_BUS=y

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACRUX=y
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=y
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
CONFIG_HID_PRODIKEYS=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=y
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_WALTOP is not set
CONFIG_HID_GYRATION=y
# CONFIG_HID_ICADE is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_HIDPP=y
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
CONFIG_LOGIG940_FF=y
CONFIG_LOGIWHEELS_FF=y
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MAYFLASH=y
# CONFIG_HID_MICROSOFT is not set
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
# CONFIG_HID_PICOLCD_FB is not set
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
# CONFIG_HID_PICOLCD_LCD is not set
# CONFIG_HID_PICOLCD_LEDS is not set
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=y
CONFIG_HID_SAITEK=y
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SPEEDLINK=y
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=y
CONFIG_SMARTJOYPLUS_FF=y
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_THINGM=y
CONFIG_HID_THRUSTMASTER=y
CONFIG_THRUSTMASTER_FF=y
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_WACOM=y
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
CONFIG_HID_ALPS=y

#
# I2C HID support
#
CONFIG_I2C_HID=y
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_USB_PHY is not set
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# CONFIG_USB_GADGET is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=y
CONFIG_UWB_WHCI=y
CONFIG_MMC=y
# CONFIG_MMC_DEBUG is not set
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_PCI=y
# CONFIG_MMC_RICOH_MMC is not set
CONFIG_MMC_SDHCI_ACPI=y
# CONFIG_MMC_SDHCI_PLTFM is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=y
CONFIG_MMC_CB710=y
CONFIG_MMC_VIA_SDMMC=y
CONFIG_MMC_USDHI6ROL0=y
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=y
CONFIG_MEMSTICK_JMICRON_38X=y
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set

#
# LED drivers
#
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_NET48XX=y
CONFIG_LEDS_WRAP=y
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_CLEVO_MAIL is not set
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM8350 is not set
CONFIG_LEDS_DAC124S085=y
CONFIG_LEDS_PWM=y
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=y
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=y
CONFIG_LEDS_MENF21BMC=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_GPIO=y
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_ACCESSIBILITY is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
CONFIG_EDAC_DEBUG=y
CONFIG_EDAC_MM_EDAC=y
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD76X=y
CONFIG_EDAC_E7XXX=y
CONFIG_EDAC_E752X=y
CONFIG_EDAC_I82875P=y
# CONFIG_EDAC_I82975X is not set
CONFIG_EDAC_I3000=y
# CONFIG_EDAC_I3200 is not set
CONFIG_EDAC_IE31200=y
CONFIG_EDAC_X38=y
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I82860 is not set
CONFIG_EDAC_R82600=y
CONFIG_EDAC_I5000=y
CONFIG_EDAC_I5100=y
# CONFIG_EDAC_I7300 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
# CONFIG_DMADEVICES_VDEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_INTEL_IDMA64=y
# CONFIG_PCH_DMA is not set
CONFIG_TIMB_DMA=y
# CONFIG_QCOM_HIDMA_MGMT is not set
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
# CONFIG_DW_DMAC_PCI is not set

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
CONFIG_DMATEST=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_AUXDISPLAY=y
CONFIG_IMG_ASCII_LCD=y
# CONFIG_UIO is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VIRTIO=y

#
# Virtio drivers
#
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=y
CONFIG_ACERHDF=y
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=y
# CONFIG_DELL_WMI_AIO is not set
# CONFIG_DELL_SMO8800 is not set
CONFIG_FUJITSU_LAPTOP=y
# CONFIG_FUJITSU_LAPTOP_DEBUG is not set
CONFIG_FUJITSU_TABLET=y
CONFIG_TC1100_WMI=y
# CONFIG_HP_ACCEL is not set
CONFIG_HP_WIRELESS=y
# CONFIG_HP_WMI is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_SURFACE3_WMI is not set
CONFIG_THINKPAD_ACPI=y
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
# CONFIG_THINKPAD_ACPI_VIDEO is not set
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_SENSORS_HDAPS is not set
CONFIG_ASUS_WIRELESS=y
CONFIG_ACPI_WMI=y
CONFIG_MSI_WMI=y
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
CONFIG_TOSHIBA_HAPS=y
CONFIG_TOSHIBA_WMI=y
CONFIG_ACPI_CMPC=y
CONFIG_INTEL_HID_EVENT=y
# CONFIG_INTEL_VBTN is not set
CONFIG_INTEL_IPS=y
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=y
CONFIG_MXM_WMI=y
CONFIG_SAMSUNG_Q10=y
CONFIG_APPLE_GMUX=y
# CONFIG_INTEL_RST is not set
CONFIG_INTEL_SMARTCONNECT=y
CONFIG_PVPANIC=y
# CONFIG_INTEL_PMC_IPC is not set
CONFIG_SURFACE_PRO3_BUTTON=y
CONFIG_INTEL_PUNIT_IPC=y
# CONFIG_MLX_CPLD_PLATFORM is not set
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=y
# CONFIG_CHROMEOS_PSTORE is not set
CONFIG_CROS_EC_CHARDEV=y
CONFIG_CROS_EC_LPC=y
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_SCPI=y
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_COMMON_CLK_S2MPS11=y
CONFIG_CLK_TWL6040=y
# CONFIG_COMMON_CLK_NXP is not set
# CONFIG_COMMON_CLK_PALMAS is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set
CONFIG_COMMON_CLK_MEDIATEK=y
CONFIG_COMMON_CLK_MT2701=y
CONFIG_COMMON_CLK_MT2701_MMSYS=y
# CONFIG_COMMON_CLK_MT2701_IMGSYS is not set
CONFIG_COMMON_CLK_MT2701_VDECSYS=y
# CONFIG_COMMON_CLK_MT2701_HIFSYS is not set
# CONFIG_COMMON_CLK_MT2701_ETHSYS is not set
# CONFIG_COMMON_CLK_MT2701_BDPSYS is not set

#
# Hardware Spinlock drivers
#

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
CONFIG_MAILBOX=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y

#
# Rpmsg drivers
#

#
# SOC (System On Chip) specific Drivers
#

#
# Broadcom SoC drivers
#
# CONFIG_SUNXI_SRAM is not set
CONFIG_SOC_TI=y
# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ARIZONA is not set
# CONFIG_EXTCON_GPIO is not set
CONFIG_EXTCON_MAX14577=y
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_MAX77693 is not set
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_PALMAS=y
CONFIG_EXTCON_QCOM_SPMI_MISC=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_MEMORY=y
# CONFIG_IIO is not set
CONFIG_NTB=y
CONFIG_NTB_PINGPONG=y
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=y
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_CRC=y
CONFIG_PWM_CROS_EC=y
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=y
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=y
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
CONFIG_SERIAL_IPOCTAL=y
# CONFIG_RESET_CONTROLLER is not set
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=y
CONFIG_FMC_TRIVIAL=y
CONFIG_FMC_WRITE_EEPROM=y
CONFIG_FMC_CHARDEV=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
CONFIG_ANDROID=y
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDER_IPC_32BIT=y
CONFIG_NVMEM=y
CONFIG_STM=y
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_GTH is not set
CONFIG_INTEL_TH_STH=y
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=y
# CONFIG_INTEL_TH_DEBUG is not set

#
# FPGA Configuration Support
#
CONFIG_FPGA=y

#
# Firmware Drivers
#
CONFIG_ARM_SCPI_PROTOCOL=y
# CONFIG_ARM_SCPI_POWER_DOMAIN is not set
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=y
# CONFIG_DCDBAS is not set
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_GOOGLE_FIRMWARE=y

#
# Google Firmware Drivers
#
CONFIG_GOOGLE_MEMCONSOLE=y
CONFIG_UEFI_CPER=y
# CONFIG_EFI_DEV_PATH_PARSER is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTACTL is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
# CONFIG_ECRYPT_FS is not set
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
CONFIG_JFFS2_SUMMARY=y
# CONFIG_JFFS2_FS_XATTR is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
# CONFIG_JFFS2_LZO is not set
CONFIG_JFFS2_RTIME=y
# CONFIG_JFFS2_RUBIN is not set
CONFIG_ROMFS_FS=y
CONFIG_ROMFS_BACKED_BY_MTD=y
CONFIG_ROMFS_ON_MTD=y
CONFIG_PSTORE=y
# CONFIG_PSTORE_ZLIB_COMPRESS is not set
# CONFIG_PSTORE_LZO_COMPRESS is not set
CONFIG_PSTORE_LZ4_COMPRESS=y
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
CONFIG_PSTORE_RAM=y
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
# CONFIG_DEBUG_INFO is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_ARCH_WANT_FRAME_POINTERS=y
CONFIG_FRAME_POINTER=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_POISONING=y
# CONFIG_PAGE_POISONING_NO_SANITY is not set
CONFIG_PAGE_POISONING_ZERO=y
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_VMACACHE=y
CONFIG_DEBUG_VM_RB=y
CONFIG_DEBUG_VM_PGFLAGS=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_DEBUG_PER_CPU_MAPS=y
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_HAVE_ARCH_KMEMCHECK=y
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=1
# CONFIG_WQ_WATCHDOG is not set
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHED_INFO is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_TIMER_STATS is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
# CONFIG_DEBUG_RT_MUTEXES is not set
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
CONFIG_DEBUG_LOCK_ALLOC=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCKDEP=y
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
# CONFIG_PROVE_RCU is not set
# CONFIG_SPARSE_RCU_POINTER is not set
CONFIG_TORTURE_TEST=y
CONFIG_RCU_PERF_TEST=y
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set

#
# Runtime Testing
#
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_TEST_HEXDUMP=y
CONFIG_TEST_STRING_HELPERS=y
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=y
CONFIG_TEST_BITMAP=y
CONFIG_TEST_UUID=y
CONFIG_TEST_RHASHTABLE=y
# CONFIG_TEST_HASH is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_UDELAY=y
# CONFIG_MEMTEST is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_DEBUG_WX=y
# CONFIG_DOUBLEFAULT is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_IOMMU_STRESS=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
CONFIG_IO_DELAY_UDELAY=y
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=2
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
CONFIG_PUNIT_ATOM_DEBUG=y

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_HAVE_ARCH_HARDENED_USERCOPY=y
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_ABLK_HELPER=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_586=y
# CONFIG_CRYPTO_AES_NI_INTEL is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_SALSA20_586=y
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# CONFIG_CRYPTO_TWOFISH_586 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
CONFIG_CRYPTO_DEV_PADLOCK_AES=y
CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
CONFIG_CRYPTO_DEV_GEODE=y
# CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_DESC is not set
# CONFIG_CRYPTO_DEV_CCP is not set
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
CONFIG_CRYPTO_DEV_QAT_C62X=y
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
CONFIG_CRYPTO_DEV_VIRTIO=y
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_VHOST_NET is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_IO=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC7=y
# CONFIG_LIBCRC32C is not set
CONFIG_CRC8=y
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
# CONFIG_CPUMASK_OFFSTACK is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=y
CONFIG_DDR=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
# CONFIG_SG_SPLIT is not set
# CONFIG_SG_POOL is not set
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_MMIO_FLUSH=y
# CONFIG_PRIME_NUMBERS is not set

--2efbkydmiu3cpayg
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--2efbkydmiu3cpayg--
