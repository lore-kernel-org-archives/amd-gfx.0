Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A02CAC597
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 14:25:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B966110E303;
	Mon, 15 Sep 2025 14:25:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UIKnv10C";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8785310E303
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 14:25:04 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-267716b113bso1371505ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 07:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757946304; x=1758551104; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P8c1O6a9zfM4o4qtjAiGlHCGLA7OMv4kdwweXh0gNf4=;
 b=UIKnv10CxVq07bprIfn92NBGCqASHoxceEXvxG4K46MtQ4R09N39tzD6KQw0svqhou
 csziIDdZOgEnjmlJERbVxFsu2ucNt+Z6VKJVceXgdALoFH2uGRe58H4gwiZaF9bZ4aqc
 J6go4veT47aJlomU8MRsRZsWtOGbbYxQemuuj/cX4R3CSDtklwuQMMiZTwMBOofAYD1J
 ktILeqJAibh4rGP1pmxhy91GXNGKU2U601UR3FHJ6lrGsQkk+LodsHwZkondFRJfcfjJ
 iUfSX6qDr4Jqu6LQ8KVacQ01jUgPkyWH6OyYS/lVrvdnUjMr85v2HqCGhLERHCEPXP5f
 AP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757946304; x=1758551104;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P8c1O6a9zfM4o4qtjAiGlHCGLA7OMv4kdwweXh0gNf4=;
 b=hgOxZqeG6A2HYS0ueIWoAX/fWwv5glGUwuxco5E1u1UuX7QoSjfvqw5mf1+IV4Z2M+
 i4Be476bvTe/xkKXcPNC7whmKC0JGylt/eVJVH0H3fTfKG45Szj5VzcEbV4c98zPB8ea
 +TURH5rpwg+Q0G/O66qcel2Y4d2UEJDMHtpqx/ut1DvPL8x2BG/6kjPdL8Oh/I5bAhKZ
 1ydhXjNkHcVpY+ptwIhlvizM/NsjhpCVPoQDVCoLqILYSCmPBXWLAj6lzdNq038glFhL
 Eon2paExTSL36+HzcJIMZvUNKXLV2W+oV7ZkWpnK7SGONSJQNDvHe0cjIk2skKWlkuB9
 gDtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqDSAR57pe5g9UVDchawfeua2mw4XNdiPl8lIW933Uq63LWx8SIs0/suGTXX7KEVQ73KWD1A2Z@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIS1GMlwnJCp3wcwOMcon1XG6iRdw1anHeq7jZenk4+GC8CIuB
 RovL38vp+O8pQDOA0W2X7vwOX3jLI4pMdjht1NoHNSZ7+iWn3ARh/km2i0uAho61Z2+ghTyeM8u
 BrBayLE/DEDR4yqQvUledUReSILcLbgY=
X-Gm-Gg: ASbGncthQWpjk4OlKwnzFd0vz2ENS1S28EI9A5g5KOIlf2GbrwPdUzuxsQ86zbfPaVo
 P1ImVIdXisN5TzqiszNjDtQ039TsmlRBbY9HZxv+4io5PisP7jFWnGpaFZ+71USYHQFCdBNTW+S
 MdvcR5OPsAOH94L5Xn/+WQvziRt0nvbkJpQVWX61fHiNnongyfAUT8L92l/P6QAfEGE74BOyX46
 RQ+tZNYXxLYNsAgBA==
X-Google-Smtp-Source: AGHT+IFL12+jrgzrmrQn8I6z2PUlXBRQHQycIEyIRtaMX1Q0FTlzRm88ctvuZG7gsG9FuqAgf532TMpyUfCBU0ztGSU=
X-Received: by 2002:a17:902:c407:b0:24b:142a:c540 with SMTP id
 d9443c01a7336-25d24bafdb3mr89316135ad.1.1757946303780; Mon, 15 Sep 2025
 07:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250915133356.3547174-1-alexander.deucher@amd.com>
 <70e8c427-f816-4bdb-8f92-9382cd5ab13a@amd.com>
In-Reply-To: <70e8c427-f816-4bdb-8f92-9382cd5ab13a@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Sep 2025 10:24:52 -0400
X-Gm-Features: Ac12FXyY3QhrW64QJBYrQRtdYWbhsRCXrwy8UGBFFyYzByOd4tK0LoiXQSsNZ5M
Message-ID: <CADnq5_PUzTPcAchWfQGzsBc_SgY6E11B5aHMv8472NMoGPz48A@mail.gmail.com>
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

On Mon, Sep 15, 2025 at 9:59=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> On 15.09.25 15:33, Alex Deucher wrote:
> > When we backup ring contents to reemit after a queue reset,
> > we don't backup ring contents from the bad context.  When
> > we signal the fences, we should set an error on those
> > fences as well.
> >
> > v2: misc cleanups
> > v3: add locking for fence error, fix comment (Christian)
> >
> > Fixes: 77cc0da39c7c ("drm/amdgpu: track ring state associated with a fe=
nce")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 33 ++++++++++++++++++++---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 +-
> >  3 files changed, 31 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_fence.c
> > index fd8cca241da62..72f0f16924476 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > @@ -758,11 +758,36 @@ void amdgpu_fence_driver_force_completion(struct =
amdgpu_ring *ring)
> >   * @fence: fence of the ring to signal
> >   *
> >   */
> > -void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *=
fence)
> > +void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *=
af)
> >  {
> > -     dma_fence_set_error(&fence->base, -ETIME);
> > -     amdgpu_fence_write(fence->ring, fence->seq);
> > -     amdgpu_fence_process(fence->ring);
> > +     struct dma_fence *unprocessed;
> > +     struct dma_fence __rcu **ptr;
> > +     struct amdgpu_fence *fence;
> > +     struct amdgpu_ring *ring =3D af->ring;
> > +     unsigned long flags;
> > +     u64 i, seqno;
> > +
> > +     seqno =3D amdgpu_fence_read(ring);
> > +
> > +     spin_lock_irqsave(&ring->fence_drv.lock, flags);
> > +     for (i =3D seqno + 1; i <=3D ring->fence_drv.sync_seq; ++i) {
>
> That won't work, the seqno can wrap around.
>
> I would just go over all fences, e.g. from 0 to end of array.
>
> The checks below should make sure that we don't try to set an error on so=
mething already processed.
>
> > +             ptr =3D &ring->fence_drv.fences[i & ring->fence_drv.num_f=
ences_mask];
> > +             rcu_read_lock();
> > +             unprocessed =3D rcu_dereference(*ptr);
> > +
> > +             if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
>
> dma_fence_is_signaled_locked(), otherwise the function would try to lock =
the same spinlock again.
>
> > +                     fence =3D container_of(unprocessed, struct amdgpu=
_fence, base);
> > +
> > +                     if (fence =3D=3D af)
> > +                             dma_fence_set_error(&fence->base, -ETIME)=
;
> > +                     else if (fence->context =3D=3D af->context)
> > +                             dma_fence_set_error(&fence->base, -ECANCE=
LED);
> > +             }
> > +             rcu_read_unlock();
> > +     }
> > +     spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
>
> > +     amdgpu_fence_write(ring, af->seq);
> > +     amdgpu_fence_process(ring);
>
> That's actually wrong. We want the other fences to signal later on when w=
e process them.

This fence is the original guilty fence.  The other fences will
naturally signal when the later fences signal.

Alex

>
> Regards,
> Christian.
>
> >  }
> >
> >  void amdgpu_fence_save_wptr(struct dma_fence *fence)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.c
> > index 6379bb25bf5ce..f6c9decedbd51 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > @@ -812,7 +812,7 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring=
 *ring,
> >       if (r)
> >               return r;
> >
> > -     /* signal the fence of the bad job */
> > +     /* signal the guilty fence and set an error on all fences from th=
e context */
> >       if (guilty_fence)
> >               amdgpu_fence_driver_guilty_force_completion(guilty_fence)=
;
> >       /* Re-emit the non-guilty commands */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.h
> > index 7670f5d82b9e4..0704fd9b85fdb 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -155,7 +155,7 @@ extern const struct drm_sched_backend_ops amdgpu_sc=
hed_ops;
> >  void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
> >  void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error=
);
> >  void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
> > -void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *=
fence);
> > +void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *=
af);
> >  void amdgpu_fence_save_wptr(struct dma_fence *fence);
> >
> >  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
>
