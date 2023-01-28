Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E1CC54EAA
	for <amd-gfx@archiver.kernel.org>; Sat, 28 Jan 2023 01:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C048B10E1C0;
	Sat, 28 Jan 2023 01:13:08 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 456FD10E1C0
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Jan 2023 01:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1674868386; x=1706404386;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=JM0DsUAXnIVbnyyRDEiq76v4MhII6gm7ppcnS6Lm9Js=;
 b=PEBqaJDJO80/yttrBOMY8t3uqlD9xZmBNFUFuNcuVh8v87DtkgL+Y1eb
 F87eeaKvSBfUY73gnsbTLmsp2PJnsaKu3FuwZNMD11NVR4SiO7fdadNeU
 gBEHL/UIKhhIhzKs5leG+2O5hH+C2sNtb0rH5s2+vr/eVo+DNqeOrdHOj
 RFaMqnaH2ftyKN9M4B2O5snCBnAeJsbSoduPFzdMf3odFoN+fIJUEQj06
 LZf+7QJd4k6purWZNbiuHXbHMnec6HD5BxQUwXaEA/jOEGZreBjNnSxyn
 VTuayhFHXLE2CizwEiXf5UYr7yi1uUPHieSMBjsjCObsFpBU8xp8MaxIw g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="307586088"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; d="scan'208";a="307586088"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2023 17:12:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="695721767"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; d="scan'208";a="695721767"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
 by orsmga001.jf.intel.com with ESMTP; 27 Jan 2023 17:12:40 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pLZln-0000AT-0S;
 Sat, 28 Jan 2023 01:12:39 +0000
Date: Sat, 28 Jan 2023 09:11:50 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [linux-next:master] BUILD REGRESSION
 9fbee811e479aca2f3523787cae1f46553141b40
Message-ID: <63d47656.PrqiDwRpfWhLZF/8%lkp@intel.com>
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
 linux-media@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 9fbee811e479aca2f3523787cae1f46553141b40  Add linux-next specific files for 20230125

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "devm_platform_ioremap_resource" [drivers/dma/fsl-edma.ko] undefined!
ERROR: modpost: "devm_platform_ioremap_resource" [drivers/dma/idma64.ko] undefined!
drivers/gpu/drm/amd/amdgpu/../display/dc/link/accessories/link_dp_trace.c:148:6: warning: no previous prototype for 'link_dp_trace_set_edp_power_timestamp' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/accessories/link_dp_trace.c:158:10: warning: no previous prototype for 'link_dp_trace_get_edp_poweron_timestamp' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/accessories/link_dp_trace.c:163:10: warning: no previous prototype for 'link_dp_trace_get_edp_poweroff_timestamp' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capability.c:1294:32: warning: variable 'result_write_min_hblank' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capability.c:1295:32: warning: variable 'result_write_min_hblank' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capability.c:278:42: warning: variable 'ds_port' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capability.c:279:42: warning: variable 'ds_port' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training.c:1585:38: warning: variable 'result' set but not used [-Wunused-but-set-variable]

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/media/i2c/max9286.c:802 max9286_s_stream() error: buffer overflow 'priv->fmt' 4 <= 32
drivers/nvmem/imx-ocotp.c:599:21: sparse: sparse: symbol 'imx_ocotp_layout' was not declared. Should it be static?
net/devlink/leftover.c:7160 devlink_fmsg_prepare_skb() error: uninitialized symbol 'err'.

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-randconfig-m031-20230123
|   `-- drivers-media-i2c-max9286.c-max9286_s_stream()-error:buffer-overflow-priv-fmt
|-- loongarch-randconfig-r014-20230123
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-accessories-link_dp_trace.c:warning:no-previous-prototype-for-link_dp_trace_get_edp_poweroff_timestamp
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-accessories-link_dp_trace.c:warning:no-previous-prototype-for-link_dp_trace_get_edp_poweron_timestamp
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-accessories-link_dp_trace.c:warning:no-previous-prototype-for-link_dp_trace_set_edp_power_timestamp
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_capability.c:warning:variable-ds_port-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_capability.c:warning:variable-result_write_min_hblank-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_training.c:warning:variable-result-set-but-not-used
|-- riscv-randconfig-s033-20230123
|   `-- drivers-nvmem-imx-ocotp.c:sparse:sparse:symbol-imx_ocotp_layout-was-not-declared.-Should-it-be-static
|-- s390-allmodconfig
|   |-- ERROR:devm_platform_ioremap_resource-drivers-dma-fsl-edma.ko-undefined
|   `-- ERROR:devm_platform_ioremap_resource-drivers-dma-idma64.ko-undefined
|-- s390-randconfig-c042-20230123
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-accessories-link_dp_trace.c:warning:no-previous-prototype-for-link_dp_trace_get_edp_poweroff_timestamp
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-accessories-link_dp_trace.c:warning:no-previous-prototype-for-link_dp_trace_get_edp_poweron_timestamp
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-accessories-link_dp_trace.c:warning:no-previous-prototype-for-link_dp_trace_set_edp_power_timestamp
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_capability.c:warning:variable-ds_port-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-protocols-link_dp_capability.c:warning:variable-result_write_min_hblank-set-but-not-used
|-- s390-randconfig-r032-20230123
|   `-- ERROR:devm_platform_ioremap_resource-drivers-dma-idma64.ko-undefined
`-- x86_64-randconfig-m001-20230123
    `-- net-devlink-leftover.c-devlink_fmsg_prepare_skb()-error:uninitialized-symbol-err-.

elapsed time: 4125m

configs tested: 62
configs skipped: 2

gcc tested configs:
um                             i386_defconfig
x86_64                            allnoconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
powerpc                           allnoconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
i386                                defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                               rhel-8.3
x86_64               randconfig-a002-20230123
arm                                 defconfig
i386                 randconfig-a004-20230123
ia64                             allmodconfig
i386                 randconfig-a003-20230123
s390                                defconfig
sh                               allmodconfig
x86_64               randconfig-a001-20230123
x86_64                           allyesconfig
arc                  randconfig-r043-20230123
arm                  randconfig-r046-20230123
i386                 randconfig-a002-20230123
x86_64               randconfig-a004-20230123
m68k                             allyesconfig
i386                 randconfig-a001-20230123
x86_64               randconfig-a003-20230123
s390                             allyesconfig
x86_64               randconfig-a005-20230123
i386                 randconfig-a005-20230123
i386                             allyesconfig
m68k                             allmodconfig
mips                             allyesconfig
x86_64               randconfig-a006-20230123
i386                 randconfig-a006-20230123
powerpc                          allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
i386                 randconfig-a012-20230123
x86_64               randconfig-a012-20230123
i386                 randconfig-a013-20230123
i386                 randconfig-a011-20230123
x86_64               randconfig-a015-20230123
hexagon              randconfig-r041-20230123
x86_64               randconfig-a014-20230123
x86_64               randconfig-a016-20230123
i386                 randconfig-a014-20230123
hexagon              randconfig-r045-20230123
i386                 randconfig-a016-20230123
i386                 randconfig-a015-20230123
s390                 randconfig-r044-20230123
riscv                randconfig-r042-20230123

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
