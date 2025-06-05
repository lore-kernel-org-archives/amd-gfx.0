Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEC7C5B543
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 13:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30BBD10E11D;
	Thu,  5 Jun 2025 13:22:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G6AtoDWa";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F89210E11D
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 13:22:04 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-b2705e3810cso85458a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Jun 2025 06:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749129724; x=1749734524; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rsa6cHo4C/x/HbRCPRGjdxZzQ5niJrWc8cNgQGLleV4=;
 b=G6AtoDWajav1Q80J9ArzU3JGwjzEpkbzgu+EVWxR1GWhk8cktCC7bO/uA9eLoMsggj
 K57R8eZ/oczMYi34NlqWuyf3RxoY4kE7JgGIPSON4S7rAc5y8MRYKImAKZjtKUN/Ips7
 UCfDYaKhPM/cYNoNzEbaR008OFn+1PP1SY6o7rkVKtRie5ONdSGiTymqtQzZtVTER3ri
 HYuWiR0UdurGSesphSnZp9gi9U2MxpnA55rUc+s+/EcGskALF22XtQB44ocl3rOQ1tDB
 BHxRKjCvTLZSy7u5rI+LOgrvC70r3fXr3wzufQ3BofKACcyo61G61uUyL/DqtkhRQ0jV
 Xz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749129724; x=1749734524;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rsa6cHo4C/x/HbRCPRGjdxZzQ5niJrWc8cNgQGLleV4=;
 b=vSqLnjI/iwlUNR8JAaOUmZnvom93utuGP38w86J8CDQq0u2XFkgoWU2X77swyI9MwK
 CLe3uwWvY6W7EJ11tHc/foebdEIZ+b3tee3wfO/XHnniPOgem5TTKctWCBodn6HdeR9q
 bSZeoklFQ6GjbbJyzeVmZdlefnv9g2gwe9fvNgx+EjwCk+WHhDttoGZD6uDgys+fZ5Y0
 GcmMjkV4bytGY1F01Ndgfhwdg5zOcUB9MCxOVhO54SClwnYjCk/9JGKkdiYgK0gVxkFx
 Ll9pnChUtjmM6q5MUbjpbVEsMjpXELOSoryf2vs5peLfGavba5xsHljwn34SJ1U2bA5k
 C0/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBG04m1bwDW0wkCt2TETr+9jHOFRFHKNYj8NU5CBsiJX8hDeIEmIjXl80auAKizwvlBiajIUDR@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQ431j0WpEJEjd0GsBFjQj1FohW5G7tBDbAVBhKn6P3ws23qPr
 b83r39FjhWsCvFlgfObpuTabddkIIdzG5YU0fikBd8QeqrUbmnO8WNyjhblWQXhrirF4d1UmrHT
 D4xJdcCBxdALBTHBJoszhgnJCkMATdJ5dZA==
X-Gm-Gg: ASbGnctrd471j6DNNOc8XD0JZr1y3eugL9VVwrnM+YcdtVP/VtsUP4Yjx8APW+D7hce
 8020tWlUMWwn+H8lIMDfnE+BoBmRd094GRYhP/HhM906rMhTlf+qPoEAQa+kpoilo0BotUmiUjD
 HmPLsLu1Zvjk2J7p0m3GicX02Bi832sVqLbdwbIYGHJYFL
X-Google-Smtp-Source: AGHT+IEKwvGrjy1RlH+MuPB36a1OYKLklWe7YkAnYsg+O6H0OGfYcM7YMsBGMU6A8h803Gqj43yjtDBnUEINFR+LTuM=
X-Received: by 2002:a17:90b:55c4:b0:310:8d79:dfe4 with SMTP id
 98e67ed59e1d1-3130cd44eadmr3477519a91.4.1749129724178; Thu, 05 Jun 2025
 06:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250605014602.5915-1-alexander.deucher@amd.com>
 <20250605014602.5915-9-alexander.deucher@amd.com>
 <85f49273-1525-4504-9fc2-e06cefd96b98@amd.com>
In-Reply-To: <85f49273-1525-4504-9fc2-e06cefd96b98@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Jun 2025 09:21:51 -0400
X-Gm-Features: AX0GCFsxfK3Buken_6_ttfCq-8Jw-2FsPYFaAoILmfv8llD3G9pGPshcpzpIvuk
Message-ID: <CADnq5_NqXpm1edeNeFEyGfDyKK52b-PqEpsiS4BS-2dUL7s5bA@mail.gmail.com>
Subject: Re: [PATCH 08/31] drm/amdgpu: track ring state associated with a job
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

On Thu, Jun 5, 2025 at 8:22=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 6/5/25 03:45, Alex Deucher wrote:
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
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 15 ++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 13 +++-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   | 11 ++-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 92 +++++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 15 ++++
> >  5 files changed, 143 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_fence.c
> > index 569e0e5373927..25a664273bf0d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > @@ -141,6 +141,9 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, str=
uct dma_fence **f, struct amd
> >       }
> >       fence =3D &am_fence->base;
> >       am_fence->ring =3D ring;
> > +     am_fence->start_ring_wptr =3D 0;
> > +     am_fence->end_ring_wptr =3D 0;
>
> Why do we need the start here? I would just keep the end around and then =
jump from fence to fence while re-submitting them.

I need to know the start and end of the ring contents associated with
each fence.  When I re-emit, I just copy over the ring contents for
all fences that don't match the bad one.  Also we submit multiple
fences per IB depending on whether we do a vm flush.  Those fences are
internal to the IB frame so they don't really need a start and end,
hence 0.

>
> > +     am_fence->context =3D 0;
> >
> >       seq =3D ++ring->fence_drv.sync_seq;
> >       if (job && job->job_run_counter) {
> > @@ -748,6 +751,18 @@ void amdgpu_fence_driver_force_completion(struct a=
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
>
> Better give the full fence structure here.

You mean pass the fence directly?

>
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
> > index 802743efa3b39..636941697a740 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > @@ -126,7 +126,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, un=
signed int num_ibs,
> >                      struct dma_fence **f)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> > +     u64 start_ring_wptr, end_ring_wptr;
> >       struct amdgpu_ib *ib =3D &ibs[0];
> > +     struct amdgpu_fence *am_fence;
> >       struct dma_fence *tmp =3D NULL;
> >       bool need_ctx_switch;
> >       struct amdgpu_vm *vm;
> > @@ -138,7 +140,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, un=
signed int num_ibs,
> >       int vmid =3D AMDGPU_JOB_GET_VMID(job);
> >       bool need_pipe_sync =3D false;
> >       unsigned int cond_exec;
> > -
> >       unsigned int i;
> >       int r =3D 0;
> >
> > @@ -187,6 +188,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, un=
signed int num_ibs,
> >               dev_err(adev->dev, "scheduling IB failed (%d).\n", r);
> >               return r;
> >       }
> > +     start_ring_wptr =3D ring->wptr;
> >
> >       need_ctx_switch =3D ring->current_ctx !=3D fence_ctx;
> >       if (ring->funcs->emit_pipeline_sync && job &&
> > @@ -306,6 +308,15 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, u=
nsigned int num_ibs,
> >
> >       amdgpu_ring_ib_end(ring);
> >       amdgpu_ring_commit(ring);
> > +     /* This must be last for resets to work properly
> > +      * as we need to save the wptr associated with this
> > +      * fence.
> > +      */
> > +     end_ring_wptr =3D ring->wptr;
> > +     am_fence =3D container_of(*f, struct amdgpu_fence, base);
> > +     am_fence->start_ring_wptr =3D start_ring_wptr;
> > +     am_fence->end_ring_wptr =3D end_ring_wptr;
>
> The end_ring_wptr variable is superflous and I would put assigning that i=
nto a helper in amdgpu_fence.c

I'm not following. I need the start and end wptrs in order to know
what ranges of the ring I need to save.

>
> > +
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_job.c
> > index 23b6a0fc0c691..73c26e2e01647 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > @@ -89,8 +89,9 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(st=
ruct drm_sched_job *s_job)
> >  {
> >       struct amdgpu_ring *ring =3D to_amdgpu_ring(s_job->sched);
> >       struct amdgpu_job *job =3D to_amdgpu_job(s_job);
> > -     struct amdgpu_task_info *ti;
> > +     struct amdgpu_fence *am_fence =3D &job->hw_fence;
> >       struct amdgpu_device *adev =3D ring->adev;
> > +     struct amdgpu_task_info *ti;
> >       bool set_error =3D false;
> >       int idx, r;
> >
> > @@ -154,7 +155,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(=
struct drm_sched_job *s_job)
> >               else
> >                       is_guilty =3D true;
> >
> > -             if (is_guilty)
> > +             amdgpu_ring_backup_unprocessed_jobs(ring, is_guilty, am_f=
ence);
> > +             if (is_guilty) {
> >                       dma_fence_set_error(&s_job->s_fence->finished, -E=
TIME);
> >                       set_error =3D true;
> >               }
> > @@ -409,6 +411,7 @@ static struct dma_fence *amdgpu_job_run(struct drm_=
sched_job *sched_job)
> >       struct amdgpu_ring *ring =3D to_amdgpu_ring(sched_job->sched);
> >       struct amdgpu_device *adev =3D ring->adev;
> >       struct dma_fence *fence =3D NULL, *finished;
> > +     struct amdgpu_fence *am_fence;
> >       struct amdgpu_job *job;
> >       int r =3D 0;
> >
> > @@ -433,6 +436,10 @@ static struct dma_fence *amdgpu_job_run(struct drm=
_sched_job *sched_job)
> >                               "Error scheduling IBs (%d) in ring(%s)", =
r,
> >                               ring->name);
> >       }
> > +     if (fence && finished) {
> > +             am_fence =3D container_of(fence, struct amdgpu_fence, bas=
e);
> > +             am_fence->context =3D finished->context;
> > +     }
>
> Better put that into amdgpu_fence_emit().

Makes sense.

>
> >
> >       job->job_run_counter++;
> >       amdgpu_job_free_resources(job);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.c
> > index 426834806fbf2..3a0e0883bd8e7 100644
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
> > @@ -753,3 +762,86 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *r=
ing)
> >
> >       return true;
> >  }
> > +
> > +static void amdgpu_ring_backup_unprocessed_job(struct amdgpu_ring *rin=
g,
> > +                                            unsigned int idx,
> > +                                            u64 start_wptr, u32 end_wp=
tr)
>
> Drop the job from all function names.
>
> We are really re-emitting unprocessed commands.

Will do.

>
> > +{
> > +     unsigned int first_idx =3D start_wptr & ring->buf_mask;
> > +     unsigned int last_idx =3D end_wptr & ring->buf_mask;
> > +     unsigned int i, j, entries_to_copy;
> > +
> > +     if (last_idx < first_idx) {
> > +             entries_to_copy =3D ring->buf_mask + 1 - first_idx;
> > +             for (i =3D 0; i < entries_to_copy; i++)
> > +                     ring->ring_backup[idx + i] =3D ring->ring[first_i=
dx + i];
> > +             ring->ring_backup_entries_to_copy +=3D entries_to_copy;
> > +             entries_to_copy =3D last_idx;
> > +             for (j =3D 0; j < entries_to_copy; j++)
> > +                     ring->ring_backup[idx + i + j] =3D ring->ring[j];
> > +             ring->ring_backup_entries_to_copy +=3D entries_to_copy;
> > +     } else {
> > +             entries_to_copy =3D last_idx - first_idx;
> > +             for (i =3D 0; i < entries_to_copy; i++)
> > +                     ring->ring_backup[idx + i] =3D ring->ring[first_i=
dx + i];
> > +             ring->ring_backup_entries_to_copy +=3D entries_to_copy;
> > +     }
> > +}
> > +
> > +void amdgpu_ring_backup_unprocessed_jobs(struct amdgpu_ring *ring,
> > +                                      bool is_guilty,
> > +                                      struct amdgpu_fence *bad_fence)
> > +{
> > +     struct amdgpu_fence *fence;
> > +     struct dma_fence *old, **ptr;
> > +     int i;
> > +
> > +     ring->ring_backup_entries_to_copy =3D 0;
> > +     for (i =3D 0; i <=3D ring->fence_drv.num_fences_mask; i++) {
>
> That is the wrong order for the fences, you need to start/end at the last=
 submitted one.

I'm not sure I follow.  When I backup the ring contents, I need to go
from oldest to newest so the order is correct when I re-emit.

Alex

>
> I strongly suggest to implement that in amdgpu_fence.c
>
> Regards,
> Christian.
>
> > +             ptr =3D &ring->fence_drv.fences[i];
> > +             rcu_read_lock();
> > +             old =3D rcu_dereference(*ptr);
> > +
> > +             if (old && !dma_fence_is_signaled(old)) {
> > +                     fence =3D container_of(old, struct amdgpu_fence, =
base);
> > +                     /* save everything if the ring is not guilty, oth=
erwise
> > +                      * just save the content from other contexts.
> > +                      */
> > +                     if (!is_guilty || (fence->context !=3D bad_fence-=
>context))
> > +                             amdgpu_ring_backup_unprocessed_job(ring,
> > +                                                                ring->=
ring_backup_entries_to_copy,
> > +                                                                fence-=
>start_ring_wptr,
> > +                                                                fence-=
>end_ring_wptr);
> > +             }
> > +             rcu_read_unlock();
> > +     }
> > +
> > +     ring->ring_bad_seq =3D bad_fence->base.seqno;
> > +}
> > +
> > +int amdgpu_ring_reemit_unprocessed_jobs(struct amdgpu_ring *ring)
> > +{
> > +     unsigned int i;
> > +     int r;
> > +
> > +     /* verify that the ring is functional */
> > +     r =3D amdgpu_ring_test_ring(ring);
> > +     if (r)
> > +             return r;
> > +     /* re-emit the unprocessed ring contents */
> > +     if (ring->ring_backup_entries_to_copy) {
> > +             r =3D amdgpu_ring_alloc(ring, ring->ring_backup_entries_t=
o_copy);
> > +             if (r)
> > +                     return r;
> > +             /* signal the fence of the bad job */
> > +             amdgpu_fence_driver_seq_force_completion(ring, ring->ring=
_bad_seq);
> > +             for (i =3D 0; i < ring->ring_backup_entries_to_copy; i++)
> > +                     amdgpu_ring_write(ring, ring->ring_backup[i]);
> > +             amdgpu_ring_commit(ring);
> > +     } else {
> > +             /* signal the fence of the bad job */
> > +             amdgpu_fence_driver_seq_force_completion(ring, ring->ring=
_bad_seq);
> > +     }
> > +
> > +     return 0;
> > +}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.h
> > index e1f25218943a4..69b71401adb7a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -141,6 +141,12 @@ struct amdgpu_fence {
> >       /* RB, DMA, etc. */
> >       struct amdgpu_ring              *ring;
> >       ktime_t                         start_timestamp;
> > +
> > +     /* wptrs for the fence for resets */
> > +     u64                             start_ring_wptr;
> > +     u64                             end_ring_wptr;
> > +     /* fence context for resets */
> > +     u64                             context;
> >  };
> >
> >  extern const struct drm_sched_backend_ops amdgpu_sched_ops;
> > @@ -148,6 +154,8 @@ extern const struct drm_sched_backend_ops amdgpu_sc=
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
> > @@ -284,6 +292,9 @@ struct amdgpu_ring {
> >
> >       struct amdgpu_bo        *ring_obj;
> >       uint32_t                *ring;
> > +     uint32_t                *ring_backup;
> > +     unsigned int            ring_backup_entries_to_copy;
> > +     uint64_t                ring_bad_seq;
> >       unsigned                rptr_offs;
> >       u64                     rptr_gpu_addr;
> >       volatile u32            *rptr_cpu_addr;
> > @@ -550,4 +561,8 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev)=
;
> >  void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
> >  int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
> >  bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
> > +void amdgpu_ring_backup_unprocessed_jobs(struct amdgpu_ring *ring,
> > +                                      bool is_guilty,
> > +                                      struct amdgpu_fence *bad_fence);
> > +int amdgpu_ring_reemit_unprocessed_jobs(struct amdgpu_ring *ring);
> >  #endif
>
