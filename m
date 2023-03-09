Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE207C64EC4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Mar 2023 15:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B608B10E84E;
	Thu,  9 Mar 2023 15:08:53 +0000 (UTC)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2695410E84C
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Mar 2023 15:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1678374531; x=1709910531;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=+CEGkxWLU/S8mn45ZTds+4lIJE2/zfMR+AlnzPAxGdE=;
 b=ZJHzR/jPRP+mR3LSdLPkIUEv+emNLPqGpGK1toFhR7aLANeZQBRzLXJW
 d/YDPxv3K9kjMI5Dg/ZxUp2pgq/LBU4vDe8AdhKLO+h9CN5j/BDsosPQ9
 ktPGkLsEils/8magrJoiVX17ljcMZWOm81Hov64CXw3cP26fCr28tiWDv
 X/agVWi89aq+tEvFvEM1XrRU5WXnau9Q1K4cTotvn5D3/F9DVSX6TqBiT
 06xhPnuqn933Q8WTquHxq+ELAahzx92K8NevFhcRAwz9Ws8ZYvj3RibXv
 5ieHxfVZIhsYItwajqZkDd8f0G2ninScMiMgJNdR4ZkXpm0CTzX4dh0ok g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="338006682"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; d="scan'208";a="338006682"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2023 06:37:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="707633256"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; d="scan'208";a="707633256"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
 by orsmga008.jf.intel.com with ESMTP; 09 Mar 2023 06:37:27 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1paHOY-00031I-2n;
 Thu, 09 Mar 2023 14:37:26 +0000
Date: Thu, 09 Mar 2023 22:36:55 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [linux-next:master] BUILD REGRESSION
 2c6433e9294b6d0f4d8f08c3c70a3eac434d3ec8
Message-ID: <6409ef07.MijoGslGE1Kw16lB%lkp@intel.com>
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
Cc: linux-gpio@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Linux Memory Management List <linux-mm@kvack.org>, asahi@lists.linux.dev,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 2c6433e9294b6d0f4d8f08c3c70a3eac434d3ec8  Add linux-next specific files for 20230309

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202302111601.jtY4lKrA-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303081657.6Ble80UY-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303081807.lBLWKmpX-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303082135.NjdX1Bij-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303091430.hbWEMt4b-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303091435.ae36t8f6-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303091548.VqmH7I6Q-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303091711.howZNrIY-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303091728.UUe6LWye-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303092022.Jqy5pbvx-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "intel_soc_pmic_exec_mipi_pmic_seq_element" [drivers/platform/x86/x86-android-tablets/x86-android-tablets.ko] undefined!
drivers/clk/mvebu/kirkwood.c:358:1: error: expected identifier or '('
drivers/clk/mvebu/kirkwood.c:358:1: error: invalid digit 'd' in decimal constant
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.c:294:6: warning: no previous prototype for 'optc3_wait_drr_doublebuffer_pending_clear' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capability.c:2184: warning: expecting prototype for Check if there is a native DP or passive DP(). Prototype was for dp_is_sink_present() instead
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_6_ppt.c:1146:3: warning: variable 'hotspotlimit' is uninitialized when used here [-Wuninitialized]
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_6_ppt.c:1149:24: warning: variable 'memlimit' is uninitialized when used here [-Wuninitialized]
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_6_ppt.c:1152:34: warning: variable 'software_shutdown_temp' is uninitialized when used here [-Wuninitialized]
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_6_ppt.c:315:17: sparse:    int
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_6_ppt.c:315:17: sparse:    void
include/linux/dynamic_debug.h:307:14: error: implicit declaration of function 'strcmp' [-Werror=implicit-function-declaration]
kismet: WARNING: unmet direct dependencies detected for GPIO_SYSCON when selected by GPIO_SAMA5D2_PIOBU
kismet: WARNING: unmet direct dependencies detected for MFD_STMFX when selected by PINCTRL_STMFX
kismet: WARNING: unmet direct dependencies detected for OF_GPIO when selected by GPIO_LOONGSON_64BIT

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/iommu/apple-dart.c:1281:1: sparse: sparse: symbol 'apple_dart_pm_ops' was not declared. Should it be static?
include/linux/gpio/consumer.h: linux/err.h is included more than once.
include/linux/gpio/driver.h: asm/bug.h is included more than once.

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_capability.c:warning:expecting-prototype-for-Check-if-there-is-a-native-DP-or-passive-DP().-Prototype-was-for-dp_is_sink_present()-inste
|-- arc-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_capability.c:warning:expecting-prototype-for-Check-if-there-is-a-native-DP-or-passive-DP().-Prototype-was-for-dp_is_sink_present()-inste
|-- arm-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_capability.c:warning:expecting-prototype-for-Check-if-there-is-a-native-DP-or-passive-DP().-Prototype-was-for-dp_is_sink_present()-inste
|-- arm-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_capability.c:warning:expecting-prototype-for-Check-if-there-is-a-native-DP-or-passive-DP().-Prototype-was-for-dp_is_sink_present()-inste
|-- arm-randconfig-r005-20230309
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_capability.c:warning:expecting-prototype-for-Check-if-there-is-a-native-DP-or-passive-DP().-Prototype-was-for-dp_is_sink_present()-inste
|-- arm-randconfig-r013-20230308
|   `-- include-linux-dynamic_debug.h:error:implicit-declaration-of-function-strcmp
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dcn30-dcn30_optc.c:warning:no-previous-prototype-for-optc3_wait_drr_doublebuffer_pending_clear
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_capability.c:warning:expecting-prototype-for-Check-if-there-is-a-native-DP-or-passive-DP().-Prototype-was-for-dp_is_sink_present()-inste
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dcn30-dcn30_optc.c:warning:no-previous-prototype-for-optc3_wait_drr_doublebuffer_pending_clear
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_capability.c:warning:expecting-prototype-for-Check-if-there-is-a-native-DP-or-passive-DP().-Prototype-was-for-dp_is_sink_present()-inste
|-- i386-randconfig-a016-20230206
|   `-- ERROR:intel_soc_pmic_exec_mipi_pmic_seq_element-drivers-platform-x86-x86-android-tablets-x86-android-tablets.ko-undefined
|-- ia64-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_capability.c:warning:expecting-prototype-for-Check-if-there-is-a-native-DP-or-passive-DP().-Prototype-was-for-dp_is_sink_present()-inste
|-- loongarch-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_capability.c:warning:expecting-prototype-for-Check-if-there-is-a-native-DP-or-passive-DP().-Prototype-was-for-dp_is_sink_present()-inste
|-- loongarch-buildonly-randconfig-r004-20230308
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_capability.c:warning:expecting-prototype-for-Check-if-there-is-a-native-DP-or-passive-DP().-Prototype-was-for-dp_is_sink_present()-inste
|-- loongarch-defconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_capability.c:warning:expecting-prototype-for-Check-if-there-is-a-native-DP-or-passive-DP().-Prototype-was-for-dp_is_sink_present()-inste
|-- microblaze-randconfig-s041-20230309
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_capability.c:warning:expecting-prototype-for-Check-if-there-is-a-native-DP-or-passive-DP().-Prototype-was-for-dp_is_sink_present()-inste
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-swsmu-smu13-smu_v13_0_6_ppt.c:sparse:int
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-swsmu-smu13-smu_v13_0_6_ppt.c:sparse:sparse:incompatible-types-in-conditional-expression-(different-base-types):
|   `-- drivers-gpu-drm-amd-amdgpu-..-pm-swsmu-smu13-smu_v13_0_6_ppt.c:sparse:void
|-- mips-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_capability.c:warning:expecting-prototype-for-Check-if-there-is-a-native-DP-or-passive-DP().-Prototype-was-for-dp_is_sink_present()-inste
|-- mips-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_capability.c:warning:expecting-prototype-for-Check-if-there-is-a-native-DP-or-passive-DP().-Prototype-was-for-dp_is_sink_present()-inste
|-- powerpc-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_capability.c:warning:expecting-prototype-for-Check-if-there-is-a-native-DP-or-passive-DP().-Prototype-was-for-dp_is_sink_present()-inste
|-- riscv-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_capability.c:warning:expecting-prototype-for-Check-if-there-is-a-native-DP-or-passive-DP().-Prototype-was-for-dp_is_sink_present()-inste
|-- riscv-randconfig-s043-20230309
|   `-- drivers-iommu-apple-dart.c:sparse:sparse:symbol-apple_dart_pm_ops-was-not-declared.-Should-it-be-static
|-- s390-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_capability.c:warning:expecting-prototype-for-Check-if-there-is-a-native-DP-or-passive-DP().-Prototype-was-for-dp_is_sink_present()-inste
|-- sparc-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_capability.c:warning:expecting-prototype-for-Check-if-there-is-a-native-DP-or-passive-DP().-Prototype-was-for-dp_is_sink_present()-inste
|-- x86_64-allnoconfig
|   |-- include-linux-gpio-consumer.h:linux-err.h-is-included-more-than-once.
|   |-- include-linux-gpio-driver.h:asm-bug.h-is-included-more-than-once.
clang_recent_errors
|-- arm-mvebu_v5_defconfig
|   |-- drivers-clk-mvebu-kirkwood.c:error:expected-identifier-or-(
|   `-- drivers-clk-mvebu-kirkwood.c:error:invalid-digit-d-in-decimal-constant
`-- s390-randconfig-r044-20230308
    |-- drivers-gpu-drm-amd-amdgpu-..-pm-swsmu-smu13-smu_v13_0_6_ppt.c:warning:variable-hotspotlimit-is-uninitialized-when-used-here
    |-- drivers-gpu-drm-amd-amdgpu-..-pm-swsmu-smu13-smu_v13_0_6_ppt.c:warning:variable-memlimit-is-uninitialized-when-used-here
    `-- drivers-gpu-drm-amd-amdgpu-..-pm-swsmu-smu13-smu_v13_0_6_ppt.c:warning:variable-software_shutdown_temp-is-uninitialized-when-used-here

elapsed time: 724m

configs tested: 106
configs skipped: 6

tested configs:
alpha                            alldefconfig   gcc  
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r006-20230308   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r031-20230308   gcc  
alpha                randconfig-r033-20230308   gcc  
alpha                randconfig-r035-20230308   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r015-20230308   gcc  
arc                  randconfig-r016-20230308   gcc  
arc                  randconfig-r021-20230308   gcc  
arc                  randconfig-r022-20230308   gcc  
arc                  randconfig-r034-20230308   gcc  
arc                  randconfig-r043-20230308   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                  randconfig-r005-20230309   gcc  
arm                  randconfig-r011-20230308   gcc  
arm                  randconfig-r046-20230308   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230308   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r024-20230308   gcc  
hexagon              randconfig-r036-20230308   clang
hexagon              randconfig-r041-20230308   clang
hexagon              randconfig-r045-20230308   clang
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
ia64                             allmodconfig   gcc  
ia64                         bigsur_defconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230309   gcc  
ia64                 randconfig-r003-20230309   gcc  
ia64                 randconfig-r026-20230308   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r004-20230308   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r032-20230308   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips                           rs90_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230309   gcc  
openrisc     buildonly-randconfig-r005-20230308   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r001-20230309   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230308   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r025-20230308   clang
s390                 randconfig-r044-20230308   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r014-20230308   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r013-20230308   gcc  
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
xtensa       buildonly-randconfig-r003-20230308   gcc  
xtensa               randconfig-r023-20230308   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
