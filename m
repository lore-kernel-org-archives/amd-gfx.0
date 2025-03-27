Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF41C3600B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 14:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3AB210E107;
	Thu, 27 Mar 2025 14:09:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J8i1GIV3";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1774410E107
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 14:09:13 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2ff6ce72844so218253a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 07:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743084552; x=1743689352; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uc9ZX9N+CRkI3KDM6oNtoXLUR4IRkgwqIiGq/haiCXk=;
 b=J8i1GIV3tYvuCRa79rjFNO8Qkb5L5ITHQ+OflpjlCaeTQtYyHCNFeNSwgpJ5XxlruO
 6z14eHzROk1Z0dA+1P7VKeB5vx/blAZiDHSgNJtNkVKhfEAiPW50Er1QE/Y8WAdfmfQL
 yAsRdzBZeys45TZ12hqPkELuO+fTSwHpm4bMfRLPNhNv6PtvP3v/au6rBU2NUIyjMORQ
 C6cVLUWYfBrKfL3CS/R3KpZQe4uJtRIYzlQUI4dIQJKSI/IzpYP9sImmK5To7LQq8WCE
 8EhYaiEnxbsRT4CMk6tTzTLlkt9Xzb532f8O920k8WnNwSh5uDPvcZaJ8eFk/gp1HqJk
 QLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743084552; x=1743689352;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uc9ZX9N+CRkI3KDM6oNtoXLUR4IRkgwqIiGq/haiCXk=;
 b=p82LsRrlLBJxwnRnZ6ffmLtiaqnLnebM9A+Y4CWg5kUOTgp22Yp2zMRnEaA+tctz1c
 NLgwyj8EJrnVeqFO2MPFi0LyiHglmrDjgch5Lb181KGw8eVzA5WU2ftK+l3pcKvyZ7Y8
 T1EEXGJUz0scMq53Z1FH9UzFMU38G8M4ArJY0LtA9IoayeaCxklKQ4bCejF1mH4z06rC
 LH3ht9zs+oR+xU2WbcmySTNw3HCGFDO0uwViaxeANYX68WeO7kSuDEnQt7wP3UycQjdY
 tDtlSkYhFujEmFWyLdZNnNB6FT/rEwsI7Jr4gmI2ulcEIbxnJAmbrAGy3bp8FM/IYdsB
 grEg==
X-Gm-Message-State: AOJu0Yz4m74r4eUnuPLvxAtGF1KmXzced695vUjeiS17hcIwK52uiuvh
 9qSAPNtj2Ha+B+5+/ASLWuCVf0+xbPteTzHgvzn2GQ9bXsKwRqcGx8phWSrsnFGqJTWXcI/qCJN
 Q+pKLt2RRk8MuQKbhy63a2UmXmoI=
X-Gm-Gg: ASbGncsfX6+IbPwF9qT1yonDglq9u8PzVpi1ju4uTMy0JQhXApO/hxrMTr7CpGdmksu
 SkD3xGeLAgfE47mqNPVz2vA76po5Vnsrmq1EX/qCvVThMBSISMpEBW/iBLxK+fQI5NuZeNr1KbL
 rtidY+LbxvvFw8hdGoYzUivZlqOw==
X-Google-Smtp-Source: AGHT+IHSUp95M319fGlqLC61W61BM/rSf0TuKEcNinYv29a7JTMyT6373pOlt9TD+HL3KvE6gp1WCTJGwqdIHMt69/4=
X-Received: by 2002:a17:90b:4d08:b0:2ff:682b:b754 with SMTP id
 98e67ed59e1d1-303a7d56faemr1920516a91.2.1743084551453; Thu, 27 Mar 2025
 07:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250326045650.770578-1-kenneth.feng@amd.com>
 <CADnq5_PL8twwX9CMNBKMdyso5U+G_8P4MLXpBTFOoHXZxMOigw@mail.gmail.com>
 <DM4PR12MB51655AC13B9C27F262EB03608EA12@DM4PR12MB5165.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51655AC13B9C27F262EB03608EA12@DM4PR12MB5165.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Mar 2025 10:08:59 -0400
X-Gm-Features: AQ5f1JqAl3UO2qNE3brUX8BXDHv48iGNoy_vnfNNKOCx5u1U2gSL72ZceXzAeWo
Message-ID: <CADnq5_POhj-+8vHCVqek+wUw6DW+J+aMsX6FBUSwfy6h+rhAVg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: port the workload profile setting logic
 into dm
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>
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

On Thu, Mar 27, 2025 at 4:22=E2=80=AFAM Feng, Kenneth <Kenneth.Feng@amd.com=
> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, March 26, 2025 11:08 PM
> To: Feng, Kenneth <Kenneth.Feng@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wentland, Harry <Harr=
y.Wentland@amd.com>
> Subject: Re: [PATCH] drm/amd/display: port the workload profile setting l=
ogic into dm
>
> Caution: This message originated from an External Source. Use proper caut=
ion when opening attachments, clicking links, or responding.
>
>
> On Wed, Mar 26, 2025 at 1:22=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.co=
m> wrote:
> >
> > Port the workload profile setting logic into dm before MALL optimizatio=
n.
> >
> > Background:
> > MALL optimization strategy has changed in the firmware.Previously,
> > firmware does not care what workload type it is, once there is a
> > request from DAL for MALL, firmware immediately trigger the MALL settin=
g sequence on the SoC, so called D0i3.x idle power sequence.
> > Now, before the D0i3.x sequence starts, firmware always check if the
> > workload type is default, if it is not, then abort the D0i3.x sequence.
> >
> > Issue:
> > Due to this strategy change, the task is moved to driver to make sure
> > if gfx is really idle and if it is, reset the workload to default.
> > Without this task, when DAL's work task for MALL optimization tries to
> > do the optimization request to DMCUB->pmfw, the workload type is always=
 3D fullscreen or compute, then MALL will never be applied.
> >
> > Why:
> > The idle task for setting workload type back to default interval is 1
> > second currently. The DAL's work task to optimize MALL always starts
> > before the idle task for setting workload type back to default. There
> > is no way to ask the idle task in the base driver to reset the
> > workload type ahead of the DAL's MALL setting work task kicks off. Ther=
e could be a workaround which sets the idle task interval to 10 millisecond=
. However, this causes some call trace issues in which the workqueues is fl=
ushed.
>
> That should already fixed by this commit:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Dde35994ecd2dd6148ab5a6c5050a1670a04dec77
>
> >
> > Side effect:
> > This solution is to port the logic in idle thread to DAL: check the
> > fence and make sure gfx is idle, then reset the workload type. It is
> > fine that when DAL's work task exits the MALL optimization, it does not=
 set back the workload type to 3d fullscreen or compute since the work task=
 in base driver can make sure the workload type can be set back once there =
are jobs in the ring.
>
> I guess this works because the workload ref count gets clamped to 0, but =
this call is not balanced.  It also doesn't handle the VIDEO profile that g=
ets set when using VCN or the COMPUTE profile when KFD queues are active.  =
Those would also prevent the idle optimizations.
> Also what happens if the profile changes after DC optimizations are enabl=
ed?  Does that cause the optimizations to exit or will they stay intact unt=
il DC tells it to exit?
>
> So I think we have two options:
> 1. always disable the 3D, compute, video profiles when entering the DAL o=
ptimization. subsequently, additional job submissions may change the worklo=
ad.  will that be a problem?
> 2. Add a helper to pause workload profiles while the DC optimization is a=
ctive.  If the profile only has to be changed while enabling the DC optimiz=
ation, we can just call it right before and right after the dc optimization=
s.  Something like the attached patches should be a good starting point.
>
> Alex
>
> Hi Alex,
> In the attached patch, I guess smu->pause_workload is not needed since wo=
rkload can be switched after idle optimization is triggered. And smu_pause_=
power_profile may not need the bool flag since I still think that we don't =
need to take care of the imbalance of workload setting.
> That is said, we just need to set the workload to default when idle optim=
ization is requested. When the idle optimization is cancelled from DAL, it =
doesn't need to restore the previous workload setting since the ring work w=
ill set it.
> Attached is my patch. It works on my system. Let me know your thoughts.

This will race with any command submissions unless you add a lock.  I
think you want something like:

/* switch to the bootup default profile */
amdgpu_dpm_pause_power_profile(adev, true);
dc_allow_idle_optimizations(dm->dc, true);
/* resume existing profiles */
amdgpu_dpm_pause_power_profile(adev, false);

Alex

> Thanks.
>
> Kenneth
>
> >
> > Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> > ---
> >  .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 29 ++++++++++++++++++-
> >  1 file changed, 28 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > index 36a830a7440f..2adb3b72ed05 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > @@ -244,6 +244,20 @@ static void amdgpu_dm_crtc_vblank_control_worker(s=
truct work_struct *work)
> >         struct vblank_control_work *vblank_work =3D
> >                 container_of(work, struct vblank_control_work, work);
> >         struct amdgpu_display_manager *dm =3D vblank_work->dm;
> > +       u32 i, fences =3D 0;
> > +       int r;
> > +       enum PP_SMC_POWER_PROFILE profile;
> > +       struct amdgpu_device *adev =3D drm_to_adev(dm->ddev);
> > +
> > +       if (adev->gfx.num_gfx_rings)
> > +               profile =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> > +       else
> > +               profile =3D PP_SMC_POWER_PROFILE_COMPUTE;
> > +
> > +       for (i =3D 0; i < AMDGPU_MAX_GFX_RINGS; ++i)
> > +               fences +=3D amdgpu_fence_count_emitted(&adev->gfx.gfx_r=
ing[i]);
> > +       for (i =3D 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INS=
TANCES); ++i)
> > +               fences +=3D
> > + amdgpu_fence_count_emitted(&adev->gfx.compute_ring[i]);
> >
> >         mutex_lock(&dm->dc_lock);
> >
> > @@ -271,8 +285,21 @@ static void amdgpu_dm_crtc_vblank_control_worker(s=
truct work_struct *work)
> >                         vblank_work->acrtc->dm_irq_params.allow_sr_entr=
y);
> >         }
> >
> > -       if (dm->active_vblank_irq_count =3D=3D 0)
> > +       if (dm->active_vblank_irq_count =3D=3D 0) {
> > +               if (adev->gfx.num_gfx_rings && !fences && !atomic_read(=
&adev->gfx.total_submission_cnt)) {
> > +                       mutex_lock(&adev->gfx.workload_profile_mutex);
> > +                       if (adev->gfx.workload_profile_active) {
> > +                               r =3D amdgpu_dpm_switch_power_profile(a=
dev, profile, false);
> > +                               if (r)
> > +                               dev_warn(adev->dev, "(%d) failed to dis=
able %s power profile mode\n", r,
> > +                                                                      =
 profile =3D=3D PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
> > +                                                                      =
 "fullscreen 3D" : "compute");
> > +                               adev->gfx.workload_profile_active =3D f=
alse;
> > +                       }
> > +                       mutex_unlock(&adev->gfx.workload_profile_mutex)=
;
> > +               }
> >                 dc_allow_idle_optimizations(dm->dc, true);
> > +       }
> >
> >         mutex_unlock(&dm->dc_lock);
> >
> > --
> > 2.34.1
> >
