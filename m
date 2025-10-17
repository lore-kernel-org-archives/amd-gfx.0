Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDADCCD199
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 13:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A586410EC09;
	Fri, 17 Oct 2025 13:31:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BxBf/ZeC";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACD7710EC08
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 13:31:47 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-290aaff26c1so5047595ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 06:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760707907; x=1761312707; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMCe/qXjTa5PfYMI4WndR0T/7mhwa+7d9WpVETEC25Y=;
 b=BxBf/ZeCQaqxJcJ859O+N9zK/V3+V/06xkDgMa+DDtlpNHCXIfdKJesgr+fMSZLCsT
 vv/FgkgEpFyrOSbIq2hTzKPEYlKhbnS7N4rDOz86eSH4an9D7yv+0gzWVzq5cX1RgHPJ
 ntWIuXKURghKWwBON8gjKEvHVXuh0BhVFvam6zYgObFR5UAIjMKF0KdqarmxULgUJrW7
 ciko6nJ4Dq3Gd4ds8ZqjYVCrfzvQVlaRQnxw6Ap+VKqqtSByQCoVs+FMm5P9lwlVu11g
 mNoruU0sjfJ244/JU77PgwMIvc8xvLXdy+lMn6e87LcCi7zcT+jPtgJiLgoNIvzkH0g0
 4Efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707907; x=1761312707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WMCe/qXjTa5PfYMI4WndR0T/7mhwa+7d9WpVETEC25Y=;
 b=kULLI2LT3Iia0GTFHRAJWzYcPjdBf9sPjnhOtxlMzJY1wNeeGOzgzfjX+tZBfscbsF
 eh3MpcSbVh+QhP710P8hv3mbPWcZqTn3801nX5D3EjSDuH5vmlf3WTLjZILpz27G5cSw
 dSRF7KBa7IVReYp57KB8cp2T9j1ZEtGjCbP9ONG1t+S8hI4i3R1pjHGK830c1c0KLo2M
 EUGbjTrGULUps0EHTqMiOW7xocMASpRRyZ1yUVOPvMFwP1GDdDrt9d2zAQ/z9bjGgCF4
 9XsWx/aYwK/MB87/3T8EKCDBn8lxpx/LKupRKWR4d/gZQMbclx5+Y4rPfB+emSP7iQQN
 n4qw==
X-Gm-Message-State: AOJu0Yz80CT0TcRveLEcQWzjveE9DfUCNUIWvUJDqF88wv/39dzeAoKn
 Tkb3vf4Uy7Vv6kJcKuxFkcy86ecNfbN5WEW3RW3h8aW7yecKbV/2chUuF6Zm7ZhT5qyOlBtCmRD
 UCTkWeckntmfqWadLKnMldcXgWHf5Eu8=
X-Gm-Gg: ASbGnctnjXb2sqU8GrEdPql2sgbrOIRSrA/Ic5+4JoNRsQxrwaONZ1gAAR6A+1J0CUk
 QyzMJTZtPwWpZiioQenYuMlIA4pFhwksbPtvfaH/lwGPe7FsH4zMEl1nhqla/mhdkBrO6I59k0w
 hO0JMaXElEvqxVxrVMwS5+gaihoLrNC5If1JQT8rb4x5Oxk2hQpkM5Sc6Lpl+Pv3FaA/tgfryGt
 d/acGUCZiSkMWWDTUVkMXKq5671hv9LoB+g7BGI7Xd5Lf5/uPKVSDlEWzrG
X-Google-Smtp-Source: AGHT+IG4UE600zJpUFXP4fD6ca5DrsimNqxFlyFmAxmqjyqAOgL7ecvbIrfnIDOD0MrFAvEbU3QLlVgdV6kDkepNVfM=
X-Received: by 2002:a17:903:b8f:b0:290:c5c5:57e6 with SMTP id
 d9443c01a7336-290c9cff139mr25512575ad.3.1760707907095; Fri, 17 Oct 2025
 06:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20251016023644.3143128-1-kevinyang.wang@amd.com>
 <CADnq5_OaJavuQf=LgBzQKAXmCxoZMnUwXAOgo-NV=toY4qawXw@mail.gmail.com>
 <PH7PR12MB5997FD7FA4EAC7170FAC368082F6A@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB5997FD7FA4EAC7170FAC368082F6A@PH7PR12MB5997.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Oct 2025 09:31:35 -0400
X-Gm-Features: AS18NWD0oyVtKlpRRbGRBXTFewFrSLzkL0uNd5n8AVokH1MC0x_b9QVzzUH34dM
Message-ID: <CADnq5_Op9Kn0j6-wzrrt0L7CpMTxZK0iwTzjDomZQbPKhC7twA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: fix missed lock in
 amdgpu_gfx_profile_ring_begin_use()
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
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

On Fri, Oct 17, 2025 at 9:23=E2=80=AFAM Wang, Yang(Kevin)
<KevinYang.Wang@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Friday, October 17, 2025 2:55 AM
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>=
; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amd/amdgpu: fix missed lock in amdgpu_gfx_profil=
e_ring_begin_use()
>
> On Wed, Oct 15, 2025 at 11:26=E2=80=AFPM Yang Wang <kevinyang.wang@amd.co=
m> wrote:
> >
> > the gfx driver need to hold lock (adev->gfx.workload_profile_mutex)
> > before access "adev->gfx.workload_profile_active" varible.
> >
> > Fixes: 9e34d8d1a1abe ("drm/amdgpu/gfx: adjust workload profile
> > handling")
> >
> > Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > index 7f02e36ccc1e..59329e8ffb86 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -2249,11 +2249,10 @@ void amdgpu_gfx_profile_ring_begin_use(struct a=
mdgpu_ring *ring)
> >          * the delayed work so there is no one else to set it to false
> >          * and we don't care if someone else sets it to true.
> >          */
> > -       if (adev->gfx.workload_profile_active)
> > -               return;
>
> Per the comment above, this should be safe.
>
> Alex
>
> [Kevin]:
> All gfx/compute kernel ring->begin_use/end_use() callback functions will =
be called at the same time from different threads (such as drm sched thread=
 and ioctl user thread)
> there may still be some contention here, holding this lock can ensure saf=
e access in different scenarios.

There's only one worker thread and that is the only place this gets
set to false.  That worker is always cancelled just before this check
so there should be no race.  All of the places where the value is
changed are locked.

Alex

>
> Best Regards,
> Kevin
>
> > -
> >         mutex_lock(&adev->gfx.workload_profile_mutex);
> > -       if (!adev->gfx.workload_profile_active) {
> > +       if (adev->gfx.workload_profile_active) {
> > +               goto out_unlock;
> > +       } else {
> >                 r =3D amdgpu_dpm_switch_power_profile(adev, profile, tr=
ue);
> >                 if (r)
> >                         dev_warn(adev->dev, "(%d) failed to disable %s
> > power profile mode\n", r, @@ -2261,6 +2260,8 @@ void amdgpu_gfx_profile=
_ring_begin_use(struct amdgpu_ring *ring)
> >                                  "fullscreen 3D" : "compute");
> >                 adev->gfx.workload_profile_active =3D true;
> >         }
> > +
> > +out_unlock:
> >         mutex_unlock(&adev->gfx.workload_profile_mutex);
> >  }
> >
> > --
> > 2.34.1
> >
