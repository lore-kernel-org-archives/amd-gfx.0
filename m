Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C0CC71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 13:50:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84E4D10E6F7;
	Tue, 17 Jun 2025 13:50:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fe0yAzGS";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 224EC10E6F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 13:50:06 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-312efc384fcso1022233a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 06:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750168205; x=1750773005; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yq7/Kp04En93Nb7EQlxZna7a39NaUXKZaOa7qch2igo=;
 b=Fe0yAzGSh6Yf26Oof2H1AfpFeVz89IFZw+t0SVBrGC8+ljUmhl6hLzOEfs4f3gzEot
 ST9kHNL1CHn+NUy/C/ZWGYXkXx8UtsdNeyyXJpa+MFidCUTEtnTBDUNOZUCVM0x7Fo1q
 1Cswk4Tz/wbdzLfP5IWpINgd4nbmAohAjJkbZhZh54Gm7mI0oAv2QFnUu5TbMHf5ZVuM
 diJ0KJTnSdD2LkQcyMo7RkIuCdv7ZxtgKQ61Afr/K/iHbD8A20oxyMae7V30TkjMm404
 CbuWJeXR6dnVMOMroLxGZU7u5O0Z0S3CanWB1eh5okDMaGQhhaDhi9mJkAySrcrxZXby
 nEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750168205; x=1750773005;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yq7/Kp04En93Nb7EQlxZna7a39NaUXKZaOa7qch2igo=;
 b=sWE40yyQ95IO9jhCBVe3ys5LeCB3V08YiN65+Y3bt5h2sPi0cCdLCy/4rZdh02JvNF
 CVV+VNwQiOAkEYgqlBvzs1S8wvYj8bBoH6vtOzMFHd2eWLLRCmdFsCez6haqIUbPcIkF
 C5ln2BgGCR1demiEUYum6lDSHS8EwREsOOHJ4EAWei1qyfdz0uZKSWJUUG2kBaBjt198
 XwP3a+ksoxFKnrdtDnLa79Nn72hw7rQfqAaJbaapsKM+oFAbnngsw+5J/OSen4iUCDze
 9oss+1ggCuj6p41Z+FVwAZ28OpGzsbESUEd9+tMVThG+8rhx9x25z/KObMv0Jzj3oElW
 QeZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF0+Ia+qVC1q+XZqp4c5IPjZFReok6WOqEiYNeIPov92VyBe+jRkR1HjtSGkrMnyiXlmuJbBRe@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyvxYYxHHQzs5BTw1qJBeVmX9Rm/E/d4p6vuBgQLAbvIp9fRTk/
 qZdOgIZ9N+HR4j9bGv17trzRiHzMRDWOcFxBAn+g7VoisBX0wZKxhp5U0bHoQ5XmE9mHfl7aOeq
 KIbJc7jtbi8fcpaIEmPTStBI5fNefdVWq1sLg
X-Gm-Gg: ASbGncudhHmvTtUfawKMmbgYT5UqdWwRDzMNF/RFSRh44wFEVQJXrUTKc+SAZvhTUSL
 +a8c1/s3cxMRiKSmah9YX0lx1E80ReX8xnxYalzKhMt5FX/Z6JWKfFdWbX42PkIGPDo0wdKei+Q
 U9q67QvHndTqJrWEm+IBcjElT4vD9TW2un72CJ9aykg8Gd
X-Google-Smtp-Source: AGHT+IEZbTKU3SUh6sgiB4879fSlDk51UJz5fhiM1EARmpZiRjUhBchRoapsvugYyI7dEgWqD0XJ7TqIbV2ZBjQFm0s=
X-Received: by 2002:a17:90b:2cc5:b0:311:a314:c2c9 with SMTP id
 98e67ed59e1d1-3142562c595mr1846631a91.1.1750168205436; Tue, 17 Jun 2025
 06:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250617030815.5785-1-alexander.deucher@amd.com>
 <20250617030815.5785-3-alexander.deucher@amd.com>
 <81b40a5b-2747-41ef-ada5-7af0f28b33df@amd.com>
 <CADnq5_OTeWFNmB6dWaodyuQhX9VbBLvMBNOjVZ+WpyB0sr5Ajg@mail.gmail.com>
In-Reply-To: <CADnq5_OTeWFNmB6dWaodyuQhX9VbBLvMBNOjVZ+WpyB0sr5Ajg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Jun 2025 09:49:53 -0400
X-Gm-Features: AX0GCFs5T0HiX0GZ3g0RA9y-r5-2ykDr4mQkOdQdf-OIqMKJnxKdo6Lx5sDUwDI
Message-ID: <CADnq5_P3bbK79K+scavz6bqJ3XMhfqsMU8zTsseU3XnoTgR9cA@mail.gmail.com>
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

On Tue, Jun 17, 2025 at 9:46=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Tue, Jun 17, 2025 at 7:57=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > On 6/17/25 05:07, Alex Deucher wrote:
> > > What we actually care about is the amdgpu_fence object
> > > so pass that in explicitly to avoid possible mistakes
> > > in the future.
> > >
> > > The job_run_counter handling can be safely removed at this
> > > point as we no longer support job resubmission.
> > >
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 36 +++++++++------------=
--
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  5 +++-
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  4 +--
> > >  3 files changed, 20 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_fence.c
> > > index 569e0e5373927..e88848c14491a 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > @@ -114,14 +114,14 @@ static u32 amdgpu_fence_read(struct amdgpu_ring=
 *ring)
> > >   *
> > >   * @ring: ring the fence is associated with
> > >   * @f: resulting fence object
> > > - * @job: job the fence is embedded in
> > > + * @af: amdgpu fence input
> > >   * @flags: flags to pass into the subordinate .emit_fence() call
> > >   *
> > >   * Emits a fence command on the requested ring (all asics).
> > >   * Returns 0 on success, -ENOMEM on failure.
> > >   */
> > > -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f=
, struct amdgpu_job *job,
> > > -                   unsigned int flags)
> > > +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f=
,
> > > +                   struct amdgpu_fence *af, unsigned int flags)
> > >  {
> > >       struct amdgpu_device *adev =3D ring->adev;
> > >       struct dma_fence *fence;
> > > @@ -130,36 +130,28 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring,=
 struct dma_fence **f, struct amd
> > >       uint32_t seq;
> > >       int r;
> > >
> > > -     if (job =3D=3D NULL) {
> > > -             /* create a sperate hw fence */
> > > +     if (!af) {
> > > +             /* create a separate hw fence */
> > >               am_fence =3D kmem_cache_alloc(amdgpu_fence_slab, GFP_AT=
OMIC);
> > >               if (am_fence =3D=3D NULL)
> > >                       return -ENOMEM;
> >
> > I think we should remove the output parameter as well.
> >
> > An amdgpu_fence can be trivially allocated by the caller.
>
> Is there anything special about amdgpu_job_fence_ops vs
> amdgpu_fence_ops other than the slab handling?  I was worried I was
> missing something about the fence lifetimes with amdgpu_job_{free,
> free_cb}.

Specifically this chunk of code is confusing to me:

        /* only put the hw fence if has embedded fence */
        if (!job->hw_fence.base.ops)
                kfree(job);
        else
                dma_fence_put(&job->hw_fence.base);

Alex

>
> Alex
>
> >
> > Apart from that looks good to me.
> >
> > Regards,
> > Christian.
> >
> > >       } else {
> > > -             /* take use of job-embedded fence */
> > > -             am_fence =3D &job->hw_fence;
> > > +             am_fence =3D af;
> > >       }
> > >       fence =3D &am_fence->base;
> > >       am_fence->ring =3D ring;
> > >
> > >       seq =3D ++ring->fence_drv.sync_seq;
> > > -     if (job && job->job_run_counter) {
> > > -             /* reinit seq for resubmitted jobs */
> > > -             fence->seqno =3D seq;
> > > -             /* TO be inline with external fence creation and other =
drivers */
> > > +     if (af) {
> > > +             dma_fence_init(fence, &amdgpu_job_fence_ops,
> > > +                            &ring->fence_drv.lock,
> > > +                            adev->fence_context + ring->idx, seq);
> > > +             /* Against remove in amdgpu_job_{free, free_cb} */
> > >               dma_fence_get(fence);
> > >       } else {
> > > -             if (job) {
> > > -                     dma_fence_init(fence, &amdgpu_job_fence_ops,
> > > -                                    &ring->fence_drv.lock,
> > > -                                    adev->fence_context + ring->idx,=
 seq);
> > > -                     /* Against remove in amdgpu_job_{free, free_cb}=
 */
> > > -                     dma_fence_get(fence);
> > > -             } else {
> > > -                     dma_fence_init(fence, &amdgpu_fence_ops,
> > > -                                    &ring->fence_drv.lock,
> > > -                                    adev->fence_context + ring->idx,=
 seq);
> > > -             }
> > > +             dma_fence_init(fence, &amdgpu_fence_ops,
> > > +                            &ring->fence_drv.lock,
> > > +                            adev->fence_context + ring->idx, seq);
> > >       }
> > >
> > >       amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ib.c
> > > index 802743efa3b39..206b70acb29a0 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > > @@ -128,6 +128,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, =
unsigned int num_ibs,
> > >       struct amdgpu_device *adev =3D ring->adev;
> > >       struct amdgpu_ib *ib =3D &ibs[0];
> > >       struct dma_fence *tmp =3D NULL;
> > > +     struct amdgpu_fence *af;
> > >       bool need_ctx_switch;
> > >       struct amdgpu_vm *vm;
> > >       uint64_t fence_ctx;
> > > @@ -154,6 +155,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, =
unsigned int num_ibs,
> > >               csa_va =3D job->csa_va;
> > >               gds_va =3D job->gds_va;
> > >               init_shadow =3D job->init_shadow;
> > > +             af =3D &job->hw_fence;
> > >       } else {
> > >               vm =3D NULL;
> > >               fence_ctx =3D 0;
> > > @@ -161,6 +163,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, =
unsigned int num_ibs,
> > >               csa_va =3D 0;
> > >               gds_va =3D 0;
> > >               init_shadow =3D false;
> > > +             af =3D NULL;
> > >       }
> > >
> > >       if (!ring->sched.ready) {
> > > @@ -282,7 +285,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, =
unsigned int num_ibs,
> > >               amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_add=
r);
> > >       }
> > >
> > > -     r =3D amdgpu_fence_emit(ring, f, job, fence_flags);
> > > +     r =3D amdgpu_fence_emit(ring, f, af, fence_flags);
> > >       if (r) {
> > >               dev_err(adev->dev, "failed to emit fence (%d)\n", r);
> > >               if (job && job->vmid)
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ring.h
> > > index e1f25218943a4..9ae522baad8e7 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > > @@ -157,8 +157,8 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_de=
vice *adev);
> > >  void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
> > >  int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
> > >  void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
> > > -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f=
ence, struct amdgpu_job *job,
> > > -                   unsigned flags);
> > > +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f=
,
> > > +                   struct amdgpu_fence *af, unsigned int flags);
> > >  int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
> > >                             uint32_t timeout);
> > >  bool amdgpu_fence_process(struct amdgpu_ring *ring);
> >
