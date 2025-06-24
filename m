Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3B5C77B7F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 13:27:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C8B610E5A8;
	Tue, 24 Jun 2025 13:27:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RYbe6Gbv";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43E3110E5A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 13:27:03 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-313756c602fso631194a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 06:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750771623; x=1751376423; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TDxkqDYnJ9n5ZqlEYOxkD1pvh9FkSUPjK2tqxtZqoDg=;
 b=RYbe6GbvQajWNwjRfQXb6WLV80YP/ZYZ5a10qquNe0jg9mq1K4CmTpJEHcKGi4/KgV
 YoPBhW9dyM/hHR4qjCjAtYi26vhoW2+/sWvFwKKzjzm6LYuFr+NpKUD7xmvK7wqXpoCf
 W+/sNtiOan3KuvKtuC5sa6OES4pUx/00EcBknZ8ILxJDVpEZB5Bubow71ZTNO2nm7HcH
 vhsDqfGFpbNPCxDR8jOSzc3skhtZ2izV5aJPqQBYShCtBQ2h01gOzyr+ECJqyRQpiKcE
 xhF4uG4hr3a5DLmbtkklak39OzYpEwI0Yy/eo4wqZvKkQ9cH3Ayp4as4lad0YACMMnqS
 VB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750771623; x=1751376423;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TDxkqDYnJ9n5ZqlEYOxkD1pvh9FkSUPjK2tqxtZqoDg=;
 b=a9jJv27evLyP6yGaWp1zz1BfZCeUG8zsMLD0ymcw8veUtF6pBeVXQgk1tHj8IwAF5D
 lBCA9vAFifLuB/ib+5jic8M8EhVKq2TcofNeza2Ew39mhHv5R0Kec88mKfFCSw5+8m+/
 fj2+79OjcTSW0zpBLdH1SpKU82rlWXJJxpCJ6rwz5dCISbbV8CMfacBzhhgf6zmcIP8r
 A4rtG2dsdfsLHWlVOQ2ZSR0uLKJEJkUG5wDbvPzqxdqn5WC81MAih8mqG9a+rWQ9mYLj
 WlPw8nQnuZG1uMs9Vd1ny0gePNrlpbuDe3868wcka00jwmPriJWWZmfXTTWX8SC3RvDW
 rsvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4AI9Pd7EqryGGbKC58J/EkdH4wk6Cb3QkfZ8ElvlaiD7AsofVl18Y8N/n3401nd8k4WL+SAfS@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRjrQYGun0oTsoM8WK8/sBN9Z9HBshtPynTVWyS5D3ZOoBemDp
 rYX9U6MzGIYhnW8rVOQSEI9O9W7kLxck2Q1hsqkvkf1yMZ7FI+oQUljhydRqThGILK2kbtvXXo3
 /Ukh/5wE/gNgl7TXoVXdZoxTJyqKzqCg=
X-Gm-Gg: ASbGncvYQ/9ZzlIdvByiz3v2ZQ8n++dNAfAXbyjUbK2GmouAkVKuUGSXqofYXRB4GBK
 GZdDRTdIFMysX1GfMuA39OWF8qm+Yyym/ASgK4n6fAyg/OakPIdFQ6F82VK/DQ575uEWXyZYYdC
 IjZTJxU2nIGhlkl/PeYozBncJLKLe68zLMF2xS4ClnLtVD
X-Google-Smtp-Source: AGHT+IFd39f6Lx1lXJ3fnRcZnz56hX/AvyRwKnqc0/4EO/gb+cPBT6CzH2A7nUcdZx/l+rkpXnCwUSlPOduAFkM9UnY=
X-Received: by 2002:a17:90b:17cb:b0:311:c5d9:2c8b with SMTP id
 98e67ed59e1d1-3159d8e05f7mr9688635a91.5.1750771622483; Tue, 24 Jun 2025
 06:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250623111717.224707-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250623111717.224707-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Jun 2025 09:26:51 -0400
X-Gm-Features: AX0GCFuqsvInSPXndARyCOVc234RzD2gyWcuhhDoQBnjXRGOF_fqBgJn8vdMwSA
Message-ID: <CADnq5_N8sp5L0FEhkahmOErn76Ao9=HwziHSTG1fEeipPaOsVw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Unify Device Aperture in amdgpu_info_ioctl
 for KGD/KFD
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Mon, Jun 23, 2025 at 7:24=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This commit refines the amdgpu_info_ioctl function to unify
> the reporting of device apertures for both KGD and KFD
> subsystems.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      | 23 ++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       | 29 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 29 --------------------
>  include/uapi/drm/amdgpu_drm.h                |  6 ++++
>  4 files changed, 58 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index d2ce7d86dbc8..6ca399a92814 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -46,6 +46,7 @@
>  #include "amdgpu_reset.h"
>  #include "amd_pcie.h"
>  #include "amdgpu_userq.h"
> +#include "amdgpu_vm.h"
>
>  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>  {
> @@ -1011,6 +1012,28 @@ int amdgpu_info_ioctl(struct drm_device *dev, void=
 *data, struct drm_file *filp)
>
>                 dev_info->userq_ip_mask =3D amdgpu_userq_get_supported_ip=
_mask(adev);
>
> +               /* Retrieve Device Apertures */
> +               if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 0,=
 0)) {

This logic looks incorrect.  Also, you need to use amdgpu_ip_version()
rather than directly accessing the IP version.  I think this check
should be:

if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(9, 0, 0)) {

Alex

> +                       dev_info->lds_base =3D MAKE_LDS_APP_BASE_V9();
> +                       dev_info->scratch_base =3D MAKE_SCRATCH_APP_BASE_=
V9();
> +
> +                       dev_info->lds_limit =3D MAKE_LDS_APP_LIMIT(dev_in=
fo->lds_base);
> +                       dev_info->scratch_limit =3D MAKE_SCRATCH_APP_LIMI=
T(dev_info->scratch_base);
> +               } else {
> +                       dev_info->lds_base =3D MAKE_LDS_APP_BASE_VI();
> +                       dev_info->scratch_base =3D MAKE_SCRATCH_APP_BASE_=
VI();
> +
> +                       dev_info->lds_limit =3D MAKE_LDS_APP_LIMIT(dev_in=
fo->lds_base);
> +                       dev_info->scratch_limit =3D MAKE_SCRATCH_APP_LIMI=
T(dev_info->scratch_base);
> +               }
> +
> +               dev_dbg(adev->dev, "Node ID: %u\n", adev->dev->id);
> +               dev_dbg(adev->dev, "GPU ID: %u\n", dev_info->device_id);
> +               dev_dbg(adev->dev, "LDS Base: %llX\n", dev_info->lds_base=
);
> +               dev_dbg(adev->dev, "LDS Limit: %llX\n", dev_info->lds_lim=
it);
> +               dev_dbg(adev->dev, "Scratch Base: %llX\n", dev_info->scra=
tch_base);
> +               dev_dbg(adev->dev, "Scratch Limit: %llX\n", dev_info->scr=
atch_limit);
> +
>                 ret =3D copy_to_user(out, dev_info,
>                                    min((size_t)size, sizeof(*dev_info))) =
? -EFAULT : 0;
>                 kfree(dev_info);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index f3ad687125ad..6ee09df0d345 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -184,6 +184,35 @@ struct amdgpu_bo_vm;
>  #define AMDGPU_VM_USE_CPU_FOR_GFX (1 << 0)
>  #define AMDGPU_VM_USE_CPU_FOR_COMPUTE (1 << 1)
>
> +#define MAKE_GPUVM_APP_BASE_VI(gpu_num) \
> +       (((uint64_t)(gpu_num) << 61) + 0x1000000000000L)
> +
> +#define MAKE_GPUVM_APP_LIMIT(base, size) \
> +       (((uint64_t)(base) & 0xFFFFFF0000000000UL) + (size) - 1)
> +
> +#define MAKE_SCRATCH_APP_BASE_VI() \
> +       (((uint64_t)(0x1UL) << 61) + 0x100000000L)
> +
> +#define MAKE_SCRATCH_APP_LIMIT(base) \
> +       (((uint64_t)(base) & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
> +
> +#define MAKE_LDS_APP_BASE_VI() \
> +       (((uint64_t)(0x1UL) << 61) + 0x0)
> +#define MAKE_LDS_APP_LIMIT(base) \
> +       (((uint64_t)(base) & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
> +
> +/* On GFXv9 the LDS and scratch apertures are programmed independently
> + * using the high 16 bits of the 64-bit virtual address. They must be
> + * in the hole, which will be the case as long as the high 16 bits are
> + * not 0.
> + *
> + * The aperture sizes are still 4GB implicitly.
> + *
> + * A GPUVM aperture is not applicable on GFXv9.
> + */
> +#define MAKE_LDS_APP_BASE_V9() ((uint64_t)(0x1UL) << 48)
> +#define MAKE_SCRATCH_APP_BASE_V9() ((uint64_t)(0x2UL) << 48)
> +
>  /* VMPT level enumerate, and the hiberachy is:
>   * PDB2->PDB1->PDB0->PTB
>   */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/d=
rm/amd/amdkfd/kfd_flat_memory.c
> index dbcb60eb54b2..fdcbb400f618 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> @@ -277,35 +277,6 @@
>   * for FLAT_* / S_LOAD operations.
>   */
>
> -#define MAKE_GPUVM_APP_BASE_VI(gpu_num) \
> -       (((uint64_t)(gpu_num) << 61) + 0x1000000000000L)
> -
> -#define MAKE_GPUVM_APP_LIMIT(base, size) \
> -       (((uint64_t)(base) & 0xFFFFFF0000000000UL) + (size) - 1)
> -
> -#define MAKE_SCRATCH_APP_BASE_VI() \
> -       (((uint64_t)(0x1UL) << 61) + 0x100000000L)
> -
> -#define MAKE_SCRATCH_APP_LIMIT(base) \
> -       (((uint64_t)base & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
> -
> -#define MAKE_LDS_APP_BASE_VI() \
> -       (((uint64_t)(0x1UL) << 61) + 0x0)
> -#define MAKE_LDS_APP_LIMIT(base) \
> -       (((uint64_t)(base) & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
> -
> -/* On GFXv9 the LDS and scratch apertures are programmed independently
> - * using the high 16 bits of the 64-bit virtual address. They must be
> - * in the hole, which will be the case as long as the high 16 bits are
> - * not 0.
> - *
> - * The aperture sizes are still 4GB implicitly.
> - *
> - * A GPUVM aperture is not applicable on GFXv9.
> - */
> -#define MAKE_LDS_APP_BASE_V9() ((uint64_t)(0x1UL) << 48)
> -#define MAKE_SCRATCH_APP_BASE_V9() ((uint64_t)(0x2UL) << 48)
> -
>  /* User mode manages most of the SVM aperture address space. The low
>   * 16MB are reserved for kernel use (CWSR trap handler and kernel IB
>   * for now).
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 45c4fa13499c..a52683ae7115 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1477,6 +1477,12 @@ struct drm_amdgpu_info_device {
>         /* Userq IP mask (1 << AMDGPU_HW_IP_*) */
>         __u32 userq_ip_mask;
>         __u32 pad;
> +
> +       /* Additional fields for memory aperture information */
> +       __u64 lds_base;          /* LDS base */
> +       __u64 lds_limit;         /* LDS limit */
> +       __u64 scratch_base;      /* Scratch base */
> +       __u64 scratch_limit;     /* Scratch limit */
>  };
>
>  struct drm_amdgpu_info_hw_ip {
> --
> 2.34.1
>
