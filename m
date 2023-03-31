Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33455C77B6C
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 20:26:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7470C10F303;
	Fri, 31 Mar 2023 20:26:16 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 765B18985A
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 20:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1680294371; x=1711830371;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=JigzRH1XS4gxfuOXH7Yq62hsAr9z5CZh7n41T3Wd6XQ=;
 b=kFWGvOtGqKHay2yZ0zCyrg1GdcWJoBF5f9PXb6jSSqSclq1CI/XG3a9N
 2dRq+jngx+alFaKOj9yt4ZRjqhBTif3TDkveEDJFXy1v2K+AQCY4W/NC7
 tSuJHvsv6kleJiRPEyYKHR/+0MgVhaX8mr5xVgOuorybvF4sINXsbgxNJ
 0v5tW72zIFR249KOEue12BoFzV998cL+TATAwSBM7tLXoh45juKojhUQu
 UC++UgFWNScFWb6wbEAaIlCKDj3PZk6/MlY65o2zTcyGZbwnRcVDTHHD2
 zRoTeGSn6QtfRBF7aMH0WXCl5uRhyi94K6YLf9Fvj5OzkOP1ToCMkkgW2 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="341569012"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; d="scan'208";a="341569012"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2023 13:26:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="678738121"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; d="scan'208";a="678738121"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
 by orsmga007.jf.intel.com with ESMTP; 31 Mar 2023 13:25:56 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1piLJr-000M8f-07;
 Fri, 31 Mar 2023 20:25:55 +0000
Date: Sat, 01 Apr 2023 04:25:06 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [linux-next:master] BUILD REGRESSION
 4b0f4525dc4fe8af17b3daefe585f0c2eb0fe0a5
Message-ID: <642741a2.Iacn1LRMRFiPMcQb%lkp@intel.com>
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
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, bpf@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 4b0f4525dc4fe8af17b3daefe585f0c2eb0fe0a5  Add linux-next specific files for 20230331

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202303161521.jbGbaFjJ-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202304010037.jagzIuJZ-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:351:13: warning: variable 'bw_needed' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:352:25: warning: variable 'link' set but not used [-Wunused-but-set-variable]
drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c:148:31: error: implicit declaration of function 'pci_msix_can_alloc_dyn' [-Werror=implicit-function-declaration]
drivers/net/wireless/legacy/ray_cs.c:628:17: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/acpi/property.c:985 acpi_data_prop_read_single() error: potentially dereferencing uninitialized 'obj'.
drivers/cdx/cdx.c:393:20: error: initialization of 'ssize_t (*)(const struct bus_type *, const char *, size_t)' {aka 'long int (*)(const struct bus_type *, const char *, long unsigned int)'} from incompatible pointer type 'ssize_t (*)(struct bus_type *, const char *, size_t)' {aka 'long int (*)(struct bus_type *, const char *, long unsigned int)'} [-Werror=incompatible-pointer-types]
kernel/bpf/verifier.c:10148:11: warning: Assigned value is garbage or undefined [clang-analyzer-core.uninitialized.Assign]
lib/cpu_rmap.c:272:2: warning: Use of memory after it is freed [clang-analyzer-unix.Malloc]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|   `-- drivers-net-wireless-legacy-ray_cs.c:warning:strncpy-specified-bound-equals-destination-size
|-- alpha-randconfig-r003-20230329
|   `-- drivers-net-ethernet-mellanox-mlx5-core-pci_irq.c:error:implicit-declaration-of-function-pci_msix_can_alloc_dyn
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- arc-buildonly-randconfig-r005-20230329
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- arm64-allyesconfig
|   |-- drivers-cdx-cdx.c:error:initialization-of-ssize_t-(-)(const-struct-bus_type-const-char-size_t)-aka-long-int-(-)(const-struct-bus_type-const-char-long-unsigned-int)-from-incompatible-pointer-type-ssize
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- arm64-buildonly-randconfig-r001-20230329
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- i386-randconfig-m021
|   `-- drivers-acpi-property.c-acpi_data_prop_read_single()-error:potentially-dereferencing-uninitialized-obj-.
|-- ia64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|   `-- drivers-net-wireless-legacy-ray_cs.c:warning:strncpy-specified-bound-equals-destination-size
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- loongarch-defconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- loongarch-randconfig-r014-20230329
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- mips-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
|-- powerpc-allmodconfig
clang_recent_errors
`-- s390-randconfig-c005-20230329
    |-- kernel-bpf-verifier.c:warning:Assigned-value-is-garbage-or-undefined-clang-analyzer-core.uninitialized.Assign
    `-- lib-cpu_rmap.c:warning:Use-of-memory-after-it-is-freed-clang-analyzer-unix.Malloc

elapsed time: 867m

configs tested: 100
configs skipped: 6

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r005-20230329   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r033-20230329   gcc  
arc                  randconfig-r043-20230329   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r034-20230329   clang
arm                  randconfig-r046-20230329   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230329   gcc  
arm64        buildonly-randconfig-r002-20230329   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230329   gcc  
arm64                randconfig-r003-20230329   gcc  
arm64                randconfig-r013-20230329   clang
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230329   clang
hexagon              randconfig-r045-20230329   clang
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
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230329   gcc  
loongarch            randconfig-r006-20230329   gcc  
loongarch            randconfig-r014-20230329   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r023-20230331   gcc  
microblaze           randconfig-r022-20230331   gcc  
microblaze           randconfig-r024-20230331   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r004-20230329   clang
mips                 randconfig-r036-20230329   clang
nios2                               defconfig   gcc  
nios2                randconfig-r016-20230329   gcc  
parisc       buildonly-randconfig-r006-20230329   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r032-20230329   gcc  
riscv                randconfig-r035-20230329   gcc  
riscv                randconfig-r042-20230329   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230329   gcc  
s390                 randconfig-r044-20230329   clang
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230329   gcc  
sparc64      buildonly-randconfig-r003-20230329   gcc  
sparc64              randconfig-r012-20230329   gcc  
sparc64              randconfig-r026-20230331   gcc  
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
xtensa               randconfig-r021-20230331   gcc  
xtensa               randconfig-r031-20230329   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
