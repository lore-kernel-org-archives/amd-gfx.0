Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F85C001DC
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 13:32:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 796E910E47B;
	Wed, 26 Jul 2023 13:32:32 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBCE210E47B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 13:32:30 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6bb140cd5a5so4012462a34.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 06:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690378350; x=1690983150;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gP9N0tvlHkKR2NW2S3t64GnwQ3IkWKHhAixtdjnLFFI=;
 b=JmtZIlqV4PTT8/uk5YnZf6fr7AAe45xs5AQ/NCRuU9Pny2VduHOjVasxezay9mRg8j
 x5QNWNOYJzk+ieKMcIVrqSAebOycXDwWEKTY25TPfSkPfuRr7D16Et3O2BaVdQdn8xB/
 o4o4mIB5yN1QR+GLCt+Udngg9zo7T4KQfiEW0gxMboszHxMUFYqEDEdLEqQ/4Mpxz8Em
 ypt2fGoDl/R/3jAM+u8f18MVroM2V70tiwo+RzOdCe5YBx7tWWBx0Sk2Xf87m5ue7p+L
 H2XqHN2y962n8ldAqh1etFlIgbvs5UpZcBzIms/4M2j9rGjguJD7SQrtySgWpyzePPxD
 /2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690378350; x=1690983150;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gP9N0tvlHkKR2NW2S3t64GnwQ3IkWKHhAixtdjnLFFI=;
 b=TF/zcrYZppd7jKnUy+7W89O+903D4yqKUU8pqSpOpyuusY7MHBV9Rd03HsuxncNbU7
 SsBHPQItz3DAirBE77LIPZkRnP4o+b1+LE5sPMI8EaX8mUgU2/OJl6ZgVqo13IhQwn8I
 kpD0hSMLpOTA9zJw7PVvT2Ygqv9T5GuJQvBriIb3nOcmqEt8gUFYcXx6N1IcBEtPKsWd
 VaDMVW39pF5oMQXDKdAQQm5C+WWEYOUWvkZSC6IGzk+j8rTOagko6hbUnBFqmuScFqrm
 yGgopTQs4YzB5qhRjChCeIMMrYzFWhbYBiNb8OyHHnZ92t18P5c8FIGhVRfL/kJbLNOP
 Esmg==
X-Gm-Message-State: ABy/qLYaghN33wMstGYjb9JycqGJWKQcn9N1SPvKq7DiRRnfL8xJBwV3
 TsqhGPDVqPki7pi4Y8zRd6GGWOqE40/C152H0cU=
X-Google-Smtp-Source: APBJJlE/OwsJ7Ij+ynNmkr5lY7Wb0WLvyAATWJlb7ho61GH5JTAAcGwF5upkPmBiC8EMwkgVVZijWR985L7fIBVZsEw=
X-Received: by 2002:a4a:2504:0:b0:567:8412:7fc8 with SMTP id
 g4-20020a4a2504000000b0056784127fc8mr1441856ooa.1.1690378349966; Wed, 26 Jul
 2023 06:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132126.2516313-1-David.Francis@amd.com>
In-Reply-To: <20230726132126.2516313-1-David.Francis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Jul 2023 09:32:18 -0400
Message-ID: <CADnq5_PVTjebxc=T=2+-ezBV4DZ95dFxDagW=5JeiXG+g7SNTQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Add EXT_COHERENCE memory allocation flags
To: David Francis <David.Francis@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 26, 2023 at 9:21=E2=80=AFAM David Francis <David.Francis@amd.co=
m> wrote:
>
> These flags (for GEM and SVM allocations) allocate
> memory that allows for system-scope atomic semantics.
>
> On GFX943 these flags cause caches to be avoided on
> non-local memory.
>
> On all other ASICs they are identical in functionality to the
> equivalent COHERENT flags.

Please include a link to the proposed userspace which uses these new flags.

Alex

>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  2 ++
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c           |  1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c           |  1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c            |  5 ++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c             | 10 +++++++++-
>  include/uapi/drm/amdgpu_drm.h                    |  7 +++++++
>  include/uapi/linux/kfd_ioctl.h                   |  3 +++
>  7 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index d34c3ef8f3ed..7f23bc0ee592 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1738,6 +1738,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>
>         if (flags & KFD_IOC_ALLOC_MEM_FLAGS_COHERENT)
>                 alloc_flags |=3D AMDGPU_GEM_CREATE_COHERENT;
> +       if (flags & KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENCE)
> +               alloc_flags |=3D AMDGPU_GEM_CREATE_EXT_COHERENCE;
>         if (flags & KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED)
>                 alloc_flags |=3D AMDGPU_GEM_CREATE_UNCACHED;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v10_0.c
> index 6b430e10d38e..8e951688668b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -632,6 +632,7 @@ static void gmc_v10_0_get_vm_pte(struct amdgpu_device=
 *adev,
>         }
>
>         if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> +                              AMDGPU_GEM_CREATE_EXT_COHERENCE |
>                                AMDGPU_GEM_CREATE_UNCACHED))
>                 *flags =3D (*flags & ~AMDGPU_PTE_MTYPE_NV10_MASK) |
>                          AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v11_0.c
> index a6ee0220db56..ff330c7c0232 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -540,6 +540,7 @@ static void gmc_v11_0_get_vm_pte(struct amdgpu_device=
 *adev,
>         }
>
>         if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> +                              AMDGPU_GEM_CREATE_EXT_COHERENCE |
>                                AMDGPU_GEM_CREATE_UNCACHED))
>                 *flags =3D (*flags & ~AMDGPU_PTE_MTYPE_NV10_MASK) |
>                          AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index 880460cd3239..e40fcfc1a3f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1183,7 +1183,8 @@ static void gmc_v9_0_get_coherence_flags(struct amd=
gpu_device *adev,
>  {
>         struct amdgpu_device *bo_adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
>         bool is_vram =3D bo->tbo.resource->mem_type =3D=3D TTM_PL_VRAM;
> -       bool coherent =3D bo->flags & AMDGPU_GEM_CREATE_COHERENT;
> +       bool coherent =3D bo->flags & (AMDGPU_GEM_CREATE_COHERENT | AMDGP=
U_GEM_CREATE_EXT_COHERENCE);
> +       bool ext_coherence =3D bo->flags & AMDGPU_GEM_CREATE_EXT_COHERENC=
E;
>         bool uncached =3D bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
>         struct amdgpu_vm *vm =3D mapping->bo_va->base.vm;
>         unsigned int mtype_local, mtype;
> @@ -1251,6 +1252,8 @@ static void gmc_v9_0_get_coherence_flags(struct amd=
gpu_device *adev,
>                 snoop =3D true;
>                 if (uncached) {
>                         mtype =3D MTYPE_UC;
> +               } else if (ext_coherence) {
> +                       mtype =3D is_local ? MTYPE_CC : MTYPE_UC;
>                 } else if (adev->flags & AMD_IS_APU) {
>                         mtype =3D is_local ? mtype_local : MTYPE_NC;
>                 } else {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.c
> index 1b50eae051a4..28304b93a990 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1155,7 +1155,8 @@ svm_range_get_pte_flags(struct kfd_node *node,
>         uint32_t mapping_flags =3D 0;
>         uint64_t pte_flags;
>         bool snoop =3D (domain !=3D SVM_RANGE_VRAM_DOMAIN);
> -       bool coherent =3D flags & KFD_IOCTL_SVM_FLAG_COHERENT;
> +       bool coherent =3D flags & (KFD_IOCTL_SVM_FLAG_COHERENT | KFD_IOCT=
L_SVM_FLAG_EXT_COHERENCE);
> +       bool ext_coherence =3D flags & KFD_IOCTL_SVM_FLAG_EXT_COHERENCE;
>         bool uncached =3D false; /*flags & KFD_IOCTL_SVM_FLAG_UNCACHED;*/
>         unsigned int mtype_local;
>
> @@ -1203,6 +1204,13 @@ svm_range_get_pte_flags(struct kfd_node *node,
>                 snoop =3D true;
>                 if (uncached) {
>                         mapping_flags |=3D AMDGPU_VM_MTYPE_UC;
> +               } else if (ext_coherence) {
> +                       /* local HBM region close to partition */
> +                       if (bo_node->adev =3D=3D node->adev &&
> +                           (!bo_node->xcp || !node->xcp || bo_node->xcp-=
>mem_id =3D=3D node->xcp->mem_id))
> +                               mapping_flags |=3D AMDGPU_VM_MTYPE_CC;
> +                       else
> +                               mapping_flags |=3D AMDGPU_VM_MTYPE_UC;
>                 } else if (domain =3D=3D SVM_RANGE_VRAM_DOMAIN) {
>                         /* local HBM region close to partition */
>                         if (bo_node->adev =3D=3D node->adev &&
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 79b14828d542..d67102dc214a 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -158,6 +158,13 @@ extern "C" {
>   * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
>   */
>  #define AMDGPU_GEM_CREATE_UNCACHED             (1 << 14)
> +/* Flag that BO should be coherent across devices when using device-leve=
l
> + * atomics. May depend on GPU instructions to flush caches explicitly.
> + *
> + * This influences the choice of MTYPE in the PTEs on GFXv9 and later GP=
Us and
> + * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
> + */
> +#define AMDGPU_GEM_CREATE_EXT_COHERENCE                (1 << 15)
>
>  struct drm_amdgpu_gem_create_in  {
>         /** the requested memory size */
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioct=
l.h
> index eeb2fdcbdcb7..dd8f0dba7631 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -405,6 +405,7 @@ struct kfd_ioctl_acquire_vm_args {
>  #define KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM  (1 << 27)
>  #define KFD_IOC_ALLOC_MEM_FLAGS_COHERENT       (1 << 26)
>  #define KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED       (1 << 25)
> +#define KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENCE  (1 << 24)
>
>  /* Allocate memory for later SVM (shared virtual memory) mapping.
>   *
> @@ -659,6 +660,8 @@ enum kfd_mmio_remap {
>  #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
>  /* Keep GPU memory mapping always valid as if XNACK is disable */
>  #define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
> +/* Fine grained coherency between all devices using device-scope atomics=
 */
> +#define KFD_IOCTL_SVM_FLAG_EXT_COHERENCE       0x00000080
>
>  /**
>   * kfd_ioctl_svm_op - SVM ioctl operations
> --
> 2.34.1
>
