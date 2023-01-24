Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543E1C25B4E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jan 2023 08:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD03510E62E;
	Tue, 24 Jan 2023 08:39:17 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 512D910E221
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jan 2023 02:03:06 +0000 (UTC)
Received: by mail-qt1-x82e.google.com with SMTP id a25so11997728qto.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jan 2023 18:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5fwAlp70Ff4dBjWPdd/F0+lK8VDSloFSOXJcS+AUrrM=;
 b=V0D4L90ZZUkdJf/6DGZzuuLkYyesEi0Jl2hiKZoR8TLDJ5CRHjAUjuZmLSc6ZihVXT
 zQ7JCpYnVDANz/rreLnJ+M+u40T8wqXD31l59Px2B6WhH/yxSMFcKopDarmiNg1UzI44
 oj976H1QZprkzZ+LeR8XtLUUM83eBui4m7oVwMayUxnw+eeDv1dhQ1WaSUdRQ+8veDQQ
 pRJkBAge0izg3P2A9Nccn0pjDYAy5tmRMacz0S1h/ZSbstc+tIm6sDy7iXmEYbLkJfb0
 TaKYfjbLt0uQDH5mojt+avozhSbFMY0qJpT7YQX5PdQ/O4nUTgOAdWCit9n218JaZzqS
 Z1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5fwAlp70Ff4dBjWPdd/F0+lK8VDSloFSOXJcS+AUrrM=;
 b=5gPggtF3NVoEwbhicW5tLMIRf5+FBasH9sHQ5lBuAXv++HB7ymjjdnZg0BU/Uo3+WK
 9Hhsw0HO5MzXCpGPypAgmXacZE4PuFCkQFOm+WewfDIqRpg9gSBR4V0UWCt+hadrZ32E
 vlu9pHFA5+MGp0aJDwEJdXpWbzOVgEuOKj4/JF5CXxM30tKoSmMMqdoUPVw40qT+z+zw
 xm/qiZq6z4Q3KY3+wO+lHfMCxY0cqj1zd8u7c/Zl9gsCEz2R01CA0qrN93kQtlLY1FkN
 xirwcpHEfw89HtIUFpaJgTA4pG6VJwCrlZ7CC8zj6+2sio5VFekjvTpgjUMOWK0lPalS
 BEtQ==
X-Gm-Message-State: AFqh2kpkCfbjJ8mCLFyaTaa4mlpZlj3AJ1FeGnK07UBeMsaORTtsY/gC
 8rLBpTXUS1gICPwswa6JZUY9ZC6erbkJKMu6dhs=
X-Google-Smtp-Source: AMrXdXsECu2naqYe2lCRPinn6EhL3OkOZ/D126kEQS4qf3HFIfCEeJ2wlj/mgQI1xEjEQoEdef6ZA9Wbq4wv1XTmCiI=
X-Received: by 2002:ac8:774d:0:b0:3b6:6669:dd20 with SMTP id
 g13-20020ac8774d000000b003b66669dd20mr755912qtu.93.1674525785184; Mon, 23 Jan
 2023 18:03:05 -0800 (PST)
MIME-Version: 1.0
References: <63cacbd5.EvTYTGZtWc/zCwC9%lkp@intel.com>
In-Reply-To: <63cacbd5.EvTYTGZtWc/zCwC9%lkp@intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 23 Jan 2023 18:02:54 -0800
Message-ID: <CAKEwX=OTDeJDs0ChuLXk8o__U6h_dHBB7YuVPBx4zOwDNU5eBw@mail.gmail.com>
Subject: Re: [linux-next:master] BUILD REGRESSION
 d514392f17fd4d386cfadde7f849d97db4ca1fb0
To: kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 24 Jan 2023 08:39:14 +0000
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 amd-gfx@lists.freedesktop.org,
 Linux Memory Management List <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, sound-open-firmware@alsa-project.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 20, 2023 at 9:14 AM kernel test robot <lkp@intel.com> wrote:
>
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> branch HEAD: d514392f17fd4d386cfadde7f849d97db4ca1fb0  Add linux-next specific files for 20230120
>
> Error/Warning reports:
>
> https://lore.kernel.org/oe-kbuild-all/202301191616.R33Dvxk4-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202301192229.wL7iPJxS-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202301201120.aIaz7dT4-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202301202042.herfGxx6-lkp@intel.com
>
> Error/Warning: (recently discovered and may have been fixed)
>
> Documentation/virt/kvm/api.rst:5070: WARNING: Unexpected indentation.
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_training.c:1585:38: warning: variable 'result' set but not used [-Wunused-but-set-variable]
> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5253:24: sparse:    left side has type restricted __le16
> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5253:24: sparse:    right side has type restricted __le32
> idma64.c:(.text+0x6a): undefined reference to `devm_platform_ioremap_resource'
>
> Unverified Error/Warning (likely false positive, please contact us if interested):
>
> drivers/net/dsa/microchip/ksz_ptp.c:217 ksz_ptp_clock_register() warn: passing zero to 'PTR_ERR'
> drivers/nvmem/imx-ocotp.c:599:21: sparse: sparse: symbol 'imx_ocotp_layout' was not declared. Should it be static?
> drivers/nvmem/layouts/sl28vpd.c:143:21: sparse: sparse: symbol 'sl28vpd_layout' was not declared. Should it be static?
> mm/hugetlb.c:3101 alloc_hugetlb_folio() error: uninitialized symbol 'h_cg'.
> mm/zsmalloc.c:900:20: warning: unused function 'obj_allocated' [-Wunused-function]

This bug was detected and fix by Arnd Bergmann:

https://lore.kernel.org/lkml/CAKEwX=OTpY9Wg6YPfADDqeu7FFzciY9o_nNE5dRR3cu_-2ntaw@mail.gmail.com/T/

It is triggered when neither CONFIG_ZPOOL nor CONFIG_COMPACTION is set.

> sound/soc/sof/sof-audio.c:329 sof_prepare_widgets_in_path() error: we previously assumed 'swidget' could be null (see line 306)
>
> Error/Warning ids grouped by kconfigs:
>
> gcc_recent_errors
> |-- alpha-allyesconfig
> |   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
> |-- arc-allyesconfig
> |   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
> |-- arm-allyesconfig
> |   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
> |-- arm-randconfig-s032-20230119
> |   `-- drivers-nvmem-imx-ocotp.c:sparse:sparse:symbol-imx_ocotp_layout-was-not-declared.-Should-it-be-static
> |-- arm64-allyesconfig
> |   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
> |-- csky-randconfig-m041-20230119
> |   |-- drivers-net-dsa-microchip-ksz_ptp.c-ksz_ptp_clock_register()-warn:passing-zero-to-PTR_ERR
> |   `-- sound-soc-sof-sof-audio.c-sof_prepare_widgets_in_path()-error:we-previously-assumed-swidget-could-be-null-(see-line-)
> |-- csky-randconfig-r025-20230119
> |   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
> |-- csky-randconfig-s043-20230119
> |   |-- drivers-net-wireless-realtek-rtl8xxxu-rtl8xxxu_core.c:sparse:left-side-has-type-restricted-__le16
> |   |-- drivers-net-wireless-realtek-rtl8xxxu-rtl8xxxu_core.c:sparse:right-side-has-type-restricted-__le32
> |   `-- drivers-net-wireless-realtek-rtl8xxxu-rtl8xxxu_core.c:sparse:sparse:invalid-assignment:
> |-- i386-allyesconfig
> |   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
> |-- ia64-allmodconfig
> |   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
> |-- ia64-randconfig-c033-20230119
> |   `-- drivers-net-ethernet-microchip-vcap-vcap_api.c:WARNING-opportunity-for-kmemdup
> |-- ia64-randconfig-s052-20230119
> |   `-- drivers-nvmem-imx-ocotp.c:sparse:sparse:symbol-imx_ocotp_layout-was-not-declared.-Should-it-be-static
> |-- loongarch-randconfig-r024-20230119
> |   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
> |-- loongarch-randconfig-s042-20230119
> |   `-- drivers-nvmem-layouts-sl28vpd.c:sparse:sparse:symbol-sl28vpd_layout-was-not-declared.-Should-it-be-static
> |-- m68k-randconfig-c004-20230119
> |   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
> |-- mips-allyesconfig
> |   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
> |-- openrisc-randconfig-s033-20230119
> |   `-- drivers-nvmem-imx-ocotp.c:sparse:sparse:symbol-imx_ocotp_layout-was-not-declared.-Should-it-be-static
> |-- powerpc-allmodconfig
> |   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
> |-- riscv-randconfig-s041-20230119
> |   `-- drivers-nvmem-imx-ocotp.c:sparse:sparse:symbol-imx_ocotp_layout-was-not-declared.-Should-it-be-static
> |-- s390-allyesconfig
> |   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
> |-- sparc-allyesconfig
> |   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
> |-- x86_64-allnoconfig
> |   `-- Documentation-virt-kvm-api.rst:WARNING:Unexpected-indentation.
> |-- x86_64-allyesconfig
> |   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-link-link_dp_training.c:warning:variable-result-set-but-not-used
> `-- x86_64-randconfig-m001
> clang_recent_errors
> |-- s390-randconfig-r044-20230119
> |   `-- idma64.c:(.text):undefined-reference-to-devm_platform_ioremap_resource
> `-- x86_64-randconfig-a012
>     `-- mm-zsmalloc.c:warning:unused-function-obj_allocated
>
> elapsed time: 882m
>
> configs tested: 79
> configs skipped: 3
>
> gcc tested configs:
> x86_64                            allnoconfig
> um                             i386_defconfig
> i386                                defconfig
> um                           x86_64_defconfig
> x86_64                              defconfig
> x86_64                               rhel-8.3
> arc                                 defconfig
> alpha                               defconfig
> arm                                 defconfig
> i386                          randconfig-a001
> x86_64                          rhel-8.3-func
> m68k                             allyesconfig
> x86_64                           rhel-8.3-syz
> x86_64                    rhel-8.3-kselftests
> x86_64                           allyesconfig
> powerpc                           allnoconfig
> x86_64                         rhel-8.3-kunit
> ia64                             allmodconfig
> arm                  randconfig-r046-20230119
> x86_64                        randconfig-a002
> arm                              allyesconfig
> arc                  randconfig-r043-20230119
> m68k                             allmodconfig
> i386                          randconfig-a003
> arc                              allyesconfig
> arm64                            allyesconfig
> alpha                            allyesconfig
> x86_64                           rhel-8.3-kvm
> x86_64                        randconfig-a006
> i386                          randconfig-a005
> x86_64                           rhel-8.3-bpf
> x86_64                        randconfig-a004
> sparc64                          alldefconfig
> riscv                             allnoconfig
> sparc                       sparc32_defconfig
> m68k                          hp300_defconfig
> i386                             allyesconfig
> powerpc                 mpc85xx_cds_defconfig
> parisc                           alldefconfig
> riscv                    nommu_virt_defconfig
> mips                         bigsur_defconfig
> arm                        keystone_defconfig
> sh                   secureedge5410_defconfig
> i386                          randconfig-a014
> riscv                    nommu_k210_defconfig
> s390                                defconfig
> i386                          randconfig-a012
> x86_64                        randconfig-a013
> i386                          randconfig-a016
> riscv                          rv32_defconfig
> s390                             allmodconfig
> sh                               allmodconfig
> i386                   debian-10.3-kselftests
> x86_64                        randconfig-a011
> i386                              debian-10.3
> i386                          randconfig-c001
> mips                             allyesconfig
> x86_64                        randconfig-a015
> s390                             allyesconfig
> powerpc                          allmodconfig
>
> clang tested configs:
> x86_64                          rhel-8.3-rust
> x86_64                        randconfig-a005
> hexagon              randconfig-r045-20230119
> x86_64                        randconfig-a001
> i386                          randconfig-a002
> riscv                randconfig-r042-20230119
> x86_64                        randconfig-a003
> hexagon              randconfig-r041-20230119
> s390                 randconfig-r044-20230119
> i386                          randconfig-a006
> x86_64                        randconfig-k001
> i386                          randconfig-a004
> arm                           omap1_defconfig
> i386                          randconfig-a013
> i386                          randconfig-a011
> i386                          randconfig-a015
> x86_64                        randconfig-a016
> x86_64                        randconfig-a012
> x86_64                        randconfig-a014
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
>
