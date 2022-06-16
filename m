Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5243C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jun 2022 19:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ED6210E3D7;
	Thu, 16 Jun 2022 19:53:18 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 296B010E686
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 19:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655409197; x=1686945197;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=jlT4m+WFkmmazCzTLedwDoWN/1Muhtuim1CMzuJuNFg=;
 b=FlfJXN/nHQs9pWKHJv3vfYkGHvTAnN1s+ykQCcqUr0BnDy7vBBd9mekW
 6IKleGilJUPzdE8pvfANeSMS4Wc1IW3iivucPeek+NDQCebBIaai6eJ67
 l2CVAUiVuh13mdWUwDgHfSBuIPrR7xpUfSuGRshaNTGual3x7KLNidKOD
 hkcAKAWiVgWKn0PR7yZFfalc+M6v/4NTmAL1JYg3VVpypftB2TY/eps2G
 oNzI7rS6p8W5lb/ldxY1+zS/AMceLehnhOWceGxG+R+IwMFAeejZ6TVjl
 +IfpHwsmLJdK0QEpFSN2ucVNoc7mj9oiSO9LemcZNAdpsT7I10Vv9aPTZ Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="279396178"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="279396178"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2022 12:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="613284579"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
 by orsmga008.jf.intel.com with ESMTP; 16 Jun 2022 12:53:13 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1o1vYG-000OiX-OA;
 Thu, 16 Jun 2022 19:53:12 +0000
Date: Fri, 17 Jun 2022 03:52:18 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [linux-next:master] BUILD REGRESSION
 c6d7e3b385f19869ab96e9404c92ff1abc34f2c8
Message-ID: <62ab89f2.Pko7sI08RAKdF8R6%lkp@intel.com>
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
Cc: linux-perf-users@vger.kernel.org, linux-staging@lists.linux.dev,
 kvm@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-um@lists.infradead.org, amd-gfx@lists.freedesktop.org,
 linux-xfs@vger.kernel.org, Linux Memory Management List <linux-mm@kvack.org>,
 linux-pci@vger.kernel.org, bpf@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: c6d7e3b385f19869ab96e9404c92ff1abc34f2c8  Add linux-next specific files for 20220616

Error/Warning reports:

https://lore.kernel.org/lkml/202206071511.FI7WLdZo-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

include/linux/highmem-internal.h:203:31: error: passing argument 1 of 'kunmap_flush_on_unmap' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
include/linux/highmem-internal.h:203:31: warning: passing argument 1 of 'kunmap_flush_on_unmap' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
kernel/bpf/helpers.c:1490:29: sparse: sparse: symbol 'bpf_dynptr_from_mem_proto' was not declared. Should it be static?
kernel/bpf/helpers.c:1516:29: sparse: sparse: symbol 'bpf_dynptr_read_proto' was not declared. Should it be static?
kernel/bpf/helpers.c:1542:29: sparse: sparse: symbol 'bpf_dynptr_write_proto' was not declared. Should it be static?
kernel/bpf/helpers.c:1569:29: sparse: sparse: symbol 'bpf_dynptr_data_proto' was not declared. Should it be static?
ld.lld: error: kernel/built-in.a(kallsyms.o):(function get_symbol_offset: .text+0x532): relocation R_RISCV_PCREL_HI20 out of range: -524434 is not in [-524288, 524287]; references kallsyms_markers
ld.lld: error: kernel/built-in.a(kallsyms.o):(function get_symbol_offset: .text+0x540): relocation R_RISCV_PCREL_HI20 out of range: -524434 is not in [-524288, 524287]; references kallsyms_names
ld.lld: error: kernel/built-in.a(kallsyms.o):(function update_iter: .text+0x95c): relocation R_RISCV_PCREL_HI20 out of range: -524434 is not in [-524288, 524287]; references kallsyms_num_syms
ld.lld: error: kernel/built-in.a(kallsyms.o):(function update_iter: .text+0xab2): relocation R_RISCV_PCREL_HI20 out of range: -524435 is not in [-524288, 524287]; references kallsyms_names
ld.lld: error: kernel/built-in.a(kallsyms.o):(function update_iter: .text+0xaca): relocation R_RISCV_PCREL_HI20 out of range: -524435 is not in [-524288, 524287]; references kallsyms_token_index
ld.lld: error: kernel/built-in.a(kallsyms.o):(function update_iter: .text+0xad4): relocation R_RISCV_PCREL_HI20 out of range: -524435 is not in [-524288, 524287]; references kallsyms_offsets

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9143:27: warning: variable 'abo' set but not used [-Wunused-but-set-variable]
drivers/usb/gadget/udc/aspeed_udc.c:1009:28: sparse: sparse: restricted __le16 degrades to integer

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- alpha-randconfig-m031-20220616
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|-- alpha-randconfig-r011-20220616
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|-- arc-allmodconfig
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
|-- arm-randconfig-s031-20220616
|   `-- drivers-usb-gadget-udc-aspeed_udc.c:sparse:sparse:restricted-__le16-degrades-to-integer
|-- arm-randconfig-s032-20220616
|   |-- fs-xfs-xfs_file.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-restricted-vm_fault_t-usertype-ret-got-int
|   |-- kernel-bpf-helpers.c:sparse:sparse:symbol-bpf_dynptr_data_proto-was-not-declared.-Should-it-be-static
|   |-- kernel-bpf-helpers.c:sparse:sparse:symbol-bpf_dynptr_from_mem_proto-was-not-declared.-Should-it-be-static
|   |-- kernel-bpf-helpers.c:sparse:sparse:symbol-bpf_dynptr_read_proto-was-not-declared.-Should-it-be-static
|   `-- kernel-bpf-helpers.c:sparse:sparse:symbol-bpf_dynptr_write_proto-was-not-declared.-Should-it-be-static
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- i386-randconfig-a005
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- i386-randconfig-m021
|   `-- arch-x86-events-core.c-init_hw_perf_events()-warn:missing-error-code-err
|-- i386-randconfig-s001
|   |-- drivers-pci-pci.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-restricted-pci_power_t-assigned-usertype-state-got-int
|   |-- drivers-vfio-pci-vfio_pci_config.c:sparse:sparse:restricted-pci_power_t-degrades-to-integer
|   `-- kernel-signal.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-lockdep_map-const-lock-got-struct-lockdep_map-noderef-__rcu
|-- i386-randconfig-s002
|   |-- drivers-pci-pci.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-restricted-pci_power_t-assigned-usertype-state-got-int
|   |-- fs-xfs-xfs_file.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-restricted-vm_fault_t-usertype-ret-got-int
|   `-- kernel-signal.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-lockdep_map-const-lock-got-struct-lockdep_map-noderef-__rcu
|-- ia64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- ia64-allyesconfig
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
|-- nios2-allmodconfig
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- nios2-allyesconfig
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- parisc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   |-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|   |-- include-linux-highmem-internal.h:error:passing-argument-of-kunmap_flush_on_unmap-discards-const-qualifier-from-pointer-target-type
|   `-- include-linux-highmem-internal.h:warning:passing-argument-of-kunmap_flush_on_unmap-discards-const-qualifier-from-pointer-target-type
|-- parisc-defconfig
|   `-- include-linux-highmem-internal.h:warning:passing-argument-of-kunmap_flush_on_unmap-discards-const-qualifier-from-pointer-target-type
|-- parisc-randconfig-r012-20220616
|   |-- include-linux-highmem-internal.h:error:passing-argument-of-kunmap_flush_on_unmap-discards-const-qualifier-from-pointer-target-type
|   `-- include-linux-highmem-internal.h:warning:passing-argument-of-kunmap_flush_on_unmap-discards-const-qualifier-from-pointer-target-type
|-- parisc64-defconfig
|   `-- include-linux-highmem-internal.h:warning:passing-argument-of-kunmap_flush_on_unmap-discards-const-qualifier-from-pointer-target-type
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- powerpc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- riscv-allmodconfig
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
|-- um-i386_defconfig
|   `-- arch-um-kernel-skas-uaccess.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-const-addr-got-unsigned-int-noderef-usertype-__user-uaddr
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
|   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
|-- x86_64-randconfig-m001
|   |-- arch-x86-events-core.c-init_hw_perf_events()-warn:missing-error-code-err
|   `-- lib-maple_tree.c-mas_wr_spanning_store()-warn:inconsistent-indenting
|-- x86_64-randconfig-s021
|   |-- drivers-pci-pci.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-restricted-pci_power_t-assigned-usertype-state-got-int
|   |-- fs-xfs-xfs_file.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-restricted-vm_fault_t-usertype-ret-got-int
|   `-- kernel-signal.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-lockdep_map-const-lock-got-struct-lockdep_map-noderef-__rcu
|-- x86_64-randconfig-s022
|   |-- drivers-pci-pci.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-restricted-pci_power_t-assigned-usertype-state-got-int
|   |-- kernel-bpf-helpers.c:sparse:sparse:symbol-bpf_dynptr_data_proto-was-not-declared.-Should-it-be-static
|   |-- kernel-bpf-helpers.c:sparse:sparse:symbol-bpf_dynptr_from_mem_proto-was-not-declared.-Should-it-be-static
|   |-- kernel-bpf-helpers.c:sparse:sparse:symbol-bpf_dynptr_read_proto-was-not-declared.-Should-it-be-static
|   |-- kernel-bpf-helpers.c:sparse:sparse:symbol-bpf_dynptr_write_proto-was-not-declared.-Should-it-be-static
|   `-- kernel-signal.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-lockdep_map-const-lock-got-struct-lockdep_map-noderef-__rcu
`-- xtensa-allyesconfig
    |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-abo-set-but-not-used
    `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used

clang_recent_errors
|-- riscv-buildonly-randconfig-r002-20220616
|   `-- arch-riscv-kernel-cpufeature.c:warning:variable-cpu_apply_feature-set-but-not-used
|-- riscv-buildonly-randconfig-r003-20220616
|   |-- ld.lld:error:kernel-built-in.a(kallsyms.o):(function-get_symbol_offset:.text):relocation-R_RISCV_PCREL_HI20-out-of-range:is-not-in-references-kallsyms_markers
|   |-- ld.lld:error:kernel-built-in.a(kallsyms.o):(function-get_symbol_offset:.text):relocation-R_RISCV_PCREL_HI20-out-of-range:is-not-in-references-kallsyms_names
|   |-- ld.lld:error:kernel-built-in.a(kallsyms.o):(function-update_iter:.text):relocation-R_RISCV_PCREL_HI20-out-of-range:is-not-in-references-kallsyms_names
|   |-- ld.lld:error:kernel-built-in.a(kallsyms.o):(function-update_iter:.text):relocation-R_RISCV_PCREL_HI20-out-of-range:is-not-in-references-kallsyms_num_syms
|   |-- ld.lld:error:kernel-built-in.a(kallsyms.o):(function-update_iter:.text):relocation-R_RISCV_PCREL_HI20-out-of-range:is-not-in-references-kallsyms_offsets
|   `-- ld.lld:error:kernel-built-in.a(kallsyms.o):(function-update_iter:.text):relocation-R_RISCV_PCREL_HI20-out-of-range:is-not-in-references-kallsyms_token_index
`-- riscv-randconfig-r042-20220616
    `-- arch-riscv-kernel-cpufeature.c:warning:variable-cpu_apply_feature-set-but-not-used

elapsed time: 720m

configs tested: 107
configs skipped: 3

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
um                             i386_defconfig
i386                          randconfig-c001
alpha                            allyesconfig
arc                              allyesconfig
nios2                            allyesconfig
mips                         bigsur_defconfig
m68k                        mvme147_defconfig
sh                         ap325rxa_defconfig
sh                      rts7751r2d1_defconfig
microblaze                      mmu_defconfig
sh                           se7780_defconfig
powerpc                 mpc834x_mds_defconfig
xtensa                  audio_kc705_defconfig
arc                              alldefconfig
nios2                         3c120_defconfig
arc                    vdk_hs38_smp_defconfig
arm                        clps711x_defconfig
nios2                         10m50_defconfig
mips                       capcella_defconfig
arm                           sunxi_defconfig
xtensa                         virt_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
alpha                               defconfig
csky                                defconfig
nios2                               defconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
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
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220616
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz

clang tested configs:
mips                        bcm63xx_defconfig
powerpc                     tqm8540_defconfig
mips                          ath79_defconfig
mips                       lemote2f_defconfig
mips                     loongson1c_defconfig
powerpc                       ebony_defconfig
powerpc                  mpc885_ads_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220616
hexagon              randconfig-r045-20220616
s390                 randconfig-r044-20220616
riscv                randconfig-r042-20220616

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
