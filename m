Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34618C678DF
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 16:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4289B10E3B7;
	Fri,  6 Jun 2025 16:00:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g0lRZFfJ";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ABF610E3B7
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 16:00:21 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-312cdbc67c9so354828a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Jun 2025 09:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749225621; x=1749830421; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G8sEZ2UIsvANSEv0zqVUQjguOWrTB6aHwKbis9fDzzg=;
 b=g0lRZFfJdEitMZx00BecHyCxFxa0Dkrr6TKjkDv14jQa7C4FWTpIAh0vqv9iE4DD1M
 3g6lmidgfnx1zliWNRdfGjCnEaxsvppbswhBKwNVc91ZOuHkkiHCwEXK/Iz0AOK3Q1ts
 Y5InXPnQhErEo+heSABuLT8kwRfU90qgRO93Z+pa+acKBsYzgvJcdNXY+Duokvh8+SNw
 zQYGBYdwwW7Usy2CZFvht0mco5yMPfM+2zd/xQLoCxhH67neOjY4BLlSDOT+8fJgiRgX
 0t+WNbjtFfiKLvnjUb3KmhAc9NQ9dD/mv7pEBQbSESOJb/puGrfh2O2AB/SfjJEItp72
 zIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749225621; x=1749830421;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G8sEZ2UIsvANSEv0zqVUQjguOWrTB6aHwKbis9fDzzg=;
 b=lKUrvCQDVrHxtV/79uFw4HFfOqjMnyrhLANv2rjCMPta465Je1rFbMBXKGdYkrAjOu
 UsRPUCFpT07VBGkw/LbTWr9jwhPpFSQ6r7YxBQqIMRRy7ZwCLrDcC/K4wE614X7iiRqv
 Bf5RTGRDHn4nz79euE1DmMJxoflMUUq4qqwcLWffpS+1VbxUpiPhQ/tCytJ2vXUre42r
 NDJq9aSfolraktJ3iRpX0VPuRkbjAWtINiUmzPQv1VUyFkxnaQL3ML3DO7sjIM2JHJyR
 yk3JYHJ+Ee4H08KNXv/DaHZWvcHs+E78k6AYmpxps8/pH4TaBpYQPIdOJ52RIhF2Vwgw
 4cAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk0uQC+ix41945rpR5hzAPG2gjESDHcD6lAiA0WUG/Vv0AR3gNhQdMpKiC1u2RyBZyXx1Wiooc@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4w9/+dpkknaCYtrZ6+R3CjoJ1/Z4UvxsUhagcBa1an7egKIir
 wJcbeIZPt0J0hI7BGX37NpLPWkQTVoTW101LdKLdbXR2rX9yOAN9wWify4AZEfLPfcgeeBZsxCt
 iP3UgevOrTw/MEniuhzLrg63dtJrOEvo=
X-Gm-Gg: ASbGncsOGHS5mfGAU8f/ucl78hCABt8LPdAgrhSx0ZfWjOrKNrJNmypq9fZ3O7khwsR
 N6J/nqD31ZCsDyl9xFthsJhtvTWNe8FrXPmXsivH4i4jAlsC/zza1jCSu5RlnGCvpZIADZ0G0xj
 pMSz+eZp/IJCEQxaRiBeNcISKHgNpyE40zrg==
X-Google-Smtp-Source: AGHT+IEdO0p0DEqCTPnx/p4cgqfMI24lJ4wxBShjOExkIxukftx1teth6Lnpbxj3Aaa/NiESt17Q07TuZf9SvlG2uPY=
X-Received: by 2002:a17:90b:28c7:b0:312:1d2d:18f8 with SMTP id
 98e67ed59e1d1-3134e431456mr1615318a91.7.1749225620463; Fri, 06 Jun 2025
 09:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250606064354.5858-1-alexander.deucher@amd.com>
 <20250606064354.5858-7-alexander.deucher@amd.com>
 <62a1601e-990a-498e-a64b-d96bfa5567e6@amd.com>
In-Reply-To: <62a1601e-990a-498e-a64b-d96bfa5567e6@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Jun 2025 12:00:07 -0400
X-Gm-Features: AX0GCFu8qHNThl6lSL1aNN4GqO8Jctn-2nccud5Ddexsg85dufceN_NJqVdZOko
Message-ID: <CADnq5_NVyLr6O71si=svVJr-Ev6TOGtLs4W32T6fayQPDyfr8Q@mail.gmail.com>
Subject: Re: [PATCH 06/29] drm/amdgpu: update ring reset function signature
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

On Fri, Jun 6, 2025 at 7:41=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 6/6/25 08:43, Alex Deucher wrote:
> > Going forward, we'll need more than just the vmid.  Everything
> > we need in currently in the amdgpu job structure, so just
> > pass that in.
>
> Please don't the job is just a container for the submission, it should no=
t be part of any reset handling.
>
> What information is actually needed here?

We need job->vmid, job->base.s_fence->finished, job->hw_fence.

Alex

>
> Regards,
> Christian.
>
>
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 ++--
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  7 ++++---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 10 ++++++----
> >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 10 ++++++----
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  3 ++-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  3 ++-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  3 ++-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  3 ++-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  3 ++-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  3 ++-
> >  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  3 ++-
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  3 ++-
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  3 ++-
> >  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  5 +++--
> >  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  5 +++--
> >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  3 ++-
> >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  3 ++-
> >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  3 ++-
> >  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  3 ++-
> >  22 files changed, 53 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_job.c
> > index ddb9d3269357c..80d4dfebde24f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > @@ -155,7 +155,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(=
struct drm_sched_job *s_job)
> >               if (is_guilty)
> >                       dma_fence_set_error(&s_job->s_fence->finished, -E=
TIME);
> >
> > -             r =3D amdgpu_ring_reset(ring, job->vmid);
> > +             r =3D amdgpu_ring_reset(ring, job);
> >               if (!r) {
> >                       if (amdgpu_ring_sched_ready(ring))
> >                               drm_sched_stop(&ring->sched, s_job);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.h
> > index e1f25218943a4..ab5402d7ce9c8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -268,7 +268,7 @@ struct amdgpu_ring_funcs {
> >       void (*patch_cntl)(struct amdgpu_ring *ring, unsigned offset);
> >       void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
> >       void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
> > -     int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
> > +     int (*reset)(struct amdgpu_ring *ring, struct amdgpu_job *job);
> >       void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
> >       bool (*is_guilty)(struct amdgpu_ring *ring);
> >  };
> > @@ -425,7 +425,7 @@ struct amdgpu_ring {
> >  #define amdgpu_ring_patch_cntl(r, o) ((r)->funcs->patch_cntl((r), (o))=
)
> >  #define amdgpu_ring_patch_ce(r, o) ((r)->funcs->patch_ce((r), (o)))
> >  #define amdgpu_ring_patch_de(r, o) ((r)->funcs->patch_de((r), (o)))
> > -#define amdgpu_ring_reset(r, v) (r)->funcs->reset((r), (v))
> > +#define amdgpu_ring_reset(r, j) (r)->funcs->reset((r), (j))
> >
> >  unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
> >  int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v10_0.c
> > index 75ea071744eb5..c58e7040c732a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -9522,7 +9522,8 @@ static void gfx_v10_ring_insert_nop(struct amdgpu=
_ring *ring, uint32_t num_nop)
> >       amdgpu_ring_insert_nop(ring, num_nop - 1);
> >  }
> >
> > -static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int =
vmid)
> > +static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
> > +                            struct amdgpu_job *job)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> >       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> > @@ -9547,7 +9548,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring=
 *ring, unsigned int vmid)
> >
> >       addr =3D amdgpu_bo_gpu_offset(ring->mqd_obj) +
> >               offsetof(struct v10_gfx_mqd, cp_gfx_hqd_active);
> > -     tmp =3D REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid)=
;
> > +     tmp =3D REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << job->=
vmid);
> >       if (ring->pipe =3D=3D 0)
> >               tmp =3D REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE0_QUEUES, 1=
 << ring->queue);
> >       else
> > @@ -9579,7 +9580,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring=
 *ring, unsigned int vmid)
> >  }
> >
> >  static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
> > -                            unsigned int vmid)
> > +                            struct amdgpu_job *job)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> >       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v11_0.c
> > index afd6d59164bfa..0ee7bdd509741 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > @@ -6806,7 +6806,8 @@ static int gfx_v11_reset_gfx_pipe(struct amdgpu_r=
ing *ring)
> >       return 0;
> >  }
> >
> > -static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int =
vmid)
> > +static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
> > +                            struct amdgpu_job *job)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> >       int r;
> > @@ -6814,7 +6815,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring=
 *ring, unsigned int vmid)
> >       if (amdgpu_sriov_vf(adev))
> >               return -EINVAL;
> >
> > -     r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false=
);
> > +     r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, =
false);
> >       if (r) {
> >
> >               dev_warn(adev->dev, "reset via MES failed and try pipe re=
set %d\n", r);
> > @@ -6968,7 +6969,8 @@ static int gfx_v11_0_reset_compute_pipe(struct am=
dgpu_ring *ring)
> >       return 0;
> >  }
> >
> > -static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int =
vmid)
> > +static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
> > +                            struct amdgpu_job *job)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> >       int r =3D 0;
> > @@ -6976,7 +6978,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring=
 *ring, unsigned int vmid)
> >       if (amdgpu_sriov_vf(adev))
> >               return -EINVAL;
> >
> > -     r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true)=
;
> > +     r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, =
true);
> >       if (r) {
> >               dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe r=
eset\n", r);
> >               r =3D gfx_v11_0_reset_compute_pipe(ring);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v12_0.c
> > index 1234c8d64e20d..a26417d53411b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > @@ -5307,7 +5307,8 @@ static int gfx_v12_reset_gfx_pipe(struct amdgpu_r=
ing *ring)
> >       return 0;
> >  }
> >
> > -static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int =
vmid)
> > +static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
> > +                            struct amdgpu_job *job)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> >       int r;
> > @@ -5315,7 +5316,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring=
 *ring, unsigned int vmid)
> >       if (amdgpu_sriov_vf(adev))
> >               return -EINVAL;
> >
> > -     r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false=
);
> > +     r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, =
false);
> >       if (r) {
> >               dev_warn(adev->dev, "reset via MES failed and try pipe re=
set %d\n", r);
> >               r =3D gfx_v12_reset_gfx_pipe(ring);
> > @@ -5421,7 +5422,8 @@ static int gfx_v12_0_reset_compute_pipe(struct am=
dgpu_ring *ring)
> >       return 0;
> >  }
> >
> > -static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int =
vmid)
> > +static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
> > +                            struct amdgpu_job *job)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> >       int r;
> > @@ -5429,7 +5431,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring=
 *ring, unsigned int vmid)
> >       if (amdgpu_sriov_vf(adev))
> >               return -EINVAL;
> >
> > -     r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true)=
;
> > +     r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, =
true);
> >       if (r) {
> >               dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe =
reset\n", r);
> >               r =3D gfx_v12_0_reset_compute_pipe(ring);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_0.c
> > index d50e125fd3e0d..5e650cc5fcb26 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -7153,7 +7153,7 @@ static void gfx_v9_ring_insert_nop(struct amdgpu_=
ring *ring, uint32_t num_nop)
> >  }
> >
> >  static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
> > -                           unsigned int vmid)
> > +                           struct amdgpu_job *job)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> >       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v9_4_3.c
> > index c233edf605694..a7dadff3dca31 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > @@ -3552,7 +3552,7 @@ static int gfx_v9_4_3_reset_hw_pipe(struct amdgpu=
_ring *ring)
> >  }
> >
> >  static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
> > -                             unsigned int vmid)
> > +                             struct amdgpu_job *job)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> >       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[ring->xcc_id];
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v2_0.c
> > index 4cde8a8bcc837..6cd3fbe00d6b9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > @@ -764,7 +764,8 @@ static int jpeg_v2_0_process_interrupt(struct amdgp=
u_device *adev,
> >       return 0;
> >  }
> >
> > -static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring, unsigned int=
 vmid)
> > +static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
> > +                             struct amdgpu_job *job)
> >  {
> >       jpeg_v2_0_stop(ring->adev);
> >       jpeg_v2_0_start(ring->adev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v2_5.c
> > index 8b39e114f3be1..8ed41868f6c32 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > @@ -643,7 +643,8 @@ static int jpeg_v2_5_process_interrupt(struct amdgp=
u_device *adev,
> >       return 0;
> >  }
> >
> > -static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring, unsigned int=
 vmid)
> > +static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
> > +                             struct amdgpu_job *job)
> >  {
> >       jpeg_v2_5_stop_inst(ring->adev, ring->me);
> >       jpeg_v2_5_start_inst(ring->adev, ring->me);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v3_0.c
> > index 2f8510c2986b9..3512fbb543301 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > @@ -555,7 +555,8 @@ static int jpeg_v3_0_process_interrupt(struct amdgp=
u_device *adev,
> >       return 0;
> >  }
> >
> > -static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring, unsigned int=
 vmid)
> > +static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
> > +                             struct amdgpu_job *job)
> >  {
> >       jpeg_v3_0_stop(ring->adev);
> >       jpeg_v3_0_start(ring->adev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v4_0.c
> > index f17ec5414fd69..c8efeaf0a2a69 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> > @@ -720,7 +720,8 @@ static int jpeg_v4_0_process_interrupt(struct amdgp=
u_device *adev,
> >       return 0;
> >  }
> >
> > -static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int=
 vmid)
> > +static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
> > +                             struct amdgpu_job *job)
> >  {
> >       if (amdgpu_sriov_vf(ring->adev))
> >               return -EINVAL;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm=
/amd/amdgpu/jpeg_v4_0_3.c
> > index 79e342d5ab28d..8b07c3651c579 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > @@ -1143,7 +1143,8 @@ static void jpeg_v4_0_3_core_stall_reset(struct a=
mdgpu_ring *ring)
> >       WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
> >  }
> >
> > -static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned i=
nt vmid)
> > +static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
> > +                               struct amdgpu_job *job)
> >  {
> >       if (amdgpu_sriov_vf(ring->adev))
> >               return -EOPNOTSUPP;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm=
/amd/amdgpu/jpeg_v5_0_1.c
> > index 3b6f65a256464..0a21a13e19360 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> > @@ -834,7 +834,8 @@ static void jpeg_v5_0_1_core_stall_reset(struct amd=
gpu_ring *ring)
> >       WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
> >  }
> >
> > -static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring, unsigned i=
nt vmid)
> > +static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
> > +                               struct amdgpu_job *job)
> >  {
> >       if (amdgpu_sriov_vf(ring->adev))
> >               return -EOPNOTSUPP;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm=
/amd/amdgpu/sdma_v4_4_2.c
> > index 9c169112a5e7b..ffd67d51b335f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > @@ -1667,7 +1667,8 @@ static bool sdma_v4_4_2_page_ring_is_guilty(struc=
t amdgpu_ring *ring)
> >       return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
> >  }
> >
> > -static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned =
int vmid)
> > +static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
> > +                                struct amdgpu_job *job)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> >       u32 id =3D GET_INST(SDMA0, ring->me);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v5_0.c
> > index 9505ae96fbecc..46affee1c2da0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > @@ -1538,7 +1538,8 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_=
block *ip_block)
> >       return 0;
> >  }
> >
> > -static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned in=
t vmid)
> > +static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
> > +                              struct amdgpu_job *job)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> >       u32 inst_id =3D ring->me;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v5_2.c
> > index a6e612b4a8928..581e75b7d01a8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > @@ -1451,7 +1451,8 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_=
ip_block *ip_block)
> >       return -ETIMEDOUT;
> >  }
> >
> > -static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned in=
t vmid)
> > +static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
> > +                              struct amdgpu_job *job)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> >       u32 inst_id =3D ring->me;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v6_0.c
> > index 5a70ae17be04e..d9866009edbfc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > @@ -1537,7 +1537,8 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgp=
u_ring *ring)
> >       return r;
> >  }
> >
> > -static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned in=
t vmid)
> > +static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
> > +                              struct amdgpu_job *job)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> >       int i, r;
> > @@ -1555,7 +1556,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ri=
ng *ring, unsigned int vmid)
> >               return -EINVAL;
> >       }
> >
> > -     r =3D amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
> > +     r =3D amdgpu_mes_reset_legacy_queue(adev, ring, job->vmid, true);
> >       if (r)
> >               return r;
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v7_0.c
> > index ad47d0bdf7775..c546e73642296 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> > @@ -802,7 +802,8 @@ static bool sdma_v7_0_check_soft_reset(struct amdgp=
u_ip_block *ip_block)
> >       return false;
> >  }
> >
> > -static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned in=
t vmid)
> > +static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
> > +                              struct amdgpu_job *job)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> >       int i, r;
> > @@ -820,7 +821,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring=
 *ring, unsigned int vmid)
> >               return -EINVAL;
> >       }
> >
> > -     r =3D amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
> > +     r =3D amdgpu_mes_reset_legacy_queue(adev, ring, job->vmid, true);
> >       if (r)
> >               return r;
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0.c
> > index b5071f77f78d2..47a0deceff433 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > @@ -1967,7 +1967,8 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct=
 amdgpu_cs_parser *p,
> >       return 0;
> >  }
> >
> > -static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int =
vmid)
> > +static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
> > +                            struct amdgpu_job *job)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> >       struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[ring->me];
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/=
amd/amdgpu/vcn_v4_0_3.c
> > index 5a33140f57235..d961a824d2098 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > @@ -1594,7 +1594,8 @@ static void vcn_v4_0_3_unified_ring_set_wptr(stru=
ct amdgpu_ring *ring)
> >       }
> >  }
> >
> > -static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned in=
t vmid)
> > +static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
> > +                              struct amdgpu_job *job)
> >  {
> >       int r =3D 0;
> >       int vcn_inst;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/=
amd/amdgpu/vcn_v4_0_5.c
> > index 16ade84facc78..10bd714592278 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > @@ -1465,7 +1465,8 @@ static void vcn_v4_0_5_unified_ring_set_wptr(stru=
ct amdgpu_ring *ring)
> >       }
> >  }
> >
> > -static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring, unsigned in=
t vmid)
> > +static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
> > +                              struct amdgpu_job *job)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> >       struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[ring->me];
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/=
amd/amdgpu/vcn_v5_0_0.c
> > index f8e3f0b882da5..7e6a7ead9a086 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > @@ -1192,7 +1192,8 @@ static void vcn_v5_0_0_unified_ring_set_wptr(stru=
ct amdgpu_ring *ring)
> >       }
> >  }
> >
> > -static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring, unsigned in=
t vmid)
> > +static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
> > +                              struct amdgpu_job *job)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> >       struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[ring->me];
>
