Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AAFC7EE23
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 16:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFFFE10E362;
	Mon, 22 May 2023 16:02:54 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34EA410E362
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 16:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684771373; x=1716307373;
 h=date:from:to:cc:subject:message-id;
 bh=YcKsNrZzbYoapgP2WalAuZDGoxvQoitEkp4ZslZrvY0=;
 b=ndvNs+oIsVs//mmJP/l4j5IJLT6+mj5AJ9whG4RyqQNJSP/Q8e5FDaTE
 ieelr24zQFwn5GQkHYvCquWg3+E40sRucvXgRBa7z8b7njQxDsQbjtV1w
 PVG5BXstfP/DCA51tbKMe9JyGN6+9+mucjQq+CwLtjepXGzfLQHSjsy7V
 Pu8iZLSE5+3lh/KpGI6wt18pc//NwqYWmDautXfbp8TXqQkEnw93RLKfP
 Hdi+mjP2p/ecM0syRdr79j0NSPBBBXD4KKFu7IMOrdUajzVhkt5YTzTlU
 0zURjYVICjSmUjnNFSE8VgzOz/ruN4AwG1CTgW6BSsiPHOaydGFysdgPM A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="337548597"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; d="scan'208";a="337548597"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2023 09:02:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="773427999"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; d="scan'208";a="773427999"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
 by fmsmga004.fm.intel.com with ESMTP; 22 May 2023 09:02:48 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1q17zk-000CyJ-0L;
 Mon, 22 May 2023 16:02:48 +0000
Date: Tue, 23 May 2023 00:01:55 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [linux-next:master] BUILD SUCCESS WITH WARNING
 9f258af06b6268be8e960f63c3f66e88bdbbbdb0
Message-ID: <20230522160155.au0hJ%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: linux-xfs@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-perf-users@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

tree/branch: INFO setup_repo_specs: /db/releases/20230522162832/lkp-src/repo/*/linux-next
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 9f258af06b6268be8e960f63c3f66e88bdbbbdb0  Add linux-next specific files for 20230522

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202305132244.DwzBUcUd-lkp@intel.com

Warning: (recently discovered and may have been fixed)

drivers/base/regmap/regcache-maple.c:113:23: warning: 'lower_index' is used uninitialized [-Wuninitialized]
drivers/base/regmap/regcache-maple.c:113:36: warning: 'lower_last' is used uninitialized [-Wuninitialized]
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6396:21: warning: variable 'count' set but not used [-Wunused-but-set-variable]

Unverified Warning (likely false positive, please contact us if interested):

arch/arm64/kvm/mmu.c:147:3-9: preceding lock on line 140
fs/xfs/scrub/fscounters.c:459 xchk_fscounters() warn: ignoring unreachable code.
kernel/events/uprobes.c:478 uprobe_write_opcode() warn: passing zero to 'PTR_ERR'
kernel/watchdog.c:40:19: sparse: sparse: symbol 'watchdog_hardlockup_user_enabled' was not declared. Should it be static?
kernel/watchdog.c:41:19: sparse: sparse: symbol 'watchdog_softlockup_user_enabled' was not declared. Should it be static?

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|-- arc-allyesconfig
|   |-- drivers-base-regmap-regcache-maple.c:warning:lower_index-is-used-uninitialized
|   |-- drivers-base-regmap-regcache-maple.c:warning:lower_last-is-used-uninitialized
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|-- arc-buildonly-randconfig-r001-20230522
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|-- arm-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|-- arm-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|-- arm-randconfig-r036-20230521
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|-- arm64-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|-- arm64-randconfig-c041-20230521
|   `-- arch-arm64-kvm-mmu.c:preceding-lock-on-line
|-- arm64-randconfig-s053-20230521
|   `-- mm-kfence-core.c:sparse:sparse:cast-to-restricted-__le64
|-- i386-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|-- i386-randconfig-m021
|   `-- kernel-events-uprobes.c-uprobe_write_opcode()-warn:passing-zero-to-PTR_ERR
|-- ia64-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|-- ia64-randconfig-m041-20230521
|   `-- fs-xfs-scrub-fscounters.c-xchk_fscounters()-warn:ignoring-unreachable-code.
|-- loongarch-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|-- loongarch-defconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|-- loongarch-randconfig-r033-20230522
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|-- mips-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|-- mips-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|-- powerpc-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|-- riscv-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|-- riscv-randconfig-r042-20230521
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|-- s390-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|-- s390-randconfig-s042-20230521
|   `-- mm-kfence-core.c:sparse:sparse:cast-to-restricted-__le64
|-- sparc-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|-- sparc-randconfig-s052-20230521
|   |-- kernel-watchdog.c:sparse:sparse:symbol-watchdog_hardlockup_user_enabled-was-not-declared.-Should-it-be-static
|   `-- kernel-watchdog.c:sparse:sparse:symbol-watchdog_softlockup_user_enabled-was-not-declared.-Should-it-be-static
|-- sparc64-randconfig-r016-20230521
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|-- x86_64-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|-- x86_64-randconfig-m001
|   `-- kernel-events-uprobes.c-uprobe_write_opcode()-warn:passing-zero-to-PTR_ERR
|-- x86_64-randconfig-s021
|   |-- kernel-watchdog.c:sparse:sparse:symbol-watchdog_hardlockup_user_enabled-was-not-declared.-Should-it-be-static
|   `-- kernel-watchdog.c:sparse:sparse:symbol-watchdog_softlockup_user_enabled-was-not-declared.-Should-it-be-static
`-- x86_64-randconfig-s022
    |-- kernel-watchdog.c:sparse:sparse:symbol-watchdog_hardlockup_user_enabled-was-not-declared.-Should-it-be-static
    `-- kernel-watchdog.c:sparse:sparse:symbol-watchdog_softlockup_user_enabled-was-not-declared.-Should-it-be-static

elapsed time: 722m

configs tested: 166
configs skipped: 12

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230522   gcc  
alpha                randconfig-r011-20230522   gcc  
alpha                randconfig-r024-20230522   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230522   gcc  
arc          buildonly-randconfig-r003-20230522   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                  randconfig-r023-20230522   gcc  
arc                  randconfig-r043-20230521   gcc  
arc                  randconfig-r043-20230522   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                           omap1_defconfig   clang
arm                  randconfig-r035-20230521   gcc  
arm                  randconfig-r036-20230521   gcc  
arm                  randconfig-r046-20230521   clang
arm                  randconfig-r046-20230522   gcc  
arm                          sp7021_defconfig   clang
arm                    vt8500_v6_v7_defconfig   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r006-20230522   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r016-20230522   clang
csky         buildonly-randconfig-r004-20230521   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r012-20230521   gcc  
hexagon              randconfig-r002-20230522   clang
hexagon              randconfig-r006-20230521   clang
hexagon              randconfig-r024-20230521   clang
hexagon              randconfig-r041-20230521   clang
hexagon              randconfig-r041-20230522   clang
hexagon              randconfig-r045-20230521   clang
hexagon              randconfig-r045-20230522   clang
i386                              allnoconfig   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230522   gcc  
i386                 randconfig-a002-20230522   gcc  
i386                 randconfig-a003-20230522   gcc  
i386                 randconfig-a004-20230522   gcc  
i386                 randconfig-a005-20230522   gcc  
i386                 randconfig-a006-20230522   gcc  
i386                 randconfig-a011-20230522   clang
i386                 randconfig-a012-20230522   clang
i386                 randconfig-a013-20230522   clang
i386                 randconfig-a014-20230522   clang
i386                 randconfig-a015-20230522   clang
i386                 randconfig-a016-20230522   clang
i386                 randconfig-r003-20230522   gcc  
i386                 randconfig-r026-20230522   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r005-20230522   gcc  
ia64                          tiger_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r033-20230522   gcc  
m68k                             allmodconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r014-20230522   gcc  
m68k                 randconfig-r034-20230521   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                        qi_lb60_defconfig   clang
mips                 randconfig-r022-20230522   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230522   gcc  
nios2                randconfig-r031-20230522   gcc  
nios2                randconfig-r032-20230521   gcc  
openrisc     buildonly-randconfig-r002-20230521   gcc  
openrisc                  or1klitex_defconfig   gcc  
openrisc             randconfig-r002-20230521   gcc  
parisc       buildonly-randconfig-r002-20230522   gcc  
parisc       buildonly-randconfig-r004-20230522   gcc  
parisc       buildonly-randconfig-r006-20230521   gcc  
parisc                              defconfig   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc                      chrp32_defconfig   gcc  
powerpc                     ksi8560_defconfig   clang
powerpc                     mpc512x_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc              randconfig-r033-20230521   clang
powerpc                     skiroot_defconfig   clang
powerpc                     tqm5200_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r005-20230521   clang
riscv                randconfig-r042-20230521   gcc  
riscv                randconfig-r042-20230522   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230521   clang
s390                 randconfig-r004-20230521   clang
s390                 randconfig-r011-20230521   gcc  
s390                 randconfig-r013-20230521   gcc  
s390                 randconfig-r023-20230521   gcc  
s390                 randconfig-r034-20230522   gcc  
s390                 randconfig-r044-20230521   gcc  
s390                 randconfig-r044-20230522   clang
sh                               allmodconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh           buildonly-randconfig-r003-20230521   gcc  
sh                   randconfig-r015-20230521   gcc  
sh                   randconfig-r021-20230521   gcc  
sh                           se7722_defconfig   gcc  
sparc        buildonly-randconfig-r005-20230521   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230522   gcc  
sparc                randconfig-r026-20230521   gcc  
sparc                randconfig-r035-20230522   gcc  
sparc64              randconfig-r001-20230521   gcc  
sparc64              randconfig-r016-20230521   gcc  
sparc64              randconfig-r025-20230521   gcc  
sparc64              randconfig-r031-20230521   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230522   gcc  
x86_64               randconfig-a002-20230522   gcc  
x86_64               randconfig-a003-20230522   gcc  
x86_64               randconfig-a004-20230522   gcc  
x86_64               randconfig-a005-20230522   gcc  
x86_64               randconfig-a006-20230522   gcc  
x86_64               randconfig-a011-20230522   clang
x86_64               randconfig-a012-20230522   clang
x86_64               randconfig-a013-20230522   clang
x86_64               randconfig-a014-20230522   clang
x86_64               randconfig-a015-20230522   clang
x86_64               randconfig-a016-20230522   clang
x86_64               randconfig-r013-20230522   clang
x86_64               randconfig-x051-20230522   clang
x86_64               randconfig-x052-20230522   clang
x86_64               randconfig-x053-20230522   clang
x86_64               randconfig-x054-20230522   clang
x86_64               randconfig-x055-20230522   clang
x86_64               randconfig-x056-20230522   clang
x86_64               randconfig-x061-20230522   clang
x86_64               randconfig-x062-20230522   clang
x86_64               randconfig-x063-20230522   clang
x86_64               randconfig-x064-20230522   clang
x86_64               randconfig-x065-20230522   clang
x86_64               randconfig-x066-20230522   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r022-20230521   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
