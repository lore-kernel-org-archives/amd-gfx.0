Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF82C5B549
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jun 2025 22:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9443910E190;
	Mon,  2 Jun 2025 22:42:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a0Xx7zJ3";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17D7310E190
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jun 2025 22:42:52 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b2ef619e80eso169160a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Jun 2025 15:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748904172; x=1749508972; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAQyO3TKrEYxgdNneJ6B/c3pqSIiOYZ/ewPpBllDXY4=;
 b=a0Xx7zJ3i7TGiD/QUDqnrSadtdlgkiB3UKB+vDVt4dm7JDZINIJZA7h5Q/SI2GBpGx
 kxHhTE4WJFus4Ye1a7qqm/LGsGNKY687Bwq+3jz7F7OmNvNqancmwG9i5tRpyfwHR32Z
 OdRk6QX4Wm56Lvn5tqH15liMbApeDFs6NOsrHezi2/ofZ5ybMNhYgJhjkaQwsZ+DxrmM
 pc89YR/axRgRobrpaZodB8IpCHkUS5PBzbjgML1NAmeh1DO5ZelSX9KysAJRnZuERYAM
 PyLN1ZsBMkt0UWyJlOJYfxPSOdBTCclknByujWxwF5LZCmMZS9eMK/WdrjYOVwyfS5rl
 JvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748904172; x=1749508972;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAQyO3TKrEYxgdNneJ6B/c3pqSIiOYZ/ewPpBllDXY4=;
 b=ZI3DxJ1274cq8rd8YffTTd3aJmvm9V6m5vPQ/L0ySfVHUgAlHGissl3AajUf+lfvOZ
 6JJ3pR+TBbHPkQqwLHUxNieiKjstTV5JsLph5lMgghjOr6Os9zxZozAKElfFGydOTrXS
 t+Rr+CDIqiYwweKV0HejwdGzMu8OmFEfc2vlBysTloRwNSWJeKqROHm86YTjPsP8Pc87
 LeEkqZxaXmqbifIsdse57AG+UYQ/5tQ9hH2DMh1ZJLTEtbY8VEcCPz8JcmDsKvyMl83C
 qcSf2AslkOPk0CM0+az070VpnmmORKTP50jzjPVqQMQopi2Fvri2NFFkgO3spxjQGwVA
 jVxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbijarIGGzHMzYXbpgEHRc3w04mYfybeM+43R0y4TJQLTXuNJ6gesmopprWdTj6aHaRZsS9VEG@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAmMxXD/Fi/2wQ7OE+lAO0OTMRvf6+9W6KxwJIkVIFA8HymTm/
 1RVeburB1vnIt8kddUF2pKkB41JZLg4WpIl/lsKYgH9p3AloVpIgkHNt8+UdUVSQ3RhX0/KVAvw
 JETcA3+ldLyU1Y1eRCfef9hrNQK9dEzs=
X-Gm-Gg: ASbGncuUciLZOIU6bS1baCz8Swso/mcETvn+dKWnhWXfSxjbXHoZTp3Lgoe0xQDW1VF
 69+gwT+dK4tc+KuISvZVAYqPlK/aWh/xRIqSvbbTGc6lUxHzW0l3ynBSb25vtc3p15E0SJOZNpI
 LoverX0jpFFwn9hpoE8Qqpp9zN2WQSf2Ch2w==
X-Google-Smtp-Source: AGHT+IHsY9yfBsPYfW1DReQgPRLo66LJzzLZ2kJXPztiPv1emos26/bxHKT9m4EMOfsOeeC0pmUubSONirM/TCvXgfs=
X-Received: by 2002:a17:90b:1e06:b0:311:488:f506 with SMTP id
 98e67ed59e1d1-312e454d6a4mr547435a91.6.1748904171757; Mon, 02 Jun 2025
 15:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250529200758.6326-1-alexander.deucher@amd.com>
 <20250529200758.6326-8-alexander.deucher@amd.com>
 <179a37aa-7e6b-4870-848f-c3ee3fd428d4@amd.com>
In-Reply-To: <179a37aa-7e6b-4870-848f-c3ee3fd428d4@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Jun 2025 18:42:40 -0400
X-Gm-Features: AX0GCFtYo_oqZQSsLUN5hk8UDEz_QESKsMYdu51Irycxd_t3smKYHMOf0qmalck
Message-ID: <CADnq5_N_0Wzjm8vCoboqe-8EuMcpkBVwg_=BVy-V3XbM=rHqVQ@mail.gmail.com>
Subject: Re: [PATCH 07/28] drm/amdgpu: track ring state associated with a job
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

On Mon, Jun 2, 2025 at 10:36=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/29/25 22:07, Alex Deucher wrote:
> > We need to know the wptr and sequence number associated
> > with a job so that we can re-emit the unprocessed state
> > after a ring reset.  Pre-allocate storage space for
> > the ring buffer contents and add a helper to save off
> > the unprocessed state so that it can be re-emitted
> > after the queue is reset.
> >
> > Add a helper that ring reset callbacks can use to verify
> > that the ring has reset successfully and to reemit any
> > unprocessed ring contents from subsequent jobs.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 12 ++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  6 +++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  5 ++-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h   |  2 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 46 +++++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  8 ++++
> >  6 files changed, 78 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_fence.c
> > index 2f24a6aa13bf6..319548ac58820 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > @@ -764,6 +764,18 @@ void amdgpu_fence_driver_force_completion(struct a=
mdgpu_ring *ring)
> >       amdgpu_fence_process(ring);
> >  }
> >
> > +/**
> > + * amdgpu_fence_driver_seq_force_completion - force signal of specifie=
d sequence
> > + *
> > + * @ring: fence of the ring to signal
> > + *
> > + */
> > +void amdgpu_fence_driver_seq_force_completion(struct amdgpu_ring *ring=
, u32 seq)
> > +{
> > +     amdgpu_fence_write(ring, seq);
> > +     amdgpu_fence_process(ring);
> > +}
> > +
> >  /*
> >   * Common fence implementation
> >   */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ib.c
> > index 802743efa3b39..67df82d50a74a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > @@ -306,6 +306,12 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, u=
nsigned int num_ibs,
> >
> >       amdgpu_ring_ib_end(ring);
> >       amdgpu_ring_commit(ring);
> > +     /* This must be last for resets to work properly
> > +      * as we need to save the wptr associated with this
> > +      * job.
> > +      */
> > +     if (job)
> > +             job->ring_wptr =3D ring->wptr;
>
> First of all such state should *absolutely* not be made part of the job. =
That belongs into the HW fence.

Done.  Updated patches pushed here:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/kq_resets?ref_type=3Dh=
eads

>
> Then we need to handle the case that one application submitted multiple j=
obs which potentially depend on each other.
>
> I think we should rather put this logic into amdgpu_device_enforce_isolat=
ion().

I'm not quite sure I understand what you are proposing.  Is the idea
to track all of the jobs associated with a particular process and then
when we reset a queue, skip all of the ring contents associated with
those jobs and signal and set the error on all of their job fences?
What about cross ring dependencies?

Alex

>
> Regards,
> Christian.
>
>
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_job.c
> > index a0fab947143b5..f0f752284b925 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > @@ -91,6 +91,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(st=
ruct drm_sched_job *s_job)
> >       struct amdgpu_job *job =3D to_amdgpu_job(s_job);
> >       struct amdgpu_task_info *ti;
> >       struct amdgpu_device *adev =3D ring->adev;
> > +     struct dma_fence *fence =3D &job->hw_fence;
> >       int idx;
> >       int r;
> >
> > @@ -154,8 +155,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout=
(struct drm_sched_job *s_job)
> >               else
> >                       is_guilty =3D true;
> >
> > -             if (is_guilty)
> > +             if (is_guilty) {
> > +                     amdgpu_ring_backup_unprocessed_jobs(ring, job->ri=
ng_wptr, fence->seqno);
> >                       dma_fence_set_error(&s_job->s_fence->finished, -E=
TIME);
> > +             }
> >
> >               r =3D amdgpu_ring_reset(ring, job->vmid);
> >               if (!r) {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_job.h
> > index f2c049129661f..c2ed0edb5179d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > @@ -79,6 +79,8 @@ struct amdgpu_job {
> >       /* enforce isolation */
> >       bool                    enforce_isolation;
> >       bool                    run_cleaner_shader;
> > +     /* wptr for the job for resets */
> > +     uint32_t                ring_wptr;
> >
> >       uint32_t                num_ibs;
> >       struct amdgpu_ib        ibs[];
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.c
> > index 426834806fbf2..909b121d432cb 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > @@ -333,6 +333,12 @@ int amdgpu_ring_init(struct amdgpu_device *adev, s=
truct amdgpu_ring *ring,
> >       /*  Initialize cached_rptr to 0 */
> >       ring->cached_rptr =3D 0;
> >
> > +     if (!ring->ring_backup) {
> > +             ring->ring_backup =3D kvzalloc(ring->ring_size, GFP_KERNE=
L);
> > +             if (!ring->ring_backup)
> > +                     return -ENOMEM;
> > +     }
> > +
> >       /* Allocate ring buffer */
> >       if (ring->ring_obj =3D=3D NULL) {
> >               r =3D amdgpu_bo_create_kernel(adev, ring->ring_size + rin=
g->funcs->extra_dw, PAGE_SIZE,
> > @@ -342,6 +348,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, st=
ruct amdgpu_ring *ring,
> >                                           (void **)&ring->ring);
> >               if (r) {
> >                       dev_err(adev->dev, "(%d) ring create failed\n", r=
);
> > +                     kvfree(ring->ring_backup);
> >                       return r;
> >               }
> >               amdgpu_ring_clear_ring(ring);
> > @@ -385,6 +392,8 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
> >       amdgpu_bo_free_kernel(&ring->ring_obj,
> >                             &ring->gpu_addr,
> >                             (void **)&ring->ring);
> > +     kvfree(ring->ring_backup);
> > +     ring->ring_backup =3D NULL;
> >
> >       dma_fence_put(ring->vmid_wait);
> >       ring->vmid_wait =3D NULL;
> > @@ -753,3 +762,40 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *r=
ing)
> >
> >       return true;
> >  }
> > +
> > +void amdgpu_ring_backup_unprocessed_jobs(struct amdgpu_ring *ring,
> > +                                      u64 bad_wptr, u32 bad_seq)
> > +{
> > +     unsigned int entries_to_copy =3D ring->wptr - bad_wptr;
> > +     unsigned int idx, i;
> > +
> > +     for (i =3D 0; i < entries_to_copy; i++) {
> > +             idx =3D (bad_wptr + i) & ring->buf_mask;
> > +             ring->ring_backup[i] =3D ring->ring[idx];
> > +     }
> > +     ring->ring_backup_entries_to_copy =3D entries_to_copy;
> > +     ring->ring_backup_seq =3D bad_seq;
> > +}
> > +
> > +int amdgpu_ring_reemit_unprocessed_jobs(struct amdgpu_ring *ring)
> > +{
> > +     unsigned int i;
> > +     int r;
> > +
> > +     /* signal the fence of the bad job */
> > +     amdgpu_fence_driver_seq_force_completion(ring, ring->ring_backup_=
seq);
> > +     /* verify that the ring is functional */
> > +     r =3D amdgpu_ring_test_ring(ring);
> > +     if (r)
> > +             return r;
> > +     /* re-emit the unprocessed ring contents */
> > +     if (ring->ring_backup_entries_to_copy) {
> > +             if (amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_=
copy))
> > +                     return -ENOMEM;
> > +             for (i =3D 0; i < ring->ring_backup_entries_to_copy; i++)
> > +                     amdgpu_ring_write(ring, ring->ring_backup[i]);
> > +             amdgpu_ring_commit(ring);
> > +     }
> > +
> > +     return r;
> > +}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.h
> > index b95b471107692..fd08449eee33f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -132,6 +132,8 @@ extern const struct drm_sched_backend_ops amdgpu_sc=
hed_ops;
> >  void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
> >  void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error=
);
> >  void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
> > +void amdgpu_fence_driver_seq_force_completion(struct amdgpu_ring *ring=
,
> > +                                           u32 seq);
> >
> >  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
> >  int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
> > @@ -268,6 +270,9 @@ struct amdgpu_ring {
> >
> >       struct amdgpu_bo        *ring_obj;
> >       uint32_t                *ring;
> > +     uint32_t                *ring_backup;
> > +     uint32_t                ring_backup_seq;
> > +     unsigned int            ring_backup_entries_to_copy;
> >       unsigned                rptr_offs;
> >       u64                     rptr_gpu_addr;
> >       volatile u32            *rptr_cpu_addr;
> > @@ -534,4 +539,7 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev)=
;
> >  void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
> >  int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
> >  bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
> > +void amdgpu_ring_backup_unprocessed_jobs(struct amdgpu_ring *ring,
> > +                                      u64 bad_wptr, u32 bad_seq);
> > +int amdgpu_ring_reemit_unprocessed_jobs(struct amdgpu_ring *ring);
> >  #endif
>
