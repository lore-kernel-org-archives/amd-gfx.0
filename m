Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00BBC7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 20:46:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A50610E1FD;
	Thu, 30 Mar 2023 20:46:33 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85AFC10E1FD
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 20:46:30 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 x8-20020a9d3788000000b0069f922cd5ceso10750558otb.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 13:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680209190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ighaFV19wpS/zCwlEcgXz1tofXkoaSlAMeA59bAQLbE=;
 b=mt7x+pSUlx66XEZlWqkqZoyU98axMzcd/SwMF5wCShT9o/vH31y6kIltovOUcWqtS5
 h2ZpRSJc9iUomw0FZk9QQl7tZh9F+tUehsUDufK90+0vWYzvrIzBb6n7uk48E1ssfjz7
 Ygu/0qP69zhngqKtzb/arAtG0QlCJhZ2FLtDvXMmjlg3nmZOmpBM2Y2xzgg1/82FuE42
 bt0QA+HGuntLQZ59cQ1IWgpYYwGwwBwQDYOz2013Oo9d7+BkPf/hwUk347oAgUkzdrTo
 LYgWSnn4PEDJLQzdmbg6BBYj+SEoBGyQxSQzbrjYwl/lVQhSCvaZNCfTnh8ECtkeIhwU
 bz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680209190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ighaFV19wpS/zCwlEcgXz1tofXkoaSlAMeA59bAQLbE=;
 b=ngeVn1Zp46EoAqgZkGxT/kRQrQpAp2aafCzkqhtUb4eu3hIMxrrli4Oc3VaNoFvSe3
 R5PM+3JoJ5D7GizkjNgy0U2yoslSJwrlOjltuUbk8pX0ZOKFlgaq6vhGt33YFe59bulf
 jkdI7W1gGe2g/ij54+7p2Ehq2lPaMnwOkz0yNcnswead0yvMdAS7RRA01QSACoGu8zzg
 jUC+Cu2+gXaMZiaQXg96b6Cj6NBwNCshLHrCjcaxKBiOhaAwIBsGhhBgTKSW2Ic3c+YG
 +NL4YJ7jX+dKsxOglCStKErApK4fhgxvP/7K41L1nSqd3OYJwhBvLtUsChvmsrcCBf1M
 y4nw==
X-Gm-Message-State: AAQBX9fXT3JRGt6hAaobkaEt7MU/VBcUWJ3e1ayiEuV2gx3UM16qAOIF
 uFcl6V8b/mfZTzOkTrJjuYMUui2PIGZQK8n+RDJOxLUZ9u4=
X-Google-Smtp-Source: AKy350aF5BfWeTOEgpCXzTe6sVFvox4+1plKf8Nq+d/hw26yoB5Wa0f4x52+0VrmafAXcrgR/vmgN0FsBSBFZJ2Sl6k=
X-Received: by 2002:a9d:6c5a:0:b0:6a1:7f22:a821 with SMTP id
 g26-20020a9d6c5a000000b006a17f22a821mr711837otq.3.1680209189759; Thu, 30 Mar
 2023 13:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-13-shashank.sharma@amd.com>
In-Reply-To: <20230329154753.1261-13-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Mar 2023 16:46:18 -0400
Message-ID: <CADnq5_Pg8+m+VqfravXf_4xxRFKKw+FaNYSMqF=PWSjk7CmVLg@mail.gmail.com>
Subject: Re: [PATCH 12/16] drm/amdgpu: use doorbell manager for kfd kernel
 doorbells
To: Shashank Sharma <shashank.sharma@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 29, 2023 at 11:48=E2=80=AFAM Shashank Sharma
<shashank.sharma@amd.com> wrote:
>
> This patch:
> - adds a doorbell manager structure in kfd device structure.
> - plugs-in doorbell manager APIs for KFD kernel doorbell allocations
>   an free functions.
> - removes the doorbell bitmap, uses the one into the doorbell manager
>   structure for all the allocations.
> - updates the get_kernel_doorbell and free_kernel_doorbell functions
>   accordingly
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c   |   4 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 109 ++++++----------------
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |   3 +
>  3 files changed, 35 insertions(+), 81 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_device.c
> index b8936340742b..a2e4cbddba26 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -435,8 +435,8 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *a=
dev, bool vf)
>         atomic_set(&kfd->compute_profile, 0);
>
>         mutex_init(&kfd->doorbell_mutex);
> -       memset(&kfd->doorbell_available_index, 0,
> -               sizeof(kfd->doorbell_available_index));
> +       memset(kfd->kernel_doorbells.doorbell_bitmap, 0,
> +              kfd->kernel_doorbells.size / BITS_PER_LONG);
>
>         atomic_set(&kfd->sram_ecc_flag, 0);
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_doorbell.c
> index cd4e61bf0493..df259f2cc58a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -61,81 +61,37 @@ size_t kfd_doorbell_process_slice(struct kfd_dev *kfd=
)
>  /* Doorbell calculations for device init. */
>  int kfd_doorbell_init(struct kfd_dev *kfd)
>  {
> -       size_t doorbell_start_offset;
> -       size_t doorbell_aperture_size;
> -       size_t doorbell_process_limit;
> +       int r;
> +       struct amdgpu_doorbell_obj *kernel_doorbells =3D &kfd->kernel_doo=
rbells;
>
> -       /*
> -        * With MES enabled, just set the doorbell base as it is needed
> -        * to calculate doorbell physical address.
> -        */
> -       if (kfd->shared_resources.enable_mes) {
> -               kfd->doorbell_base =3D
> -                       kfd->shared_resources.doorbell_physical_address;
> -               return 0;
> -       }
> -
> -       /*
> -        * We start with calculations in bytes because the input data mig=
ht
> -        * only be byte-aligned.
> -        * Only after we have done the rounding can we assume any alignme=
nt.
> -        */
> -
> -       doorbell_start_offset =3D
> -                       roundup(kfd->shared_resources.doorbell_start_offs=
et,
> -                                       kfd_doorbell_process_slice(kfd));
> -
> -       doorbell_aperture_size =3D
> -                       rounddown(kfd->shared_resources.doorbell_aperture=
_size,
> -                                       kfd_doorbell_process_slice(kfd));
> -
> -       if (doorbell_aperture_size > doorbell_start_offset)
> -               doorbell_process_limit =3D
> -                       (doorbell_aperture_size - doorbell_start_offset) =
/
> -                                               kfd_doorbell_process_slic=
e(kfd);
> -       else
> -               return -ENOSPC;
> -
> -       if (!kfd->max_doorbell_slices ||
> -           doorbell_process_limit < kfd->max_doorbell_slices)
> -               kfd->max_doorbell_slices =3D doorbell_process_limit;
> -
> -       kfd->doorbell_base =3D kfd->shared_resources.doorbell_physical_ad=
dress +
> -                               doorbell_start_offset;
> -
> -       kfd->doorbell_base_dw_offset =3D doorbell_start_offset / sizeof(u=
32);
> -
> -       kfd->doorbell_kernel_ptr =3D ioremap(kfd->doorbell_base,
> -                                          kfd_doorbell_process_slice(kfd=
));
> -
> -       if (!kfd->doorbell_kernel_ptr)
> +       /* Bitmap to dynamically allocate doorbells from kernel page */
> +       kernel_doorbells->doorbell_bitmap =3D bitmap_zalloc(PAGE_SIZE, GF=
P_KERNEL);
> +       if (!kernel_doorbells->doorbell_bitmap) {
> +               DRM_ERROR("Failed to allocate kernel doorbell bitmap\n");
>                 return -ENOMEM;
> +       }
>
> -       pr_debug("Doorbell initialization:\n");
> -       pr_debug("doorbell base           =3D=3D 0x%08lX\n",
> -                       (uintptr_t)kfd->doorbell_base);
> -
> -       pr_debug("doorbell_base_dw_offset      =3D=3D 0x%08lX\n",
> -                       kfd->doorbell_base_dw_offset);
> -
> -       pr_debug("doorbell_process_limit  =3D=3D 0x%08lX\n",
> -                       doorbell_process_limit);
> -
> -       pr_debug("doorbell_kernel_offset  =3D=3D 0x%08lX\n",
> -                       (uintptr_t)kfd->doorbell_base);
> -
> -       pr_debug("doorbell aperture size  =3D=3D 0x%08lX\n",
> -                       kfd->shared_resources.doorbell_aperture_size);
> +       /* Alloc and reserve doorbells for KFD kernel usages */
> +       kernel_doorbells->size =3D PAGE_SIZE;
> +       r =3D amdgpu_doorbell_alloc_page(kfd->adev, kernel_doorbells);


Just do something like:
r =3D amdgpu_bo_create_kernel(kfd->adev, PAGE_SIZE, PAGE_SIZE,
AMDGPU_GEM_DOMAIN_DOORBELL,

&kfd->doorbell_kernel_bo, NULL, &kfd->doorbell_kernel_ptr);

Then you have your KFD pointer to its doorbell memory and no need to
track the ranges.

Alex


> +       if (r) {
> +               pr_err("failed to allocate kernel doorbells\n");
> +               bitmap_free(kernel_doorbells->doorbell_bitmap);
> +               return r;
> +       }
>
> -       pr_debug("doorbell kernel address =3D=3D %p\n", kfd->doorbell_ker=
nel_ptr);
> +       kfd->doorbell_kernel_ptr =3D kernel_doorbells->cpu_addr;
> +       pr_debug("Doorbell kernel address =3D=3D %p\n", kfd->doorbell_ker=
nel_ptr);
>
>         return 0;
>  }
>
>  void kfd_doorbell_fini(struct kfd_dev *kfd)
>  {
> -       if (kfd->doorbell_kernel_ptr)
> -               iounmap(kfd->doorbell_kernel_ptr);
> +       struct amdgpu_doorbell_obj *kernel_doorbells =3D &kfd->kernel_doo=
rbells;
> +
> +       bitmap_free(kernel_doorbells->doorbell_bitmap);
> +       amdgpu_doorbell_free_page(kfd->adev, kernel_doorbells);
>  }
>
>  int kfd_doorbell_mmap(struct kfd_dev *dev, struct kfd_process *process,
> @@ -186,24 +142,19 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_de=
v *kfd,
>                                         unsigned int *doorbell_off)
>  {
>         u32 inx;
> +       struct amdgpu_doorbell_obj *kernel_doorbells =3D &kfd->kernel_doo=
rbells;
>
>         mutex_lock(&kfd->doorbell_mutex);
> -       inx =3D find_first_zero_bit(kfd->doorbell_available_index,
> -                                       KFD_MAX_NUM_OF_QUEUES_PER_PROCESS=
);
> +       inx =3D find_first_zero_bit(kernel_doorbells->doorbell_bitmap,
> +                                 kernel_doorbells->size);
>
> -       __set_bit(inx, kfd->doorbell_available_index);
> +       __set_bit(inx, kernel_doorbells->doorbell_bitmap);
>         mutex_unlock(&kfd->doorbell_mutex);
>
>         if (inx >=3D KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
>                 return NULL;
>
> -       inx *=3D kfd->device_info.doorbell_size / sizeof(u32);
> -
> -       /*
> -        * Calculating the kernel doorbell offset using the first
> -        * doorbell page.
> -        */
> -       *doorbell_off =3D kfd->doorbell_base_dw_offset + inx;
> +       *doorbell_off =3D amdgpu_doorbell_index_on_bar(kfd->adev, kernel_=
doorbells->bo, inx);
>
>         pr_debug("Get kernel queue doorbell\n"
>                         "     doorbell offset   =3D=3D 0x%08X\n"
> @@ -216,12 +167,12 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_de=
v *kfd,
>  void kfd_release_kernel_doorbell(struct kfd_dev *kfd, u32 __iomem *db_ad=
dr)
>  {
>         unsigned int inx;
> +       struct amdgpu_doorbell_obj *kernel_doorbells =3D &kfd->kernel_doo=
rbells;
>
> -       inx =3D (unsigned int)(db_addr - kfd->doorbell_kernel_ptr)
> -               * sizeof(u32) / kfd->device_info.doorbell_size;
> +       inx =3D (unsigned int)(db_addr - kfd->doorbell_kernel_ptr);
>
>         mutex_lock(&kfd->doorbell_mutex);
> -       __clear_bit(inx, kfd->doorbell_available_index);
> +       __clear_bit(inx, kernel_doorbells->doorbell_bitmap);
>         mutex_unlock(&kfd->doorbell_mutex);
>  }
>
> @@ -280,7 +231,7 @@ phys_addr_t kfd_get_process_doorbells(struct kfd_proc=
ess_device *pdd)
>         if (!pdd->doorbell_index) {
>                 int r =3D kfd_alloc_process_doorbells(pdd->dev,
>                                                     &pdd->doorbell_index)=
;
> -               if (r)
> +               if (r < 0)
>                         return 0;
>         }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index 552c3ac85a13..0ed33416c35f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -346,6 +346,9 @@ struct kfd_dev {
>
>         /* HMM page migration MEMORY_DEVICE_PRIVATE mapping */
>         struct dev_pagemap pgmap;
> +
> +       /* Kernel doorbells for KFD device */
> +       struct amdgpu_doorbell_obj kernel_doorbells;
>  };
>
>  enum kfd_mempool {
> --
> 2.40.0
>
