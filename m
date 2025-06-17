Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906CFC71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 13:47:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3910410E6EA;
	Tue, 17 Jun 2025 13:47:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TNleF9tm";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B78410E6EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 13:47:10 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-235db423abdso4407185ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 06:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750168030; x=1750772830; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgPDRtrYSzvbLDKXZje/XRvd15rDYQ3QDUbAAyNvo9Y=;
 b=TNleF9tmOA4A4Pt6Lz4UHD+YmAy4eKaIqXZMTPMMrqOmCzxKkEhmYSbGagcELXOssc
 NE1vDND8B2xhT6DMmunK9pTEpFTc5rTfOBmPZ8q9OQYQRqSDUoyOlnc9LJP+atcz3w1N
 eJIkk9BOz8EOXq3ZtbmjDvVAvpdN2ObNKwGNIfIIfJv3DOSw0UW4KAVSuXIG2P08Wv73
 TKA8XNm9bU5TwqGdm48oqmU7bFq0VLd3iMypEhle+GzU1mP9yBYHLRgY+9srHXZXJ4/0
 d69NMnBW+1xgU5LQcXUQGWXf868rSQ+Aykmv23CeyzfAn9vzyrMPV4e9cTkbDJwXAjev
 +DYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750168030; x=1750772830;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fgPDRtrYSzvbLDKXZje/XRvd15rDYQ3QDUbAAyNvo9Y=;
 b=vleoxZ2Yo4AvtMP//2pfNO222e9BkYCwE83DXJGbwjL3kPQlTJPdj/S0+8q/xsr6rR
 QUKZs4iEWNgRyOV4VC3gq+w6xdkrMePROEk2WVmvIWve5FWu5L+EOUWKWv0K3aWhxMcP
 Jz8BmIE0K9dO3WOZdH6KcNZiZrbeXu95LsGlrTijZMGR+LUrV6shmSfCLONqUUG2kxTr
 ffTi1ygVn16kRxhiHHU9WCACUS87iCVemmofHsrt4nV4zws70pFfAVXsF6VrqSUNaD3o
 XId3fzK2X99CmTBXY7Hm81/cOXtIMAEGhFuC3iraVUgpU3mjKM0skvzYApbLXv6pE/2I
 eA0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg3ovh7hk28dpal7+2DzEkQBv0MnxZmxZmch/QXZCyg6D+2rV5Wkm8q8n4zE0OFXjHCHey+nST@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzo9w7ZQw55vww8cZ6pQh/fSKSWOIBOiPaiCAzC0Fva+D/CO/St
 bXZgEmmoqgrijNds0hW02uwwFZom0QN8RXveSs+gBfhZKX0/Hd7/xlFiSYHFzG0H3Vy2r5ApKje
 bh06djIZ6Dh3Oo7m4W749+q6v9kSG6Yg=
X-Gm-Gg: ASbGncv9R9PyelWGQhmAK0Q/gvubXVdk8jEPy/0XWdLRaWvpGEsgnG17Sb1FASHvn0+
 Mwt+OLgz8h8mpfKfAazUraIYQjMPaHFx0AJlUVRKrXOl3fyeUCdU44GlFDj+k6rO70DX42C+tQ7
 gN3pH1vjXQUYJE0VbmQWj6upd35DOfyuPmjVWLnL6O7NBW
X-Google-Smtp-Source: AGHT+IGdjVHFsFo/0fYXUctdyU3vpDQGpDtgmbK3wd0qI4z5I4r+liZHl0lwOv3dJ6VJDkrc6zsDwUNR6ItD8XnwUjc=
X-Received: by 2002:a17:903:1a67:b0:234:ba37:87a3 with SMTP id
 d9443c01a7336-2368ec78e52mr21790385ad.3.1750168029550; Tue, 17 Jun 2025
 06:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250617030815.5785-1-alexander.deucher@amd.com>
 <20250617030815.5785-3-alexander.deucher@amd.com>
 <81b40a5b-2747-41ef-ada5-7af0f28b33df@amd.com>
In-Reply-To: <81b40a5b-2747-41ef-ada5-7af0f28b33df@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Jun 2025 09:46:57 -0400
X-Gm-Features: AX0GCFvUqQi24-VmyHSAkLYR_KoH2U0uvHgZaakualbswzNbwyDO8XARkA16e7M
Message-ID: <CADnq5_OTeWFNmB6dWaodyuQhX9VbBLvMBNOjVZ+WpyB0sr5Ajg@mail.gmail.com>
Subject: Re: [PATCH 02/36] drm/amdgpu: remove job parameter from
 amdgpu_fence_emit()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 sasundar@amd.com
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

On Tue, Jun 17, 2025 at 7:57=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 6/17/25 05:07, Alex Deucher wrote:
> > What we actually care about is the amdgpu_fence object
> > so pass that in explicitly to avoid possible mistakes
> > in the future.
> >
> > The job_run_counter handling can be safely removed at this
> > point as we no longer support job resubmission.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 36 +++++++++--------------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  5 +++-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  4 +--
> >  3 files changed, 20 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_fence.c
> > index 569e0e5373927..e88848c14491a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > @@ -114,14 +114,14 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *=
ring)
> >   *
> >   * @ring: ring the fence is associated with
> >   * @f: resulting fence object
> > - * @job: job the fence is embedded in
> > + * @af: amdgpu fence input
> >   * @flags: flags to pass into the subordinate .emit_fence() call
> >   *
> >   * Emits a fence command on the requested ring (all asics).
> >   * Returns 0 on success, -ENOMEM on failure.
> >   */
> > -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, =
struct amdgpu_job *job,
> > -                   unsigned int flags)
> > +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
> > +                   struct amdgpu_fence *af, unsigned int flags)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> >       struct dma_fence *fence;
> > @@ -130,36 +130,28 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, s=
truct dma_fence **f, struct amd
> >       uint32_t seq;
> >       int r;
> >
> > -     if (job =3D=3D NULL) {
> > -             /* create a sperate hw fence */
> > +     if (!af) {
> > +             /* create a separate hw fence */
> >               am_fence =3D kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOM=
IC);
> >               if (am_fence =3D=3D NULL)
> >                       return -ENOMEM;
>
> I think we should remove the output parameter as well.
>
> An amdgpu_fence can be trivially allocated by the caller.

Is there anything special about amdgpu_job_fence_ops vs
amdgpu_fence_ops other than the slab handling?  I was worried I was
missing something about the fence lifetimes with amdgpu_job_{free,
free_cb}.

Alex

>
> Apart from that looks good to me.
>
> Regards,
> Christian.
>
> >       } else {
> > -             /* take use of job-embedded fence */
> > -             am_fence =3D &job->hw_fence;
> > +             am_fence =3D af;
> >       }
> >       fence =3D &am_fence->base;
> >       am_fence->ring =3D ring;
> >
> >       seq =3D ++ring->fence_drv.sync_seq;
> > -     if (job && job->job_run_counter) {
> > -             /* reinit seq for resubmitted jobs */
> > -             fence->seqno =3D seq;
> > -             /* TO be inline with external fence creation and other dr=
ivers */
> > +     if (af) {
> > +             dma_fence_init(fence, &amdgpu_job_fence_ops,
> > +                            &ring->fence_drv.lock,
> > +                            adev->fence_context + ring->idx, seq);
> > +             /* Against remove in amdgpu_job_{free, free_cb} */
> >               dma_fence_get(fence);
> >       } else {
> > -             if (job) {
> > -                     dma_fence_init(fence, &amdgpu_job_fence_ops,
> > -                                    &ring->fence_drv.lock,
> > -                                    adev->fence_context + ring->idx, s=
eq);
> > -                     /* Against remove in amdgpu_job_{free, free_cb} *=
/
> > -                     dma_fence_get(fence);
> > -             } else {
> > -                     dma_fence_init(fence, &amdgpu_fence_ops,
> > -                                    &ring->fence_drv.lock,
> > -                                    adev->fence_context + ring->idx, s=
eq);
> > -             }
> > +             dma_fence_init(fence, &amdgpu_fence_ops,
> > +                            &ring->fence_drv.lock,
> > +                            adev->fence_context + ring->idx, seq);
> >       }
> >
> >       amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ib.c
> > index 802743efa3b39..206b70acb29a0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > @@ -128,6 +128,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, un=
signed int num_ibs,
> >       struct amdgpu_device *adev =3D ring->adev;
> >       struct amdgpu_ib *ib =3D &ibs[0];
> >       struct dma_fence *tmp =3D NULL;
> > +     struct amdgpu_fence *af;
> >       bool need_ctx_switch;
> >       struct amdgpu_vm *vm;
> >       uint64_t fence_ctx;
> > @@ -154,6 +155,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, un=
signed int num_ibs,
> >               csa_va =3D job->csa_va;
> >               gds_va =3D job->gds_va;
> >               init_shadow =3D job->init_shadow;
> > +             af =3D &job->hw_fence;
> >       } else {
> >               vm =3D NULL;
> >               fence_ctx =3D 0;
> > @@ -161,6 +163,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, un=
signed int num_ibs,
> >               csa_va =3D 0;
> >               gds_va =3D 0;
> >               init_shadow =3D false;
> > +             af =3D NULL;
> >       }
> >
> >       if (!ring->sched.ready) {
> > @@ -282,7 +285,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, un=
signed int num_ibs,
> >               amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr)=
;
> >       }
> >
> > -     r =3D amdgpu_fence_emit(ring, f, job, fence_flags);
> > +     r =3D amdgpu_fence_emit(ring, f, af, fence_flags);
> >       if (r) {
> >               dev_err(adev->dev, "failed to emit fence (%d)\n", r);
> >               if (job && job->vmid)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.h
> > index e1f25218943a4..9ae522baad8e7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -157,8 +157,8 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_devi=
ce *adev);
> >  void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
> >  int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
> >  void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
> > -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fen=
ce, struct amdgpu_job *job,
> > -                   unsigned flags);
> > +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
> > +                   struct amdgpu_fence *af, unsigned int flags);
> >  int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
> >                             uint32_t timeout);
> >  bool amdgpu_fence_process(struct amdgpu_ring *ring);
>
