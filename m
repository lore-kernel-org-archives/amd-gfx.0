Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AE0C28B2F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 14:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33CB210E716;
	Wed, 12 Mar 2025 14:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IG+QZjwS";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19C7B10E716
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 14:16:17 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-301001bc6a8so520786a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 07:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741788976; x=1742393776; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qi7xbi8TyPmTP9OrwSscG66E4tYkHqAKiN3qiHUvnbE=;
 b=IG+QZjwSAuNpshuMln6ZUAEnrRBaGWXOW+xG0zmYwbNevKeOPngrhYhtyGxy3Kn7vq
 z6vVEI6WrNj+xHyySiKzfZUDy9mExxcjzVNM5xh9oxNBsMfjFDi/8H9LadoHCsHIjgST
 t9ejsVBtCIXqqhccLhovKdR1wtZ90mEMpLTCGkd5amZbqANUY/z1dg3Ptq2c2XBoxYNT
 SufLj5rzQlJsT9zRtiVl9rKBJvokuxI+0kQTMK1svxonOn2Fkboo7/GSN1EQvqqskuM0
 JD/kp2EQAkePLcD4a6pD7DOXAi+NyP/46wDVjvtiDwyonpodWZkN+NWucyxF+WzIwYqK
 U86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741788976; x=1742393776;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qi7xbi8TyPmTP9OrwSscG66E4tYkHqAKiN3qiHUvnbE=;
 b=muQPAgez3lNNx6ZAqC9qGfargXJYfbpOXbETh+kukHOWRU2If5VIbiL/aM97RQsuLw
 9s+hSPEom1P7N5qO2UuQdRCopiMHFELmZz/olsB8QcmImCZfwmQpeGqgjtNGmoEx9IIS
 skE5MyPze5jjXfvFSNEoFdlCt5kLPnFrJMsZQQQ+99GinlxicBgFgkU11O22X+jQv+Sg
 /P1hTJuHvcgh4APwXxoEwpekKnf1wexgM7L7QAkn1+WWsLmUA0wXWjTXtk/TtHWvviVb
 1NZskYkSacTz8K7E4AyvyhETUUMGhv/kf2bXG9r6sEkuSbBdqXIXFAvE/cO0djuY5nhs
 0TFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN/yfDQAb62noICE5ClabaD4RE3TYVeHBNAbv8Gk8RbhwuTG8uuJHgrMyPYNn7NdMxi2aywPi2@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxnePJjJz4iv0hSpyWIow9NeXxWyjz6F/s6caLxFWjPB2LRvv9j
 VrBthc7Gq23oFkzz7gh2DKaDeWVb+gAP/39R2N71nOUIAGD1a9wb0Qdx75/9Qluvwlw2WoFZy0V
 Pz+3MvbFkd2vzbdT6IUB5Us02MSs=
X-Gm-Gg: ASbGncsurfQFXFCFSBsPc1xVezxELGHLUZDYgMf3nByt0JWQPpsr/HYScEmLEcEUzEv
 J+GoYrgTbiDFEvAp60lsmGvCXWg53XSvs6stdAFZVVFItV9oNLFyo7Kdacl1Hvq5MJgEOUTD2HP
 pqEgFcbB7Ll9AsWGwFdDstMsWXzA==
X-Google-Smtp-Source: AGHT+IGmgurvtGwlrFGmiiPeQPmEN+YGXX2vVBc2n4/+YQRVdr0qiZHyc3Ob9qaJhZpKhhawxZTbDrxv4GcI3wmykkQ=
X-Received: by 2002:a17:90b:1d0b:b0:2ff:7c5a:216d with SMTP id
 98e67ed59e1d1-300ff90db80mr3963941a91.5.1741788976355; Wed, 12 Mar 2025
 07:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250311141711.1911564-1-alexander.deucher@amd.com>
 <5daeb642-903a-451c-9245-b540afcabb72@amd.com>
In-Reply-To: <5daeb642-903a-451c-9245-b540afcabb72@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Mar 2025 10:16:04 -0400
X-Gm-Features: AQ5f1JojNSq9Et-U5IhS9cBXbaAAFSwQyLKoWPV4_HvYsQvPR5Xgz4TWwsMTUtY
Message-ID: <CADnq5_OkrSKyu_TaYzkc5gjRq0m4_3PqujApp1NW4+2Km2accA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/gfx: fix ref counting for ring based
 profile handling
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Yang Wang <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
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

On Wed, Mar 12, 2025 at 4:19=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 3/11/2025 7:47 PM, Alex Deucher wrote:
> > Only increment the power profile on the first submission.
> > Since the decrement may end up being pushed out as new
> > submissions come in, we only need to increment it once.
> >
> > Fixes: 1443dd3c67f6 ("drm/amd/pm: fix and simplify workload handling=E2=
=80=9D)
> > Cc: Yang Wang <kevinyang.wang@amd.com>
> > Cc: Kenneth Feng <kenneth.feng@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 28 ++++++++++++++++++-------
> >  1 file changed, 21 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.c
> > index 984e6ff6e4632..90396aa8ec9f6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -2142,12 +2142,25 @@ void amdgpu_gfx_enforce_isolation_ring_end_use(=
struct amdgpu_ring *ring)
> >               amdgpu_gfx_kfd_sch_ctrl(adev, idx, true);
> >  }
> >
> > +static unsigned int
> > +amdgpu_gfx_get_kernel_ring_fence_counts(struct amdgpu_device *adev)
> > +{
> > +     unsigned int i, fences =3D 0;
> > +
> > +     for (i =3D 0; i < AMDGPU_MAX_GFX_RINGS; ++i)
> > +             fences +=3D amdgpu_fence_count_emitted(&adev->gfx.gfx_rin=
g[i]);
> > +     for (i =3D 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTA=
NCES); ++i)
> > +             fences +=3D amdgpu_fence_count_emitted(&adev->gfx.compute=
_ring[i]);
> > +
> > +     return fences;
> > +}
> > +
> >  void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work)
> >  {
> >       struct amdgpu_device *adev =3D
> >               container_of(work, struct amdgpu_device, gfx.idle_work.wo=
rk);
> >       enum PP_SMC_POWER_PROFILE profile;
> > -     u32 i, fences =3D 0;
> > +     unsigned int fences =3D 0;
> >       int r;
> >
> >       if (adev->gfx.num_gfx_rings)
> > @@ -2155,10 +2168,8 @@ void amdgpu_gfx_profile_idle_work_handler(struct=
 work_struct *work)
> >       else
> >               profile =3D PP_SMC_POWER_PROFILE_COMPUTE;
> >
> > -     for (i =3D 0; i < AMDGPU_MAX_GFX_RINGS; ++i)
> > -             fences +=3D amdgpu_fence_count_emitted(&adev->gfx.gfx_rin=
g[i]);
> > -     for (i =3D 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTA=
NCES); ++i)
> > -             fences +=3D amdgpu_fence_count_emitted(&adev->gfx.compute=
_ring[i]);
> > +     fences =3D amdgpu_gfx_get_kernel_ring_fence_counts(adev);
> > +
> >       if (!fences && !atomic_read(&adev->gfx.total_submission_cnt)) {
> >               r =3D amdgpu_dpm_switch_power_profile(adev, profile, fals=
e);
> >               if (r)
> > @@ -2174,6 +2185,7 @@ void amdgpu_gfx_profile_ring_begin_use(struct amd=
gpu_ring *ring)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> >       enum PP_SMC_POWER_PROFILE profile;
> > +     unsigned int fences =3D 0;
> >       int r;
> >
> >       if (adev->gfx.num_gfx_rings)
> > @@ -2181,15 +2193,17 @@ void amdgpu_gfx_profile_ring_begin_use(struct a=
mdgpu_ring *ring)
> >       else
> >               profile =3D PP_SMC_POWER_PROFILE_COMPUTE;
> >
> > -     atomic_inc(&adev->gfx.total_submission_cnt);
> > +     fences =3D amdgpu_gfx_get_kernel_ring_fence_counts(adev);
> >
> > -     if (!cancel_delayed_work_sync(&adev->gfx.idle_work)) {
> > +     if (!cancel_delayed_work_sync(&adev->gfx.idle_work) && !fences &&
> > +         !atomic_read(&adev->gfx.total_submission_cnt)) {
>
> Should this check be restricted to !fences &&
> !atomic_read(&adev->gfx.total_submission_cnt). If the work has already
> started execution, cancel_delayed_work_sync will wait for completion and
> will return true. In that case, it could happen that idle work would
> have already called amdgpu_dpm_switch_power_profile(adev, profile,
> false) since submission count increment is moved down.
>
> Wondering if this needs to be split like below -
>
> 1) cancel_delayed_work_sync(&adev->gfx.idle_work);
>
> 2) Take fence/submission count
>
> 3) if (!fences && !atomic_read(&adev->gfx.total_submission_cnt)

I think it will be easier with just a mutex and a flag.  Will send out
a new patch set momentarily.

Alex

>
> Thanks,
> Lijo
>
> >               r =3D amdgpu_dpm_switch_power_profile(adev, profile, true=
);
> >               if (r)
> >                       dev_warn(adev->dev, "(%d) failed to disable %s po=
wer profile mode\n", r,
> >                                profile =3D=3D PP_SMC_POWER_PROFILE_FULL=
SCREEN3D ?
> >                                "fullscreen 3D" : "compute");
> >       }
> > +     atomic_inc(&adev->gfx.total_submission_cnt);
> >  }
> >
> >  void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring)
>
