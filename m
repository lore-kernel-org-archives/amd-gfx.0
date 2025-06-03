Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AC3C5AE59
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 14:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E24AE10E604;
	Tue,  3 Jun 2025 14:27:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AUn3ftCt";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 750F010E604
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 14:27:23 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-234a45e69c8so6139225ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jun 2025 07:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748960843; x=1749565643; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0342+i7nNpPgjlek1fm7MeN4K2e7UFxCdUfMxiF3WBc=;
 b=AUn3ftCtviPjOFtgpTEfi1jNL8OKE7vjNaTw1QrrfVux7SYOB8JxPGr6zhH24ZCsCU
 Q+KKkG8E8lVxb8jh+aKWj6VTzuj+AtZ5cpDHxKqAyPoWYqpVOtX81kQfnwixwLt0ueV5
 R3SpuKyu2Ffe5pGHyNbfTb9Jh91I15KhDzA6k9ZC6vu99Pgy8cIpuucxT8mXls/gKvPl
 CQlr3W5Ml8Y9qwCu6+dRujqtzgIvW9EL7UFPcG1OpF0x0f9+EKDP9qEGGNLu/tTG11+U
 7OAqAnPzvu0+JfquCuxAhP8dM6j7FMkA3uiCeI+WUzyP4Q/hnVbgq1zY9D9RYEwqvV0H
 +INQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748960843; x=1749565643;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0342+i7nNpPgjlek1fm7MeN4K2e7UFxCdUfMxiF3WBc=;
 b=Dhk1k9dvzjg8gwsBaLmj6SgHwNaT82lbR7SPRMvFX/fvVatd14m1tKGR/ZmYk37hJG
 f8tav3+LA050jllHWZ/xFMZCm3ldjOp2tfCIKeH5mqrh5b2wT6o+uW3xBIxxz0Yl/rg/
 PeveJ1RPYFwXUapqbGdROsq2yH8pTtyGKcHeTmHqeSdwgXJ7I8pIZZGRKzyUyUIilN7m
 c8IKi7dV+D28exl5cqHlroxq4Dce20MmwGykpAAY0YsHODA80rQkOf7iXXtUV/Y9tDFw
 Y4RyWyMxbLouAujiCKbM6HENC/C02NtUAQ3w2vRy5gPt2zOQJXLFIN7Y42dilRfmt/eY
 TABQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3ig/vWbd3PBcJ52/EeSyGR62WmrhLlrCiIh9nuGXq6G4x0rFI8UpK6pm3S9sxJb561GPI1ikJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBj28i5LgWXB9bsrFQfUCL7B3aMPtH3iS+s0jwa85qA3IXXt9Z
 dJmppohJInwFmL92FMfCzV6kBJSp8zYbxQ3xgkXLTv+9wAdI8bs0RX3eIESRotu+8Lk4VOvGDiu
 WrkhAxFW0N5zEi16QnF1lg2cERZ0nBUpCotKU
X-Gm-Gg: ASbGncv8G4aUhYsgidKD1HoZ4RzksSz/sKiHEpMq3irpHD/9PMyZy20eO6nvR9Hz3yX
 NQyzW04E9mo+YHuMeqa0UmB9OsiFAWVGPjFXc3BUD8j36DUdEDpKFrB8UPu1Yko4J3PnNvbMglD
 m9H5cPmDDXN/5WX5EQDJlOwc4bby17ZBqMgyYWUZPxthSR
X-Google-Smtp-Source: AGHT+IFunX/QnJ3J8xhNbRtU0JoBpmCtzRNgjgbuJUPABQDGY/xH/2yjsW4wM2uGYudzokyVaw2LI+kEUP5G6S7dfpI=
X-Received: by 2002:a17:90b:4c49:b0:310:cf92:7899 with SMTP id
 98e67ed59e1d1-312e44c95bemr1835709a91.3.1748960843103; Tue, 03 Jun 2025
 07:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250529200758.6326-1-alexander.deucher@amd.com>
 <20250529200758.6326-8-alexander.deucher@amd.com>
 <179a37aa-7e6b-4870-848f-c3ee3fd428d4@amd.com>
 <CADnq5_N_0Wzjm8vCoboqe-8EuMcpkBVwg_=BVy-V3XbM=rHqVQ@mail.gmail.com>
 <d44d1df2-bd9d-46c5-96a5-6694ae4ad0ea@amd.com>
In-Reply-To: <d44d1df2-bd9d-46c5-96a5-6694ae4ad0ea@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Jun 2025 10:27:11 -0400
X-Gm-Features: AX0GCFvT54MNBOHSmArYQSFCSJ9LfViNUNkW-2sB0eJY3P5BaSueRa2mHuaoVtE
Message-ID: <CADnq5_NNYfG4cRm0t17yFz2vHdq=fj0=Kx2tReK0h4obp4G2Hw@mail.gmail.com>
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

On Tue, Jun 3, 2025 at 4:03=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 6/3/25 00:42, Alex Deucher wrote:
> > On Mon, Jun 2, 2025 at 10:36=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 5/29/25 22:07, Alex Deucher wrote:
> >>> We need to know the wptr and sequence number associated
> >>> with a job so that we can re-emit the unprocessed state
> >>> after a ring reset.  Pre-allocate storage space for
> >>> the ring buffer contents and add a helper to save off
> >>> the unprocessed state so that it can be re-emitted
> >>> after the queue is reset.
> >>>
> >>> Add a helper that ring reset callbacks can use to verify
> >>> that the ring has reset successfully and to reemit any
> >>> unprocessed ring contents from subsequent jobs.
> >>>
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> ---
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 12 ++++++
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  6 +++
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  5 ++-
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h   |  2 +
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 46 +++++++++++++++++++++=
++
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  8 ++++
> >>>  6 files changed, 78 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_fence.c
> >>> index 2f24a6aa13bf6..319548ac58820 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> >>> @@ -764,6 +764,18 @@ void amdgpu_fence_driver_force_completion(struct=
 amdgpu_ring *ring)
> >>>       amdgpu_fence_process(ring);
> >>>  }
> >>>
> >>> +/**
> >>> + * amdgpu_fence_driver_seq_force_completion - force signal of specif=
ied sequence
> >>> + *
> >>> + * @ring: fence of the ring to signal
> >>> + *
> >>> + */
> >>> +void amdgpu_fence_driver_seq_force_completion(struct amdgpu_ring *ri=
ng, u32 seq)
> >>> +{
> >>> +     amdgpu_fence_write(ring, seq);
> >>> +     amdgpu_fence_process(ring);
> >>> +}
> >>> +
> >>>  /*
> >>>   * Common fence implementation
> >>>   */
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ib.c
> >>> index 802743efa3b39..67df82d50a74a 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> >>> @@ -306,6 +306,12 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring,=
 unsigned int num_ibs,
> >>>
> >>>       amdgpu_ring_ib_end(ring);
> >>>       amdgpu_ring_commit(ring);
> >>> +     /* This must be last for resets to work properly
> >>> +      * as we need to save the wptr associated with this
> >>> +      * job.
> >>> +      */
> >>> +     if (job)
> >>> +             job->ring_wptr =3D ring->wptr;
> >>
> >> First of all such state should *absolutely* not be made part of the jo=
b. That belongs into the HW fence.
> >
> > Done.  Updated patches pushed here:
> > https://gitlab.freedesktop.org/agd5f/linux/-/commits/kq_resets?ref_type=
=3Dheads
> >
> >>
> >> Then we need to handle the case that one application submitted multipl=
e jobs which potentially depend on each other.
> >>
> >> I think we should rather put this logic into amdgpu_device_enforce_iso=
lation().
> >
> > I'm not quite sure I understand what you are proposing.  Is the idea
> > to track all of the jobs associated with a particular process and then
> > when we reset a queue, skip all of the ring contents associated with
> > those jobs and signal and set the error on all of their job fences?
>
> More or less yes, I think that is what is needed here.
>
> A simple example: Unigine Heaven in window mode on an X server. Each fram=
e usually results in 3 job submissions from unigine, plus one submission fr=
om X to copy the result it into the displayed frame.
>
> When we now assume that we can schedule 4 jobs at a time on the ring we g=
et: U1, U2, U3, X1 | U4, U5, U6, X2 | U7, U8, U9, X3....
>
> Let's assume U4 hangs and we initiate a queue reset, in this case we defi=
nately need to skip U5 and U6 as well because they belonged to the same con=
text and depend on each other. Only skipping U4 would certainly crash the G=
PU again.

In that case, we'd just reset the queue again, but I agree it would be
a nicer experience to skip all of the jobs for that app.

>
> X2 also dependet on U6, but that submission is from X and totally innocen=
t and rendering garbage for the window content is probably ok considering t=
hat the application just crashed.
>
> > What about cross ring dependencies?
>
> For gang submission we would need to do a queue reset for both the gfx an=
d compute queue to get out of this again. But that is probably ok since eac=
h queue can timeout on its own.
>
> We also don't need to track the jobs per process, just looking if job->ba=
se.sched_fence->finished.context changes should be sufficient.

Something like this?

        for (i =3D 0; i <=3D ring->fence_drv.num_fences_mask; i++) {
                ptr =3D &ring->fence_drv.fences[i];
            old =3D rcu_dereference_protected(*ptr, 1);
                if (old && old->ops =3D=3D &amdgpu_job_fence_ops) {
                        struct amdgpu_job *other_job =3D
                container_of(old, struct amdgpu_job, hw_fence.base);

                        if (other_job->base.sched_fence->finished.context =
=3D=3D
                            job->base.sched_fence->finished.context) {
                                struct amdgpu_fence *am_fence =3D
&other_job->hw_fence;
                                // skip the ring contents associated
with this context
                        }
                }
        }

Thanks,

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
> >>
> >>>       return 0;
> >>>  }
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_job.c
> >>> index a0fab947143b5..f0f752284b925 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>> @@ -91,6 +91,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(=
struct drm_sched_job *s_job)
> >>>       struct amdgpu_job *job =3D to_amdgpu_job(s_job);
> >>>       struct amdgpu_task_info *ti;
> >>>       struct amdgpu_device *adev =3D ring->adev;
> >>> +     struct dma_fence *fence =3D &job->hw_fence;
> >>>       int idx;
> >>>       int r;
> >>>
> >>> @@ -154,8 +155,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedo=
ut(struct drm_sched_job *s_job)
> >>>               else
> >>>                       is_guilty =3D true;
> >>>
> >>> -             if (is_guilty)
> >>> +             if (is_guilty) {
> >>> +                     amdgpu_ring_backup_unprocessed_jobs(ring, job->=
ring_wptr, fence->seqno);
> >>>                       dma_fence_set_error(&s_job->s_fence->finished, =
-ETIME);
> >>> +             }
> >>>
> >>>               r =3D amdgpu_ring_reset(ring, job->vmid);
> >>>               if (!r) {
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_job.h
> >>> index f2c049129661f..c2ed0edb5179d 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> >>> @@ -79,6 +79,8 @@ struct amdgpu_job {
> >>>       /* enforce isolation */
> >>>       bool                    enforce_isolation;
> >>>       bool                    run_cleaner_shader;
> >>> +     /* wptr for the job for resets */
> >>> +     uint32_t                ring_wptr;
> >>>
> >>>       uint32_t                num_ibs;
> >>>       struct amdgpu_ib        ibs[];
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ring.c
> >>> index 426834806fbf2..909b121d432cb 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> >>> @@ -333,6 +333,12 @@ int amdgpu_ring_init(struct amdgpu_device *adev,=
 struct amdgpu_ring *ring,
> >>>       /*  Initialize cached_rptr to 0 */
> >>>       ring->cached_rptr =3D 0;
> >>>
> >>> +     if (!ring->ring_backup) {
> >>> +             ring->ring_backup =3D kvzalloc(ring->ring_size, GFP_KER=
NEL);
> >>> +             if (!ring->ring_backup)
> >>> +                     return -ENOMEM;
> >>> +     }
> >>> +
> >>>       /* Allocate ring buffer */
> >>>       if (ring->ring_obj =3D=3D NULL) {
> >>>               r =3D amdgpu_bo_create_kernel(adev, ring->ring_size + r=
ing->funcs->extra_dw, PAGE_SIZE,
> >>> @@ -342,6 +348,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, =
struct amdgpu_ring *ring,
> >>>                                           (void **)&ring->ring);
> >>>               if (r) {
> >>>                       dev_err(adev->dev, "(%d) ring create failed\n",=
 r);
> >>> +                     kvfree(ring->ring_backup);
> >>>                       return r;
> >>>               }
> >>>               amdgpu_ring_clear_ring(ring);
> >>> @@ -385,6 +392,8 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
> >>>       amdgpu_bo_free_kernel(&ring->ring_obj,
> >>>                             &ring->gpu_addr,
> >>>                             (void **)&ring->ring);
> >>> +     kvfree(ring->ring_backup);
> >>> +     ring->ring_backup =3D NULL;
> >>>
> >>>       dma_fence_put(ring->vmid_wait);
> >>>       ring->vmid_wait =3D NULL;
> >>> @@ -753,3 +762,40 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring =
*ring)
> >>>
> >>>       return true;
> >>>  }
> >>> +
> >>> +void amdgpu_ring_backup_unprocessed_jobs(struct amdgpu_ring *ring,
> >>> +                                      u64 bad_wptr, u32 bad_seq)
> >>> +{
> >>> +     unsigned int entries_to_copy =3D ring->wptr - bad_wptr;
> >>> +     unsigned int idx, i;
> >>> +
> >>> +     for (i =3D 0; i < entries_to_copy; i++) {
> >>> +             idx =3D (bad_wptr + i) & ring->buf_mask;
> >>> +             ring->ring_backup[i] =3D ring->ring[idx];
> >>> +     }
> >>> +     ring->ring_backup_entries_to_copy =3D entries_to_copy;
> >>> +     ring->ring_backup_seq =3D bad_seq;
> >>> +}
> >>> +
> >>> +int amdgpu_ring_reemit_unprocessed_jobs(struct amdgpu_ring *ring)
> >>> +{
> >>> +     unsigned int i;
> >>> +     int r;
> >>> +
> >>> +     /* signal the fence of the bad job */
> >>> +     amdgpu_fence_driver_seq_force_completion(ring, ring->ring_backu=
p_seq);
> >>> +     /* verify that the ring is functional */
> >>> +     r =3D amdgpu_ring_test_ring(ring);
> >>> +     if (r)
> >>> +             return r;
> >>> +     /* re-emit the unprocessed ring contents */
> >>> +     if (ring->ring_backup_entries_to_copy) {
> >>> +             if (amdgpu_ring_alloc(ring, ring->ring_backup_entries_t=
o_copy))
> >>> +                     return -ENOMEM;
> >>> +             for (i =3D 0; i < ring->ring_backup_entries_to_copy; i+=
+)
> >>> +                     amdgpu_ring_write(ring, ring->ring_backup[i]);
> >>> +             amdgpu_ring_commit(ring);
> >>> +     }
> >>> +
> >>> +     return r;
> >>> +}
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ring.h
> >>> index b95b471107692..fd08449eee33f 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> >>> @@ -132,6 +132,8 @@ extern const struct drm_sched_backend_ops amdgpu_=
sched_ops;
> >>>  void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
> >>>  void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int err=
or);
> >>>  void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
> >>> +void amdgpu_fence_driver_seq_force_completion(struct amdgpu_ring *ri=
ng,
> >>> +                                           u32 seq);
> >>>
> >>>  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
> >>>  int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
> >>> @@ -268,6 +270,9 @@ struct amdgpu_ring {
> >>>
> >>>       struct amdgpu_bo        *ring_obj;
> >>>       uint32_t                *ring;
> >>> +     uint32_t                *ring_backup;
> >>> +     uint32_t                ring_backup_seq;
> >>> +     unsigned int            ring_backup_entries_to_copy;
> >>>       unsigned                rptr_offs;
> >>>       u64                     rptr_gpu_addr;
> >>>       volatile u32            *rptr_cpu_addr;
> >>> @@ -534,4 +539,7 @@ int amdgpu_ib_pool_init(struct amdgpu_device *ade=
v);
> >>>  void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
> >>>  int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
> >>>  bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
> >>> +void amdgpu_ring_backup_unprocessed_jobs(struct amdgpu_ring *ring,
> >>> +                                      u64 bad_wptr, u32 bad_seq);
> >>> +int amdgpu_ring_reemit_unprocessed_jobs(struct amdgpu_ring *ring);
> >>>  #endif
> >>
>
