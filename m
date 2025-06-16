Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6453C71155
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 16:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7630310E33B;
	Mon, 16 Jun 2025 16:03:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SaVDQu2F";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 675BB10E33B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 16:03:21 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-31308f52248so809004a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 09:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750089801; x=1750694601; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f/cz39XEsw2ttiOxMwHBUeD3QO++H8S0h73YgeuJeDQ=;
 b=SaVDQu2FVzcF6yWIdDaP46fKoyxz4HCyHGca/SBLO5mC1e+46LXfbQUDzL4Ydb3TIA
 4W/y+HcfG0d7T4oYQQeBlnowAmd+ZvZOSFmW8u/hcKetPnsmmfZ/v7HcHcHGAy0uEj2M
 7O1jng8Gs25vXD4v47oNYsyM9zXLSpC0VE+ZPWNX/Spb/UH6JNzIceBpPrcEdOAvMU6M
 jl0bX7Q1zckOoLAejztduMG+nz7qiJpIw7HgSIuYz4SwWxXxsB8gyiiYWVOMHbs1jWIf
 hVaIuQ1oQ+AdHPbNkjoi8lSIcRzDs3PZg2gjDd/XL09bHUTIO8iAeL/Q00ewuMxqXEoK
 r/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750089801; x=1750694601;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f/cz39XEsw2ttiOxMwHBUeD3QO++H8S0h73YgeuJeDQ=;
 b=iXmunbNP7MSRKOvjMtVlq5D/p+PlOD6K+e5KWFk7zCKmjuEtMXeGb78vfVocX+skdW
 qgDA0e3qaBptbXVyLJ4vlbAcvOO+FTCTBvM4AtaFcx8T+F4ZaIHAPBqpXuYuuMd+nKcR
 wkMt/qRs77ziygw0/XDb9jjLF7xp0TdOL95TOnejysNwU4u0h5xcMx8IRavvgD85yXe2
 kY+RQKbETGlUhrnDSnp0QPymiCXgKrgLctx1k8Jn27Adhly9kMH14WIC/wW0fCIevaMA
 mDLGIhZwBxCgFmMMyUP0T7X5RyRyBUhVCjuBLtvLX7jVLYrbi6eAAIH7XHk9uepU1JDh
 Oy9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdTPlcvHHYpcZlwerv7D0FzJG+2/M3f6FB/NIQuVitPY5z32ZoVqEgkWBpuMwHY5SqtDezafch@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7RU64tnvXQfO+RwBdEt2H6KWVwH3PLdyUUdJq99WliOakXoo3
 R4N5K4sCm3scqyVJVqlMW8aHKPf+oSLVkm8uU40TeRvZuvg4t3ku6hNdacgi9FOOLOqba6s3T+E
 wTl8nOIy+djjikQs854yP2SaojnBwp8JKXA==
X-Gm-Gg: ASbGncvj/6gN/naFEqVQo9uQ24PxLBqqKTV/ZipDeaeE6a9i/oQnPRWOMjtf6n9TVcK
 AZ20mIbI2FsIN3ZCTO+rurHroqph5V8jOp0QqNVg+Jndz4JBatMOVL+uMH3Rzw4kKcaTkn3wGGw
 JZJhN9yX6CtaZ4ZSofERG9lv4x2VAEkmHWqMF1Oi7eYy4k
X-Google-Smtp-Source: AGHT+IGEbr24o1LOqEA2+obDXPupFqXnwXwZ66KqFCr9SQp6zI/ePX+K4oUlqHmdC3dqg6+IhtnsEWRqHU2quuxurVY=
X-Received: by 2002:a17:90b:540d:b0:312:1d2d:18f8 with SMTP id
 98e67ed59e1d1-313f1e50e63mr5592150a91.7.1750089800545; Mon, 16 Jun 2025
 09:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250613214748.5889-1-alexander.deucher@amd.com>
 <20250613214748.5889-8-alexander.deucher@amd.com>
 <b1ffaaaf-2f16-452f-ae0a-6847e4439675@amd.com>
In-Reply-To: <b1ffaaaf-2f16-452f-ae0a-6847e4439675@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Jun 2025 12:03:08 -0400
X-Gm-Features: AX0GCFsuk4ksapbVU7QVPvT-2FCUKqORua6r6Gq-O4knVW8Vmy1pVmEgCUMM_HQ
Message-ID: <CADnq5_OfGP3Ckb8syhEQwpgV4to-DvmYRM0HzfWryqhap954tQ@mail.gmail.com>
Subject: Re: [PATCH 07/27] drm/amdgpu: move guilty handling into ring resets
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 christian.koenig@amd.com, sasundar@amd.com
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

On Mon, Jun 16, 2025 at 12:11=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 6/14/2025 3:17 AM, Alex Deucher wrote:
> > Move guilty logic into the ring reset callbacks.  This
> > allows each ring reset callback to better handle fence
> > errors and force completions in line with the reset
> > behavior for each IP.  It also allows us to remove
> > the ring guilty callback since that logic now lives
> > in the reset callback.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 22 +---------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 -
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  2 +
> >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  2 +
> >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   |  2 +
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  1 +
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  1 +
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  1 +
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  1 +
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  1 +
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  1 +
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  1 +
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  1 +
> >  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 52 ++++++++++++------------
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 23 ++++++++++-
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 25 ++++++++++--
> >  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  1 +
> >  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  1 +
> >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  1 +
> >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  1 +
> >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  1 +
> >  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  1 +
> >  22 files changed, 89 insertions(+), 54 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_job.c
> > index 177f04491a11b..680cdd8fc3ab2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > @@ -91,7 +91,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(st=
ruct drm_sched_job *s_job)
> >       struct amdgpu_job *job =3D to_amdgpu_job(s_job);
> >       struct amdgpu_task_info *ti;
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     bool set_error =3D false;
> >       int idx, r;
> >
> >       if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
> > @@ -134,8 +133,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(=
struct drm_sched_job *s_job)
> >       if (unlikely(adev->debug_disable_gpu_ring_reset)) {
> >               dev_err(adev->dev, "Ring reset disabled by debug mask\n")=
;
> >       } else if (amdgpu_gpu_recovery && ring->funcs->reset) {
> > -             bool is_guilty;
> > -
> >               dev_err(adev->dev, "Starting %s ring reset\n",
> >                       s_job->sched->name);
> >
> > @@ -145,24 +142,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout=
(struct drm_sched_job *s_job)
> >                */
> >               drm_sched_wqueue_stop(&ring->sched);
> >
> > -             /* for engine resets, we need to reset the engine,
> > -              * but individual queues may be unaffected.
> > -              * check here to make sure the accounting is correct.
> > -              */
> > -             if (ring->funcs->is_guilty)
> > -                     is_guilty =3D ring->funcs->is_guilty(ring);
> > -             else
> > -                     is_guilty =3D true;
> > -
> > -             if (is_guilty) {
> > -                     dma_fence_set_error(&s_job->s_fence->finished, -E=
TIME);
> > -                     set_error =3D true;
> > -             }
> > -
> >               r =3D amdgpu_ring_reset(ring, job->vmid, NULL);
> >               if (!r) {
> > -                     if (is_guilty)
> > -                             atomic_inc(&ring->adev->gpu_reset_counter=
);
> >                       drm_sched_wqueue_start(&ring->sched);
> >                       dev_err(adev->dev, "Ring %s reset succeeded\n",
> >                               ring->sched.name);
> > @@ -173,8 +154,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(=
struct drm_sched_job *s_job)
> >               dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.=
name);
> >       }
> >
> > -     if (!set_error)
> > -             dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
> > +     dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
> >
> >       if (amdgpu_device_should_recover_gpu(ring->adev)) {
> >               struct amdgpu_reset_context reset_context;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.h
> > index ff3a4b81e51ab..c1d14183abfe6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -271,7 +271,6 @@ struct amdgpu_ring_funcs {
> >       int (*reset)(struct amdgpu_ring *ring, unsigned int vmid,
> >                    struct amdgpu_fence *guilty_fence);
> >       void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
> > -     bool (*is_guilty)(struct amdgpu_ring *ring);
> >  };
> >
> >  /**
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v10_0.c
> > index b4f4ad966db82..a9d26d91c8468 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -9581,6 +9581,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring=
 *ring,
> >       if (r)
> >               return r;
> >       amdgpu_fence_driver_force_completion(ring);
> > +     atomic_inc(&ring->adev->gpu_reset_counter);
> >       return 0;
> >  }
> >
> > @@ -9658,6 +9659,7 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring=
 *ring,
> >       if (r)
> >               return r;
> >       amdgpu_fence_driver_force_completion(ring);
> > +     atomic_inc(&ring->adev->gpu_reset_counter);
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v11_0.c
> > index 5707ce7dd5c82..3dd2e04830dc6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > @@ -6846,6 +6846,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring=
 *ring,
> >       if (r)
> >               return r;
> >       amdgpu_fence_driver_force_completion(ring);
> > +     atomic_inc(&ring->adev->gpu_reset_counter);
> >       return 0;
> >  }
> >
> > @@ -7012,6 +7013,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring=
 *ring,
> >       if (r)
> >               return r;
> >       amdgpu_fence_driver_force_completion(ring);
> > +     atomic_inc(&ring->adev->gpu_reset_counter);
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v12_0.c
> > index 259a83c3acb5d..d2ee4543ce222 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > @@ -5341,6 +5341,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring=
 *ring,
> >       if (r)
> >               return r;
> >       amdgpu_fence_driver_force_completion(ring);
> > +     atomic_inc(&ring->adev->gpu_reset_counter);
> >       return 0;
> >  }
> >
> > @@ -5460,6 +5461,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring=
 *ring,
> >       if (r)
> >               return r;
> >       amdgpu_fence_driver_force_completion(ring);
> > +     atomic_inc(&ring->adev->gpu_reset_counter);
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_0.c
> > index e0dec946b7cdc..1b767094dfa24 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -7228,6 +7228,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring =
*ring,
> >       if (r)
> >               return r;
> >       amdgpu_fence_driver_force_completion(ring);
> > +     atomic_inc(&ring->adev->gpu_reset_counter);
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v9_4_3.c
> > index e5fcc63cd99df..05abe86ecd9ac 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > @@ -3625,6 +3625,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_rin=
g *ring,
> >       if (r)
> >               return r;
> >       amdgpu_fence_driver_force_completion(ring);
> > +     atomic_inc(&ring->adev->gpu_reset_counter);
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v2_0.c
> > index 0b1fa35a441ae..dbc28042c7d53 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > @@ -776,6 +776,7 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring =
*ring,
> >       if (r)
> >               return r;
> >       amdgpu_fence_driver_force_completion(ring);
> > +     atomic_inc(&ring->adev->gpu_reset_counter);
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v2_5.c
> > index 7a9e91f6495de..f8af473e2a7a4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > @@ -655,6 +655,7 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring =
*ring,
> >       if (r)
> >               return r;
> >       amdgpu_fence_driver_force_completion(ring);
> > +     atomic_inc(&ring->adev->gpu_reset_counter);
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v3_0.c
> > index 81ee1ba4c0a3c..83559a32ed3d2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > @@ -567,6 +567,7 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring =
*ring,
> >       if (r)
> >               return r;
> >       amdgpu_fence_driver_force_completion(ring);
> > +     atomic_inc(&ring->adev->gpu_reset_counter);
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v4_0.c
> > index 06f75091e1304..b0f80f2a549c6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> > @@ -735,6 +735,7 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring =
*ring,
> >       if (r)
> >               return r;
> >       amdgpu_fence_driver_force_completion(ring);
> > +     atomic_inc(&ring->adev->gpu_reset_counter);
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm=
/amd/amdgpu/jpeg_v4_0_3.c
> > index 10a7b990b0adf..4fd9386d2efd6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > @@ -1158,6 +1158,7 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_r=
ing *ring,
> >       if (r)
> >               return r;
> >       amdgpu_fence_driver_force_completion(ring);
> > +     atomic_inc(&ring->adev->gpu_reset_counter);
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm=
/amd/amdgpu/jpeg_v5_0_1.c
> > index 88dea7a47a1e5..beca4d1e941b3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> > @@ -849,6 +849,7 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_rin=
g *ring,
> >       if (r)
> >               return r;
> >       amdgpu_fence_driver_force_completion(ring);
> > +     atomic_inc(&ring->adev->gpu_reset_counter);
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm=
/amd/amdgpu/sdma_v4_4_2.c
> > index c5e0d2e730740..0199d5bb5821d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > @@ -1651,37 +1651,21 @@ static bool sdma_v4_4_2_is_queue_selected(struc=
t amdgpu_device *adev, uint32_t i
> >       return (context_status & SDMA_GFX_CONTEXT_STATUS__SELECTED_MASK) =
!=3D 0;
> >  }
> >
> > -static bool sdma_v4_4_2_ring_is_guilty(struct amdgpu_ring *ring)
> > -{
> > -     struct amdgpu_device *adev =3D ring->adev;
> > -     uint32_t instance_id =3D ring->me;
> > -
> > -     return sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
> > -}
> > -
> > -static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
> > -{
> > -     struct amdgpu_device *adev =3D ring->adev;
> > -     uint32_t instance_id =3D ring->me;
> > -
> > -     if (!adev->sdma.has_page_queue)
> > -             return false;
> > -
> > -     return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
> > -}
> > -
> >  static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
> >                                  unsigned int vmid,
> >                                  struct amdgpu_fence *guilty_fence)
> >  {
> > -     bool is_guilty =3D ring->funcs->is_guilty(ring);
> >       struct amdgpu_device *adev =3D ring->adev;
> >       u32 id =3D ring->me;
> > +     bool is_guilty;
> >       int r;
> >
> >       if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> >               return -EOPNOTSUPP;
> >
> > +     is_guilty =3D sdma_v4_4_2_is_queue_selected(adev, id,
> > +                                               &adev->sdma.instance[id=
].page =3D=3D ring);
> > +
> >       amdgpu_amdkfd_suspend(adev, false);
> >       r =3D amdgpu_sdma_reset_engine(adev, id);
> >       amdgpu_amdkfd_resume(adev, false);
> > @@ -1689,7 +1673,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_=
ring *ring,
> >               return r;
> >
> >       if (is_guilty)
> > -             amdgpu_fence_driver_force_completion(ring);
> > +             atomic_inc(&ring->adev->gpu_reset_counter);
>
> This may not be related to this patch as such. SDMA reset happened
> regardless of page/sdma queue being guilty. Why this increment is done
> conditionally in that case?

Yes, that should be fixed.  Will fix it up in the next rev.  I was
getting ahead of myself.  After the re-emit changes, we are able to
recover the non-guilty ring(s).

Alex

>
> Thanks,
> Lijo
>
> >
> >       return 0;
> >  }
> > @@ -1735,8 +1719,8 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_r=
ing *ring)
> >  static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     u32 inst_mask;
> > -     int i;
> > +     u32 inst_mask, tmp_mask;
> > +     int i, r;
> >
> >       inst_mask =3D 1 << ring->me;
> >       udelay(50);
> > @@ -1753,7 +1737,25 @@ static int sdma_v4_4_2_restore_queue(struct amdg=
pu_ring *ring)
> >               return -ETIMEDOUT;
> >       }
> >
> > -     return sdma_v4_4_2_inst_start(adev, inst_mask, true);
> > +     r =3D sdma_v4_4_2_inst_start(adev, inst_mask, true);
> > +     if (r) {
> > +             return r;
> > +     }
> > +
> > +     tmp_mask =3D inst_mask;
> > +     for_each_inst(i, tmp_mask) {
> > +             ring =3D &adev->sdma.instance[i].ring;
> > +
> > +             amdgpu_fence_driver_force_completion(ring);
> > +
> > +             if (adev->sdma.has_page_queue) {
> > +                     struct amdgpu_ring *page =3D &adev->sdma.instance=
[i].page;
> > +
> > +                     amdgpu_fence_driver_force_completion(page);
> > +             }
> > +     }
> > +
> > +     return r;
> >  }
> >
> >  static int sdma_v4_4_2_soft_reset_engine(struct amdgpu_device *adev,
> > @@ -2159,7 +2161,6 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2=
_ring_funcs =3D {
> >       .emit_reg_wait =3D sdma_v4_4_2_ring_emit_reg_wait,
> >       .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wait_=
helper,
> >       .reset =3D sdma_v4_4_2_reset_queue,
> > -     .is_guilty =3D sdma_v4_4_2_ring_is_guilty,
> >  };
> >
> >  static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs =3D =
{
> > @@ -2192,7 +2193,6 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2=
_page_ring_funcs =3D {
> >       .emit_reg_wait =3D sdma_v4_4_2_ring_emit_reg_wait,
> >       .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wait_=
helper,
> >       .reset =3D sdma_v4_4_2_reset_queue,
> > -     .is_guilty =3D sdma_v4_4_2_page_ring_is_guilty,
> >  };
> >
> >  static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v5_0.c
> > index 09419db2d49a6..4a36e5199f248 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > @@ -1538,18 +1538,34 @@ static int sdma_v5_0_soft_reset(struct amdgpu_i=
p_block *ip_block)
> >       return 0;
> >  }
> >
> > +static bool sdma_v5_0_is_queue_selected(struct amdgpu_device *adev,
> > +                                     uint32_t instance_id)
> > +{
> > +     u32 context_status =3D RREG32(sdma_v5_0_get_reg_offset(adev, inst=
ance_id,
> > +                                                          mmSDMA0_GFX_=
CONTEXT_STATUS));
> > +
> > +     /* Check if the SELECTED bit is set */
> > +     return (context_status & SDMA0_GFX_CONTEXT_STATUS__SELECTED_MASK)=
 !=3D 0;
> > +}
> > +
> >  static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
> >                                unsigned int vmid,
> >                                struct amdgpu_fence *guilty_fence)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> >       u32 inst_id =3D ring->me;
> > +     bool is_guilty =3D sdma_v5_0_is_queue_selected(adev, inst_id);
> >       int r;
> >
> > +     amdgpu_amdkfd_suspend(adev, false);
> >       r =3D amdgpu_sdma_reset_engine(adev, inst_id);
> > +     amdgpu_amdkfd_resume(adev, false);
> >       if (r)
> >               return r;
> > -     amdgpu_fence_driver_force_completion(ring);
> > +
> > +     if (is_guilty)
> > +             atomic_inc(&ring->adev->gpu_reset_counter);
> > +
> >       return 0;
> >  }
> >
> > @@ -1617,7 +1633,10 @@ static int sdma_v5_0_restore_queue(struct amdgpu=
_ring *ring)
> >
> >       r =3D sdma_v5_0_gfx_resume_instance(adev, inst_id, true);
> >       amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> > -     return r;
> > +     if (r)
> > +             return r;
> > +     amdgpu_fence_driver_force_completion(ring);
> > +     return 0;
> >  }
> >
> >  static int sdma_v5_0_ring_preempt_ib(struct amdgpu_ring *ring)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v5_2.c
> > index 365c710ee9e8c..84d85ef30701c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > @@ -1451,18 +1451,34 @@ static int sdma_v5_2_wait_for_idle(struct amdgp=
u_ip_block *ip_block)
> >       return -ETIMEDOUT;
> >  }
> >
> > +static bool sdma_v5_2_is_queue_selected(struct amdgpu_device *adev,
> > +                                     uint32_t instance_id)
> > +{
> > +     u32 context_status =3D RREG32(sdma_v5_2_get_reg_offset(adev, inst=
ance_id,
> > +                                                          mmSDMA0_GFX_=
CONTEXT_STATUS));
> > +
> > +     /* Check if the SELECTED bit is set */
> > +     return (context_status & SDMA0_GFX_CONTEXT_STATUS__SELECTED_MASK)=
 !=3D 0;
> > +}
> > +
> >  static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
> >                                unsigned int vmid,
> >                                struct amdgpu_fence *guilty_fence)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> >       u32 inst_id =3D ring->me;
> > +     bool is_guilty =3D sdma_v5_2_is_queue_selected(adev, inst_id);
> >       int r;
> >
> > +     amdgpu_amdkfd_suspend(adev, false);
> >       r =3D amdgpu_sdma_reset_engine(adev, inst_id);
> > +     amdgpu_amdkfd_resume(adev, false);
> >       if (r)
> >               return r;
> > -     amdgpu_fence_driver_force_completion(ring);
> > +
> > +     if (is_guilty)
> > +             atomic_inc(&ring->adev->gpu_reset_counter);
> > +
> >       return 0;
> >  }
> >
> > @@ -1529,11 +1545,12 @@ static int sdma_v5_2_restore_queue(struct amdgp=
u_ring *ring)
> >       freeze =3D RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0=
_FREEZE));
> >       freeze =3D REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
> >       WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE), f=
reeze);
> > -
> >       r =3D sdma_v5_2_gfx_resume_instance(adev, inst_id, true);
> > -
> >       amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> > -     return r;
> > +     if (r)
> > +             return r;
> > +     amdgpu_fence_driver_force_completion(ring);
> > +     return 0;
> >  }
> >
> >  static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v6_0.c
> > index 746f14862d9ff..595e90a5274ea 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > @@ -1565,6 +1565,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ri=
ng *ring,
> >       if (r)
> >               return r;
> >       amdgpu_fence_driver_force_completion(ring);
> > +     atomic_inc(&ring->adev->gpu_reset_counter);
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v7_0.c
> > index 2e4c658598001..3e036c37b1f5a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> > @@ -830,6 +830,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring=
 *ring,
> >       if (r)
> >               return r;
> >       amdgpu_fence_driver_force_completion(ring);
> > +     atomic_inc(&ring->adev->gpu_reset_counter);
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0.c
> > index 0d73b2bd4aad6..d5be19361cc89 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > @@ -1985,6 +1985,7 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring=
 *ring,
> >       if (r)
> >               return r;
> >       amdgpu_fence_driver_force_completion(ring);
> > +     atomic_inc(&ring->adev->gpu_reset_counter);
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/=
amd/amdgpu/vcn_v4_0_3.c
> > index bf9edfef2107e..c7c2b7f5ba56d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > @@ -1626,6 +1626,7 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ri=
ng *ring,
> >       if (r)
> >               return r;
> >       amdgpu_fence_driver_force_completion(ring);
> > +     atomic_inc(&ring->adev->gpu_reset_counter);
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/=
amd/amdgpu/vcn_v4_0_5.c
> > index 3a3ed600e15f0..af75617cf6df5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > @@ -1483,6 +1483,7 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ri=
ng *ring,
> >       if (r)
> >               return r;
> >       amdgpu_fence_driver_force_completion(ring);
> > +     atomic_inc(&ring->adev->gpu_reset_counter);
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/=
amd/amdgpu/vcn_v5_0_0.c
> > index c7953116ad532..64f2b64da6258 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > @@ -1210,6 +1210,7 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ri=
ng *ring,
> >       if (r)
> >               return r;
> >       amdgpu_fence_driver_force_completion(ring);
> > +     atomic_inc(&ring->adev->gpu_reset_counter);
> >       return 0;
> >  }
> >
>
