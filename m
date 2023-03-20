Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B521CC6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 15:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EEB110E5D9;
	Mon, 20 Mar 2023 15:49:39 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E277010E5D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 15:49:36 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id w133so9035944oib.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 08:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679327376;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/sAIclhA2bG8wjqpqUelukW7DDMOZ4njysTNHnB5c84=;
 b=qBSnFdoNMwqFXtbgs5r96krMw3RjPJtPtOwIv2mnRFypvYKFIwcY9s7ElsoHK8LbFE
 aBqWChiYkP86ER9/kWptE/Rz6vM1okLQcmCmEuGMgrcxCFe58HTxw6/miOZ75UmtPgTK
 t179vpXsVr+NeiALS/AZXTJJf3Fep4TgGUSzz/G2N3olqZwzK3G5WM0HDzZUE+Q0zEYA
 eURfhcn3I7zUHCR9he5vpSw9xnNzErdNJ0naUVe973uOmyNErfldw/xvmZ67imrIIX78
 EqhktXPi0n4WoBDYx/LpOV/r6c4eQApNnZ42Nqgm+FUiL95va3feC7BxNjMrHwvxwva9
 0QYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679327376;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/sAIclhA2bG8wjqpqUelukW7DDMOZ4njysTNHnB5c84=;
 b=oMgPiZ2BoHJaiDqKT3nxsedQYEZpz/QhDGHoXfnQdJ4rEE/ASfMuGrF9tGviQEQUfm
 0uNV0rXiOvPp1FxxaOomPJvFBqiBHd0/Y8HhAL04W4JPcuMn19vtktoERmDfZEsqputD
 MT6S0epmVCBYn0qoohO5T6aLwonkHinTFYF0jjnvJMr13BvQlzEBS+orj1oTDz2MgItf
 OEFtOolGVdOutTaTyXQwD9m1lkn8GVxytgIGfdJsVCXZbVXe5EUbXM2VcsyzKwFuCCUU
 kmKG6K3iS/ZL53b/r1498fEduot1/+7eBaJPuhBhbe8PD+F3KxMgeUPKs6TQv5KNZfI7
 dU2g==
X-Gm-Message-State: AO0yUKX8J7UYuV0lcT64xeH02BBkqG/FVVfKxxteYzQaEa/gGbOYIbFU
 9KFH2ovtnBeeI19syNa6xtSZ/Hc2It7qtJzYsCtji2CX
X-Google-Smtp-Source: AK7set/pN0FqZm0MvuRoSjZBf48OxKjN19rAZo9ntm+f0cTVR2CjcNuKwDr17XmiTJq7Gg1FYMqYfqPDuBsuz8cmAOg=
X-Received: by 2002:a05:6808:3a91:b0:384:893:a924 with SMTP id
 fb17-20020a0568083a9100b003840893a924mr113420oib.3.1679327376061; Mon, 20 Mar
 2023 08:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230317171748.682691-1-alexander.deucher@amd.com>
 <20230317171748.682691-4-alexander.deucher@amd.com>
 <a1b61e2f-d69c-4401-b9d5-46c80c14ae15@amd.com>
In-Reply-To: <a1b61e2f-d69c-4401-b9d5-46c80c14ae15@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Mar 2023 11:49:24 -0400
Message-ID: <CADnq5_NenjAzNtjw_LFRQM96j3jXYTRi7MBFOr767v=PVSW+BA@mail.gmail.com>
Subject: Re: [PATCH 03/10] drm/amdgpu: add gfx shadow CS IOCTL support
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 20, 2023 at 11:46=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 17.03.23 um 18:17 schrieb Alex Deucher:
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
> >
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   | 24 +++++++++++++++++++++++=
+
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h  |  1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   |  4 ++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  6 ++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
> >   5 files changed, 37 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.c
> > index f6144b378617..9bdda246b09c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -280,6 +280,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser =
*p,
> >               case AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES:
> >               case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT:
> >               case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
> > +             case AMDGPU_CHUNK_ID_CP_GFX_SHADOW:
> >                       break;
> >
> >               default:
> > @@ -587,6 +588,26 @@ static int amdgpu_cs_p2_syncobj_timeline_signal(st=
ruct amdgpu_cs_parser *p,
> >       return 0;
> >   }
> >
> > +static void amdgpu_cs_p2_shadow(struct amdgpu_cs_parser *p,
> > +                             struct amdgpu_cs_chunk *chunk)
> > +{
> > +     struct drm_amdgpu_cs_chunk_cp_gfx_shadow *shadow =3D chunk->kdata=
;
> > +     bool shadow_initialized =3D false;
> > +     int i;
> > +
> > +     for (i =3D 0; i < p->gang_size; ++i) {
> > +             p->jobs[i]->shadow_va =3D shadow->shadow_va;
> > +             p->jobs[i]->csa_va =3D shadow->csa_va;
> > +             p->jobs[i]->gds_va =3D shadow->gds_va;
>
> Do we really need all three VAs separately?
>
> > +             if (!p->ctx->shadow_initialized) {
> > +                     p->jobs[i]->init_shadow =3D true;
> > +                     shadow_initialized =3D true;
>
> > +             }
> > +     }
> > +     if (shadow_initialized)
> > +             p->ctx->shadow_initialized =3D true;
>
> This is a really bad idea since the IOCTL can be interrupted later on.
>
> Why do we need that?

Yes.  We have to only initial the buffer the first time it's used.
Doing it again will overwrite whatever userspace has done with it
since then.

Alex

>
> Regards,
> Christian.
>
>
> > +}
> > +
> >   static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)
> >   {
> >       unsigned int ce_preempt =3D 0, de_preempt =3D 0;
> > @@ -629,6 +650,9 @@ static int amdgpu_cs_pass2(struct amdgpu_cs_parser =
*p)
> >                       if (r)
> >                               return r;
> >                       break;
> > +             case AMDGPU_CHUNK_ID_CP_GFX_SHADOW:
> > +                     amdgpu_cs_p2_shadow(p, chunk);
> > +                     break;
> >               }
> >       }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ctx.h
> > index 0fa0e56daf67..909d188c41f2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> > @@ -57,6 +57,7 @@ struct amdgpu_ctx {
> >       unsigned long                   ras_counter_ce;
> >       unsigned long                   ras_counter_ue;
> >       uint32_t                        stable_pstate;
> > +     bool                            shadow_initialized;
> >   };
> >
> >   struct amdgpu_ctx_mgr {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ib.c
> > index bcccc348dbe2..d88964b9407f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > @@ -212,6 +212,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, u=
nsigned num_ibs,
> >       }
> >
> >       amdgpu_ring_ib_begin(ring);
> > +
> > +     if (job && ring->funcs->emit_gfx_shadow)
> > +             amdgpu_ring_emit_gfx_shadow(ring, job);
> > +
> >       if (job && ring->funcs->init_cond_exec)
> >               patch_offset =3D amdgpu_ring_init_cond_exec(ring);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_job.h
> > index 9790def34815..b470808fa40e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > @@ -68,6 +68,12 @@ struct amdgpu_job {
> >       uint64_t                uf_addr;
> >       uint64_t                uf_sequence;
> >
> > +     /* virtual addresses for shadow/GDS/CSA */
> > +     uint64_t                shadow_va;
> > +     uint64_t                csa_va;
> > +     uint64_t                gds_va;
> > +     bool                    init_shadow;
> > +
> >       /* job_run_counter >=3D 1 means a resubmit job */
> >       uint32_t                job_run_counter;
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.h
> > index 3989e755a5b4..8643d4a92c27 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -212,6 +212,7 @@ struct amdgpu_ring_funcs {
> >       void (*end_use)(struct amdgpu_ring *ring);
> >       void (*emit_switch_buffer) (struct amdgpu_ring *ring);
> >       void (*emit_cntxcntl) (struct amdgpu_ring *ring, uint32_t flags);
> > +     void (*emit_gfx_shadow)(struct amdgpu_ring *ring, struct amdgpu_j=
ob *job);
> >       void (*emit_rreg)(struct amdgpu_ring *ring, uint32_t reg,
> >                         uint32_t reg_val_offs);
> >       void (*emit_wreg)(struct amdgpu_ring *ring, uint32_t reg, uint32_=
t val);
> > @@ -307,6 +308,7 @@ struct amdgpu_ring {
> >   #define amdgpu_ring_emit_hdp_flush(r) (r)->funcs->emit_hdp_flush((r))
> >   #define amdgpu_ring_emit_switch_buffer(r) (r)->funcs->emit_switch_buf=
fer((r))
> >   #define amdgpu_ring_emit_cntxcntl(r, d) (r)->funcs->emit_cntxcntl((r)=
, (d))
> > +#define amdgpu_ring_emit_gfx_shadow(r, j) (r)->funcs->emit_gfx_shadow(=
(r), (j))
> >   #define amdgpu_ring_emit_rreg(r, d, o) (r)->funcs->emit_rreg((r), (d)=
, (o))
> >   #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d)=
, (v))
> >   #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wa=
it((r), (d), (v), (m))
>
