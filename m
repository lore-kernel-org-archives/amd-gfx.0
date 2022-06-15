Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3971C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jun 2022 19:50:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EF36112B01;
	Wed, 15 Jun 2022 19:50:04 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2645E112AF0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 19:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655322603; x=1686858603;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=jBZXiGn2WqVLxecW6QE1v9L/SpOLkZw3RsnqZsFZLFU=;
 b=I3Pzp1XQNFg4Nzow2c/bD8WIfnowE5GdkqT+Sc3a2k5NInMeywUvlnTT
 vqHObR/uugyG2ZIVGUBbXNSRRE5S/66Zc5pGpxygSXx6UZnhJQLaDHImc
 plBj+oOOvs1MUmbNuOhK5jQvQaaDHec+YRFCUM5qXBOBys8vdyYA4fwAE
 KaiZNWYvVTkl7uoAJVPmPhSMCNRsURKp6dtIdBJsQkzcOONvFFrd7rQfm
 bQB5kKo+n1e85KMWUmwl+F3Ty1Ftn/OZSD2fqe5qXMx/S/klarc5xCl2U
 tTKz1j64ayXo3E69SR4jVenLxQgAlVrRQKTF7ThOt3nDxcLT6Av4C2v2I w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="280122070"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; d="scan'208";a="280122070"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2022 12:49:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; d="scan'208";a="713095483"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 15 Jun 2022 12:49:50 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1o1Z1R-000N8u-To;
 Wed, 15 Jun 2022 19:49:49 +0000
Date: Thu, 16 Jun 2022 03:49:02 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [linux-next:master] BUILD SUCCESS
 6012273897fefb12566580efedee10bb06e5e6ed
Message-ID: <62aa37ae.yalJnDwm6FNPklVK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 linux-staging@lists.linux.dev, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 6012273897fefb12566580efedee10bb06e5e6ed  Add linux-next specific files for 20220615

Warning reports:

https://lore.kernel.org/llvm/202206151803.AN0dJvGe-lkp@intel.com
https://lore.kernel.org/llvm/202206152336.qCDzjUHG-lkp@intel.com
https://lore.kernel.org/llvm/202206160206.7v6ivUDZ-lkp@intel.com

Unverified Warning (likely false positive, please contact us if interested):

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9139:27: warning: variable 'abo' set but not used [-Wunused-but-set-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- ia64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- ia64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- m68k-allmodconfig
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- m68k-allyesconfig
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- mips-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- nios2-allyesconfig
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- parisc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- powerpc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- riscv-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- s390-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|-- sh-allmodconfig
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- sparc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
`-- xtensa-allyesconfig
    |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
    `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used

clang_recent_errors
`-- x86_64-randconfig-a005-20220613
    |-- vmlinux.o:warning:objtool:__ct_user_enter:call-to-ftrace_likely_update()-leaves-.noinstr.text-section
    |-- vmlinux.o:warning:objtool:ct_idle_enter:call-to-ftrace_likely_update()-leaves-.noinstr.text-section
    |-- vmlinux.o:warning:objtool:ct_idle_exit:call-to-ftrace_likely_update()-leaves-.noinstr.text-section
    |-- vmlinux.o:warning:objtool:ct_irq_enter:call-to-ftrace_likely_update()-leaves-.noinstr.text-section
    |-- vmlinux.o:warning:objtool:ct_irq_exit:call-to-ftrace_likely_update()-leaves-.noinstr.text-section
    `-- vmlinux.o:warning:objtool:ct_nmi_enter:call-to-ftrace_likely_update()-leaves-.noinstr.text-section

elapsed time: 809m

configs tested: 55
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
arc                                 defconfig
h8300                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
nios2                               defconfig
arc                              allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
parisc64                            defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
