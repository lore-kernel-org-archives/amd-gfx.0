Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53B0C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 08:00:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D13E210E687;
	Mon, 13 Jun 2022 08:00:39 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E2C810E1FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 02:05:40 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-fe4ac3b87fso6733241fac.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Jun 2022 19:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e46J6YpvZlo2yGMzk6PY6sq3v309vZF6FtZnu8zauLo=;
 b=iJBQxF2Wl8xxK/rALoNpaCDWo3V4BFLqvJPHSBKd+7wAbQVgGZOGN6oaw8AoVgfAO2
 kacOO+OTX7lzg2LAvn+n1wMfeLtg5vtSuRqsFvoUqtsD/E+8Zfj+PWUSnp1gQRFX55+V
 ugDYSdtx/pX5N0b3Rzk2R1X0n1Q7bLh/QNEhIbXz8h11K6c2UvpOub/rddfitIN6XLGF
 fn7YG6cUzDDw+wgoIJJQLCWkyBC6H8cJqbdj4G1DjgcouBGe+iBpQMQ+Hun8+wevETDi
 suvR2BriwLgGym/UvWSy+NCXBqma/WYQxesdN/8RF7M1YfiX4TSaitFsHIQcPGwz4PBy
 ZzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e46J6YpvZlo2yGMzk6PY6sq3v309vZF6FtZnu8zauLo=;
 b=UO8DNZV7TG5BfsatBFCILeinalwJu16rsNSjmS+XBBCRUgUh8ZRL2b2VKvnU6hCfF+
 epc7kn+Ew44kOloJLEUJKbonv97xn6zzyI9aFCsLAwqx8yvuOdDVvoLQUfrhuBOQdrtF
 qXpLX3rziAiyidsUBKk6uHCk+TfaoavQl6UvJR6A3EaNZzOmsQ5njvPDOkl0MDWEmR39
 dA+lZy5T7rdpi8QG4BsSgoUCmwlXJ5MGok3ku49EBXGubH4wZTjmJGbCf3qLKy0neUpb
 h7Wr97ko8LSdUByTSbAAxRS/yZn0aeylLwoKUIuHtcFWRVpI2W0ktfKi232+EaYMSSc2
 Nuhg==
X-Gm-Message-State: AOAM530RiSHjK3XF8uh4PfeEM/8QTTAqknL8CxaRFnrEKK7dbD9qUStU
 2j53ZAjgFEHwEb5hVjm9QivykgmnoYDek6QzQe+YVNOwIEg=
X-Google-Smtp-Source: ABdhPJwz5UGAyOrgXcceDNDm0wdsu410WRWWGrrkAgaIqwJLEpLVqHsAtKdij4lra+lyQ0P01s8Oj7xw9CpeCe+QygU=
X-Received: by 2002:a05:6870:d582:b0:fe:4131:6dbb with SMTP id
 u2-20020a056870d58200b000fe41316dbbmr6421526oao.76.1655085939878; Sun, 12 Jun
 2022 19:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <62a3ad70.TorcQosfTdYPgOzL%lkp@intel.com>
In-Reply-To: <62a3ad70.TorcQosfTdYPgOzL%lkp@intel.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Mon, 13 Jun 2022 07:35:27 +0530
Message-ID: <CAFqt6zaL=QBkS5PJNKV9D81uGmwGwjjsa0w90ohGjJkB2qEu4g@mail.gmail.com>
Subject: Re: [linux-next:master] BUILD REGRESSION
 6d0c806803170f120f8cb97b321de7bd89d3a791
To: kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 13 Jun 2022 08:00:37 +0000
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
 Andrew Morton <akpm@linux-foundation.org>, linux-staging@lists.linux.dev,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Jun 11, 2022 at 2:16 AM kernel test robot <lkp@intel.com> wrote:
>
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> branch HEAD: 6d0c806803170f120f8cb97b321de7bd89d3a791  Add linux-next specific files for 20220610
>
> Error/Warning reports:
>
> https://lore.kernel.org/llvm/202205220805.wrw5woEk-lkp@intel.com
>
> Error/Warning: (recently discovered and may have been fixed)
>
> arch/riscv/include/asm/pgtable-64.h:215:2: error: invalid input constraint '0' in asm
> arch/riscv/include/asm/pgtable.h:257:2: error: invalid input constraint '0' in asm
> drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:130:17: warning: 'DP_SINK_BRANCH_DEV_NAME_7580' defined but not used [-Wunused-const-variable=]

This is a False warning.
0 ddc_service_types.h <global>                    130 static const u8
DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
1 dc_link.c           detect_link_and_local_sink 1106
memcmp(&link->dpcd_caps.branch_dev_name, DP_SINK_BRANCH_DEV_NAME_7580,


> drivers/misc/cardreader/rts5261.c:406:13: warning: variable 'setting_reg2' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
I think, code wise this looks correct and can be excluded.

> drivers/staging/rtl8723bs/hal/hal_btcoex.c:1182:30: warning: variable 'pHalData' set but not used [-Wunused-but-set-variable]
>
> Error/Warning ids grouped by kconfigs:
>
> gcc_recent_errors
> |-- alpha-allyesconfig
> |   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
> |-- arc-allyesconfig
> |   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
> |-- arm-allmodconfig
> |   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
> |-- arm-allyesconfig
> |   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
> |-- arm64-allyesconfig
> |   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
> |-- i386-allyesconfig
> |   |-- drivers-gpu-drm-amd-amdgpu-..-display-include-ddc_service_types.h:warning:DP_SINK_BRANCH_DEV_NAME_7580-defined-but-not-used
> |   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
> |-- ia64-allmodconfig
> |   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
> |-- m68k-allmodconfig
> |   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
> |-- m68k-allyesconfig
> |   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
> |-- mips-allmodconfig
> |   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
> |-- mips-allyesconfig
> |   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
> |-- nios2-allyesconfig
> |   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
> |-- parisc-allyesconfig
> |   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
> |-- powerpc-allmodconfig
> |   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
> |-- powerpc-allyesconfig
> |   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
> |-- riscv-allmodconfig
> |   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
> |-- riscv-allyesconfig
> |   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
> |-- sh-allmodconfig
> |   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
> |-- sparc-allyesconfig
> |   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
> |-- x86_64-allyesconfig
> |   |-- drivers-gpu-drm-amd-amdgpu-..-display-include-ddc_service_types.h:warning:DP_SINK_BRANCH_DEV_NAME_7580-defined-but-not-used
> |   `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
> `-- xtensa-allyesconfig
>     `-- drivers-staging-rtl8723bs-hal-hal_btcoex.c:warning:variable-pHalData-set-but-not-used
>
> clang_recent_errors
> |-- i386-randconfig-a013
> |   `-- drivers-misc-cardreader-rts5261.c:warning:variable-setting_reg2-is-used-uninitialized-whenever-if-condition-is-false
> `-- riscv-randconfig-r013-20220610
>     |-- arch-riscv-include-asm-pgtable-.h:error:invalid-input-constraint-in-asm
>     `-- arch-riscv-include-asm-pgtable.h:error:invalid-input-constraint-in-asm
>
> elapsed time: 873m
>
> configs tested: 61
> configs skipped: 3
>
> gcc tested configs:
> arm                                 defconfig
> arm                              allmodconfig
> arm                              allyesconfig
> arm64                               defconfig
> arm64                            allyesconfig
> um                             i386_defconfig
> um                           x86_64_defconfig
> ia64                                defconfig
> ia64                             allmodconfig
> ia64                             allyesconfig
> m68k                                defconfig
> m68k                             allyesconfig
> m68k                             allmodconfig
> nios2                               defconfig
> arc                              allyesconfig
> alpha                               defconfig
> csky                                defconfig
> nios2                            allyesconfig
> alpha                            allyesconfig
> h8300                            allyesconfig
> arc                                 defconfig
> sh                               allmodconfig
> xtensa                           allyesconfig
> parisc                              defconfig
> s390                             allmodconfig
> parisc                           allyesconfig
> s390                             allyesconfig
> parisc64                            defconfig
> s390                                defconfig
> i386                   debian-10.3-kselftests
> i386                              debian-10.3
> i386                                defconfig
> i386                             allyesconfig
> sparc                               defconfig
> sparc                            allyesconfig
> mips                             allyesconfig
> mips                             allmodconfig
> powerpc                           allnoconfig
> powerpc                          allmodconfig
> powerpc                          allyesconfig
> i386                          randconfig-a014
> i386                          randconfig-a012
> i386                          randconfig-a016
> riscv                             allnoconfig
> riscv                            allyesconfig
> riscv                            allmodconfig
> riscv                    nommu_k210_defconfig
> riscv                          rv32_defconfig
> riscv                    nommu_virt_defconfig
> riscv                               defconfig
> x86_64                              defconfig
> x86_64                           allyesconfig
> x86_64                                  kexec
> x86_64                               rhel-8.3
> x86_64                         rhel-8.3-kunit
> x86_64                           rhel-8.3-syz
> x86_64                          rhel-8.3-func
> x86_64                    rhel-8.3-kselftests
>
> clang tested configs:
> i386                          randconfig-a013
> i386                          randconfig-a011
> i386                          randconfig-a015
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
>
