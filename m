Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919F3C7115A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 22:33:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A33110E912;
	Wed, 18 Jun 2025 22:33:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UerS1wkd";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E2D310E912
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 22:32:56 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-313dc7be67aso17034a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 15:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750285976; x=1750890776; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eXiBZbfwxwzHN6vD7beBkiYW/qAU6TkygWh25Rq53S8=;
 b=UerS1wkdLMSrCawzjiK/E3mX69H8lm5YHVbci/TWEuQmwTAEljfOP1aZwj6jP03NCF
 cphzDCVvW7Qyzkgtfp1BLARTtSadvxrWPl1VTa3fURvMAz8tCPUg2AuI4Yr+WUcY7x95
 4ktuzOYX8eQvplvCxHL43ZwcMk5NZL3uB/Ks7KGzjV0AOS4/wQuS5Z3Cz9h0sPMJqHt5
 Uxdw9l0YmycLMBIotQBqpYD+KhVdamY7OQgtA1WCim/x4zfC8NYgfAQiFjRA1BfZME0U
 N23LiLSfTz8UnUzqikPKQHF6ND3XT+CF6pjJP+J/35mrN1M1CAvlMc6wGDcoEpZDDzoc
 OqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750285976; x=1750890776;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eXiBZbfwxwzHN6vD7beBkiYW/qAU6TkygWh25Rq53S8=;
 b=tWXKqBTcA27WtBt0XZH3YyMKT8sj6G+laHwguU9fckpsxG7wk7jNa5KjjqlpKm4518
 dhrCoRMQHFxtUV4XNQMOf985JoOIO+gv27Wd80A3L1owahVqQyZB9ddyNji0/VMK8wJv
 sW3ImsGoTO8KgH285nI8msV3DDDIyCssNzysIRELLCukINBkODKhYv4VyWuhih0x6+IY
 5Z9ZQDnPJPIS+lvh0o4nHvGFUTy50o/L+oPbwWdfPdZ4DFBA2uLu3YGdfM0VKGlCcGWd
 ertzom0RsukeAHSZcUh3fBDfDC9mUrKyECXNCjRLpf8lmRestNSIGSpLZjRAglTjfmPN
 cUYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVj5gkNDa1o+h8KLsXdKxrN0ro6bapfax7IMAIv4lRNsHqVXvi/WfdM9FWAPZEQNX5hAVCXL0i@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDQZRCHp3W4XYS39lkBpwRBQIH1dzizc/6aCFAemdjvhcspYXm
 dKfGCmmN3xmfKXz7A4DS+gZR41zwuBoXMv4rK1kXcMc0CWWZI9GqXNHhpV1DZapujIKY6OD+9z0
 NT6kpdqJcwbvdsBQr8EtOljBBOatKbpTlH4NX
X-Gm-Gg: ASbGncuYIA94INtvt8H+EGOlo4hUrDYgu+9YMww0cJP8n8oRT/Hv7ajzwDA2oBPgrSt
 JFrzqsN2/FBWEh0zHWQ4xa0KLV1vx4PWrMtPiplvJHEHNslGUpyGMwHWutEljKpe9zxsLn39rkl
 LCbsRHGeOBZhD3czAoLe7HVVyTB0AICcRJQ2G+vmHhm1h0hLATvOn1+HY=
X-Google-Smtp-Source: AGHT+IEte7GpZ7CXfpGH5lKwjVVs5jmWngJe40TrRKFTb1GgzOqXP03N4T9akdLdBlDtyqfqFJG9g1yOtNqhvFBNZYo=
X-Received: by 2002:a17:90b:5305:b0:312:1ae9:1537 with SMTP id
 98e67ed59e1d1-3158b3b703emr605502a91.0.1750285975920; Wed, 18 Jun 2025
 15:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250617030815.5785-1-alexander.deucher@amd.com>
 <20250617030815.5785-3-alexander.deucher@amd.com>
 <81b40a5b-2747-41ef-ada5-7af0f28b33df@amd.com>
In-Reply-To: <81b40a5b-2747-41ef-ada5-7af0f28b33df@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 18 Jun 2025 18:32:44 -0400
X-Gm-Features: AX0GCFsvBkgME-02WRtBJ5Jle3CDoyfWaTNouLB5cmYkqzzG0IofOdUJbeIPUeU
Message-ID: <CADnq5_OL7R30ztBxShXq58-9+ZvJ9mCMi3uULLCMGKt=uCwTNQ@mail.gmail.com>
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

I think we should either take this patch as is or just drop it.  It's
looking to be non-trivial to clean this up further.  We still need
some sort of parameter to determine whether or not to use the
amdgpu_job_fence_ops or amdgpu_fence_ops.  Removing those is
non-trivial as there are all sorts of corner cases for fence
lifetimes.  Because the fence is part of the amdgpu_job structure, we
need to make sure fence lifetime aligns with the job lifetime since
the fence release also frees the job structure.  There is also special
handling in amdgpu_fence_driver_clear_job_fences() to handle memory
leaks in failed IB tests. It's definitely a worthwhile cleanup that
needs to be done, but it's looking like a whole project on its own.

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
