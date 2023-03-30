Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA0EC7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C004110F013;
	Thu, 30 Mar 2023 19:59:15 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3156F10F013
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:59:14 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-17aceccdcf6so20968787fac.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 12:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680206353;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RVTrgTdxQ2f93Hs5DTLtWFI8EL9W1di9bh6dSscQuCc=;
 b=guXCt3/+8U+XG0pX1T1mDzn9nQLaArb9vjGAp5ncOyP/MpB8VfAVJN5u/XdP+8LYti
 OjNvHhHkvWDbyOSKnIVCUP+bJs3ScyTNzGVbpSqoEEkjYM3wMQOXEfKOajq4qPeGB150
 divS1QSpWi3uTGdQPtD5m5NlpqqZAyLsZekf+/rD3Lpc7sGhSdkq2oBE+Yy5BGPUGobK
 Zdo0pbzcTsSaIYVfMc0a1yW9pWBAsjUc7PHCm+8Txix+lYdADtzxQxTMSVz7kjCpcxFF
 bTHWwnvzUKuzVRGBMjd7pYpKkD7nIqZoWS9h5q13m03Zf7Js4jr3BN9Y9C2/g4PMoC/l
 h2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680206353;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RVTrgTdxQ2f93Hs5DTLtWFI8EL9W1di9bh6dSscQuCc=;
 b=ifkIoaIPXWv8oR2DlIlAj4EtADarctk5pV5lqKRyKa1gcPet53DSisB7Kd1yLqcgN7
 YwwKCqZfZaoOnJUHFp2Cfi87OI3xiMI9Z5LBl1mdS3P1lGBRZiD0L6PVvnACpWg+03Vz
 k0HnfinEDx6n23+k81Y9TWnKN32VBOYh8p0SKFiMbSIWv4BHvItb+GbKW5l4Sb1n/8XA
 2t6vDlv4wuPCHw27Xqmq2YGsXrockHZlwBppEXBwb9n781R6yL2ty0Hwhszjm7h6V7OP
 G7UzLeQBlvR7ckZvFuYA3rF8iFgnZ4zGVAgsU0WJ+qGYzLWUL/3RGY0xPvOkqLedwMRB
 vRww==
X-Gm-Message-State: AAQBX9fQVRsGxpbiPEDZzb6JxYRM032kj9PHmdv3+cNRdU11fIL1No3r
 4DT1IVtEldFGHe1OG+xTl+2dfnGxgyDQA5TfqPA=
X-Google-Smtp-Source: AKy350abZ8AZlspDHSTytap8Er6lqTlmewG1kRKhGC/wMRZRftqLTBm11fN9nQJA7xYmhmvIY9NFPnQZ29MGeE+DdQ8=
X-Received: by 2002:a05:6871:4910:b0:177:b992:fee7 with SMTP id
 tw16-20020a056871491000b00177b992fee7mr6195930oab.3.1680206353372; Thu, 30
 Mar 2023 12:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-7-shashank.sharma@amd.com>
In-Reply-To: <20230329154753.1261-7-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Mar 2023 15:59:02 -0400
Message-ID: <CADnq5_ODDptH7KRGHO7JDTnp-uhdQfpEa113hyces-0YDfh=ww@mail.gmail.com>
Subject: Re: [PATCH 06/16] drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
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
> From: Alex Deucher <alexander.deucher@amd.com>
>
> This patch adds changes:
> - to accommodate the new GEM domain DOORBELL
> - to accommodate the new TTM PL DOORBELL
>
> in order to manage doorbell pages as GEM object.
>
> V2: Addressed reviwe comments from Christian
>     - drop the doorbell changes for pinning/unpinning
>     - drop the doorbell changes for dma-buf map
>     - drop the doorbell changes for sgt
>     - no need to handle TTM_PL_FLAG_CONTIGUOUS for doorbell
>     - add caching type for doorbell
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c     | 11 ++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c        | 16 +++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h        |  1 +

Also need to update amdgpu_mem_type_to_domain() in amdgpu_object.h

Alex

>  4 files changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index 4e684c2afc70..0ec080e240ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -147,6 +147,14 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_b=
o *abo, u32 domain)
>                 c++;
>         }
>
> +       if (domain & AMDGPU_GEM_DOMAIN_DOORBELL) {
> +               places[c].fpfn =3D 0;
> +               places[c].lpfn =3D 0;
> +               places[c].mem_type =3D AMDGPU_PL_DOORBELL;
> +               places[c].flags =3D 0;
> +               c++;
> +       }
> +
>         if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>                 places[c].fpfn =3D 0;
>                 places[c].lpfn =3D 0;
> @@ -466,7 +474,7 @@ static bool amdgpu_bo_validate_size(struct amdgpu_dev=
ice *adev,
>                 goto fail;
>         }
>
> -       /* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
> +       /* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU,  =
AMDGPU_GEM_DOMAIN_DOORBELL */
>         return true;
>
>  fail:
> @@ -1013,6 +1021,7 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>         } else if (bo->tbo.resource->mem_type =3D=3D TTM_PL_TT) {
>                 atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
>         }
> +
>  }
>
>  static const char *amdgpu_vram_names[] =3D {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_res_cursor.h
> index 5c4f93ee0c57..3c988cc406e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
> @@ -90,6 +90,7 @@ static inline void amdgpu_res_first(struct ttm_resource=
 *res,
>                 cur->node =3D block;
>                 break;
>         case TTM_PL_TT:
> +       case AMDGPU_PL_DOORBELL:
>                 node =3D to_ttm_range_mgr_node(res)->mm_nodes;
>                 while (start >=3D node->size << PAGE_SHIFT)
>                         start -=3D node++->size << PAGE_SHIFT;
> @@ -152,6 +153,7 @@ static inline void amdgpu_res_next(struct amdgpu_res_=
cursor *cur, uint64_t size)
>                 cur->size =3D min(amdgpu_vram_mgr_block_size(block), cur-=
>remaining);
>                 break;
>         case TTM_PL_TT:
> +       case AMDGPU_PL_DOORBELL:
>                 node =3D cur->node;
>
>                 cur->node =3D ++node;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 55e0284b2bdd..6f61491ef3dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -128,6 +128,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_obje=
ct *bo,
>         case AMDGPU_PL_GDS:
>         case AMDGPU_PL_GWS:
>         case AMDGPU_PL_OA:
> +       case AMDGPU_PL_DOORBELL:
>                 placement->num_placement =3D 0;
>                 placement->num_busy_placement =3D 0;
>                 return;
> @@ -500,9 +501,11 @@ static int amdgpu_bo_move(struct ttm_buffer_object *=
bo, bool evict,
>         if (old_mem->mem_type =3D=3D AMDGPU_PL_GDS ||
>             old_mem->mem_type =3D=3D AMDGPU_PL_GWS ||
>             old_mem->mem_type =3D=3D AMDGPU_PL_OA ||
> +           old_mem->mem_type =3D=3D AMDGPU_PL_DOORBELL ||
>             new_mem->mem_type =3D=3D AMDGPU_PL_GDS ||
>             new_mem->mem_type =3D=3D AMDGPU_PL_GWS ||
> -           new_mem->mem_type =3D=3D AMDGPU_PL_OA) {
> +           new_mem->mem_type =3D=3D AMDGPU_PL_OA ||
> +           new_mem->mem_type =3D=3D AMDGPU_PL_DOORBELL) {
>                 /* Nothing to save here */
>                 ttm_bo_move_null(bo, new_mem);
>                 goto out;
> @@ -586,6 +589,12 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_devi=
ce *bdev,
>                 mem->bus.offset +=3D adev->gmc.aper_base;
>                 mem->bus.is_iomem =3D true;
>                 break;
> +       case AMDGPU_PL_DOORBELL:
> +               mem->bus.offset =3D mem->start << PAGE_SHIFT;
> +               mem->bus.offset +=3D adev->doorbell.base;
> +               mem->bus.is_iomem =3D true;
> +               mem->bus.caching =3D ttm_uncached;
> +               break;
>         default:
>                 return -EINVAL;
>         }
> @@ -600,6 +609,10 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct tt=
m_buffer_object *bo,
>
>         amdgpu_res_first(bo->resource, (u64)page_offset << PAGE_SHIFT, 0,
>                          &cursor);
> +
> +       if (bo->resource->mem_type =3D=3D AMDGPU_PL_DOORBELL)
> +               return ((uint64_t)(adev->doorbell.base + cursor.start)) >=
> PAGE_SHIFT;
> +
>         return (adev->gmc.aper_base + cursor.start) >> PAGE_SHIFT;
>  }
>
> @@ -1267,6 +1280,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm=
, struct ttm_resource *mem)
>                 flags |=3D AMDGPU_PTE_VALID;
>
>         if (mem && (mem->mem_type =3D=3D TTM_PL_TT ||
> +                   mem->mem_type =3D=3D AMDGPU_PL_DOORBELL ||
>                     mem->mem_type =3D=3D AMDGPU_PL_PREEMPT)) {
>                 flags |=3D AMDGPU_PTE_SYSTEM;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.h
> index e2cd5894afc9..761cd6b2b942 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -33,6 +33,7 @@
>  #define AMDGPU_PL_GWS          (TTM_PL_PRIV + 1)
>  #define AMDGPU_PL_OA           (TTM_PL_PRIV + 2)
>  #define AMDGPU_PL_PREEMPT      (TTM_PL_PRIV + 3)
> +#define AMDGPU_PL_DOORBELL     (TTM_PL_PRIV + 4)
>
>  #define AMDGPU_GTT_MAX_TRANSFER_SIZE   512
>  #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS        2
> --
> 2.40.0
>
