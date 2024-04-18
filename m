Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAF3C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 16:10:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65539113D94;
	Thu, 18 Apr 2024 16:10:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="crl2bcn3";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1791113D94
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 16:10:25 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2a475bdd4a6so744876a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 09:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713456625; x=1714061425; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FJWgXfTdeKgmHISLNVP+6AhENqFDzYGCZMinlQq/9+s=;
 b=crl2bcn3Da3gyfcBxkCX5ijk9PNt/GJcFx4lE9xbjOch3s5t4iA9AH/DIw/4bdYpDL
 fbzDmUCibLM/yfVpXUiArG7yNpOX89QPEMMQDhLSFqehRkfrndWkqDCU46pPjPiJgL8o
 liHB7k0lNTOTaqM+R9E6PT8fHJgOJGp9pqM0B4vqEY8/wHy0o+ScgWo1SYUwb9CAVZvb
 3akthsI+1/Kbu7FxmgCzOokrCj4YTowJ7iX95fVJyJL7fc/rbFKpmeO7Y6FyV9oyE8M7
 iKTaJSmLLGmupVJj1keNp932FQjSjAcQSgIMSLBAuteq2J7LMGMnJ/zN/hrlOQV0uFl8
 qF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713456625; x=1714061425;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FJWgXfTdeKgmHISLNVP+6AhENqFDzYGCZMinlQq/9+s=;
 b=CBW2z1rJDNT2xPVhgrpDFFDja2SIkwngxPmT89lT7C6v/MkWWLYwZ/I+vU11DCM0zK
 bcoKUmAJPZ4tWTOwr5Ml3fIE/TDOGBZG06g2FxFwIFhhiqq2ovEnmSsAYZsTko1AZhJy
 duLmNsYqWa+2Rt328m6snOBZzjXMmaNao8BhJsYDMq9KH+xst6/2ExEghxpZuEl2/21a
 qrukemFyZmoVy7EZzZtNFGcED6RY9J06nFANY4/qJyjaqhXvfyiSvRo5SeyUsRX0PWwH
 zl6XZSTJ4QuuXD7g3vLkScoJ2tvcwfP7ybE+kE4ZDZL8j6nl+C4Iaa1u1MeF6an21BEG
 P8rA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhnIYTXdx9abnbRzhxzqHRuHdtL16fLhceP7cuQQJ986/K5fbWQuJrxvz6Zd7IJU7VNPge0jQ9RR9HENAAzTFkgySw1Pcn990/JuN0qg==
X-Gm-Message-State: AOJu0YyQv8Oa0m+qLM9KlYs3FjfBBdgc/EOsyU6nAkx9AlmzdNl53r5b
 R9D9Y1kckJxnGmFuopL2MP9JIzAZYfCemYvqFP7xxKoV1xXFHFpujKiB+sjJi2RpVS4kdxedtjU
 7QuyrGxjY21WDCeu3FLBf1s3gGTI=
X-Google-Smtp-Source: AGHT+IEVsnbPjZ2AK6ksQHtx9FOc+5kOASKZ7/6rTkUeEPI/LphGaeiHyNNqRzweYrs94dRcH7ibiYLtpaBT1/bzypk=
X-Received: by 2002:a17:90a:ca86:b0:2a6:d186:236e with SMTP id
 y6-20020a17090aca8600b002a6d186236emr3485683pjt.1.1713456625064; Thu, 18 Apr
 2024 09:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240321124311.2279-1-christian.koenig@amd.com>
 <fbe52af7-4ebb-490d-9771-d0ee177307e5@ursulin.net>
 <5d237fd2-4af4-4a4a-8c52-224b41f505f9@gmail.com>
In-Reply-To: <5d237fd2-4af4-4a4a-8c52-224b41f505f9@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Apr 2024 12:10:13 -0400
Message-ID: <CADnq5_Pk_1H07acZ83bPHVhjaTEgkR5Yr7=6TbH-Oy=NmFYgYw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: once more fix the call oder in
 amdgpu_ttm_move()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org
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

On Thu, Mar 21, 2024 at 10:37=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 21.03.24 um 15:12 schrieb Tvrtko Ursulin:
> >
> > On 21/03/2024 12:43, Christian K=C3=B6nig wrote:
> >> This reverts drm/amdgpu: fix ftrace event amdgpu_bo_move always move
> >> on same heap. The basic problem here is that after the move the old
> >> location is simply not available any more.
> >>
> >> Some fixes where suggested, but essentially we should call the move
> >> notification before actually moving things because only this way we ha=
ve
> >> the correct order for DMA-buf and VM move notifications as well.
> >>
> >> Also rework the statistic handling so that we don't update the evictio=
n
> >> counter before the move.
> >>
> >> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >
> > Don't forget:
> >
> > Fixes: 94aeb4117343 ("drm/amdgpu: fix ftrace event amdgpu_bo_move
> > always move on same heap")
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3171
>
> Ah, thanks. I already wanted to ask if there is any bug report about
> that as well.

Did this ever land?  I don't see it anywhere.

Alex

>
> Regards,
> Christian.
>
> >
> > ;)
> >
> > Regards,
> >
> > Tvrtko
> >
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 15 +++----
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  4 +-
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 48 ++++++++++++--------=
--
> >>   3 files changed, 37 insertions(+), 30 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >> index 425cebcc5cbf..eb7d824763b9 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >> @@ -1245,19 +1245,20 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo
> >> *bo, void *buffer,
> >>    * amdgpu_bo_move_notify - notification about a memory move
> >>    * @bo: pointer to a buffer object
> >>    * @evict: if this move is evicting the buffer from the graphics
> >> address space
> >> + * @new_mem: new resource for backing the BO
> >>    *
> >>    * Marks the corresponding &amdgpu_bo buffer object as invalid,
> >> also performs
> >>    * bookkeeping.
> >>    * TTM driver callback which is called when ttm moves a buffer.
> >>    */
> >> -void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict)
> >> +void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
> >> +               bool evict,
> >> +               struct ttm_resource *new_mem)
> >>   {
> >>       struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->bdev);
> >> +    struct ttm_resource *old_mem =3D bo->resource;
> >>       struct amdgpu_bo *abo;
> >>   -    if (!amdgpu_bo_is_amdgpu_bo(bo))
> >> -        return;
> >> -
> >>       abo =3D ttm_to_amdgpu_bo(bo);
> >>       amdgpu_vm_bo_invalidate(adev, abo, evict);
> >>   @@ -1267,9 +1268,9 @@ void amdgpu_bo_move_notify(struct
> >> ttm_buffer_object *bo, bool evict)
> >>           bo->resource->mem_type !=3D TTM_PL_SYSTEM)
> >>           dma_buf_move_notify(abo->tbo.base.dma_buf);
> >>   -    /* remember the eviction */
> >> -    if (evict)
> >> -        atomic64_inc(&adev->num_evictions);
> >> +    /* move_notify is called before move happens */
> >> +    trace_amdgpu_bo_move(abo, new_mem ? new_mem->mem_type : -1,
> >> +                 old_mem ? old_mem->mem_type : -1);
> >>   }
> >>     void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> >> index a3ea8a82db23..d28e21baef16 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> >> @@ -344,7 +344,9 @@ int amdgpu_bo_set_metadata (struct amdgpu_bo *bo,
> >> void *metadata,
> >>   int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
> >>                  size_t buffer_size, uint32_t *metadata_size,
> >>                  uint64_t *flags);
> >> -void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict);
> >> +void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
> >> +               bool evict,
> >> +               struct ttm_resource *new_mem);
> >>   void amdgpu_bo_release_notify(struct ttm_buffer_object *bo);
> >>   vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object
> >> *bo);
> >>   void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dma_fence *fence,
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >> index a5ceec7820cf..460b23918bfc 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >> @@ -471,14 +471,16 @@ static int amdgpu_bo_move(struct
> >> ttm_buffer_object *bo, bool evict,
> >>         if (!old_mem || (old_mem->mem_type =3D=3D TTM_PL_SYSTEM &&
> >>                bo->ttm =3D=3D NULL)) {
> >> +        amdgpu_bo_move_notify(bo, evict, new_mem);
> >>           ttm_bo_move_null(bo, new_mem);
> >> -        goto out;
> >> +        return 0;
> >>       }
> >>       if (old_mem->mem_type =3D=3D TTM_PL_SYSTEM &&
> >>           (new_mem->mem_type =3D=3D TTM_PL_TT ||
> >>            new_mem->mem_type =3D=3D AMDGPU_PL_PREEMPT)) {
> >> +        amdgpu_bo_move_notify(bo, evict, new_mem);
> >>           ttm_bo_move_null(bo, new_mem);
> >> -        goto out;
> >> +        return 0;
> >>       }
> >>       if ((old_mem->mem_type =3D=3D TTM_PL_TT ||
> >>            old_mem->mem_type =3D=3D AMDGPU_PL_PREEMPT) &&
> >> @@ -488,9 +490,10 @@ static int amdgpu_bo_move(struct
> >> ttm_buffer_object *bo, bool evict,
> >>               return r;
> >>             amdgpu_ttm_backend_unbind(bo->bdev, bo->ttm);
> >> +        amdgpu_bo_move_notify(bo, evict, new_mem);
> >>           ttm_resource_free(bo, &bo->resource);
> >>           ttm_bo_assign_mem(bo, new_mem);
> >> -        goto out;
> >> +        return 0;
> >>       }
> >>         if (old_mem->mem_type =3D=3D AMDGPU_PL_GDS ||
> >> @@ -502,8 +505,9 @@ static int amdgpu_bo_move(struct
> >> ttm_buffer_object *bo, bool evict,
> >>           new_mem->mem_type =3D=3D AMDGPU_PL_OA ||
> >>           new_mem->mem_type =3D=3D AMDGPU_PL_DOORBELL) {
> >>           /* Nothing to save here */
> >> +        amdgpu_bo_move_notify(bo, evict, new_mem);
> >>           ttm_bo_move_null(bo, new_mem);
> >> -        goto out;
> >> +        return 0;
> >>       }
> >>         if (bo->type =3D=3D ttm_bo_type_device &&
> >> @@ -515,22 +519,23 @@ static int amdgpu_bo_move(struct
> >> ttm_buffer_object *bo, bool evict,
> >>           abo->flags &=3D ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> >>       }
> >>   -    if (adev->mman.buffer_funcs_enabled) {
> >> -        if (((old_mem->mem_type =3D=3D TTM_PL_SYSTEM &&
> >> -              new_mem->mem_type =3D=3D TTM_PL_VRAM) ||
> >> -             (old_mem->mem_type =3D=3D TTM_PL_VRAM &&
> >> -              new_mem->mem_type =3D=3D TTM_PL_SYSTEM))) {
> >> -            hop->fpfn =3D 0;
> >> -            hop->lpfn =3D 0;
> >> -            hop->mem_type =3D TTM_PL_TT;
> >> -            hop->flags =3D TTM_PL_FLAG_TEMPORARY;
> >> -            return -EMULTIHOP;
> >> -        }
> >> +    if (adev->mman.buffer_funcs_enabled &&
> >> +        ((old_mem->mem_type =3D=3D TTM_PL_SYSTEM &&
> >> +          new_mem->mem_type =3D=3D TTM_PL_VRAM) ||
> >> +         (old_mem->mem_type =3D=3D TTM_PL_VRAM &&
> >> +          new_mem->mem_type =3D=3D TTM_PL_SYSTEM))) {
> >> +        hop->fpfn =3D 0;
> >> +        hop->lpfn =3D 0;
> >> +        hop->mem_type =3D TTM_PL_TT;
> >> +        hop->flags =3D TTM_PL_FLAG_TEMPORARY;
> >> +        return -EMULTIHOP;
> >> +    }
> >>   +    amdgpu_bo_move_notify(bo, evict, new_mem);
> >> +    if (adev->mman.buffer_funcs_enabled)
> >>           r =3D amdgpu_move_blit(bo, evict, new_mem, old_mem);
> >> -    } else {
> >> +    else
> >>           r =3D -ENODEV;
> >> -    }
> >>         if (r) {
> >>           /* Check that all memory is CPU accessible */
> >> @@ -545,11 +550,10 @@ static int amdgpu_bo_move(struct
> >> ttm_buffer_object *bo, bool evict,
> >>               return r;
> >>       }
> >>   -    trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type)=
;
> >> -out:
> >> -    /* update statistics */
> >> +    /* update statistics after the move */
> >> +    if (evict)
> >> +        atomic64_inc(&adev->num_evictions);
> >>       atomic64_add(bo->base.size, &adev->num_bytes_moved);
> >> -    amdgpu_bo_move_notify(bo, evict);
> >>       return 0;
> >>   }
> >>   @@ -1551,7 +1555,7 @@ static int amdgpu_ttm_access_memory(struct
> >> ttm_buffer_object *bo,
> >>   static void
> >>   amdgpu_bo_delete_mem_notify(struct ttm_buffer_object *bo)
> >>   {
> >> -    amdgpu_bo_move_notify(bo, false);
> >> +    amdgpu_bo_move_notify(bo, false, NULL);
> >>   }
> >>     static struct ttm_device_funcs amdgpu_bo_driver =3D {
>
