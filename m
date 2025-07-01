Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9C4C7EE30
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 14:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB25610E2C7;
	Tue,  1 Jul 2025 14:07:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NLnb3Shb";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F26510E2C7
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 14:07:32 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-31305ee3281so733106a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Jul 2025 07:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751378851; x=1751983651; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X+PjpcBkWy62SoS5+hlBpxc/FOUvg97H7qpe+bZJdLk=;
 b=NLnb3ShbT+fZvDnMp5Kz+CCWkXsyic5dRtMLVoUnMy8dC0z8B9bh5GxJE9I5MHOHKN
 imRJyYVZSzUrOeubCkjlSJArNhoEdweE7oU/ct/YIrYJO0OsTx/sc2O6HIcDnB22/eGO
 S+vRiWziElE27x4kC1+I57E6YRBOfgzdZlQGRmkZxgTCJvQV2xFBgyQBFPO3yCxqEHn1
 VKRIopKl3jWMT5Cagn9qLTL3r4eiz4i89+3zO7++PFIEy8YTOfjfdtdNKrGZI2GYUJgX
 ydNdtDSB1YgYeWTNMe5gg62eu8Kwx71b+UqBb7YrHUykz6sngWWP4wYCzFsSqJuJvVTq
 T3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751378851; x=1751983651;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X+PjpcBkWy62SoS5+hlBpxc/FOUvg97H7qpe+bZJdLk=;
 b=ZCsexrRJrAlaBHMWWtNxSpwHTj6TU5i3y1rz/3rscMXXV0OIB802/Y5IzDTkehOqxk
 wkXDqCzZ1CxvTOren02SsgwJQ8bnEAJlQOoUDhnlORYD2D0NhTJUc1cZCRBuop23Orku
 /10e/AEnEp4LOIp267AeeplfhuUCAPxfVUIIYOHDLenICDGaXEUIs+22gG38GM+wiqZx
 V+g3533pgzwKmH0Sh+cyfAHcGDV5qilCKA0z/UC67yj72gHRuQEpM0OEPC3KChxz7OD4
 Pjg4as1n3LlKLEmZvQ4XgB0050JCGKswV2vUo7ssbE4YuQsaPBhQxxVnFuYMPnU4Lh0K
 dJiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPyqO3J6BmZb6tqT/6ihmJF7WtWFg/P31g3FMYQT6LjnjzQcfZVbdyHHwMnpkL1gZGF8TSUA4L@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzfdnm5WtOgEnRkHhUR2Dx7F/5S+XqywJuq1Oul/bJC/FR74SqM
 gwbU+HOtP01+vM6dP8nFX5dG6U/Y9nab1/3Q2xWFZgtkR+GlL2ZwSdoDXFIeYc5tTeCeqo10TqV
 JMKMBmMaRbP5+rNw319c3xrTR7ERGyIHa3w==
X-Gm-Gg: ASbGncveQrIIP7g+u4IVwvZlPSV0gLBCDLjLqghojkO4n8zv6r0yWbVLsIEIag71sbq
 FolNJUMAPumER4I/LjKAcnfPhIcgID3IZ961JCmz4F5HY7eiaNeyhP57+JmXls9jsvRvP5wwYCA
 buZCkvUraIK0k9tSxUVyA1MxdGNB5OEjWI3RmB30QC66wH
X-Google-Smtp-Source: AGHT+IG3KmYqYNDKAxrSrJgyyJr+Fn6gxO0Uz/QJ2bwoQeB7fcg+304RVZWb79UEXOw56tQ6Ip8n8FeRz4aqogXVP5w=
X-Received: by 2002:a17:90b:1843:b0:314:29ff:6845 with SMTP id
 98e67ed59e1d1-319519ee90bmr2118218a91.4.1751378851319; Tue, 01 Jul 2025
 07:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250623111717.224707-1-srinivasan.shanmugam@amd.com>
 <20250701064459.287603-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250701064459.287603-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Jul 2025 10:07:19 -0400
X-Gm-Features: Ac12FXwyUL2Av0vkf6SbgIh-0zZKDfvh36SELyYelni0WNWlTvp1Bv52QAHRO7I
Message-ID: <CADnq5_OyF=E23TrceinSnt2fFntUB3DBP0cRfUgh9JeAgPfYFw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Unify Device Aperture in amdgpu_info_ioctl
 for KGD/KFD
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 David Yat Sin <David.YatSin@amd.com>
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

On Tue, Jul 1, 2025 at 2:53=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This commit refines the amdgpu_info_ioctl function to unify
> the reporting of device apertures for both KGD and KFD
> subsystems.
>
> v2:
> - Use amdgpu_ip_version() instead of directly accessing
>   adev->ip_versions. (Alex)
> - Added AMDGPU_VM_ prefix to scratch and LDS base and limit macros.
>   (Christian)
> - Clarified in comments that the top 16 bits of the 64-bit address must
>   not be 0x0000 or 0xffff to avoid sign extension problems. (Christian)
>
> Cc: David Yat Sin <David.YatSin@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
But don't commit this yet as we are still waiting on the userspace
side to be complete.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      | 25 +++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       | 23 ++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 45 ++++----------------
>  include/uapi/drm/amdgpu_drm.h                |  6 +++
>  4 files changed, 62 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 4aab5e394ce2..76d902342271 100644
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
> @@ -1031,6 +1032,30 @@ int amdgpu_info_ioctl(struct drm_device *dev, void=
 *data, struct drm_file *filp)
>
>                 dev_info->userq_ip_mask =3D amdgpu_userq_get_supported_ip=
_mask(adev);
>
> +               /* Retrieve Device Apertures */
> +               if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(9=
, 0, 0)) {
> +                       dev_info->lds_base =3D AMDGPU_VM_MAKE_LDS_APP_BAS=
E_V9();
> +                       dev_info->scratch_base =3D AMDGPU_VM_MAKE_SCRATCH=
_APP_BASE_V9();
> +
> +                       dev_info->lds_limit =3D AMDGPU_VM_MAKE_LDS_APP_LI=
MIT(dev_info->lds_base);
> +                       dev_info->scratch_limit =3D
> +                               AMDGPU_VM_MAKE_SCRATCH_APP_LIMIT(dev_info=
->scratch_base);
> +               } else {
> +                       dev_info->lds_base =3D AMDGPU_VM_MAKE_LDS_APP_BAS=
E_VI();
> +                       dev_info->scratch_base =3D AMDGPU_VM_MAKE_SCRATCH=
_APP_BASE_VI();
> +
> +                       dev_info->lds_limit =3D AMDGPU_VM_MAKE_LDS_APP_LI=
MIT(dev_info->lds_base);
> +                       dev_info->scratch_limit =3D
> +                               AMDGPU_VM_MAKE_SCRATCH_APP_LIMIT(dev_info=
->scratch_base);
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
> index f3ad687125ad..fd8f6da30096 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -184,6 +184,29 @@ struct amdgpu_bo_vm;
>  #define AMDGPU_VM_USE_CPU_FOR_GFX (1 << 0)
>  #define AMDGPU_VM_USE_CPU_FOR_COMPUTE (1 << 1)
>
> +#define AMDGPU_VM_MAKE_SCRATCH_APP_BASE_VI() \
> +       (((uint64_t)(0x1UL) << 61) + 0x100000000L)
> +#define AMDGPU_VM_MAKE_SCRATCH_APP_LIMIT(base) \
> +       (((uint64_t)(base) & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
> +
> +#define AMDGPU_VM_MAKE_LDS_APP_BASE_VI() \
> +       (((uint64_t)(0x1UL) << 61) + 0x0)
> +#define AMDGPU_VM_MAKE_LDS_APP_LIMIT(base) \
> +       (((uint64_t)(base) & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
> +
> +/* On GFXv9 the LDS and scratch apertures are programmed independently
> + * using the high 16 bits of the 64-bit virtual address. They must be
> + * in the hole, which will be the case as long as the high 16 bits are
> + * neither 0x0000 nor 0xffff to avoid sign extension issues.
> + *
> + * The aperture sizes are still 4GB implicitly.
> + *
> + * Note: While GPUVM apertures are generally not applicable on GFXv9,
> + * there is at least one APU case where GFX9 has a limited GPUVM apertur=
e.
> + */
> +#define AMDGPU_VM_MAKE_LDS_APP_BASE_V9() ((uint64_t)(0x1UL) << 48)
> +#define AMDGPU_VM_MAKE_SCRATCH_APP_BASE_V9() ((uint64_t)(0x2UL) << 48)
> +
>  /* VMPT level enumerate, and the hiberachy is:
>   * PDB2->PDB1->PDB0->PTB
>   */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/d=
rm/amd/amdkfd/kfd_flat_memory.c
> index 1d170dc50df3..291b068aaf8a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> @@ -276,35 +276,6 @@
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
> @@ -319,8 +290,8 @@ static void kfd_init_apertures_vi(struct kfd_process_=
device *pdd, uint8_t id)
>          * node id couldn't be 0 - the three MSB bits of
>          * aperture shouldn't be 0
>          */
> -       pdd->lds_base =3D MAKE_LDS_APP_BASE_VI();
> -       pdd->lds_limit =3D MAKE_LDS_APP_LIMIT(pdd->lds_base);
> +       pdd->lds_base =3D AMDGPU_VM_MAKE_LDS_APP_BASE_VI();
> +       pdd->lds_limit =3D AMDGPU_VM_MAKE_LDS_APP_LIMIT(pdd->lds_base);
>
>         /* dGPUs: SVM aperture starting at 0
>          * with small reserved space for kernel.
> @@ -336,21 +307,21 @@ static void kfd_init_apertures_vi(struct kfd_proces=
s_device *pdd, uint8_t id)
>         pdd->qpd.cwsr_base =3D SVM_CWSR_BASE;
>         pdd->qpd.ib_base =3D SVM_IB_BASE;
>
> -       pdd->scratch_base =3D MAKE_SCRATCH_APP_BASE_VI();
> -       pdd->scratch_limit =3D MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
> +       pdd->scratch_base =3D AMDGPU_VM_MAKE_SCRATCH_APP_BASE_VI();
> +       pdd->scratch_limit =3D AMDGPU_VM_MAKE_SCRATCH_APP_LIMIT(pdd->scra=
tch_base);
>  }
>
>  static void kfd_init_apertures_v9(struct kfd_process_device *pdd, uint8_=
t id)
>  {
> -       pdd->lds_base =3D MAKE_LDS_APP_BASE_V9();
> -       pdd->lds_limit =3D MAKE_LDS_APP_LIMIT(pdd->lds_base);
> +       pdd->lds_base =3D AMDGPU_VM_MAKE_LDS_APP_BASE_V9();
> +       pdd->lds_limit =3D AMDGPU_VM_MAKE_LDS_APP_LIMIT(pdd->lds_base);
>
>         pdd->gpuvm_base =3D AMDGPU_VA_RESERVED_BOTTOM;
>         pdd->gpuvm_limit =3D
>                 pdd->dev->kfd->shared_resources.gpuvm_size - 1;
>
> -       pdd->scratch_base =3D MAKE_SCRATCH_APP_BASE_V9();
> -       pdd->scratch_limit =3D MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
> +       pdd->scratch_base =3D AMDGPU_VM_MAKE_SCRATCH_APP_BASE_V9();
> +       pdd->scratch_limit =3D AMDGPU_VM_MAKE_SCRATCH_APP_LIMIT(pdd->scra=
tch_base);
>
>         /*
>          * Place TBA/TMA on opposite side of VM hole to prevent
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 66c4a03ac9f9..f285e9325d06 100644
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
