Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C666D609C2
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 16:38:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2879910E690;
	Tue, 16 Dec 2025 16:38:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PeniAbmq";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77C8E10E690
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 16:38:33 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2a0f3d2e503so4342335ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 08:38:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765903113; cv=none;
 d=google.com; s=arc-20240605;
 b=a9T01oUOJj0cdxjR/BQXySJB5mXIK8jSlaG6sr8LtgkSOdTgX46y2VWIwb6P8EJ8ul
 0aaWfVaozrd5mTbS7xjXECjCeFju5zht9hTNtG3CDonaCfCqsL7BM59VNMMwokcBXKeG
 V7owfnxuKQvB3K6HaWkHGuC0e2g6se8xFP4M+Qpki5ghChlCwi8GtkN24as2+3f30qXj
 rL/cZKmPH8ldxcD0eSjHw0HLxkfhhqHeyrkNXE6cYvTeng1whUo3ngy4v08/Po4FClyr
 1+sWJkpWiIrlBC2toACcPrkRGRp35D8WSRj3t+BAvnPXCjelaHpfoSpLUHV7yJN5BLI7
 jyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XMrFwPZb6CQ8jcsL5zvoIsRvVOcd0dfCUBKlguCUZZo=;
 fh=hY26Edfw5zSfQ7k5ViI2NrfnfaMcpj1z2TiRTG9Zwhg=;
 b=gAvIjH5+blNMmnp5ZGCG1b6tdNORelFGsr9c5tmgmRWgkG1p28hrzo7MuD6H28DDXq
 hJSdLQsJfPESDXIs91h483ch7sC6KqIVuKA0pU0VZWM5Bi0yZDb5DZIZDFOBr4D2pnNd
 39dpViiXaTyLDGviAtt/exeIcZHWMgEdJnuIkY/ykyOYXpMidr9DP8SGTjq3f34KSL0x
 m0f7PePfZ791FvswZn8qkxJtuv7DghzDY3fGVRhstY+j8hN2T00oqrsselLScXXlDc+K
 Pt17o7Sww/2HnxpNUKgx9zUKvw7jGrIFwkp+L2SyIO99MyaH/p6YeHGKiBHhzPP9yKGZ
 UibA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765903113; x=1766507913; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMrFwPZb6CQ8jcsL5zvoIsRvVOcd0dfCUBKlguCUZZo=;
 b=PeniAbmqMStl9mLrn4RDnq8fY5KQLuSOPPqX9slR7I9+7w1bm/pn+UVvAtNE0cBByF
 vT1gO2djTvwbz63ebjiUXXCM0gAbU1WyI/hagP9oAtYMbV312sSS7ITN3IPnQyDeZitv
 UkQ/yqsUSmydExQ7Sm/DcfSyMDkrXIqaJCyL4nr7u159aNaG19DH8D8V8as7I0IOZC8W
 ZuSwa5y6T5nOMTSZsebzNOEUdnQ21+V55xEvWtpbSy1vyPBwkBRVmmWX6KhKcqut4N+u
 e4PmRQd00lE1r0RsFT6EW6zaZrt25dvb0S37QeALPa5TuRfbZNvPJkjCPSHdqGnIJT4k
 aTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765903113; x=1766507913;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XMrFwPZb6CQ8jcsL5zvoIsRvVOcd0dfCUBKlguCUZZo=;
 b=rqRdUxzLRk1bsyI5h0O2wqRNPcgmYqJhO4HS3pWAh+4/HIN4yzlKLExKR9qZzsxssi
 7psY/wnIdPfwROBdcRzXsExjFdgnIKJ3Ihj66kMjO8cad2Duy07nqCgUQlfDBI9MF4CQ
 fyCTxnQ/2zOJt/Deo5QBbjEKymAsvk4MFDMmBwMx3oct7HEvXVDG/2+2EF7Z1CO9sXYZ
 9lMnuTUXSWo4b3Jcp7x3XiNqKG8gX5htMz+mbYk0mkizKO+cohMcHWKgmJINLyfSB1oz
 GmAhyvVpRxfdDx+UiU3Js+hHXRHbzJcP1NqeRRVtkAFdLT1psQMA3LCxZJHNWyP4l2rW
 veMA==
X-Gm-Message-State: AOJu0YwLYBgiUfM4oiE1h31b0zPDYRc4eYkeaxbxNQJs4stRplBYmmr5
 lSGz2QBm3S/2F94WGS0dEqQf4k2SVzYCeN19m01TYjQOlAP+zLtRzz/rwxsHWz3r7WBoo2adKfa
 AaJqpC4aJnwdNeLRC/lngM3qQwsMcmgzsiuiFekA=
X-Gm-Gg: AY/fxX5jUbRftBibIJfNBgBY3GE3cIOXZCEK8hvW5OSEN0agSpzbl+xd0weNCb3yoDL
 B7I1L40rWes07vfgr/sEkze9uT0nszROPGBMCojJNgNt/3ZTQd0GCyKwyNZEfEQSwCINPBMjFkU
 xoTDVYSW75fqQh1otiEARADwBwoKaY2a0ibCV5+Tm0QvQASsziQZlNyhPRNUJ0sv53ybgHl1H4b
 xU2ymUNtMVsekWQsixwFfCMd/5tv7oU4qpyeZ1PNl7Qmy8/3K8WiANsGbJC/OR66GpObuWT
X-Google-Smtp-Source: AGHT+IH+i2T3/9OrzVWnEjWRNlRGFMAy7zf19SIHWr1YxFQufGKHk8/O368KBdR1S4kaOfSXwOYq0j2GZjzXN9Ii8OQ=
X-Received: by 2002:a05:701b:2513:b0:11a:43fb:58dd with SMTP id
 a92af1059eb24-11f34c3a335mr4552145c88.5.1765903112830; Tue, 16 Dec 2025
 08:38:32 -0800 (PST)
MIME-Version: 1.0
References: <20251203130436.745633-1-lijo.lazar@amd.com>
 <20251203130436.745633-3-lijo.lazar@amd.com>
In-Reply-To: <20251203130436.745633-3-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Dec 2025 11:38:21 -0500
X-Gm-Features: AQt7F2qWIv_3QLcJ5c0CuNCUaSPCex8vX6ARpzw4QWWgCg50ieG-nIJl6mLLQ30
Message-ID: <CADnq5_MjhgFvcRH-r9ppZP=5kKodg5Z3_XTaza5PpONfA4En9Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 02/10] drm/amdgpu: Add cwsr functions
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jesse.Zhang@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Dec 3, 2025 at 8:14=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> Add functions related to cwsr handling inside amdgpu framework.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile      |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 346 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h |  67 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   |   2 +-
>  5 files changed, 418 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index f65021678fc0..a5feb674508a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -67,7 +67,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_doorbell_mgr.o amd=
gpu_kms.o \
>         amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>         amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
>         amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu=
_dev_coredump.o \
> -       amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu=
_ip.o
> +       amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu=
_ip.o  amdgpu_cwsr.o
>
>  amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index fa71df36f4b3..b9920cab5d31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -331,6 +331,7 @@ struct kfd_vm_fault_info;
>  struct amdgpu_hive_info;
>  struct amdgpu_reset_context;
>  struct amdgpu_reset_control;
> +struct amdgpu_cwsr_isa;
>
>  enum amdgpu_cp_irq {
>         AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP =3D 0,
> @@ -1325,6 +1326,8 @@ struct amdgpu_device {
>          * Must be last --ends in a flexible-array member.
>          */
>         struct amdgpu_kfd_dev           kfd;
> +
> +       struct amdgpu_cwsr_info *cwsr_info;
>  };
>
>  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *ade=
v,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cwsr.c
> new file mode 100644
> index 000000000000..c0fc5a383071
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> @@ -0,0 +1,346 @@
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include <drm/drm_exec.h>
> +
> +#include "amdgpu.h"
> +#include "cwsr_trap_handler.h"
> +#include "amdgpu_cwsr.h"
> +
> +extern int cwsr_enable;
> +
> +#define AMDGPU_CWSR_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
> +#define AMDGPU_CWSR_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
> +#define AMDGPU_CWSR_TMA_OFFSET (AMDGPU_CWSR_TBA_MAX_SIZE)
> +
> +enum amdgpu_cwsr_region {
> +       AMDGPU_CWSR_TBA,
> +       AMDGPU_CWSR_TMA,
> +};
> +
> +static inline uint64_t amdgpu_cwsr_tba_vaddr(struct amdgpu_device *adev)
> +{
> +       uint64_t addr =3D AMDGPU_VA_RESERVED_TRAP_START(adev);
> +
> +       addr =3D amdgpu_gmc_sign_extend(addr);
> +
> +       return addr;
> +}
> +
> +static inline bool amdgpu_cwsr_is_supported(struct amdgpu_device *adev)
> +{
> +       uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);
> +
> +       if (!cwsr_enable || gc_ver < IP_VERSION(9, 0, 1))
> +               return false;

Probably also want a check for whether userqs are enabled.  E.g.,

if (adev->gfx.disable_uq)
    return false;

Alex

> +
> +       return true;
> +}
> +
> +static void amdgpu_cwsr_init_isa_details(struct amdgpu_device *adev,
> +                                        struct amdgpu_cwsr_info *cwsr_in=
fo)
> +{
> +       uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);
> +
> +       if (gc_ver < IP_VERSION(9, 0, 1)) {
> +               BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) >
> +                            AMDGPU_CWSR_TBA_MAX_SIZE);
> +               cwsr_info->isa_buf =3D cwsr_trap_gfx8_hex;
> +               cwsr_info->isa_sz =3D sizeof(cwsr_trap_gfx8_hex);
> +       } else if (gc_ver =3D=3D IP_VERSION(9, 4, 1)) {
> +               BUILD_BUG_ON(sizeof(cwsr_trap_arcturus_hex) >
> +                            AMDGPU_CWSR_TBA_MAX_SIZE);
> +               cwsr_info->isa_buf =3D cwsr_trap_arcturus_hex;
> +               cwsr_info->isa_sz =3D sizeof(cwsr_trap_arcturus_hex);
> +       } else if (gc_ver =3D=3D IP_VERSION(9, 4, 2)) {
> +               BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) >
> +                            AMDGPU_CWSR_TBA_MAX_SIZE);
> +               cwsr_info->isa_buf =3D cwsr_trap_aldebaran_hex;
> +               cwsr_info->isa_sz =3D sizeof(cwsr_trap_aldebaran_hex);
> +       } else if (gc_ver =3D=3D IP_VERSION(9, 4, 3) ||
> +                  gc_ver =3D=3D IP_VERSION(9, 4, 4)) {
> +               BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_4_3_hex) >
> +                            AMDGPU_CWSR_TBA_MAX_SIZE);
> +               cwsr_info->isa_buf =3D cwsr_trap_gfx9_4_3_hex;
> +               cwsr_info->isa_sz =3D sizeof(cwsr_trap_gfx9_4_3_hex);
> +       } else if (gc_ver =3D=3D IP_VERSION(9, 5, 0)) {
> +               BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_5_0_hex) > PAGE_SIZE);
> +               cwsr_info->isa_buf =3D cwsr_trap_gfx9_5_0_hex;
> +               cwsr_info->isa_sz =3D sizeof(cwsr_trap_gfx9_5_0_hex);
> +       } else if (gc_ver < IP_VERSION(10, 1, 1)) {
> +               BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex) >
> +                            AMDGPU_CWSR_TBA_MAX_SIZE);
> +               cwsr_info->isa_buf =3D cwsr_trap_gfx9_hex;
> +               cwsr_info->isa_sz =3D sizeof(cwsr_trap_gfx9_hex);
> +       } else if (gc_ver < IP_VERSION(10, 3, 0)) {
> +               BUILD_BUG_ON(sizeof(cwsr_trap_nv1x_hex) >
> +                            AMDGPU_CWSR_TBA_MAX_SIZE);
> +               cwsr_info->isa_buf =3D cwsr_trap_nv1x_hex;
> +               cwsr_info->isa_sz =3D sizeof(cwsr_trap_nv1x_hex);
> +       } else if (gc_ver < IP_VERSION(11, 0, 0)) {
> +               BUILD_BUG_ON(sizeof(cwsr_trap_gfx10_hex) >
> +                            AMDGPU_CWSR_TBA_MAX_SIZE);
> +               cwsr_info->isa_buf =3D cwsr_trap_gfx10_hex;
> +               cwsr_info->isa_sz =3D sizeof(cwsr_trap_gfx10_hex);
> +       } else if (gc_ver < IP_VERSION(12, 0, 0)) {
> +               /* The gfx11 cwsr trap handler must fit inside a single
> +                          page. */
> +               BUILD_BUG_ON(sizeof(cwsr_trap_gfx11_hex) > PAGE_SIZE);
> +               cwsr_info->isa_buf =3D cwsr_trap_gfx11_hex;
> +               cwsr_info->isa_sz =3D sizeof(cwsr_trap_gfx11_hex);
> +       } else {
> +               BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex) >
> +                            AMDGPU_CWSR_TBA_MAX_SIZE);
> +               cwsr_info->isa_buf =3D cwsr_trap_gfx12_hex;
> +               cwsr_info->isa_sz =3D sizeof(cwsr_trap_gfx12_hex);
> +       }
> +}
> +
> +int amdgpu_cwsr_init(struct amdgpu_device *adev)
> +{
> +       struct amdgpu_cwsr_info *cwsr_info __free(kfree) =3D NULL;
> +       void *ptr;
> +       int r;
> +
> +       if (!amdgpu_cwsr_is_supported(adev))
> +               return -EOPNOTSUPP;
> +
> +       cwsr_info =3D kzalloc(sizeof(*cwsr_info), GFP_KERNEL);
> +       if (!cwsr_info)
> +               return -ENOMEM;
> +       amdgpu_cwsr_init_isa_details(adev, cwsr_info);
> +
> +       if (!cwsr_info->isa_sz)
> +               return -EOPNOTSUPP;
> +
> +       r =3D amdgpu_bo_create_kernel(adev, AMDGPU_CWSR_TBA_MAX_SIZE, PAG=
E_SIZE,
> +                                   AMDGPU_GEM_DOMAIN_GTT, &cwsr_info->is=
a_bo,
> +                                   NULL, &ptr);
> +       if (r)
> +               return r;
> +
> +       memcpy(ptr, cwsr_info->isa_buf, cwsr_info->isa_sz);
> +       adev->cwsr_info =3D no_free_ptr(cwsr_info);
> +
> +       return 0;
> +}
> +
> +void amdgpu_cwsr_fini(struct amdgpu_device *adev)
> +{
> +       if (!amdgpu_cwsr_is_enabled(adev))
> +               return;
> +
> +       amdgpu_bo_free_kernel(&adev->cwsr_info->isa_bo, NULL, NULL);
> +       kfree(adev->cwsr_info);
> +       adev->cwsr_info =3D NULL;
> +}
> +
> +/*
> + * amdgpu_map_cwsr_trap_handler should be called during amdgpu_vm_init
> + * it maps virtual address amdgpu_cwsr_trap_handler_vaddr() to this VM, =
and each
> + * compute queue can use this virtual address for wave save/restore
> + * operations to support compute preemption.
> + */
> +static int amdgpu_cwsr_map_region(struct amdgpu_device *adev,
> +                                 struct amdgpu_vm *vm,
> +                                 struct amdgpu_cwsr_trap_obj *cwsr,
> +                                 enum amdgpu_cwsr_region region)
> +{
> +       uint64_t cwsr_addr, va_flags, va;
> +       struct amdgpu_bo_va **bo_va;
> +       struct amdgpu_bo *bo;
> +       uint32_t size;
> +       int r;
> +
> +       if (!cwsr || !vm)
> +               return -EINVAL;
> +
> +       cwsr_addr =3D amdgpu_cwsr_tba_vaddr(adev);
> +
> +       if (region =3D=3D AMDGPU_CWSR_TBA) {
> +               size =3D AMDGPU_CWSR_TBA_MAX_SIZE;
> +               bo_va =3D &cwsr->tba_va;
> +               bo =3D adev->cwsr_info->isa_bo;
> +               va =3D cwsr_addr;
> +               va_flags =3D (AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WR=
ITEABLE |
> +                           AMDGPU_VM_PAGE_EXECUTABLE);
> +       } else {
> +               size =3D AMDGPU_CWSR_TMA_MAX_SIZE;
> +               bo_va =3D &cwsr->tma_va;
> +               bo =3D cwsr->tma_bo;
> +               va =3D cwsr_addr + AMDGPU_CWSR_TMA_OFFSET;
> +               va_flags =3D (AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WR=
ITEABLE);
> +       }
> +
> +       *bo_va =3D amdgpu_vm_bo_add(adev, vm, bo);
> +       if (!*bo_va)
> +               return -ENOMEM;
> +
> +       va &=3D AMDGPU_GMC_HOLE_MASK;
> +       r =3D amdgpu_vm_bo_map(adev, *bo_va, va, 0, size, va_flags);
> +
> +       if (r) {
> +               dev_err(adev->dev, "failed to do bo_map on CWSR TBA, err=
=3D%d\n",
> +                       r);
> +               amdgpu_vm_bo_del(adev, *bo_va);
> +               *bo_va =3D NULL;
> +       } else {
> +               if (region =3D=3D AMDGPU_CWSR_TBA)
> +                       cwsr->tba_gpu_va_addr =3D va;
> +               else
> +                       cwsr->tma_gpu_va_addr =3D va;
> +       }
> +
> +       return r;
> +}
> +
> +static int amdgpu_cwsr_unmap_region(struct amdgpu_device *adev,
> +                                   struct amdgpu_cwsr_trap_obj *cwsr,
> +                                   enum amdgpu_cwsr_region region)
> +{
> +       struct amdgpu_bo_va **bo_va;
> +       uint64_t va;
> +       int r;
> +
> +       if (!cwsr)
> +               return -EINVAL;
> +
> +       if (region =3D=3D AMDGPU_CWSR_TBA) {
> +               bo_va =3D &cwsr->tba_va;
> +               va =3D cwsr->tba_gpu_va_addr;
> +       } else {
> +               bo_va =3D &cwsr->tma_va;
> +               va =3D cwsr->tma_gpu_va_addr;
> +       }
> +
> +       r =3D amdgpu_vm_bo_unmap(adev, *bo_va, va);
> +       if (r) {
> +               dev_err(adev->dev,
> +                       "failed to do bo_unmap on CWSR trap handler, err=
=3D%d\n",
> +                       r);
> +               return r;
> +       }
> +
> +       amdgpu_vm_bo_del(adev, *bo_va);
> +       *bo_va =3D NULL;
> +
> +       return r;
> +}
> +
> +/* TBD : Handle APU allocation */
> +int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +                     struct amdgpu_cwsr_trap_obj **trap_obj)
> +{
> +       struct amdgpu_cwsr_trap_obj *cwsr __free(kfree) =3D NULL;
> +       struct amdgpu_bo *bo;
> +       struct drm_exec exec;
> +       int r;
> +
> +       if (!amdgpu_cwsr_is_enabled(adev))
> +               return -EOPNOTSUPP;
> +
> +       cwsr =3D kzalloc(sizeof(*cwsr), GFP_KERNEL);
> +       if (!cwsr)
> +               return -ENOMEM;
> +
> +       bo =3D adev->cwsr_info->isa_bo;
> +       drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +       drm_exec_until_all_locked(&exec)
> +       {
> +               r =3D amdgpu_vm_lock_pd(vm, &exec, 0);
> +               if (likely(!r))
> +                       r =3D drm_exec_lock_obj(&exec, &bo->tbo.base);
> +               drm_exec_retry_on_contention(&exec);
> +               if (unlikely(r)) {
> +                       dev_err(adev->dev,
> +                               "failed to reserve for CWSR allocs: err=
=3D%d\n",
> +                               r);
> +                       goto err;
> +               }
> +       }
> +
> +       r =3D amdgpu_bo_create_kernel(adev, AMDGPU_CWSR_TMA_MAX_SIZE, PAG=
E_SIZE,
> +                                   AMDGPU_GEM_DOMAIN_GTT, &cwsr->tma_bo,=
 NULL,
> +                                   &cwsr->tma_cpu_addr);
> +       if (r)
> +               goto err;
> +
> +       r =3D amdgpu_cwsr_map_region(adev, vm, cwsr, AMDGPU_CWSR_TMA);
> +       if (r)
> +               goto err;
> +       r =3D amdgpu_cwsr_map_region(adev, vm, cwsr, AMDGPU_CWSR_TBA);
> +       if (r) {
> +               amdgpu_cwsr_unmap_region(adev, cwsr, AMDGPU_CWSR_TMA);
> +               goto err;
> +       }
> +
> +       *trap_obj =3D no_free_ptr(cwsr);
> +
> +err:
> +       drm_exec_fini(&exec);
> +       if (r)
> +               amdgpu_bo_free_kernel(&cwsr->tma_bo, NULL, NULL);
> +
> +       return r;
> +}
> +
> +void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +                     struct amdgpu_cwsr_trap_obj **trap_obj)
> +{
> +       struct amdgpu_bo *tba_bo;
> +       struct amdgpu_bo *tma_bo;
> +       struct drm_exec exec;
> +       int r;
> +
> +       if (!trap_obj || !*trap_obj || !(*trap_obj)->tma_bo)
> +               return;
> +       tba_bo =3D adev->cwsr_info->isa_bo;
> +       tma_bo =3D (*trap_obj)->tma_bo;
> +
> +       if (!tba_bo || !tma_bo)
> +               return;
> +
> +       drm_exec_init(&exec, 0, 0);
> +       drm_exec_until_all_locked(&exec)
> +       {
> +               r =3D amdgpu_vm_lock_pd(vm, &exec, 0);
> +               if (likely(!r))
> +                       r =3D drm_exec_lock_obj(&exec, &tba_bo->tbo.base)=
;
> +               drm_exec_retry_on_contention(&exec);
> +               if (likely(!r))
> +                       r =3D drm_exec_lock_obj(&exec, &tma_bo->tbo.base)=
;
> +               drm_exec_retry_on_contention(&exec);
> +               if (unlikely(r)) {
> +                       dev_err(adev->dev,
> +                               "failed to reserve CWSR BOs: err=3D%d\n",=
 r);
> +                       goto err;
> +               }
> +       }
> +
> +       amdgpu_cwsr_unmap_region(adev, *trap_obj, AMDGPU_CWSR_TBA);
> +       amdgpu_cwsr_unmap_region(adev, *trap_obj, AMDGPU_CWSR_TMA);
> +err:
> +       drm_exec_fini(&exec);
> +       amdgpu_bo_free_kernel(&(*trap_obj)->tma_bo, NULL, NULL);
> +       kfree(*trap_obj);
> +       *trap_obj =3D NULL;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cwsr.h
> new file mode 100644
> index 000000000000..26ed9308f70b
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> @@ -0,0 +1,67 @@
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#ifndef AMDGPU_CWSR_H
> +#define AMDGPU_CWSR_H
> +
> +#include <linux/types.h>
> +
> +struct amdgpu_bo;
> +struct amdgpu_bo_va;
> +struct amdgpu_device;
> +struct amdgpu_vm;
> +
> +/**
> + * struct amdgpu_cwsr_obj - CWSR (Compute Wave Save Restore) buffer trac=
king
> + * @bo: Buffer object for CWSR area
> + * @bo_va: Buffer object virtual address mapping
> + */
> +struct amdgpu_cwsr_trap_obj {
> +       uint64_t tma_gpu_va_addr;
> +       uint64_t tba_gpu_va_addr;
> +
> +       struct amdgpu_bo *tma_bo;
> +       struct amdgpu_bo_va *tba_va;
> +       struct amdgpu_bo_va *tma_va;
> +       void *tma_cpu_addr;
> +};
> +
> +struct amdgpu_cwsr_info {
> +       /* cwsr isa */
> +       struct amdgpu_bo *isa_bo;
> +       const void *isa_buf;
> +       uint32_t isa_sz;
> +};
> +
> +int amdgpu_cwsr_init(struct amdgpu_device *adev);
> +void amdgpu_cwsr_fini(struct amdgpu_device *adev);
> +
> +int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +                     struct amdgpu_cwsr_trap_obj **cwsr_obj);
> +void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +                     struct amdgpu_cwsr_trap_obj **cwsr_obj);
> +static inline bool amdgpu_cwsr_is_enabled(struct amdgpu_device *adev)
> +{
> +       return adev->cwsr_info !=3D NULL;
> +}
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index 139642eacdd0..783ca2b8dfef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
>  #define AMDGPU_VA_RESERVED_SEQ64_SIZE          (2ULL << 20)
>  #define AMDGPU_VA_RESERVED_SEQ64_START(adev)   (AMDGPU_VA_RESERVED_CSA_S=
TART(adev) \
>                                                  - AMDGPU_VA_RESERVED_SEQ=
64_SIZE)
> -#define AMDGPU_VA_RESERVED_TRAP_SIZE           (2ULL << 12)
> +#define AMDGPU_VA_RESERVED_TRAP_SIZE           (3ULL << 12)
>  #define AMDGPU_VA_RESERVED_TRAP_START(adev)    (AMDGPU_VA_RESERVED_SEQ64=
_START(adev) \
>                                                  - AMDGPU_VA_RESERVED_TRA=
P_SIZE)
>  #define AMDGPU_VA_RESERVED_BOTTOM              (1ULL << 16)
> --
> 2.49.0
>
