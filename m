Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF48C7EE2E
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 17:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D8AB10E15A;
	Fri,  9 Jun 2023 17:08:32 +0000 (UTC)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 736CE10E15A
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 17:08:30 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-559b0ddcd4aso1356747eaf.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Jun 2023 10:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686330509; x=1688922509;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dW/9W+8WaVB62HJrX9jrnMBfjv1uW3Fiq+E2hZxdhHE=;
 b=XMqc2ax0oP171QdepSFOPHxZkOl/MKzZVAydrDCxq4x3YKw+1oGumTG0HeEiQ/BjJl
 Ky3qwYOu9X2F8uHk7uJersSWcJ4gY74Li7qQVo8Syk54gz8ImqKz68ULljF2pPoZdEaA
 B0+Y7iZng/UcNaGrJNah+V6PUjOKzQPKzC9U6NqN8RUCTamr0I6CybdeSLd7rpLLmKUp
 dkac7tNQlkx61VXTXIuRSko4eDCKw1v7At6X+fJm+QSEnwL+GDVJiMsIIYV0MTyFmnbt
 ijyui3BBPKkfmGL7ZcYj/876uFa2UtBOQdra0mdAm0X4q1sC4XiprwIkfGHBwli4vvnE
 I44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686330509; x=1688922509;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dW/9W+8WaVB62HJrX9jrnMBfjv1uW3Fiq+E2hZxdhHE=;
 b=I1Iau/OBH9JUnqNp8dBiBpzxrlH8jBxuWEdo3pG4t2YFrb0zXuoNRWEm4im+0XuH90
 kJXmRIpRu3X4zm2d8vxGSls91Z7IojLK1EUFtF6XviV0n5X8mDUesfzEy/Fhlh71DovX
 2BBNkpzw7Zmi2+BL9sGZlQEllYZK8xkq22MbpcYOptllZm9EWQx/VSRAz2G3p+moIBQ6
 tM61B4gx9XU4vDJmTPYs4gsyjiTfsFsC73aEbj72Bpu9GCd29l5Z47w6HdkHwOPx4LuJ
 RLPw4KxEVPwJC4zzkBfArbGtrlduaotgGylM0gKQf/vadUCq9EVVSTxQ1XugJkQHNrjI
 6ASg==
X-Gm-Message-State: AC+VfDw51seuJRhFYmsaU7OnUtIwRRPuzr3tC0QMBu0wqnPxD5TkVYJ5
 RR4+0rcV7PRgbYD1al33Qouezycqw4/qbboXnS4=
X-Google-Smtp-Source: ACHHUZ4B7wTfZ7Fk2E0XEQhRVE+2xeayEcZxupTaYWkAKViV2OwyIVjULw5e8oFLEaFdi91HuUMMWWhhfTlzvY99GU4=
X-Received: by 2002:a4a:d542:0:b0:55a:7bfe:2df3 with SMTP id
 q2-20020a4ad542000000b0055a7bfe2df3mr1135086oos.8.1686330509236; Fri, 09 Jun
 2023 10:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230609150521.951-1-shashank.sharma@amd.com>
In-Reply-To: <20230609150521.951-1-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 9 Jun 2023 13:08:18 -0400
Message-ID: <CADnq5_O3377WchqgAK+tEkt5-oN_9Wu2bRz2VZ3tpkZaVR5Zww@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: flush GPU TLB using SDMA ring
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
Cc: Philip Yang <philip.yang@amd.com>, felix.kuehling@amd.com,
 Amaranath.Somalapuram@amd.com, Rajneesh.Bhardwaj@amd.com,
 amd-gfx@lists.freedesktop.org, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 9, 2023 at 11:05=E2=80=AFAM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
>
> This patch moves the code to flush GPU TLB using SDMA ring and
> splits it into two parts:
> - a general purpose function to flush GPU TLB using any valid GPU ring.
> - a wrapper which consumes this function using SDMA ring.
>
> The idea is that KFD/KGD code should be able to flush GPU TLB
> using SDMA ring if they want to.
>
> v2: Addressed review comments on RFC
>     - Make the TLB flush function generic, and add a SDMA wrapper
>       to it (Christian).
>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Philip Yang <philip.yang@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 22 +++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  | 36 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h  |  1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 34 +++++-----------------
>  5 files changed, 67 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index 231ca06bc9c7..05ffeb704dc4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -30,6 +30,28 @@
>  /* SDMA CSA reside in the 3rd page of CSA */
>  #define AMDGPU_CSA_SDMA_OFFSET (4096 * 2)
>
> +/**
> + * amdgpu_sdma_flush_tlb - flush gpu TLB using SDMA ring
> + *
> + * @adev: amdgpu device pointer
> + *
> + * return: returns 0 on success.
> + */
> +int amdgpu_sdma_flush_gpu_tlb(struct amdgpu_device *adev)
> +{
> +       struct dma_fence *fence;
> +       struct amdgpu_ring *ring =3D adev->mman.buffer_funcs_ring;

I think it would be better to put this function in amdgpu_ttm.c or
some amdgpu_vm.c.  It doesn't really have anything to do with SDMA per
se.  buffer_funcs_ring could point to any engine that could handle
buffer ops.  It just happens to be SDMA on most chips.

> +
> +       fence =3D amdgpu_ttm_flush_tlb(ring);
> +       if (fence) {
> +               dma_fence_wait(fence, false);
> +               dma_fence_put(fence);
> +               return 0;
> +       }
> +
> +       return -1;

Please use an appropriate error code here rather than -1.

Alex

> +}
> +
>  /*
>   * GPU SDMA IP block helpers function.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.h
> index fc8528812598..739077862a7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -130,5 +130,6 @@ void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_devic=
e *adev,
>          bool duplicate);
>  void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device *adev);
>  int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
> +int amdgpu_sdma_flush_gpu_tlb(struct amdgpu_device *adev);
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index c5ef7f7bdc15..1248d1dd5abc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -81,6 +81,42 @@ static int amdgpu_ttm_init_on_chip(struct amdgpu_devic=
e *adev,
>                                   false, size_in_page);
>  }
>
> +/**
> + * amdgpu_ttm_flush_tlb - flush gpu TLB using a GPU ring
> + *
> + * @ring: ring to submit the flushing job to
> + *
> + * return: returns dma fence which must be put by caller
> + */
> +struct dma_fence *amdgpu_ttm_flush_tlb(struct amdgpu_ring *ring)
> +{
> +       struct amdgpu_job *job;
> +       struct dma_fence *fence;
> +       struct amdgpu_device *adev =3D ring->adev;
> +       int r;
> +
> +       mutex_lock(&adev->mman.gtt_window_lock);
> +       r =3D amdgpu_job_alloc_with_ib(adev, &adev->mman.entity,
> +                                    AMDGPU_FENCE_OWNER_UNDEFINED,
> +                                    16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
> +                                    &job);
> +       if (r)
> +               goto error_alloc;
> +
> +       job->vm_pd_addr =3D amdgpu_gmc_pd_addr(adev->gart.bo);
> +       job->vm_needs_flush =3D true;
> +       job->ibs->ptr[job->ibs->length_dw++] =3D ring->funcs->nop;
> +       amdgpu_ring_pad_ib(ring, &job->ibs[0]);
> +       fence =3D amdgpu_job_submit(job);
> +
> +       mutex_unlock(&adev->mman.gtt_window_lock);
> +       return fence;
> +
> +error_alloc:
> +       mutex_unlock(&adev->mman.gtt_window_lock);
> +       return NULL;
> +}
> +
>  /**
>   * amdgpu_evict_flags - Compute placement flags
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.h
> index e2cd5894afc9..86ba70d2eb53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -200,5 +200,6 @@ uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device=
 *adev, struct ttm_tt *ttm,
>  int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int mem_type)=
;
>
>  void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev);
> +struct dma_fence *amdgpu_ttm_flush_tlb(struct amdgpu_ring *ring);
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v10_0.c
> index ab2556ca984e..9892b155d1ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -52,6 +52,7 @@
>  #include "athub_v2_1.h"
>
>  #include "amdgpu_reset.h"
> +#include "amdgpu_sdma.h"
>
>  #if 0
>  static const struct soc15_reg_golden golden_settings_navi10_hdp[] =3D
> @@ -332,10 +333,6 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_de=
vice *adev, uint32_t vmid,
>                                         uint32_t vmhub, uint32_t flush_ty=
pe)
>  {
>         struct amdgpu_ring *ring =3D adev->mman.buffer_funcs_ring;
> -       struct dma_fence *fence;
> -       struct amdgpu_job *job;
> -
> -       int r;
>
>         /* flush hdp cache */
>         adev->hdp.funcs->flush_hdp(adev, NULL);
> @@ -378,34 +375,17 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_d=
evice *adev, uint32_t vmid,
>                 return;
>         }
>
> -       /* The SDMA on Navi has a bug which can theoretically result in m=
emory
> +       mutex_unlock(&adev->mman.gtt_window_lock);
> +
> +       /*
> +        * The SDMA on Navi has a bug which can theoretically result in m=
emory
>          * corruption if an invalidation happens at the same time as an V=
A
>          * translation. Avoid this by doing the invalidation from the SDM=
A
>          * itself.
>          */
> -       r =3D amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.entity,
> -                                    AMDGPU_FENCE_OWNER_UNDEFINED,
> -                                    16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
> -                                    &job);
> -       if (r)
> -               goto error_alloc;
>
> -       job->vm_pd_addr =3D amdgpu_gmc_pd_addr(adev->gart.bo);
> -       job->vm_needs_flush =3D true;
> -       job->ibs->ptr[job->ibs->length_dw++] =3D ring->funcs->nop;
> -       amdgpu_ring_pad_ib(ring, &job->ibs[0]);
> -       fence =3D amdgpu_job_submit(job);
> -
> -       mutex_unlock(&adev->mman.gtt_window_lock);
> -
> -       dma_fence_wait(fence, false);
> -       dma_fence_put(fence);
> -
> -       return;
> -
> -error_alloc:
> -       mutex_unlock(&adev->mman.gtt_window_lock);
> -       DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
> +       if (amdgpu_sdma_flush_gpu_tlb(adev))
> +               DRM_ERROR("Error flushing GPU TLB using the SDMA !\n");
>  }
>
>  /**
> --
> 2.40.1
>
