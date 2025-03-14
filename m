Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC016C282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 14:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7416010EA00;
	Fri, 14 Mar 2025 14:58:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="msxpdV2g";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C10610EA00
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 14:58:22 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2ff5f2c5924so471265a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 07:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741964302; x=1742569102; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iz574TpwXMl7Rpi0uHBYvLo2hfXNWAxV18dznlnaT3U=;
 b=msxpdV2gvLmkK7RCNxspU5MF7Vf2Ig9gG8WZ+jq4/5VFCk+1gtPvHoVfS5bQd0JEP1
 2I0v7MMrCFHKUa3fqoqx+BhWI2V2yhtgJjuLq+GxcmCK07vot3KhUFpWpff5XOZy9Lez
 vwZxoQEXPi4GZ3AfdgtIpoqvtbltHLUt5tSTDgCAVsV7VKOPbkdij09OvkcgmpCE4BSi
 9QxlX+WWX7rawSkc2OqM/JPmaxZwTAqNEsVhmb5AJY6dXQngf5VtLKh+ra+ExiaIIH9/
 dOQ5Kde0wQ75FMBOJqyCr1zwn9B9RqHhjrnRoT0A1nuyv0JG5gDdXv3rNfg7OSfGdTOe
 hjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741964302; x=1742569102;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iz574TpwXMl7Rpi0uHBYvLo2hfXNWAxV18dznlnaT3U=;
 b=dlwDXDMOOCt1g68hgCg8/W+3+p6ROhndpuYE70sAkh6RNCIZILr5ZHig7WhT/WtIs2
 QVGCX+Ues1/W7pQeifz2w9196ocq8bVCF+uY/H/EoiwIDOmwHmWuNSDPdYuaSBU8AwMz
 k8QClKhLGkZzaB+6xaTc9vH+Lh0GO5TpVyOfnZty9hSqgA1EoX3Vp4oT5PiUkzaTKYR3
 GTEHN4Rgo044WsugIKo2YmWcmzZgCqdieo8Y7pLIPjuAsa4rDPZxruRV0DKJb6bPytTr
 tbZW7w/AgGnffSIaMBzTKAmvVR6kodc8IFMAF5hxmJGCchPjSth8hZSs/TAOl2Nm6+WA
 FYng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfXzuJyfSjIoIHeRXU/58643WI286A6CMMNS4hQKphsQug0pw+QNVZ5aPZ5UWdJy6VGu2V/Z8M@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzuwzGDab+aoh6dIXmgVi0lv6/aUDcNOQKOP8VLK50ffYhssOlo
 rkA4CoPPXZmuKykn+EcoLFoZqfFCSFt7E/9VQL8sYkJ2qRuhVIjmmoi1KtPPSfz+M4BaYf910xI
 wfO+hQtBTi7sOave2mNTgZZVz5npFZA==
X-Gm-Gg: ASbGncsYwQN2cgdv1N9zugSbSDDsK7Wu/BnM2hoY1zsJtosQGHWFVoFqiv3Aj7vDnRX
 TMrKiUKdO7zdSkRMhjqFVwn0HtGzod+Bt76ExnFyeBbjxbtuE2EfMa4ROkBRI10jFmmPlP3vO71
 B+uxNCKMu4VFbSmzXZ2mKuoSrPrw==
X-Google-Smtp-Source: AGHT+IFtvF61lfOAQ+4kwI81dcKygjFGvzeMsQ3MYvIqQI5Se6N/zWdYJwetluYhJH7P4Z2YsapheRKLgner7GpMS2w=
X-Received: by 2002:a17:90b:38ce:b0:2ff:6666:529d with SMTP id
 98e67ed59e1d1-30151d6e1demr1437121a91.6.1741964301813; Fri, 14 Mar 2025
 07:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250314134707.3012124-1-alexander.deucher@amd.com>
 <bc45f314-3720-49c3-a836-b409f8b89595@amd.com>
In-Reply-To: <bc45f314-3720-49c3-a836-b409f8b89595@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Mar 2025 10:58:09 -0400
X-Gm-Features: AQ5f1JoY-X359FmmgfE30awz_hxtu54PVevOeg_a7EsiSy9FhJSq7oyiSET7oTo
Message-ID: <CADnq5_PA5KnsBN5vJeq+K22bKwYSut13e6sdy2s_f5=yS78ygA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/gfx: adjust workload profile handling
To: "Lazar, Lijo" <lijo.lazar@amd.com>
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

On Fri, Mar 14, 2025 at 10:53=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 3/14/2025 7:17 PM, Alex Deucher wrote:
> > No need to make the workload profile setup dependent
> > on the results of cancelling the delayed work thread.
> > We have all of the necessary checking in place for the
> > workload profile reference counting, so separate the
> > two.  As it is now, we can theoretically end up with
> > the call from begin_use happening while the worker
> > thread is executing which would result in the profile
> > not getting set for that submission.  It should not
> > affect the reference counting.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.c
> > index 099329d15b9ff..20424f8c4925f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -2188,18 +2188,18 @@ void amdgpu_gfx_profile_ring_begin_use(struct a=
mdgpu_ring *ring)
> >
> >       atomic_inc(&adev->gfx.total_submission_cnt);
> >
> > -     if (!cancel_delayed_work_sync(&adev->gfx.idle_work)) {
> > -             mutex_lock(&adev->gfx.workload_profile_mutex);
> > -             if (!adev->gfx.workload_profile_active) {
> > -                     r =3D amdgpu_dpm_switch_power_profile(adev, profi=
le, true);
> > -                     if (r)
> > -                             dev_warn(adev->dev, "(%d) failed to disab=
le %s power profile mode\n", r,
> > -                                      profile =3D=3D PP_SMC_POWER_PROF=
ILE_FULLSCREEN3D ?
> > -                                      "fullscreen 3D" : "compute");
> > -                     adev->gfx.workload_profile_active =3D true;
> > -             }
> > -             mutex_unlock(&adev->gfx.workload_profile_mutex);
> > +     cancel_delayed_work_sync(&adev->gfx.idle_work);
> > +
>
> To avoid locking/unlocking mutex for each begin_use, I think here we
> could do like
>
> if (adev->gfx.workload_profile_active)
>         return;

But that is what the mutex is protecting.

Alex

>
> Thanks,
> Lijo
>
> > +     mutex_lock(&adev->gfx.workload_profile_mutex);
> > +     if (!adev->gfx.workload_profile_active) {
> > +             r =3D amdgpu_dpm_switch_power_profile(adev, profile, true=
);
> > +             if (r)
> > +                     dev_warn(adev->dev, "(%d) failed to disable %s po=
wer profile mode\n", r,
> > +                              profile =3D=3D PP_SMC_POWER_PROFILE_FULL=
SCREEN3D ?
> > +                              "fullscreen 3D" : "compute");
> > +             adev->gfx.workload_profile_active =3D true;
> >       }
> > +     mutex_unlock(&adev->gfx.workload_profile_mutex);
> >  }
> >
> >  void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring)
>
