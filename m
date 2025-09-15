Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4D2CAC597
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 17:09:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4952A10E10E;
	Mon, 15 Sep 2025 17:09:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZvNtjR+o";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4AE210E10E
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 17:09:37 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-24cb6c57a16so6596345ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 10:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757956177; x=1758560977; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+uuyi1J+ciW+UiWnHziygS+ziIdUGzIT0Hra8YgKodI=;
 b=ZvNtjR+omNDaQ8rhk205iHTsA7Fi3ZpgEIphscRiGfL4bmfv2za5a7QnqFnC+XFQrK
 mUwCi7wO4zovG4uBOTNgRsRg/zoNcdSlkGCpctRi+g3TOYWSOudXxM27lGlHlsOCCqcj
 gFNeyVYvklQz9VGcghCqIC4Gm3aro9Wnfplatq03Dma/KPqglCSGe3sl/rvceQKBBOgZ
 P8gy5gNbo2CulZL6vtNfrpni2LmxgAdRj2Z6dF3Inymwe/VPd7dkxhuHaz4nFpUJ5pYi
 A7n6HRvmSwm3bfPAZ+sKvJBbS0lf0x6MeFIhFc9fKzj5+19XLG7HmztBRkobmPeBBopG
 /pkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757956177; x=1758560977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+uuyi1J+ciW+UiWnHziygS+ziIdUGzIT0Hra8YgKodI=;
 b=IgafHlUDneCWxCONx53x18+XyXNUb9IZeJqOrIqJZ/2+ZwUbd3r6uhSszSFEM6gGn2
 Qo2IeqlbGB8c3cYpsWzpikLGJOS0FuvLGY+XfQuc3geFNqo65dlfuhtmjTkxzyEoAxCw
 fcN35b8YuqKSHTXMBOz3gZW7EyDDgmod+nygQwilgk370BdiICx2g0wJ9b+YHJKuLjQ2
 lxWmPjbuaYXSD5vYwq4I6tFZYNHQo+vVV/2+4GeiwYr07Tdbu4H6FjUYodxZpeqO6KiP
 C3dmJbvvrps3f+Q8yz9li1ttfcEKAAthhrPykBIFhLozqUGJU8oOjNJ5F755uz/QA5do
 KW2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZhqHYd57nMvdzw4OrXZNGjZ2rghsAhuGRz3GPMCfKcEOmihkwU0FCJkK7+y1QKOTbMQXSeNH2@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwcVmI2C38bbXrQg3KBHVaW+ygJBCDfT23APtJ4LAb3UUwq8xzV
 wSlTlAKgK7Wvs1PRkthD1XGgr+11X//1MRso2DyKh5GEmSvmAXNYVlb97Tc64/XkCoB/47uPuNt
 29jAPKNQlbnFrd6RePYmNXF400GXaJqM=
X-Gm-Gg: ASbGnctXkzq//CbkNKaY+keEefH6hR6RC9JVTVjuLIfmtg54BmfskQWoEK3BGv2/jkR
 VusQrTkhpi1O/NdcsLU2OxJx023uPO8UGP34e+HucZ8PPwCcf5IgdJBbij5eccIMGp1ZmZMLX81
 RUCWXjQETXGkRWXa2nxX6B+/hEq8EBZT8WM6irbsq/WiF4N2QnQ4/yVtrsQ2E9gTRs2J5ydSG3Q
 ACSTi2NWtLS2xCPqw==
X-Google-Smtp-Source: AGHT+IF03mdOCK6rxxIV7+XPolshLMdGNw6legs4+SvLuxx8+tWbGQ5lwuWn3rHGr4zVcKSQATk4KINKTF3bbVio1vg=
X-Received: by 2002:a17:903:1ce:b0:25e:8089:5070 with SMTP id
 d9443c01a7336-25e80895390mr81289315ad.1.1757956177278; Mon, 15 Sep 2025
 10:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250915133356.3547174-1-alexander.deucher@amd.com>
 <70e8c427-f816-4bdb-8f92-9382cd5ab13a@amd.com>
 <CADnq5_PUzTPcAchWfQGzsBc_SgY6E11B5aHMv8472NMoGPz48A@mail.gmail.com>
 <e5546919-aca4-4f8c-be0f-0895f3eb28ee@amd.com>
In-Reply-To: <e5546919-aca4-4f8c-be0f-0895f3eb28ee@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Sep 2025 13:09:24 -0400
X-Gm-Features: Ac12FXwfhDPDgqTmOgaiP1p4etnyJrWldKDdg2B0fBENQw_u3--IQkOPMi8Ox2Q
Message-ID: <CADnq5_N5hwm4BMiBGGBrEtkhg65y46jgtPP_69MxaxsQs9wOoQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: set an error on all fences from a bad
 context
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Mon, Sep 15, 2025 at 10:32=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 15.09.25 16:24, Alex Deucher wrote:
> > On Mon, Sep 15, 2025 at 9:59=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >>
> >>
> >> On 15.09.25 15:33, Alex Deucher wrote:
> >>> When we backup ring contents to reemit after a queue reset,
> >>> we don't backup ring contents from the bad context.  When
> >>> we signal the fences, we should set an error on those
> >>> fences as well.
> >>>
> >>> v2: misc cleanups
> >>> v3: add locking for fence error, fix comment (Christian)
> >>>
> >>> Fixes: 77cc0da39c7c ("drm/amdgpu: track ring state associated with a =
fence")
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> ---
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 33 ++++++++++++++++++++-=
--
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  |  2 +-
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 +-
> >>>  3 files changed, 31 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_fence.c
> >>> index fd8cca241da62..72f0f16924476 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> >>> @@ -758,11 +758,36 @@ void amdgpu_fence_driver_force_completion(struc=
t amdgpu_ring *ring)
> >>>   * @fence: fence of the ring to signal
> >>>   *
> >>>   */
> >>> -void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence=
 *fence)
> >>> +void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence=
 *af)
> >>>  {
> >>> -     dma_fence_set_error(&fence->base, -ETIME);
> >>> -     amdgpu_fence_write(fence->ring, fence->seq);
> >>> -     amdgpu_fence_process(fence->ring);
> >>> +     struct dma_fence *unprocessed;
> >>> +     struct dma_fence __rcu **ptr;
> >>> +     struct amdgpu_fence *fence;
> >>> +     struct amdgpu_ring *ring =3D af->ring;
> >>> +     unsigned long flags;
> >>> +     u64 i, seqno;
> >>> +
> >>> +     seqno =3D amdgpu_fence_read(ring);
> >>> +
> >>> +     spin_lock_irqsave(&ring->fence_drv.lock, flags);
> >>> +     for (i =3D seqno + 1; i <=3D ring->fence_drv.sync_seq; ++i) {
> >>
> >> That won't work, the seqno can wrap around.
> >>
> >> I would just go over all fences, e.g. from 0 to end of array.
> >>
> >> The checks below should make sure that we don't try to set an error on=
 something already processed.
> >>
> >>> +             ptr =3D &ring->fence_drv.fences[i & ring->fence_drv.num=
_fences_mask];
> >>> +             rcu_read_lock();
> >>> +             unprocessed =3D rcu_dereference(*ptr);
> >>> +
> >>> +             if (unprocessed && !dma_fence_is_signaled(unprocessed))=
 {
> >>
> >> dma_fence_is_signaled_locked(), otherwise the function would try to lo=
ck the same spinlock again.
> >>
> >>> +                     fence =3D container_of(unprocessed, struct amdg=
pu_fence, base);
> >>> +
> >>> +                     if (fence =3D=3D af)
> >>> +                             dma_fence_set_error(&fence->base, -ETIM=
E);
> >>> +                     else if (fence->context =3D=3D af->context)
> >>> +                             dma_fence_set_error(&fence->base, -ECAN=
CELED);
> >>> +             }
> >>> +             rcu_read_unlock();
> >>> +     }
> >>> +     spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
> >>
> >>> +     amdgpu_fence_write(ring, af->seq);
> >>> +     amdgpu_fence_process(ring);
> >>
> >> That's actually wrong. We want the other fences to signal later on whe=
n we process them.
> >
> > This fence is the original guilty fence.  The other fences will
> > naturally signal when the later fences signal.
>
> Ah, got it. But that is still racy as hell.
>
> We should probably rather signal the guilty fence separately by calling d=
ma_fence_signal().

What is it racing with?  amdgpu_fence_process() ultimately calls
dma_fence_signal(), plus it handles various AMD specific bookkeeping.

Alex

>
> Regards,
> Christian.
>
> >
> > Alex
> >
> >>
> >> Regards,
> >> Christian.
> >>
> >>>  }
> >>>
> >>>  void amdgpu_fence_save_wptr(struct dma_fence *fence)
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ring.c
> >>> index 6379bb25bf5ce..f6c9decedbd51 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> >>> @@ -812,7 +812,7 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ri=
ng *ring,
> >>>       if (r)
> >>>               return r;
> >>>
> >>> -     /* signal the fence of the bad job */
> >>> +     /* signal the guilty fence and set an error on all fences from =
the context */
> >>>       if (guilty_fence)
> >>>               amdgpu_fence_driver_guilty_force_completion(guilty_fenc=
e);
> >>>       /* Re-emit the non-guilty commands */
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ring.h
> >>> index 7670f5d82b9e4..0704fd9b85fdb 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> >>> @@ -155,7 +155,7 @@ extern const struct drm_sched_backend_ops amdgpu_=
sched_ops;
> >>>  void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
> >>>  void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int err=
or);
> >>>  void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
> >>> -void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence=
 *fence);
> >>> +void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence=
 *af);
> >>>  void amdgpu_fence_save_wptr(struct dma_fence *fence);
> >>>
> >>>  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
> >>
>
