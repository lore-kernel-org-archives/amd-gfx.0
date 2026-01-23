Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B54D778AE
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 20:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2FB010EBD9;
	Fri, 23 Jan 2026 20:41:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lhUa/26g";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4044110EBD9
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 20:41:26 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1233ad1b4cdso281954c88.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 12:41:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769200885; cv=none;
 d=google.com; s=arc-20240605;
 b=BHp7I4s6oCPoSSPTuK3IDo8aomZVG6iOWaojYdHECDwBkSKaAu73oqTInc9ypaIayI
 bBur8cP3/4Neh0F4y4AijEs2uYpEAjbHbtAYW0N7WdNpBfQuyYgPVABfTkSokAv62Krr
 FBVSOW5aff3HnhaqzTyxSigqotp0jEz1gd3gULj+FSqFn21D+zh7/JhkMLy9iJneK6rk
 YekhctRTBzGRFjNoF+TuyC2fbolKnwRn7Uv6yyn2+YoljE8tY78me71xr/J4lViom/E2
 1dqHRVWF8uPzhsUabnFt1Qbt49hUS5PZJcJCD34vhLkK0JscO5ntqr8uNOv6vQ2dL+UU
 QlpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=STpFiC/5Y4a26mwhAkCauN8U3wXqxrYqjQNHggbvqK8=;
 fh=hY26Edfw5zSfQ7k5ViI2NrfnfaMcpj1z2TiRTG9Zwhg=;
 b=O0oooi/SWwjix5sHygYoTnx9+1PacRWP7NWILdws3Lw2frc0iHk0UjijgIKkDlXnr8
 jMa16e3/ibAEP2ftis4cVMqQfoFumxaQhxowIDfGr2cnwluPXNbnutQUthxVyacDFvpw
 dBuhCc6ILVElKIwK3sRqpHzdVGCCrqnqnLpYPRd6UK9PbJhxEl9LGI9Qpaf3s7FdrQ87
 vYdSn/Mzd2bCGTKchQnRVSVWOHgkFwYf8i0AAeZ0D1CaYbx/oVR56VwocTXS3VMcv+UH
 XnC5kima3lQc7wiKyIteS6nxRE2Kgzwo9rBNxBUu2JvhBKksPIyPyKfa0ZV/jKwYyCV0
 JW1w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769200885; x=1769805685; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=STpFiC/5Y4a26mwhAkCauN8U3wXqxrYqjQNHggbvqK8=;
 b=lhUa/26g9Gw1kfkUUGHPFWd/KsXABlXp5XFwrUVFtw6SIHFCK4vT1ZLDJ6NrIrhHSH
 xWAkgn2DQaKiUxAP1BUH0uHK12hVER2O6SlH8Lo0pvF2P6ms08ARvWoThNKCOpuWH89O
 FbrZLOVzS2GcTg0uCz0AeP6Dla0Lyhx5LXklSw+XSLIqKUdsmm1IJcn3AQQJuTKrTuo2
 yM/L0ZEh1ogxp9t1fUIP4Ga3JIwViEg0nd6cPF5f2/WzadWzEs8mgKOjsHVVSrBeZ5C1
 6U68AdSYVb7tarP9tOngj+qbHccVaqcnqqUKplcOTy0tPA5lJacVrQzMyi/XrJCSUKKg
 OwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769200885; x=1769805685;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=STpFiC/5Y4a26mwhAkCauN8U3wXqxrYqjQNHggbvqK8=;
 b=kaHoJ7i7w0BN29/1YNcPwd6DNijN1z/a86zGUlFcVYiWM4laE5vF/WkLIkbBb0kvar
 Q+Qod7Ra09rEdmL1RN1Z9JIzVlrl+GdQKFFtawYU4JGD84CG6OSeSsgwFgDY+019V1J/
 mVBbPGfVhAm8TeBozg+sffAMekV/xwgX88QWGM2M12kNSB9rgbgKqTeyDafusod83vUJ
 nymCMe/hExhY+/rc8eTjvJgOQNoviXcx17gl8tVj8sE0c8BU8OZi7ZjTxYLI6seTodSo
 dtU5MPh5n/XEAoEOAPLJdrTNML79AgtgieE+pNoKMaAfyAh7oZafisB923Ek8l2hxW4Y
 LlzA==
X-Gm-Message-State: AOJu0Ywl2+68QBKvI1XH0xbLc54Us/YCls5tMgSCHJe4d3US/M3NW3hs
 AR0nCcBgfH3oloXzFHHBI8IA7C+0lbhj7x0vqUrOvihOgKf4JXfsl7HtTnSQBmBUT+E6LtpYw+L
 NseteN+9aeLhzxdGldyCGaUDS3YCvoxg=
X-Gm-Gg: AZuq6aL1Cf0SJqLZ7RxAGOJVQgWJ/tzxhj/YfDUZK8fYJzLa5M+huu0TgXx/1MSpWux
 ZRP7y9x/XnKG3MPeauT7CgyyYSOHsF/NKtf9ZA/zXC7SuXU50mIQxcDPE2eXoYuFThjk+VWloAT
 8ZN+AK97UqapthV670KYtq6GajdWANx/7Bj7l1eTCapI5aoEKhFo41QW+yGV0jCoBT2wUNW5AFL
 CiShZmy52/4R3Nn3mX8SDznssAUL7boRokHwU26F/iH2KuSPsPF0uJiK44uw41PSY8F9b7tq5wa
 0+i/oDQ=
X-Received: by 2002:a05:7022:301:b0:119:e56a:4fff with SMTP id
 a92af1059eb24-1247dbffc9amr1086313c88.4.1769200885150; Fri, 23 Jan 2026
 12:41:25 -0800 (PST)
MIME-Version: 1.0
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
 <20260122104118.1682154-3-lijo.lazar@amd.com>
In-Reply-To: <20260122104118.1682154-3-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Jan 2026 15:41:12 -0500
X-Gm-Features: AZwV_QiPKIlackcIRRDorC6zV-3xXKIiute92s-0NXKwhwKzHrp40dLFJKqL1N8
Message-ID: <CADnq5_ONygcpiTmjiDqPFC4642VbAc7cj16O8dad9PUNNSVF9Q@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] drm/amdgpu: Add cwsr functions
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

On Thu, Jan 22, 2026 at 6:37=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Add functions related to cwsr handling inside amdgpu framework.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile      |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 364 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h |  67 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   |  13 +-
>  5 files changed, 445 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index 8e22882b66aa..3b563c73bb66 100644
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
> index 9c11535c44c6..0ace28c170bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -328,6 +328,7 @@ struct kfd_vm_fault_info;
>  struct amdgpu_hive_info;
>  struct amdgpu_reset_context;
>  struct amdgpu_reset_control;
> +struct amdgpu_cwsr_isa;
>
>  enum amdgpu_cp_irq {
>         AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP =3D 0,
> @@ -1237,6 +1238,8 @@ struct amdgpu_device {
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
> index 000000000000..f2d3837366bf
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> @@ -0,0 +1,364 @@
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
> +       uint64_t addr =3D AMDGPU_VA_RESERVED_TRAP_UQ_START(adev);
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
> +       if (!cwsr_enable || adev->gfx.disable_uq ||
> +           gc_ver < IP_VERSION(9, 0, 1))
> +               return false;
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
> +       } else if (gc_ver < IP_VERSION(12, 1, 0)) {
> +               BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex) >
> +                            AMDGPU_CWSR_TBA_MAX_SIZE);
> +               cwsr_info->isa_buf =3D cwsr_trap_gfx12_hex;
> +               cwsr_info->isa_sz =3D sizeof(cwsr_trap_gfx12_hex);
> +       } else {
> +               BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_hex) >
> +                            AMDGPU_CWSR_TBA_MAX_SIZE);
> +               cwsr_info->isa_buf =3D cwsr_trap_gfx12_1_0_hex;
> +               cwsr_info->isa_sz =3D sizeof(cwsr_trap_gfx12_1_0_hex);
> +       }
> +}
> +
> +int amdgpu_cwsr_init(struct amdgpu_device *adev)
> +{
> +       struct amdgpu_cwsr_info *cwsr_info __free(kfree) =3D
> +               kzalloc(sizeof(*cwsr_info), GFP_KERNEL);
> +       void *ptr;
> +       int r;
> +
> +       if (!amdgpu_cwsr_is_supported(adev))
> +               return -EOPNOTSUPP;
> +
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
> +       if (r) {
> +               dev_err(adev->dev, "failed to do bo map of %s region, err=
=3D%d\n",
> +                       (region =3D=3D AMDGPU_CWSR_TBA ? "tba" : "tma"), =
r);
> +               amdgpu_vm_bo_del(adev, *bo_va);
> +               *bo_va =3D NULL;
> +               return r;
> +       }
> +
> +       r =3D amdgpu_vm_bo_update(adev, *bo_va, false);
> +       if (r) {
> +               dev_err(adev->dev,
> +                       "failed to do page table update of %s region, err=
=3D%d\n",
> +                       (region =3D=3D AMDGPU_CWSR_TBA ? "tba" : "tma"), =
r);
> +               amdgpu_vm_bo_del(adev, *bo_va);
> +               *bo_va =3D NULL;
> +               return r;
> +       }
> +
> +       if (region =3D=3D AMDGPU_CWSR_TBA)
> +               cwsr->tba_gpu_va_addr =3D va;
> +       else
> +               cwsr->tma_gpu_va_addr =3D va;
> +
> +       return 0;
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
> +int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +                     struct amdgpu_cwsr_trap_obj **trap_obj)
> +{
> +       struct amdgpu_cwsr_trap_obj *cwsr;
> +       struct amdgpu_bo *bo;
> +       struct drm_exec exec;
> +       int r;
> +
> +       if (!amdgpu_cwsr_is_enabled(adev))
> +               return -EOPNOTSUPP;
> +       if (!vm || !trap_obj)
> +               return -EINVAL;
> +       cwsr =3D kzalloc(sizeof(*cwsr), GFP_KERNEL);
> +       if (!cwsr)
> +               return -ENOMEM;
> +
> +       bo =3D adev->cwsr_info->isa_bo;
> +       drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +       drm_exec_until_all_locked(&exec) {
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
> +err:
> +       drm_exec_fini(&exec);
> +       if (r) {
> +               amdgpu_bo_free_kernel(&cwsr->tma_bo, NULL, NULL);
> +               kfree(cwsr);
> +               *trap_obj =3D NULL;
> +       } else {
> +               *trap_obj =3D cwsr;
> +       }
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
> index 139642eacdd0..9bde17815a6a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -176,10 +176,17 @@ struct amdgpu_bo_vm;
>  #define AMDGPU_VA_RESERVED_TRAP_SIZE           (2ULL << 12)
>  #define AMDGPU_VA_RESERVED_TRAP_START(adev)    (AMDGPU_VA_RESERVED_SEQ64=
_START(adev) \
>                                                  - AMDGPU_VA_RESERVED_TRA=
P_SIZE)
> +/* TBD: Ideally, existing TRAP VA should do. There is a conflict with KF=
D mapping that needs to be
> + * resolved. Revisit later.
> + */
> +#define AMDGPU_VA_RESERVED_TRAP_UQ_SIZE (3ULL << 12)
> +#define AMDGPU_VA_RESERVED_TRAP_UQ_START(adev) \
> +       (AMDGPU_VA_RESERVED_TRAP_START(adev) - AMDGPU_VA_RESERVED_TRAP_UQ=
_SIZE)
> +
>  #define AMDGPU_VA_RESERVED_BOTTOM              (1ULL << 16)
> -#define AMDGPU_VA_RESERVED_TOP                 (AMDGPU_VA_RESERVED_TRAP_=
SIZE + \
> -                                                AMDGPU_VA_RESERVED_SEQ64=
_SIZE + \
> -                                                AMDGPU_VA_RESERVED_CSA_S=
IZE)
> +#define AMDGPU_VA_RESERVED_TOP                                          =
  \
> +       (AMDGPU_VA_RESERVED_TRAP_UQ_SIZE + AMDGPU_VA_RESERVED_TRAP_SIZE +=
 \
> +        AMDGPU_VA_RESERVED_SEQ64_SIZE + AMDGPU_VA_RESERVED_CSA_SIZE)
>
>  /* See vm_update_mode */
>  #define AMDGPU_VM_USE_CPU_FOR_GFX (1 << 0)
> --
> 2.49.0
>
