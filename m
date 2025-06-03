Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8D0C5AD49
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 16:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F02410E23C;
	Tue,  3 Jun 2025 16:26:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="baqAuEyj";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E506310E23C
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 16:26:12 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-30e85955bebso818589a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jun 2025 09:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748967972; x=1749572772; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FeaGsZUiPpbRjiHZKmGImZP0OQ4XA7oF9P4G9jy7YFg=;
 b=baqAuEyjE2VkryY+ecQMHaFQxa9UHiW8WJoyE3mTgHnOj1zLPMRjp7MMXsuE0+bBhX
 k1WtZ4b1x24YKbs4kaR394d+DQg3YSMeQfwm64AvhGsxIJZDnVdRwqg6qzFvheJ6QYQg
 BfrCQOUkOsM+CF4uxsVDqIR3B/G54BkwQO2W8jQju2wyt3g5ApqKo1ib6WtXJroDQL5+
 YWpp6B4BqaV4vESeY1AbRgrZRAH9a4rNRDeX8y7avbMn6V89bNM9+Z7F5kJg/kLErwRP
 0W0D6QHRGr9VDzV1x8b1PV9MW0QkHGZLgmeISoFTvGXjoa9kIVAN/USQ29AV+uEb3Y9P
 XWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748967972; x=1749572772;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FeaGsZUiPpbRjiHZKmGImZP0OQ4XA7oF9P4G9jy7YFg=;
 b=Y4y23gLNYWGRiwcDmYHcAEm7J+2qa96oxaK6Y8nFWLrVkKnP9cfCe4lTdsP8yBf4/R
 1R3Ve+Gq7PQMYgow6YVQ8bhD6lIl1MPRrbgeYKI5z+ZDwKskCxMuCOWcTeb7/6cLAWbl
 p673ZNeHUKK845juGI08/yY+ElsmPcP+xxlsesRS+w0/ImOGc9i1ibfCHI7BW8duqiH+
 86V1M0Jpk0gBts6jYFJyrbFL9ouDPSCs1yybQYVqDd1vPh/qyS1Tkcrd61fxJJl/u8Sf
 kCmBoWEq2RgrBTmheBriWaa9AoDgPrO7+jujSuTPLTdV9jKFx+0fYBhapizUwUQGpFsj
 KdRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt20nQIkDXiP44oK/zkGSvgjXPH+gt8d3ZJ5qbQdCfdHVJcJSWDu24uDAll7XOgnBBM3+mU+0e@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMsSshnnRosbM6E75B3mzVP7EhcQ/3SmVUWVqcSQhxX1GRwjvl
 104I9V01dmdymiq8r+ONposcDUfCUPt4w9OSv2VpiSRMERHMhmuUcseNr8QR/pY7UDRKf0GDXsJ
 VvDTvDZ/06tzbKrV+W1ZjJOZbESPX9AIxY//3
X-Gm-Gg: ASbGncvzw1Olrc6AVdAStSNc9asQyOabSEkRKK2BDLa97U0YS7mor8raz9amkon+qKq
 1DsUSb3Y5tP6/Jtp1IR+2li+IsGUvRC6G3s0lXh1C35qvJD9X/dolL6gQbmRagfPFPrtQI9A94e
 TUrY8cqeHtNMdwFRGecnAfLDrdPS3TpEtZ4g==
X-Google-Smtp-Source: AGHT+IGiZ2Owk/dza35l041pAbKhHviCx0diSL4VeApaAYaU62D9h8+JtKM2fDQ7lX/tERhEv34d254DTICM7X3cyBw=
X-Received: by 2002:a17:90b:3950:b0:311:c5d9:2c8b with SMTP id
 98e67ed59e1d1-3124db0cd2fmr11405758a91.5.1748967972010; Tue, 03 Jun 2025
 09:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250529200758.6326-1-alexander.deucher@amd.com>
 <20250529200758.6326-8-alexander.deucher@amd.com>
 <179a37aa-7e6b-4870-848f-c3ee3fd428d4@amd.com>
 <CADnq5_N_0Wzjm8vCoboqe-8EuMcpkBVwg_=BVy-V3XbM=rHqVQ@mail.gmail.com>
 <d44d1df2-bd9d-46c5-96a5-6694ae4ad0ea@amd.com>
 <CADnq5_NNYfG4cRm0t17yFz2vHdq=fj0=Kx2tReK0h4obp4G2Hw@mail.gmail.com>
 <6d488337-65ac-4673-bf3f-cb72235e7f16@amd.com>
 <CADnq5_MsW04xGXUw4zWeBt=+1jATLs=nC29VO6fETcMEm7aFeQ@mail.gmail.com>
In-Reply-To: <CADnq5_MsW04xGXUw4zWeBt=+1jATLs=nC29VO6fETcMEm7aFeQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Jun 2025 12:25:59 -0400
X-Gm-Features: AX0GCFt5waRdu6M8Rd6VprrFkJUs6zA-ISjnNfKscfKhw2gJ8QVoiIRXgFK5Y4E
Message-ID: <CADnq5_NnORasU_UtWMzJ9rb399JkN6XWBFprB4gsnV3NkthgHw@mail.gmail.com>
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

On Tue, Jun 3, 2025 at 11:18=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Tue, Jun 3, 2025 at 11:01=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > On 6/3/25 16:27, Alex Deucher wrote:
> > >>> I'm not quite sure I understand what you are proposing.  Is the ide=
a
> > >>> to track all of the jobs associated with a particular process and t=
hen
> > >>> when we reset a queue, skip all of the ring contents associated wit=
h
> > >>> those jobs and signal and set the error on all of their job fences?
> > >>
> > >> More or less yes, I think that is what is needed here.
> > >>
> > >> A simple example: Unigine Heaven in window mode on an X server. Each=
 frame usually results in 3 job submissions from unigine, plus one submissi=
on from X to copy the result it into the displayed frame.
> > >>
> > >> When we now assume that we can schedule 4 jobs at a time on the ring=
 we get: U1, U2, U3, X1 | U4, U5, U6, X2 | U7, U8, U9, X3....
> > >>
> > >> Let's assume U4 hangs and we initiate a queue reset, in this case we=
 definately need to skip U5 and U6 as well because they belonged to the sam=
e context and depend on each other. Only skipping U4 would certainly crash =
the GPU again.
> > >
> > > In that case, we'd just reset the queue again, but I agree it would b=
e
> > > a nicer experience to skip all of the jobs for that app.
> >
> > Well, that is a must have I think. Otherwise problems only get worse an=
d worse after a while and we can't let submissions run into timeouts over a=
nd over again.
> >
> > >>
> > >> X2 also dependet on U6, but that submission is from X and totally in=
nocent and rendering garbage for the window content is probably ok consider=
ing that the application just crashed.
> > >>
> > >>> What about cross ring dependencies?
> > >>
> > >> For gang submission we would need to do a queue reset for both the g=
fx and compute queue to get out of this again. But that is probably ok sinc=
e each queue can timeout on its own.
> > >>
> > >> We also don't need to track the jobs per process, just looking if jo=
b->base.sched_fence->finished.context changes should be sufficient.
> > >
> > > Something like this?
> > >
> > >         for (i =3D 0; i <=3D ring->fence_drv.num_fences_mask; i++) {
> > >                 ptr =3D &ring->fence_drv.fences[i];
> > >             old =3D rcu_dereference_protected(*ptr, 1);
> > >                 if (old && old->ops =3D=3D &amdgpu_job_fence_ops) {
> > >                         struct amdgpu_job *other_job =3D
> > >                 container_of(old, struct amdgpu_job, hw_fence.base);
> > >
> > >                         if (other_job->base.sched_fence->finished.con=
text =3D=3D
> > >                             job->base.sched_fence->finished.context) =
{
> > >                                 struct amdgpu_fence *am_fence =3D
> > > &other_job->hw_fence;
> > >                                 // skip the ring contents associated
> > > with this context
> > >                         }
> > >                 }
> > >         }
> >
> > I would copy job->base.sched_fence->finished.context into the HW fence =
when it is created, but apart from that yes that is exactly what I had in m=
ind.
>
> Where and when does finished.context get set?

I found it.  It's drm_sched_job_arm().

Alex


>
> Alex
>
> >
> > Christian.
> >
> >
> > >
> > > Thanks,
> > >
> > > Alex
> > >
> > >
> > >>
> > >> Regards,
> > >> Christian.
> > >>
> > >>>
> > >>> Alex
> > >>>
> > >>>>
> > >>>> Regards,
> > >>>> Christian.
> > >>>>
> > >>>>
> > >>>>>       return 0;
> > >>>>>  }
> > >>>>>
> > >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_job.c
> > >>>>> index a0fab947143b5..f0f752284b925 100644
> > >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > >>>>> @@ -91,6 +91,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timed=
out(struct drm_sched_job *s_job)
> > >>>>>       struct amdgpu_job *job =3D to_amdgpu_job(s_job);
> > >>>>>       struct amdgpu_task_info *ti;
> > >>>>>       struct amdgpu_device *adev =3D ring->adev;
> > >>>>> +     struct dma_fence *fence =3D &job->hw_fence;
> > >>>>>       int idx;
> > >>>>>       int r;
> > >>>>>
> > >>>>> @@ -154,8 +155,10 @@ static enum drm_gpu_sched_stat amdgpu_job_ti=
medout(struct drm_sched_job *s_job)
> > >>>>>               else
> > >>>>>                       is_guilty =3D true;
> > >>>>>
> > >>>>> -             if (is_guilty)
> > >>>>> +             if (is_guilty) {
> > >>>>> +                     amdgpu_ring_backup_unprocessed_jobs(ring, j=
ob->ring_wptr, fence->seqno);
> > >>>>>                       dma_fence_set_error(&s_job->s_fence->finish=
ed, -ETIME);
> > >>>>> +             }
> > >>>>>
> > >>>>>               r =3D amdgpu_ring_reset(ring, job->vmid);
> > >>>>>               if (!r) {
> > >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_job.h
> > >>>>> index f2c049129661f..c2ed0edb5179d 100644
> > >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > >>>>> @@ -79,6 +79,8 @@ struct amdgpu_job {
> > >>>>>       /* enforce isolation */
> > >>>>>       bool                    enforce_isolation;
> > >>>>>       bool                    run_cleaner_shader;
> > >>>>> +     /* wptr for the job for resets */
> > >>>>> +     uint32_t                ring_wptr;
> > >>>>>
> > >>>>>       uint32_t                num_ibs;
> > >>>>>       struct amdgpu_ib        ibs[];
> > >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_ring.c
> > >>>>> index 426834806fbf2..909b121d432cb 100644
> > >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > >>>>> @@ -333,6 +333,12 @@ int amdgpu_ring_init(struct amdgpu_device *a=
dev, struct amdgpu_ring *ring,
> > >>>>>       /*  Initialize cached_rptr to 0 */
> > >>>>>       ring->cached_rptr =3D 0;
> > >>>>>
> > >>>>> +     if (!ring->ring_backup) {
> > >>>>> +             ring->ring_backup =3D kvzalloc(ring->ring_size, GFP=
_KERNEL);
> > >>>>> +             if (!ring->ring_backup)
> > >>>>> +                     return -ENOMEM;
> > >>>>> +     }
> > >>>>> +
> > >>>>>       /* Allocate ring buffer */
> > >>>>>       if (ring->ring_obj =3D=3D NULL) {
> > >>>>>               r =3D amdgpu_bo_create_kernel(adev, ring->ring_size=
 + ring->funcs->extra_dw, PAGE_SIZE,
> > >>>>> @@ -342,6 +348,7 @@ int amdgpu_ring_init(struct amdgpu_device *ad=
ev, struct amdgpu_ring *ring,
> > >>>>>                                           (void **)&ring->ring);
> > >>>>>               if (r) {
> > >>>>>                       dev_err(adev->dev, "(%d) ring create failed=
\n", r);
> > >>>>> +                     kvfree(ring->ring_backup);
> > >>>>>                       return r;
> > >>>>>               }
> > >>>>>               amdgpu_ring_clear_ring(ring);
> > >>>>> @@ -385,6 +392,8 @@ void amdgpu_ring_fini(struct amdgpu_ring *rin=
g)
> > >>>>>       amdgpu_bo_free_kernel(&ring->ring_obj,
> > >>>>>                             &ring->gpu_addr,
> > >>>>>                             (void **)&ring->ring);
> > >>>>> +     kvfree(ring->ring_backup);
> > >>>>> +     ring->ring_backup =3D NULL;
> > >>>>>
> > >>>>>       dma_fence_put(ring->vmid_wait);
> > >>>>>       ring->vmid_wait =3D NULL;
> > >>>>> @@ -753,3 +762,40 @@ bool amdgpu_ring_sched_ready(struct amdgpu_r=
ing *ring)
> > >>>>>
> > >>>>>       return true;
> > >>>>>  }
> > >>>>> +
> > >>>>> +void amdgpu_ring_backup_unprocessed_jobs(struct amdgpu_ring *rin=
g,
> > >>>>> +                                      u64 bad_wptr, u32 bad_seq)
> > >>>>> +{
> > >>>>> +     unsigned int entries_to_copy =3D ring->wptr - bad_wptr;
> > >>>>> +     unsigned int idx, i;
> > >>>>> +
> > >>>>> +     for (i =3D 0; i < entries_to_copy; i++) {
> > >>>>> +             idx =3D (bad_wptr + i) & ring->buf_mask;
> > >>>>> +             ring->ring_backup[i] =3D ring->ring[idx];
> > >>>>> +     }
> > >>>>> +     ring->ring_backup_entries_to_copy =3D entries_to_copy;
> > >>>>> +     ring->ring_backup_seq =3D bad_seq;
> > >>>>> +}
> > >>>>> +
> > >>>>> +int amdgpu_ring_reemit_unprocessed_jobs(struct amdgpu_ring *ring=
)
> > >>>>> +{
> > >>>>> +     unsigned int i;
> > >>>>> +     int r;
> > >>>>> +
> > >>>>> +     /* signal the fence of the bad job */
> > >>>>> +     amdgpu_fence_driver_seq_force_completion(ring, ring->ring_b=
ackup_seq);
> > >>>>> +     /* verify that the ring is functional */
> > >>>>> +     r =3D amdgpu_ring_test_ring(ring);
> > >>>>> +     if (r)
> > >>>>> +             return r;
> > >>>>> +     /* re-emit the unprocessed ring contents */
> > >>>>> +     if (ring->ring_backup_entries_to_copy) {
> > >>>>> +             if (amdgpu_ring_alloc(ring, ring->ring_backup_entri=
es_to_copy))
> > >>>>> +                     return -ENOMEM;
> > >>>>> +             for (i =3D 0; i < ring->ring_backup_entries_to_copy=
; i++)
> > >>>>> +                     amdgpu_ring_write(ring, ring->ring_backup[i=
]);
> > >>>>> +             amdgpu_ring_commit(ring);
> > >>>>> +     }
> > >>>>> +
> > >>>>> +     return r;
> > >>>>> +}
> > >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_ring.h
> > >>>>> index b95b471107692..fd08449eee33f 100644
> > >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > >>>>> @@ -132,6 +132,8 @@ extern const struct drm_sched_backend_ops amd=
gpu_sched_ops;
> > >>>>>  void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ri=
ng);
> > >>>>>  void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int=
 error);
> > >>>>>  void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ri=
ng);
> > >>>>> +void amdgpu_fence_driver_seq_force_completion(struct amdgpu_ring=
 *ring,
> > >>>>> +                                           u32 seq);
> > >>>>>
> > >>>>>  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
> > >>>>>  int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
> > >>>>> @@ -268,6 +270,9 @@ struct amdgpu_ring {
> > >>>>>
> > >>>>>       struct amdgpu_bo        *ring_obj;
> > >>>>>       uint32_t                *ring;
> > >>>>> +     uint32_t                *ring_backup;
> > >>>>> +     uint32_t                ring_backup_seq;
> > >>>>> +     unsigned int            ring_backup_entries_to_copy;
> > >>>>>       unsigned                rptr_offs;
> > >>>>>       u64                     rptr_gpu_addr;
> > >>>>>       volatile u32            *rptr_cpu_addr;
> > >>>>> @@ -534,4 +539,7 @@ int amdgpu_ib_pool_init(struct amdgpu_device =
*adev);
> > >>>>>  void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
> > >>>>>  int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
> > >>>>>  bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
> > >>>>> +void amdgpu_ring_backup_unprocessed_jobs(struct amdgpu_ring *rin=
g,
> > >>>>> +                                      u64 bad_wptr, u32 bad_seq)=
;
> > >>>>> +int amdgpu_ring_reemit_unprocessed_jobs(struct amdgpu_ring *ring=
);
> > >>>>>  #endif
> > >>>>
> > >>
> >
