Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D31C282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 13:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB40610E980;
	Fri, 14 Mar 2025 13:00:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aoGsZWEp";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EDA010E980
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 13:00:26 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2241c95619eso5297495ad.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 06:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741957224; x=1742562024; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nl49pb5YkM4fQ6ztEAajhR6ESmbBVwTbcnrAyoXYeqw=;
 b=aoGsZWEpcCmOKsU2fueIUllj7+aZjVqzIHPMEJt4+wSJHDaAPyDCQgz9k+J7qTzvDG
 S0ycfKuVqiXf9atTJnaHiRdCic4hW3VXeJpAjSYjI8aSJnupTHGfwjUoPg1SmMRZSk1R
 5yRDK0PoClB81u6i3sxwoNaAeRB1mgiZWEx09uTvTPnqzFX+Hz2F4VenP07GXgKiE28+
 EQQKhG4vFEPdWzthHApztB8Uq8bEodgt/THdFthO6LlNFuACU/+bthCPhxi7x6Es63FR
 K6Y4Fq4Ay04NsxDrsMve8k5d7GfwK2tsNpjn/Eeq5W/Nhr9Rn57x+V76XLfLLksG43nT
 4rlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741957224; x=1742562024;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nl49pb5YkM4fQ6ztEAajhR6ESmbBVwTbcnrAyoXYeqw=;
 b=w3RN0l2rEWU2OWL8d0mX2iEj49qFF2pa8ePxYxWxkwU9fUUTT1XCzNDhBtd5E7y4zt
 Y8EVi1UGUNmcA2SIHhq6jFAqXFjQTRaCvQq44AvtQ6+/QgTDn209TyWhVLid5IfwJwfK
 p8entKnEPTMh+VESTO4f1SkmqmsINCSJ7PDIHQT+Jg7KZnZUJkNi9YVHjqG6wi7B/P0L
 NSr7MZ+3OCENzhhOykW+RYeTmXIYdh+O7sDTDGEhBz4PWcen3dISfidLzY6Ht5zn2SCN
 GW2f2bqoOEQvRcMRwwfekyGM84Ip017GcHihoohtXTReQjFk1zM07Q66dt82B8n0335t
 XgVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrWyxNR8zOZssfyWHi0UIGZWySiST4i8wRXWGTbTayTQJJ3NC7MX/ri3kwc03e5Z0b5OpFc2Uk@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyD/aHQ5lvq2kdu/tCfBWMXPHJxZJY2cSGDgHeSIIohZIrmCj9v
 8M3hOSnnMWfgh5tnPXO174KxRlkRF8BGkeV9WDobSbCzeeerxiYndTGjrn5Cb2yM4bYxN9dz4Y/
 +iNHzU8bEPPa5KFFaueeKvMjvVC5+pg==
X-Gm-Gg: ASbGncsOwQTJTmifF/eypT1m6vOP92BuKKnj6VnXRHtypLz+7kIM37S8CzSdXes/Kdm
 QfgH6n2s5oY5Gs/nXvRlo+eNluFEFWEaucy9gLWY2SplgYfdwNfPpO1l/j40Pu0ffSM/72mxy4w
 5DRaN0pXTpvdvJMa6R199vs5n25vJR3M+AVKw7
X-Google-Smtp-Source: AGHT+IGPNBsITSew1p++gwJSM7EnBJ2MKJabfJgJ6dLmfsI94a8uCnVNRo7fbwCQv9n0yDKYu6O7+/oKpfR0Qug4pNE=
X-Received: by 2002:a17:903:f86:b0:224:18fd:6e09 with SMTP id
 d9443c01a7336-225e08602a8mr12554705ad.0.1741957223977; Fri, 14 Mar 2025
 06:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250312141912.10994-1-alexander.deucher@amd.com>
 <d15f3b87-f6c5-4c5a-b7e0-e5570691d3ff@amd.com>
In-Reply-To: <d15f3b87-f6c5-4c5a-b7e0-e5570691d3ff@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Mar 2025 09:00:12 -0400
X-Gm-Features: AQ5f1Jp2W8IcGhhb5OigfujSZKntotElVtGXAtEWwGtHkjhW6eTBXNUqVra3RKw
Message-ID: <CADnq5_NZ+YY2LR=5e7sgtxK+4ohxYZ1bd8FvNpn_QAqVp7u5uw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] drm/amdgpu/gfx: fix ref counting for ring based
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

On Fri, Mar 14, 2025 at 6:31=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 3/12/2025 7:49 PM, Alex Deucher wrote:
> > We need to make sure the workload profile ref counts are
> > balanced.  This isn't currently the case because we can
> > increment the count on submissions, but the decrement may
> > be delayed as work comes in.  Track when we enable the
> > workload profile so the references are balanced.
> >
> > v2: switch to a mutex and active flag
> >
> > Fixes: 8fdb3958e396 ("drm/amdgpu/gfx: add ring helpers for setting work=
load profile")
> > Cc: Yang Wang <kevinyang.wang@amd.com>
> > Cc: Kenneth Feng <kenneth.feng@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 30 ++++++++++++++++---------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
> >  2 files changed, 22 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.c
> > index 984e6ff6e4632..099329d15b9ff 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -2160,11 +2160,16 @@ void amdgpu_gfx_profile_idle_work_handler(struc=
t work_struct *work)
> >       for (i =3D 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTA=
NCES); ++i)
> >               fences +=3D amdgpu_fence_count_emitted(&adev->gfx.compute=
_ring[i]);
> >       if (!fences && !atomic_read(&adev->gfx.total_submission_cnt)) {
> > -             r =3D amdgpu_dpm_switch_power_profile(adev, profile, fals=
e);
> > -             if (r)
> > -                     dev_warn(adev->dev, "(%d) failed to disable %s po=
wer profile mode\n", r,
> > -                              profile =3D=3D PP_SMC_POWER_PROFILE_FULL=
SCREEN3D ?
> > -                              "fullscreen 3D" : "compute");
> > +             mutex_lock(&adev->gfx.workload_profile_mutex);
> > +             if (adev->gfx.workload_profile_active) {
> > +                     r =3D amdgpu_dpm_switch_power_profile(adev, profi=
le, false);
> > +                     if (r)
> > +                             dev_warn(adev->dev, "(%d) failed to disab=
le %s power profile mode\n", r,
> > +                                      profile =3D=3D PP_SMC_POWER_PROF=
ILE_FULLSCREEN3D ?
> > +                                      "fullscreen 3D" : "compute");
> > +                     adev->gfx.workload_profile_active =3D false;
> > +             }
> > +             mutex_unlock(&adev->gfx.workload_profile_mutex);
> >       } else {
> >               schedule_delayed_work(&adev->gfx.idle_work, GFX_PROFILE_I=
DLE_TIMEOUT);
> >       }
> > @@ -2184,11 +2189,16 @@ void amdgpu_gfx_profile_ring_begin_use(struct a=
mdgpu_ring *ring)
> >       atomic_inc(&adev->gfx.total_submission_cnt);
> >
> >       if (!cancel_delayed_work_sync(&adev->gfx.idle_work)) {
>
> I guess this has the same problem as mentioned in the earlier patch.
> AFAIU, this will switch profile only if no idle work is scheduled. If a
> begin_use call comes when idle_work is being executed, there is a chance
> that idle_work completes amdgpu_dpm_switch_power_profile(adev, profile,
> false). Then this would skip changing the profile.

I think that problem exists already independent of the ref counting.
I suppose there isn't actually a need to make the workload change
dependent on the cancelling of the delayed work.  I'll send out some
patches to address this.

Alex

>
> Thanks,
> Lijo
>
> > -             r =3D amdgpu_dpm_switch_power_profile(adev, profile, true=
);
> > -             if (r)
> > -                     dev_warn(adev->dev, "(%d) failed to disable %s po=
wer profile mode\n", r,
> > -                              profile =3D=3D PP_SMC_POWER_PROFILE_FULL=
SCREEN3D ?
> > -                              "fullscreen 3D" : "compute");
> > +             mutex_lock(&adev->gfx.workload_profile_mutex);
> > +             if (!adev->gfx.workload_profile_active) {
> > +                     r =3D amdgpu_dpm_switch_power_profile(adev, profi=
le, true);
> > +                     if (r)
> > +                             dev_warn(adev->dev, "(%d) failed to disab=
le %s power profile mode\n", r,
> > +                                      profile =3D=3D PP_SMC_POWER_PROF=
ILE_FULLSCREEN3D ?
> > +                                      "fullscreen 3D" : "compute");
> > +                     adev->gfx.workload_profile_active =3D true;
> > +             }
> > +             mutex_unlock(&adev->gfx.workload_profile_mutex);
> >       }
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.h
> > index ddf4533614bac..75af4f25a133b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > @@ -483,6 +483,8 @@ struct amdgpu_gfx {
> >
> >       atomic_t                        total_submission_cnt;
> >       struct delayed_work             idle_work;
> > +     bool                            workload_profile_active;
> > +     struct mutex                    workload_profile_mutex;
> >  };
> >
> >  struct amdgpu_gfx_ras_reg_entry {
>
