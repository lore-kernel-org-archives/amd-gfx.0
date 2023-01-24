Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1100EC38142
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jan 2023 16:37:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 572D810E0A0;
	Tue, 24 Jan 2023 16:37:12 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4661210E0A0
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jan 2023 16:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1674578231; x=1706114231;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=pn97jEIAu/MECh0v1WxEWAkGQxc1uJC47tP454sU/qE=;
 b=CwrSHt2t4B6nS2w0TaPvDKfJMjfp/MBlEhj1KMJKpbb9Rg+TdIC50tzD
 bk0m8VJQ7fLPG3ARgl9KBpBq75mIpXibH3B/t1NLUhRNILZ0fZkmnCn0U
 2Zoa1yFtR6icvFPS1LQFJ2zknIMUhPzscG8278CGvOracn1hGC8eCSo73
 vgbDB1Swv5SJ88Zqe1Mh/lSyxQM4oG3lMV+Giod5ZobvC9Goy+DHvug03
 fh7o9nQ3nASk8fUM6SoPecSD+zw0PAC9/AZrh3Y43fMjEEHUj7sxP3cRQ
 QkY/9oinaas/6tMATyr0jitW7nfJYjkA5cmAxo7UtsxxVtiChLicOQuKr g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="309908743"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; d="scan'208";a="309908743"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2023 08:37:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="612099752"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; d="scan'208";a="612099752"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 24 Jan 2023 08:37:08 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pKMIF-0006cm-2N;
 Tue, 24 Jan 2023 16:37:07 +0000
Date: Wed, 25 Jan 2023 00:37:05 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [linux-next:master] BUILD REGRESSION
 a54df7622717a40ddec95fd98086aff8ba7839a6
Message-ID: <63d00931.j+gAM+ywiXvJX7wP%lkp@intel.com>
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
Cc: Linux Memory Management List <linux-mm@kvack.org>, netdev@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 virtualization@lists.linux-foundation.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: a54df7622717a40ddec95fd98086aff8ba7839a6  Add linux-next specific files for 20230124

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "devm_platform_ioremap_resource" [drivers/dma/fsl-edma.ko] undefined!
ERROR: modpost: "devm_platform_ioremap_resource" [drivers/dma/idma64.ko] undefined!
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_training.c:1585:38: warning: variable 'result' set but not used [-Wunused-but-set-variable]

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/block/virtio_blk.c:721:9: sparse:    bad type *
drivers/block/virtio_blk.c:721:9: sparse:    unsigned int *
drivers/block/virtio_blk.c:721:9: sparse: sparse: incompatible types in comparison expression (different base types):
drivers/block/virtio_blk.c:721:9: sparse: sparse: no generic selection for 'restricted __le32 [addressable] virtio_cread_v'
drivers/block/virtio_blk.c:721:9: sparse: sparse: no generic selection for 'restricted __le32 virtio_cread_v'
drivers/nvmem/imx-ocotp.c:599:21: sparse: sparse: symbol 'imx_ocotp_layout' was not declared. Should it be static?
mm/hugetlb.c:3100 alloc_hugetlb_folio() error: uninitialized symbol 'h_cg'.
net/devlink/leftover.c:7160 devlink_fmsg_prepare_skb() error: uninitialized symbol 'err'.

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
|-- arc-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
|-- arm-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
|-- arm-buildonly-randconfig-r005-20230123
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
|-- arm-randconfig-r014-20230123
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
|-- arm64-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
|-- i386-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
|-- ia64-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
|-- microblaze-randconfig-s033-20230123
|   |-- drivers-block-virtio_blk.c:sparse:bad-type
|   |-- drivers-block-virtio_blk.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-base-types):
|   |-- drivers-block-virtio_blk.c:sparse:sparse:no-generic-selection-for-restricted-__le32-addressable-virtio_cread_v
|   |-- drivers-block-virtio_blk.c:sparse:sparse:no-generic-selection-for-restricted-__le32-virtio_cread_v
|   |-- drivers-block-virtio_blk.c:sparse:unsigned-int
|   `-- drivers-nvmem-imx-ocotp.c:sparse:sparse:symbol-imx_ocotp_layout-was-not-declared.-Should-it-be-static
|-- mips-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
|-- powerpc-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
|-- powerpc-randconfig-s032-20230123
|   `-- drivers-nvmem-imx-ocotp.c:sparse:sparse:symbol-imx_ocotp_layout-was-not-declared.-Should-it-be-static
|-- s390-allmodconfig
|   |-- ERROR:devm_platform_ioremap_resource-drivers-dma-fsl-edma.ko-undefined
|   `-- ERROR:devm_platform_ioremap_resource-drivers-dma-idma64.ko-undefined
|-- s390-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
|-- sparc-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
|-- x86_64-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
`-- x86_64-randconfig-m001-20230123
    |-- mm-hugetlb.c-alloc_hugetlb_folio()-error:uninitialized-symbol-h_cg-.
    `-- net-devlink-leftover.c-devlink_fmsg_prepare_skb()-error:uninitialized-symbol-err-.

elapsed time: 724m

configs tested: 66
configs skipped: 3

gcc tested configs:
powerpc                           allnoconfig
x86_64                              defconfig
x86_64                            allnoconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
um                             i386_defconfig
arc                  randconfig-r043-20230123
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
arm                  randconfig-r046-20230123
arc                                 defconfig
sh                               allmodconfig
alpha                               defconfig
i386                                defconfig
x86_64                           allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a004-20230123
i386                 randconfig-a003-20230123
i386                 randconfig-a002-20230123
arm                                 defconfig
i386                 randconfig-a001-20230123
i386                 randconfig-a005-20230123
i386                 randconfig-a006-20230123
x86_64               randconfig-a002-20230123
x86_64               randconfig-a001-20230123
s390                                defconfig
s390                             allmodconfig
x86_64               randconfig-a006-20230123
arm64                            allyesconfig
x86_64               randconfig-a004-20230123
ia64                             allmodconfig
x86_64               randconfig-a003-20230123
arm                              allyesconfig
i386                             allyesconfig
x86_64               randconfig-a005-20230123
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
s390                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                       eiger_defconfig
arc                            hsdk_defconfig
mips                            ar7_defconfig
arm                        multi_v7_defconfig

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230123
hexagon              randconfig-r045-20230123
s390                 randconfig-r044-20230123
riscv                randconfig-r042-20230123
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
i386                 randconfig-a012-20230123
x86_64               randconfig-a012-20230123
i386                 randconfig-a013-20230123
i386                 randconfig-a011-20230123
x86_64               randconfig-a016-20230123
i386                 randconfig-a014-20230123
x86_64               randconfig-a015-20230123
x86_64               randconfig-a014-20230123
i386                 randconfig-a016-20230123
i386                 randconfig-a015-20230123

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
