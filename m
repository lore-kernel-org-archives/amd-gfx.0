Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B02CC7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 21:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A78210EB76;
	Thu, 23 Mar 2023 21:58:07 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FAFD10EB67
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 21:48:31 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 p13-20020a05600c358d00b003ed346d4522so1936230wmq.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 14:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679608110;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5UFnlQ0HXGyesKlAwwKVRU7O4P5Pf230XDi0wR0aLbw=;
 b=cqeHvhPDJmN1I/ln71Ad/bPY2Zr426QHAKplpmzF2quRSp66nFo6hUhutBMUcVJLaw
 Gzlp/LnKY41WK7KsHW+gFqvB6aTa7upfE84MHE2LJ7QW0NODSaKDEy78xhMU+jZLrKk1
 inOnlDM9/8sVf2gPBFCVY1Tx/zwIfkQBw3BDfg6d8HB7PsqtAaGkHK+ukTgWnc+VSK0D
 K1A3TOxT78mqjFSa8XxUcmu5PO4fb46upoEogZ02LnlAK1agEql2M5yr4rYWd1KX+/qC
 fdZuBAOkU+tz3tR6iXRt3LhnyhJVrAsJl5fg6myv+1ZWBzfg8id7I6QDmbH64rl6XL7H
 glQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679608110;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5UFnlQ0HXGyesKlAwwKVRU7O4P5Pf230XDi0wR0aLbw=;
 b=WgBPyLqjmvbW9Q6XmVem9jkjmt3IGGV0dq0LiqOXCjGCcmuy+0SpL/rKxwLP3pzfTb
 tpUnPdLu3CaNik+Ylg8sHs3sB53lRmgOLhvr2AhxUQBNRo68lWfdXoPs10CtARQUJC+S
 eiYWEVsJBtcnTg0NANNB2xmp9PRximpDarrkn8KIL6q/eltsshm2VKCk/QpXPorOKJg0
 /8ch2qc23dVNBWjoQpovLsYj3IK8nhOHivd2DdyID7pJ2xsgm3oj8truMUyKosJNFcr8
 uSHc5Ewxd8clI5HSNuxmqj6hB65E7g/OREZ0UiBeMLXO2igSdlCJoqslTuhfxZkQLwg0
 SfAg==
X-Gm-Message-State: AO0yUKUBQV1H50w4zt0tpAv8/aywrcRN02bh6sg5UI3Y9H4PImgTvkVk
 D/yvugDpMKefR2FP/oWfuws=
X-Google-Smtp-Source: AK7set/xYqu9CrMptZGCvAXMd+l1DRA4YKriDiX3qGR0Fh0x7aQU7d1XCjUlcakR6pnWbGx6COQYQQ==
X-Received: by 2002:a7b:ce8a:0:b0:3ea:d620:570a with SMTP id
 q10-20020a7bce8a000000b003ead620570amr738439wmj.38.1679608109671; 
 Thu, 23 Mar 2023 14:48:29 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com.
 [86.156.84.164]) by smtp.gmail.com with ESMTPSA id
 23-20020a05600c229700b003ee53e3e98asm2974110wmf.47.2023.03.23.14.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Mar 2023 14:48:28 -0700 (PDT)
Date: Thu, 23 Mar 2023 21:48:28 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: kernel test robot <lkp@intel.com>
Subject: Re: [linux-next:master] BUILD REGRESSION
 7c4a254d78f89546d0e74a40617ef24c6151c8d1
Message-ID: <8c6b19b7-5059-472d-a56d-eb4f49f1c170@lucifer.local>
References: <641cc5da.LRhzzaC4RvFK5EH/%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <641cc5da.LRhzzaC4RvFK5EH/%lkp@intel.com>
X-Mailman-Approved-At: Thu, 23 Mar 2023 21:58:05 +0000
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
Cc: linux-wireless@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, sound-open-firmware@alsa-project.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Mar 24, 2023 at 05:34:18AM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> branch HEAD: 7c4a254d78f89546d0e74a40617ef24c6151c8d1  Add linux-next specific files for 20230323
>
> Error/Warning reports:
>
> https://lore.kernel.org/oe-kbuild-all/202303161521.jbGbaFjJ-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202303231302.iY6qIfXA-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202303232154.aXOXAWhg-lkp@intel.com
>
> Error/Warning: (recently discovered and may have been fixed)
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:351:13: warning: variable 'bw_needed' set but not used [-Wunused-but-set-variable]
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:352:25: warning: variable 'link' set but not used [-Wunused-but-set-variable]
> drivers/net/wireless/legacy/ray_cs.c:628:17: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> gpio.c:(.init.text+0xec): undefined reference to `of_mm_gpiochip_add_data'
> include/linux/mmzone.h:1749:2: error: #error Allocator MAX_ORDER exceeds SECTION_SIZE
>
> Unverified Error/Warning (likely false positive, please contact us if interested):
>
> drivers/soc/fsl/qe/tsa.c:140:26: sparse: sparse: incorrect type in argument 2 (different address spaces)
> drivers/soc/fsl/qe/tsa.c:150:27: sparse: sparse: incorrect type in argument 1 (different address spaces)
> mm/mmap.c:962 vma_merge() error: uninitialized symbol 'next'.

I hate to add noise, but just for completeness and clarity, this is an
issue that was resolved in the patchset already whose fixes will be ported
to -next on the next go around.

https://lore.kernel.org/all/cover.1679516210.git.lstoakes@gmail.com has the
latest version (v5), fix came in v3.

> sound/soc/sof/ipc4-pcm.c:391 sof_ipc4_pcm_dai_link_fixup_rate() error: uninitialized symbol 'be_rate'.
> sound/soc/sof/ipc4-topology.c:1132 ipc4_copier_set_capture_fmt() error: uninitialized symbol 'sample_valid_bits'.
>
> Error/Warning ids grouped by kconfigs:
>
> gcc_recent_errors
> |-- alpha-allyesconfig
> |   `-- drivers-net-wireless-legacy-ray_cs.c:warning:strncpy-specified-bound-equals-destination-size
> |-- arm-allmodconfig
> |   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
> |   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
> |-- i386-randconfig-m021
> |   `-- mm-mmap.c-vma_merge()-error:uninitialized-symbol-next-.
> |-- ia64-allmodconfig
> |   `-- drivers-net-wireless-legacy-ray_cs.c:warning:strncpy-specified-bound-equals-destination-size
> |-- loongarch-randconfig-r006-20230322
> |   `-- include-linux-mmzone.h:error:error-Allocator-MAX_ORDER-exceeds-SECTION_SIZE
> |-- m68k-randconfig-s041-20230323
> |   |-- drivers-soc-fsl-qe-tsa.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-const-noderef-__iomem-got-void-noderef-__iomem-addr
> |   `-- drivers-soc-fsl-qe-tsa.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-noderef-__iomem-got-void-noderef-__iomem-addr
> |-- microblaze-buildonly-randconfig-r003-20230323
> |   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
> |   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
> |-- powerpc-allmodconfig
> |   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-bw_needed-set-but-not-used
> |   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_validation.c:warning:variable-link-set-but-not-used
> |-- powerpc-randconfig-s041-20230322
> |   `-- gpio.c:(.init.text):undefined-reference-to-of_mm_gpiochip_add_data
> |-- s390-randconfig-m031-20230321
> |   |-- sound-soc-sof-ipc4-pcm.c-sof_ipc4_pcm_dai_link_fixup_rate()-error:uninitialized-symbol-be_rate-.
> |   `-- sound-soc-sof-ipc4-topology.c-ipc4_copier_set_capture_fmt()-error:uninitialized-symbol-sample_valid_bits-.
> `-- sparc-allyesconfig
>     `-- drivers-net-wireless-legacy-ray_cs.c:warning:strncpy-specified-bound-equals-destination-size
>
> elapsed time: 1022m
>
> configs tested: 95
> configs skipped: 4
>
> tested configs:
> alpha                            allyesconfig   gcc
> alpha                               defconfig   gcc
> alpha                randconfig-r026-20230322   gcc
> arc                              allyesconfig   gcc
> arc                                 defconfig   gcc
> arc                  randconfig-r033-20230322   gcc
> arc                  randconfig-r043-20230322   gcc
> arm                              allmodconfig   gcc
> arm                              allyesconfig   gcc
> arm                                 defconfig   gcc
> arm                  randconfig-r023-20230322   clang
> arm                  randconfig-r046-20230322   clang
> arm                         vf610m4_defconfig   gcc
> arm64                            allyesconfig   gcc
> arm64                               defconfig   gcc
> csky                                defconfig   gcc
> hexagon              randconfig-r041-20230322   clang
> hexagon              randconfig-r045-20230322   clang
> i386                             allyesconfig   gcc
> i386                              debian-10.3   gcc
> i386                                defconfig   gcc
> i386                          randconfig-a001   gcc
> i386                          randconfig-a002   clang
> i386                          randconfig-a003   gcc
> i386                          randconfig-a004   clang
> i386                          randconfig-a005   gcc
> i386                          randconfig-a006   clang
> i386                          randconfig-a011   clang
> i386                          randconfig-a012   gcc
> i386                          randconfig-a013   clang
> i386                          randconfig-a014   gcc
> i386                          randconfig-a015   clang
> i386                          randconfig-a016   gcc
> ia64                             allmodconfig   gcc
> ia64                                defconfig   gcc
> ia64                 randconfig-r015-20230322   gcc
> loongarch                        allmodconfig   gcc
> loongarch                         allnoconfig   gcc
> loongarch                           defconfig   gcc
> loongarch            randconfig-r032-20230322   gcc
> m68k                             allmodconfig   gcc
> m68k                                defconfig   gcc
> m68k                       m5208evb_defconfig   gcc
> m68k                 randconfig-r012-20230322   gcc
> mips                             allmodconfig   gcc
> mips                             allyesconfig   gcc
> mips                 randconfig-r021-20230322   clang
> nios2                               defconfig   gcc
> nios2                randconfig-r016-20230322   gcc
> openrisc             randconfig-r024-20230322   gcc
> parisc                              defconfig   gcc
> parisc               randconfig-r031-20230322   gcc
> parisc               randconfig-r034-20230322   gcc
> parisc64                            defconfig   gcc
> powerpc                          allmodconfig   gcc
> powerpc                           allnoconfig   gcc
> powerpc                     mpc83xx_defconfig   gcc
> powerpc                      obs600_defconfig   clang
> riscv                            allmodconfig   gcc
> riscv                             allnoconfig   gcc
> riscv                               defconfig   gcc
> riscv                randconfig-r022-20230322   gcc
> riscv                randconfig-r042-20230322   gcc
> riscv                          rv32_defconfig   gcc
> s390                             allmodconfig   gcc
> s390                             allyesconfig   gcc
> s390                                defconfig   gcc
> s390                 randconfig-r014-20230322   gcc
> s390                 randconfig-r035-20230322   clang
> s390                 randconfig-r044-20230322   gcc
> sh                               allmodconfig   gcc
> sparc                               defconfig   gcc
> sparc                randconfig-r011-20230322   gcc
> um                             i386_defconfig   gcc
> um                           x86_64_defconfig   gcc
> x86_64                            allnoconfig   gcc
> x86_64                           allyesconfig   gcc
> x86_64                              defconfig   gcc
> x86_64                                  kexec   gcc
> x86_64                        randconfig-a001   clang
> x86_64                        randconfig-a002   gcc
> x86_64                        randconfig-a003   clang
> x86_64                        randconfig-a004   gcc
> x86_64                        randconfig-a005   clang
> x86_64                        randconfig-a006   gcc
> x86_64                        randconfig-a011   gcc
> x86_64                        randconfig-a012   clang
> x86_64                        randconfig-a013   gcc
> x86_64                        randconfig-a014   clang
> x86_64                        randconfig-a015   gcc
> x86_64                        randconfig-a016   clang
> x86_64                               rhel-8.3   gcc
> xtensa                  nommu_kc705_defconfig   gcc
> xtensa               randconfig-r013-20230322   gcc
> xtensa               randconfig-r025-20230322   gcc
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
