Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F11C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 18:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8C1F10E054;
	Thu, 30 Mar 2023 18:42:46 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD6A810E054
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 18:42:44 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id bm2so14932428oib.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 11:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680201764;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GsH+o52GLfkObV6SiVwfLzuYMOVbuC3JGNoTHWLUMBM=;
 b=TZsMkyzV5IUAbXOemZ/C/M/1OTXF30MgdTTxBbxJ42R6/kaFR4OliosypzJ6068dfB
 gpKri3hVt4mavdl1GvvdU7U1It2i8KX6y56Hlq+acAVfEpjbMxeEEPxOosjHgvbRhBjH
 PALLbq8++Wg7dVFZqOh0UDLznHaitiInyACQirjsqUdKn5NDF5dMuklF1dopetjr7Mn1
 GgSwajlwI/6YnbW27ZsLZyWgc4u38d501kbLJLIlwQCQgcuHQ96WHRXJZtWLnp2HIYEE
 D+mSsoML8uJe8ax4O00E+bDKXozggnDsaLlRXQcFjrHgktAwTeUY6yw5gMoAUarDm/M/
 AthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680201764;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GsH+o52GLfkObV6SiVwfLzuYMOVbuC3JGNoTHWLUMBM=;
 b=SDnlkw/rMoMHH5ItcRjkLEujrDmj5RlbW9fhM7GTcjWK9GE7FMcda3cjhBiLj4lxbp
 QMprvJVXXz5buLdexJBFObxXFD+sJkB3FauLHRI5kqIO2AnXR3kZFGzbWPumbTRPaQ1L
 HNGPQdjybGkuj7M6qWrAklKSXlypL4gr/6JNkuKW1HVF0sodZIjgGpPZSg1GAF/ate55
 kFxRN4glXqSf3/0kk/YElw0HBTe2oAvxJMb+Rky8IFb9ZAHyaFE1ouiBWrRwUT+ndW8j
 jw60YOiv5KqzvLzOI2GJ6N0z7FSwcBsPeWzgxRKZ6saIg0UI3/WsrSDZHz3lTblcbW9q
 AeUA==
X-Gm-Message-State: AAQBX9exTZr87Bi9eeaeQFbad80HmUaX0GOG6WNm8P0M4+1rk05Q1EPG
 jZyzmCCl8TKsQFqXKsqV1te+Gh2x9ORWQyf0lJb0YboL
X-Google-Smtp-Source: AKy350bgKbyHnGoPpKQ5rEo5eiAU42a5vHHeRqqAOjolq75mQjKs6HLZsnVBsqSUyOtwjaCCzfVsd8vTE+27PiSc6XQ=
X-Received: by 2002:a05:6808:2810:b0:389:8025:aae8 with SMTP id
 et16-20020a056808281000b003898025aae8mr714443oib.3.1680201764049; Thu, 30 Mar
 2023 11:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230329152521.1980681-1-alexander.deucher@amd.com>
 <20230329152521.1980681-5-alexander.deucher@amd.com>
 <06cfb048-5349-9e96-ebd2-7adbbb66ebc5@gmail.com>
In-Reply-To: <06cfb048-5349-9e96-ebd2-7adbbb66ebc5@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Mar 2023 14:42:33 -0400
Message-ID: <CADnq5_Oj=E7XLQKBMeipuWTGT=CdLg4TKMNrfj8GFo1QYUg-sw@mail.gmail.com>
Subject: Re: [PATCH 04/13] drm/amdgpu: add gfx shadow CS IOCTL support
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 30, 2023 at 2:12=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 29.03.23 um 17:25 schrieb Alex Deucher:
> > From: Christian K=C3=B6nig <christian.koenig@amd.com>
> >
> > Add support for submitting the shadow update packet
> > when submitting an IB.  Needed for MCBP on GFX11.
> >
> > v2: update API for CSA (Alex)
> > v3: fix ordering; SET_Q_PREEMPTION_MODE most come before COND_EXEC
> >      Add missing check for AMDGPU_CHUNK_ID_CP_GFX_SHADOW in
> >      amdgpu_cs_pass1()
> >      Only initialize shadow on first use
> >      (Alex)
> > v4: Pass parameters rather than job to new ring callback (Alex)
> > v5: squash in change to call SET_Q_PREEMPTION_MODE/COND_EXEC
> >      before RELEASE_MEM to complete the UMDs use of the shadow (Alex)
> >
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   | 26 +++++++++++++++++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 29 +++++++++++++++++++++++=
-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  6 +++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  3 +++
> >   4 files changed, 63 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.c
> > index 47763ac0d14a..41bd3a1a1989 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -281,6 +281,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser =
*p,
> >               case AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES:
> >               case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT:
> >               case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
> > +             case AMDGPU_CHUNK_ID_CP_GFX_SHADOW:
> >                       break;
> >
> >               default:
> > @@ -583,6 +584,26 @@ static int amdgpu_cs_p2_syncobj_timeline_signal(st=
ruct amdgpu_cs_parser *p,
> >       return 0;
> >   }
> >
> > +static int amdgpu_cs_p2_shadow(struct amdgpu_cs_parser *p,
> > +                            struct amdgpu_cs_chunk *chunk)
> > +{
> > +     struct drm_amdgpu_cs_chunk_cp_gfx_shadow *shadow =3D chunk->kdata=
;
> > +     int i;
> > +
> > +     if (shadow->flags & ~AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHA=
DOW)
> > +             return -EINVAL;
> > +
> > +     for (i =3D 0; i < p->gang_size; ++i) {
> > +             p->jobs[i]->shadow_va =3D shadow->shadow_va;
> > +             p->jobs[i]->csa_va =3D shadow->csa_va;
> > +             p->jobs[i]->gds_va =3D shadow->gds_va;
> > +             p->jobs[i]->init_shadow =3D
> > +                     shadow->flags & AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLA=
GS_INIT_SHADOW;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >   static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)
> >   {
> >       unsigned int ce_preempt =3D 0, de_preempt =3D 0;
> > @@ -625,6 +646,11 @@ static int amdgpu_cs_pass2(struct amdgpu_cs_parser=
 *p)
> >                       if (r)
> >                               return r;
> >                       break;
> > +             case AMDGPU_CHUNK_ID_CP_GFX_SHADOW:
> > +                     r =3D amdgpu_cs_p2_shadow(p, chunk);
> > +                     if (r)
> > +                             return r;
> > +                     break;
> >               }
> >       }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ib.c
> > index bcccc348dbe2..9bee630eb0c9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > @@ -136,7 +136,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, un=
signed num_ibs,
> >       uint64_t fence_ctx;
> >       uint32_t status =3D 0, alloc_size;
> >       unsigned fence_flags =3D 0;
> > -     bool secure;
> > +     bool secure, init_shadow;
> > +     u64 shadow_va, csa_va, gds_va;
> > +     int vmid =3D AMDGPU_JOB_GET_VMID(job);
> >
> >       unsigned i;
> >       int r =3D 0;
> > @@ -150,9 +152,17 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, u=
nsigned num_ibs,
> >               vm =3D job->vm;
> >               fence_ctx =3D job->base.s_fence ?
> >                       job->base.s_fence->scheduled.context : 0;
> > +             shadow_va =3D job->shadow_va;
> > +             csa_va =3D job->csa_va;
> > +             gds_va =3D job->gds_va;
> > +             init_shadow =3D job->init_shadow;
> >       } else {
> >               vm =3D NULL;
> >               fence_ctx =3D 0;
> > +             shadow_va =3D 0;
> > +             csa_va =3D 0;
> > +             gds_va =3D 0;
> > +             init_shadow =3D false;
> >       }
> >
> >       if (!ring->sched.ready && !ring->is_mes_queue) {
> > @@ -212,6 +222,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, u=
nsigned num_ibs,
> >       }
> >
> >       amdgpu_ring_ib_begin(ring);
> > +
> > +     if (job && ring->funcs->emit_gfx_shadow)
> > +             amdgpu_ring_emit_gfx_shadow(ring, shadow_va, csa_va, gds_=
va,
> > +                                         init_shadow, vmid);
> > +
> >       if (job && ring->funcs->init_cond_exec)
> >               patch_offset =3D amdgpu_ring_init_cond_exec(ring);
> >
> > @@ -263,6 +278,18 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, u=
nsigned num_ibs,
> >                                      fence_flags | AMDGPU_FENCE_FLAG_64=
BIT);
> >       }
> >
> > +     if (ring->funcs->emit_gfx_shadow) {
> > +             amdgpu_ring_emit_gfx_shadow(ring, 0, 0, 0, false, 0);
> > +
> > +             if (ring->funcs->init_cond_exec) {
> > +                     unsigned ce_offset =3D ~0;
> > +
> > +                     ce_offset =3D amdgpu_ring_init_cond_exec(ring);
> > +                     if (ce_offset !=3D ~0 && ring->funcs->patch_cond_=
exec)
> > +                             amdgpu_ring_patch_cond_exec(ring, ce_offs=
et);
> > +             }
> > +     }
> > +
> >       r =3D amdgpu_fence_emit(ring, f, job, fence_flags);
> >       if (r) {
> >               dev_err(adev->dev, "failed to emit fence (%d)\n", r);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_job.h
> > index 52f2e313ea17..3f9804f956c9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > @@ -67,6 +67,12 @@ struct amdgpu_job {
> >       uint64_t                uf_addr;
> >       uint64_t                uf_sequence;
> >
> > +     /* virtual addresses for shadow/GDS/CSA */
> > +     uint64_t                shadow_va;
> > +     uint64_t                csa_va;
> > +     uint64_t                gds_va;
> > +     bool                    init_shadow;
>
> Doesn't the job has a flags field for stuff like that? Or was that the IB=
?

This comes from the flag in the new CS chunk.  Job doesn't have any
flags at the moment.

Alex

>
> Apart from that looks good to me.
>
> > +
> >       /* job_run_counter >=3D 1 means a resubmit job */
> >       uint32_t                job_run_counter;
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.h
> > index 3989e755a5b4..7942cb62e52c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -212,6 +212,8 @@ struct amdgpu_ring_funcs {
> >       void (*end_use)(struct amdgpu_ring *ring);
> >       void (*emit_switch_buffer) (struct amdgpu_ring *ring);
> >       void (*emit_cntxcntl) (struct amdgpu_ring *ring, uint32_t flags);
> > +     void (*emit_gfx_shadow)(struct amdgpu_ring *ring, u64 shadow_va, =
u64 csa_va,
> > +                             u64 gds_va, bool init_shadow, int vmid);
> >       void (*emit_rreg)(struct amdgpu_ring *ring, uint32_t reg,
> >                         uint32_t reg_val_offs);
> >       void (*emit_wreg)(struct amdgpu_ring *ring, uint32_t reg, uint32_=
t val);
> > @@ -307,6 +309,7 @@ struct amdgpu_ring {
> >   #define amdgpu_ring_emit_hdp_flush(r) (r)->funcs->emit_hdp_flush((r))
> >   #define amdgpu_ring_emit_switch_buffer(r) (r)->funcs->emit_switch_buf=
fer((r))
> >   #define amdgpu_ring_emit_cntxcntl(r, d) (r)->funcs->emit_cntxcntl((r)=
, (d))
> > +#define amdgpu_ring_emit_gfx_shadow(r, s, c, g, i, v) (r)->funcs->emit=
_gfx_shadow((r), (s), (c), (g), (i), (v))
> >   #define amdgpu_ring_emit_rreg(r, d, o) (r)->funcs->emit_rreg((r), (d)=
, (o))
> >   #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d)=
, (v))
> >   #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wa=
it((r), (d), (v), (m))
>
