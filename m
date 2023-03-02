Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E09C678D4
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 13:38:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43D8810E4FF;
	Thu,  2 Mar 2023 13:38:20 +0000 (UTC)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A98FB10E4FF
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 13:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1677764297; x=1709300297;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=6OYAiwfks4OjPCRq90r/EYamEUUaDRkmJG0efQwfQyw=;
 b=gxxMFmO8rBOivnl/YsLA5KtB+Vz5/nEjxpmholrBgCBLKL4+IQD3x5WG
 xq8Vwv7/9e9Prm+xzkTjVEtpsXwQiikqUt5Ji2xzuadjBGbJDHLoRhbFY
 KCB7QtpvqeBgbpPQvi1QhxI/HheVdHpfK4Urf3RSDiGH7Es+pU5CYtnRv
 12B7vX6PROx0zrMcs1/Q01wP3Rl0FI9Lcw3ao3HqpNMGUaKXIr6+4lrru
 /UY1d+EE21El+i4Po+SR1VxkQOJrZmtAsQBkLr0UQDaL6pbZ9tif4LuPz
 +AyoC7ucPZweCGYbSNMHtuwWnO9JciTP1RrwbG+23mxYtfofIBWUYwo7b g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="397285720"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; d="scan'208";a="397285720"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2023 05:38:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="798826399"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; d="scan'208";a="798826399"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 02 Mar 2023 05:38:15 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pXj8Q-0000Uu-19;
 Thu, 02 Mar 2023 13:38:14 +0000
Date: Thu, 02 Mar 2023 21:37:52 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [linux-next:master] BUILD REGRESSION
 26a4eaba02f7f917fc1340553b49a7efd419c730
Message-ID: <6400a6b0.IdTGL2f2FP1n7kHl%lkp@intel.com>
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
 linux-usb@vger.kernel.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 26a4eaba02f7f917fc1340553b49a7efd419c730  Add linux-next specific files for 20230302

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202302111601.jtY4lKrA-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202302192254.EGOAcwpm-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.c:294:6: warning: no previous prototype for 'optc3_wait_drr_doublebuffer_pending_clear' [-Wmissing-prototypes]
fsl-edma.c:(.text+0xf58): undefined reference to `devm_platform_ioremap_resource'
idma64.c:(.text+0x1dec): undefined reference to `devm_platform_ioremap_resource'
s390-linux-ld: fsl-edma.c:(.text+0x1026): undefined reference to `devm_platform_ioremap_resource'

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/usb/gadget/composite.c:2082:33: sparse: sparse: restricted __le16 degrades to integer

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dcn30-dcn30_optc.c:warning:no-previous-prototype-for-optc3_wait_drr_doublebuffer_pending_clear
|-- i386-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dcn30-dcn30_optc.c:warning:no-previous-prototype-for-optc3_wait_drr_doublebuffer_pending_clear
|-- powerpc-randconfig-s051-20230302
|   `-- drivers-usb-gadget-composite.c:sparse:sparse:restricted-__le16-degrades-to-integer
|-- s390-randconfig-r031-20230302
|   |-- fsl-edma.c:(.text):undefined-reference-to-devm_platform_ioremap_resource
|   |-- idma64.c:(.text):undefined-reference-to-devm_platform_ioremap_resource
|   `-- s390-linux-ld:fsl-edma.c:(.text):undefined-reference-to-devm_platform_ioremap_resource
|-- x86_64-allnoconfig
|   `-- Warning:Documentation-devicetree-bindings-usb-rockchip-dwc3.yaml-references-a-file-that-doesn-t-exist:Documentation-devicetree-bindings-phy-phy-rockchip-inno-usb2.yaml
`-- x86_64-allyesconfig
    `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dcn30-dcn30_optc.c:warning:no-previous-prototype-for-optc3_wait_drr_doublebuffer_pending_clear

elapsed time: 728m

configs tested: 109
configs skipped: 5

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r021-20230302   gcc  
alpha                randconfig-r023-20230302   gcc  
alpha                randconfig-r036-20230302   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230302   gcc  
arc                  randconfig-r043-20230302   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r004-20230302   gcc  
arm                                 defconfig   gcc  
arm                         orion5x_defconfig   clang
arm                  randconfig-r015-20230302   gcc  
arm                  randconfig-r046-20230302   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r016-20230302   gcc  
csky                 randconfig-r022-20230302   gcc  
csky                 randconfig-r024-20230302   gcc  
hexagon              randconfig-r025-20230302   clang
hexagon              randconfig-r041-20230302   clang
hexagon              randconfig-r045-20230302   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r012-20230302   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r033-20230302   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230302   gcc  
m68k                 randconfig-r006-20230302   gcc  
m68k                 randconfig-r013-20230302   gcc  
m68k                 randconfig-r014-20230302   gcc  
microblaze   buildonly-randconfig-r001-20230302   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r005-20230302   clang
mips                      pic32mzda_defconfig   clang
nios2                               defconfig   gcc  
parisc       buildonly-randconfig-r003-20230302   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r035-20230302   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc              randconfig-r034-20230302   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r042-20230302   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230302   clang
s390                                defconfig   gcc  
s390                 randconfig-r005-20230302   gcc  
s390                 randconfig-r026-20230302   clang
s390                 randconfig-r031-20230302   gcc  
s390                 randconfig-r044-20230302   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r006-20230302   gcc  
sh                   randconfig-r003-20230302   gcc  
sh                            titan_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230302   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa                       common_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
