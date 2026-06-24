Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A75CDE000
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 06:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 532C410E050;
	Wed, 24 Jun 2026 06:43:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="l8s4aetS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A8E110E050
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 06:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782283414; x=1813819414;
 h=date:from:to:cc:subject:message-id;
 bh=S66rB3G/Ir4h7R1MR1yYlN5jdw1782v1j22LxL+eeto=;
 b=l8s4aetScNMg2I3knyva0v/jHHPpoCtEZFD5K7PBTLXI8GnnXTc1MZA+
 X7ei0NQkEleKj3RzMpELVI0XUttor2z7OsPQZZWPLzroTEWC0zCmjmytG
 pxGLCBhVXQSEKSuSmX3tNkHISq6cA3UieZUVMlpmkS2BlvgKmDLrlki6e
 0uQGNYjRCuAK0GM+EdKDfUP2fpuaNAyCtYITgx3qEElYlHIrPTlVKvILY
 8Y9wVwT8x6U5Cv7ivFes/BPWJUMRgKh7oDlwiZVd85BWLwxJlpv8TMXC1
 FjD8KGX2IT7WZxwiJZ66S2wlo7VbduUlNTsHejO25juOXowP9c2+/f7LC A==;
X-CSE-ConnectionGUID: wmpcBXPkQ6ashvWl15qo6A==
X-CSE-MsgGUID: X1DzBEAYRg+LrJ4pjf0hrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93395448"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="93395448"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 23:43:33 -0700
X-CSE-ConnectionGUID: tNThZ1yXTxaz/GlK+t9ABQ==
X-CSE-MsgGUID: CaV2eLCeTeyBwpGXrV8Dxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="287876518"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
 by orviesa001.jf.intel.com with ESMTP; 23 Jun 2026 23:43:30 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wcHKa-000000003Ad-0Rsw;
 Wed, 24 Jun 2026 06:43:28 +0000
Date: Wed, 24 Jun 2026 14:42:31 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>
Subject: [linux-next:master] BUILD REGRESSION
 4e5dfb7c84012007c3c7061126491bbc92d71bf1
Message-ID: <202606241414.J3MBjGDP-lkp@intel.com>
User-Agent: s-nail v14.9.25
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 4e5dfb7c84012007c3c7061126491bbc92d71bf1  Add linux-next specific files for 20260623

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202606240749.ZFFiISB2-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202606240753.kYjobJVl-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202606241110.iUga5vVw-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202606241320.9gDd2s75-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202606241431.L9VUbAKp-lkp@intel.com

    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/tests/amdgpu_dm_connector_test.c:120:1: warning: the frame size of 1384 bytes is larger than 1280 bytes [-Wframe-larger-than=]
    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/tests/amdgpu_dm_connector_test.c:120:1: warning: the frame size of 1388 bytes is larger than 1280 bytes [-Wframe-larger-than=]
    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/tests/amdgpu_dm_connector_test.c:120:1: warning: the frame size of 1424 bytes is larger than 1280 bytes [-Wframe-larger-than=]
    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/tests/amdgpu_dm_connector_test.c:120:1: warning: the frame size of 1696 bytes is larger than 1280 bytes [-Wframe-larger-than=]
    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/tests/amdgpu_dm_connector_test.c:120:1: warning: the frame size of 1696 bytes is larger than 1536 bytes [-Wframe-larger-than=]
    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.o: error: objtool: amdgpu_vm_handle_fault+0x97: sibling call from callable instruction with modified stack frame
    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.o: warning: objtool: amdgpu_vm_handle_fault+0x12d: sibling call from callable instruction with modified stack frame
    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.o: warning: objtool: amdgpu_vm_handle_fault+0x140: sibling call from callable instruction with modified stack frame

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arc-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-tests-amdgpu_dm_connector_test.c:warning:the-frame-size-of-bytes-is-larger-than-bytes
|-- arc-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-tests-amdgpu_dm_connector_test.c:warning:the-frame-size-of-bytes-is-larger-than-bytes
|-- arm-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-tests-amdgpu_dm_connector_test.c:warning:the-frame-size-of-bytes-is-larger-than-bytes
|-- csky-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-tests-amdgpu_dm_connector_test.c:warning:the-frame-size-of-bytes-is-larger-than-bytes
|-- i386-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-tests-amdgpu_dm_connector_test.c:warning:the-frame-size-of-bytes-is-larger-than-bytes
|-- i386-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-tests-amdgpu_dm_connector_test.c:warning:the-frame-size-of-bytes-is-larger-than-bytes
|-- loongarch-defconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_vm.o:warning:objtool:amdgpu_vm_handle_fault:sibling-call-from-callable-instruction-with-modified-stack-frame
|-- microblaze-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-tests-amdgpu_dm_connector_test.c:warning:the-frame-size-of-bytes-is-larger-than-bytes
|-- mips-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-tests-amdgpu_dm_connector_test.c:warning:the-frame-size-of-bytes-is-larger-than-bytes
|-- mips-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-tests-amdgpu_dm_connector_test.c:warning:the-frame-size-of-bytes-is-larger-than-bytes
|-- openrisc-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-tests-amdgpu_dm_connector_test.c:warning:the-frame-size-of-bytes-is-larger-than-bytes
|-- powerpc64-randconfig-r052-20260624
|   `-- drivers-firmware-imx-se_ctrl.c:WARNING:invalid-free-of-devm_-allocated-data
|-- sparc-randconfig-r133-20260624
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-tests-..-..-..-amdgpu-amdgv_sriovmsg.h:sparse:sparse:static-assertion-failed:amd_sriov_msg_vf2pf_info-must-be-KB
|-- x86_64-randconfig-003-20260622
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_vm.o:warning:objtool:amdgpu_vm_handle_fault:sibling-call-from-callable-instruction-with-modified-stack-frame
|-- x86_64-randconfig-072-20250919
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_vm.o:error:objtool:amdgpu_vm_handle_fault:sibling-call-from-callable-instruction-with-modified-stack-frame
`-- xtensa-allyesconfig
    `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-tests-amdgpu_dm_connector_test.c:warning:the-frame-size-of-bytes-is-larger-than-bytes

elapsed time: 941m

configs tested: 278
configs skipped: 4

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260624    gcc-15.2.0
arc                   randconfig-001-20260624    gcc-9.5.0
arc                   randconfig-002-20260624    gcc-15.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260624    clang-19
arm                   randconfig-001-20260624    gcc-15.2.0
arm                   randconfig-002-20260624    gcc-15.2.0
arm                   randconfig-002-20260624    gcc-8.5.0
arm                   randconfig-003-20260624    gcc-15.2.0
arm                   randconfig-004-20260624    clang-17
arm                   randconfig-004-20260624    gcc-15.2.0
arm                           sama5_defconfig    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260624    clang-21
arm64                 randconfig-002-20260624    clang-21
arm64                 randconfig-002-20260624    gcc-15.2.0
arm64                 randconfig-003-20260624    clang-21
arm64                 randconfig-003-20260624    clang-23
arm64                 randconfig-004-20260624    clang-21
arm64                 randconfig-004-20260624    clang-23
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260624    clang-21
csky                  randconfig-001-20260624    gcc-16.1.0
csky                  randconfig-002-20260624    clang-21
csky                  randconfig-002-20260624    gcc-9.5.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260624    clang-20
hexagon               randconfig-001-20260624    gcc-11.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260624    clang-23
hexagon               randconfig-002-20260624    gcc-11.5.0
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    gcc-12
i386        buildonly-randconfig-001-20260624    gcc-12
i386        buildonly-randconfig-001-20260624    gcc-14
i386                 buildonly-randconfig-002    gcc-12
i386        buildonly-randconfig-002-20260624    gcc-12
i386        buildonly-randconfig-002-20260624    gcc-14
i386                 buildonly-randconfig-003    gcc-12
i386        buildonly-randconfig-003-20260624    gcc-12
i386                 buildonly-randconfig-004    gcc-12
i386        buildonly-randconfig-004-20260624    gcc-12
i386        buildonly-randconfig-004-20260624    gcc-14
i386                 buildonly-randconfig-005    gcc-12
i386        buildonly-randconfig-005-20260624    gcc-12
i386        buildonly-randconfig-005-20260624    gcc-14
i386                 buildonly-randconfig-006    gcc-12
i386        buildonly-randconfig-006-20260624    gcc-12
i386        buildonly-randconfig-006-20260624    gcc-14
i386                                defconfig    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260624    clang-22
i386                  randconfig-001-20260624    gcc-14
i386                  randconfig-002-20260624    clang-22
i386                  randconfig-002-20260624    gcc-14
i386                  randconfig-003-20260624    clang-22
i386                  randconfig-003-20260624    gcc-14
i386                  randconfig-004-20260624    clang-22
i386                  randconfig-004-20260624    gcc-12
i386                  randconfig-005-20260624    clang-22
i386                  randconfig-006-20260624    clang-22
i386                  randconfig-007-20260624    clang-22
i386                  randconfig-007-20260624    gcc-14
i386                  randconfig-011-20260624    clang-22
i386                  randconfig-012-20260624    clang-22
i386                  randconfig-012-20260624    gcc-14
i386                  randconfig-013-20260624    clang-22
i386                  randconfig-014-20260624    clang-22
i386                  randconfig-015-20260624    clang-22
i386                  randconfig-015-20260624    gcc-14
i386                  randconfig-016-20260624    clang-22
i386                  randconfig-017-20260624    clang-22
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260624    gcc-11.5.0
loongarch             randconfig-001-20260624    gcc-16.1.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260624    gcc-11.5.0
loongarch             randconfig-002-20260624    gcc-15.2.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                               defconfig    gcc-11.5.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260624    gcc-11.5.0
nios2                 randconfig-001-20260624    gcc-9.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260624    gcc-11.5.0
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260624    gcc-16.1.0
parisc                randconfig-002-20260624    gcc-14.3.0
parisc                randconfig-002-20260624    gcc-16.1.0
parisc64                            defconfig    clang-23
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                     asp8347_defconfig    clang-23
powerpc               randconfig-001-20260624    clang-17
powerpc               randconfig-001-20260624    gcc-16.1.0
powerpc               randconfig-002-20260624    gcc-16.1.0
powerpc               randconfig-002-20260624    gcc-8.5.0
powerpc64             randconfig-001-20260624    gcc-16.1.0
powerpc64             randconfig-001-20260624    gcc-8.5.0
powerpc64             randconfig-002-20260624    gcc-11.5.0
powerpc64             randconfig-002-20260624    gcc-16.1.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260624    clang-18
riscv                 randconfig-001-20260624    gcc-13.4.0
riscv                 randconfig-002-20260624    clang-18
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260624    clang-18
s390                  randconfig-001-20260624    gcc-8.5.0
s390                  randconfig-002-20260624    clang-18
s390                  randconfig-002-20260624    gcc-10.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-16.1.0
sh                    randconfig-001-20260624    clang-18
sh                    randconfig-001-20260624    gcc-15.2.0
sh                    randconfig-002-20260624    clang-18
sh                    randconfig-002-20260624    gcc-9.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260624    gcc-14.3.0
sparc                 randconfig-001-20260624    gcc-8.5.0
sparc                 randconfig-002-20260624    gcc-14.3.0
sparc                 randconfig-002-20260624    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260624    clang-20
sparc64               randconfig-001-20260624    gcc-14.3.0
sparc64               randconfig-002-20260624    clang-20
sparc64               randconfig-002-20260624    gcc-14.3.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260624    clang-23
um                    randconfig-001-20260624    gcc-14.3.0
um                    randconfig-002-20260624    clang-17
um                    randconfig-002-20260624    gcc-14.3.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260624    clang-22
x86_64      buildonly-randconfig-001-20260624    gcc-14
x86_64      buildonly-randconfig-002-20260624    clang-22
x86_64      buildonly-randconfig-003-20260624    clang-22
x86_64      buildonly-randconfig-003-20260624    gcc-14
x86_64      buildonly-randconfig-004-20260624    clang-22
x86_64      buildonly-randconfig-005-20260624    clang-22
x86_64      buildonly-randconfig-005-20260624    gcc-14
x86_64      buildonly-randconfig-006-20260624    clang-22
x86_64      buildonly-randconfig-006-20260624    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260624    clang-22
x86_64                randconfig-002-20260624    clang-22
x86_64                randconfig-003-20260624    clang-22
x86_64                randconfig-004-20260624    clang-22
x86_64                randconfig-004-20260624    gcc-14
x86_64                randconfig-005-20260624    clang-22
x86_64                randconfig-006-20260624    clang-22
x86_64                randconfig-006-20260624    gcc-14
x86_64                randconfig-011-20260624    gcc-14
x86_64                randconfig-012-20260624    gcc-14
x86_64                randconfig-013-20260624    gcc-12
x86_64                randconfig-013-20260624    gcc-14
x86_64                randconfig-014-20260624    gcc-14
x86_64                randconfig-015-20260624    gcc-14
x86_64                randconfig-016-20260624    gcc-14
x86_64                randconfig-071-20260624    gcc-14
x86_64                randconfig-072-20260624    clang-22
x86_64                randconfig-072-20260624    gcc-14
x86_64                randconfig-073-20260624    gcc-14
x86_64                randconfig-074-20260624    clang-22
x86_64                randconfig-074-20260624    gcc-14
x86_64                randconfig-075-20260624    gcc-14
x86_64                randconfig-076-20260624    clang-22
x86_64                randconfig-076-20260624    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                               rhel-9.4    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                          rhel-9.4-func    gcc-14
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                    rhel-9.4-kselftests    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260624    gcc-14.3.0
xtensa                randconfig-002-20260624    gcc-14.3.0
xtensa                randconfig-002-20260624    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
