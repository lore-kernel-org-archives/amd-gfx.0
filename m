Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455BBC28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 13:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E26F310EA14;
	Fri, 28 Mar 2025 13:27:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cahCSsA6";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85D9F10EA14
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 13:27:35 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2ff67f44fcaso535380a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 06:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743168455; x=1743773255; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6phKcwwA7rDcDlsheU0FazxANtcKzYoGE7av43xk/dg=;
 b=cahCSsA67mxX0PG6a4F4fxGuFjxDVUpRa85byVp22fRhagFqbZKOQzpWkVjVS6vEP5
 kbMtUtv3EURkbSD7uW9rWwIZz+LCtaqfAVDz7d3tw63XzGmQhXoAxk5Meh8tuA52QnwR
 YLlbvOvpUIMdaPx7s9XYp1Rh/NUyQYZKPqiF7NGImzX1/YhaEHI9yd9WAWrLz8p4R6Ba
 0SrPlZ8raj11ySrchVlMe90csLX6XZ2Z2T4qt28ZNiTh881YxkwZl3pyAkGrkJpKJdt+
 e4LU6WvzObtYevNsIuc2jbO5hlXtM+8V/aAK+YGV+HRaxtpVMf29uSnAXgjxeM8PrC50
 rTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743168455; x=1743773255;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6phKcwwA7rDcDlsheU0FazxANtcKzYoGE7av43xk/dg=;
 b=QuBbnCi9KyiFpZQ7gNokhbiE2euch6lnlsOaqu88ntRBRlM8gN685JC/nomOfisihC
 YQWFpZ9BjzEs6hhyOTWHviG7UEefDR9ABpOBvkm44+odGr1JAC+J+qSN1mB/QmiYcWZd
 U1mL1lh1Pt0AcPubo7fRb+RgKNtL0V8fPyJNtVSBL2UXh5i5n6qmJj2aMPdQp/IeWU8F
 C9gjXhThn/wdxABtaWLDTXd1S7+mQH0MN5OtuJxIF3rPjfWi6rjKOgX+mc6vB+YxIxF5
 bEz3q8lByopI7xpvwKNAJ6p+xpFJNcea1Fuh/AfY3A1ZhnjXyiT2HhHl2MVUZHMR5/kA
 TBKA==
X-Gm-Message-State: AOJu0YyUl7cGOsB4BwrpnaoTUlR+hNzdb/PTS6BcdA4UQ9K1XnZIdRO4
 ZBfYNcqdXqbREw61LKwCFFRVJURqvD/DuIb7XDLPJenxLGyDVU9rBBg3HEARgWsAbtLDvlFZNAn
 3yiNyxzDmgj/cOKQP47vraXcMyoH+IQ==
X-Gm-Gg: ASbGncsms20S5/DXX4muuxeYyQwAu6IXtdhnB7R7t2BgnTpwunquy1BKrB/pdVIBmQM
 ceeqjN6T0BIyQzsOZAIO5+WPc8TpBotZLxRaYWkQ+uEp8S+txJ/Zi949hSHVuSql8jrW4kfgTPV
 F2WOqKZtfMjLQmoQdu2DF+cTAkiQ==
X-Google-Smtp-Source: AGHT+IFYN0vXbmKcArurzscLNVLFH6O7icWTDofoX8d6uyUfPMC3jR00+Ja1lqqdSelG0bZnJGZSK7ei1OGRVRoP6gg=
X-Received: by 2002:a17:90b:4a02:b0:2fa:6055:17e7 with SMTP id
 98e67ed59e1d1-303b279c933mr3843651a91.8.1743168454791; Fri, 28 Mar 2025
 06:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250326045650.770578-1-kenneth.feng@amd.com>
 <CADnq5_PL8twwX9CMNBKMdyso5U+G_8P4MLXpBTFOoHXZxMOigw@mail.gmail.com>
 <DM4PR12MB51655AC13B9C27F262EB03608EA12@DM4PR12MB5165.namprd12.prod.outlook.com>
 <CADnq5_POhj-+8vHCVqek+wUw6DW+J+aMsX6FBUSwfy6h+rhAVg@mail.gmail.com>
 <DM4PR12MB516500FD3B6395D51C50134D8EA02@DM4PR12MB5165.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB516500FD3B6395D51C50134D8EA02@DM4PR12MB5165.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Mar 2025 09:27:22 -0400
X-Gm-Features: AQ5f1Jr0xRET1OvtHDWJYkyJciRV2NjPrxCJMhbTGrfA2J7lSeOnumDmmPYWirg
Message-ID: <CADnq5_OZdwn=BxvgFDhUvgaJmSuV_pi_6Odh5FNQfHL3GHW=iw@mail.gmail.com>
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

On Thu, Mar 27, 2025 at 10:37=E2=80=AFPM Feng, Kenneth <Kenneth.Feng@amd.co=
m> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Thursday, March 27, 2025 10:09 PM
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
> On Thu, Mar 27, 2025 at 4:22=E2=80=AFAM Feng, Kenneth <Kenneth.Feng@amd.c=
om> wrote:
> >
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Wednesday, March 26, 2025 11:08 PM
> > To: Feng, Kenneth <Kenneth.Feng@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Wang, Yang(Kevin)
> > <KevinYang.Wang@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>
> > Subject: Re: [PATCH] drm/amd/display: port the workload profile
> > setting logic into dm
> >
> > Caution: This message originated from an External Source. Use proper ca=
ution when opening attachments, clicking links, or responding.
> >
> >
> > On Wed, Mar 26, 2025 at 1:22=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.=
com> wrote:
> > >
> > > Port the workload profile setting logic into dm before MALL optimizat=
ion.
> > >
> > > Background:
> > > MALL optimization strategy has changed in the firmware.Previously,
> > > firmware does not care what workload type it is, once there is a
> > > request from DAL for MALL, firmware immediately trigger the MALL sett=
ing sequence on the SoC, so called D0i3.x idle power sequence.
> > > Now, before the D0i3.x sequence starts, firmware always check if the
> > > workload type is default, if it is not, then abort the D0i3.x sequenc=
e.
> > >
> > > Issue:
> > > Due to this strategy change, the task is moved to driver to make
> > > sure if gfx is really idle and if it is, reset the workload to defaul=
t.
> > > Without this task, when DAL's work task for MALL optimization tries
> > > to do the optimization request to DMCUB->pmfw, the workload type is a=
lways 3D fullscreen or compute, then MALL will never be applied.
> > >
> > > Why:
> > > The idle task for setting workload type back to default interval is
> > > 1 second currently. The DAL's work task to optimize MALL always
> > > starts before the idle task for setting workload type back to
> > > default. There is no way to ask the idle task in the base driver to
> > > reset the workload type ahead of the DAL's MALL setting work task kic=
ks off. There could be a workaround which sets the idle task interval to 10=
 millisecond. However, this causes some call trace issues in which the work=
queues is flushed.
> >
> > That should already fixed by this commit:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > /commit/?id=3Dde35994ecd2dd6148ab5a6c5050a1670a04dec77
> >
> > >
> > > Side effect:
> > > This solution is to port the logic in idle thread to DAL: check the
> > > fence and make sure gfx is idle, then reset the workload type. It is
> > > fine that when DAL's work task exits the MALL optimization, it does n=
ot set back the workload type to 3d fullscreen or compute since the work ta=
sk in base driver can make sure the workload type can be set back once ther=
e are jobs in the ring.
> >
> > I guess this works because the workload ref count gets clamped to 0, bu=
t this call is not balanced.  It also doesn't handle the VIDEO profile that=
 gets set when using VCN or the COMPUTE profile when KFD queues are active.=
  Those would also prevent the idle optimizations.
> > Also what happens if the profile changes after DC optimizations are ena=
bled?  Does that cause the optimizations to exit or will they stay intact u=
ntil DC tells it to exit?
> >
> > So I think we have two options:
> > 1. always disable the 3D, compute, video profiles when entering the DAL=
 optimization. subsequently, additional job submissions may change the work=
load.  will that be a problem?
> > 2. Add a helper to pause workload profiles while the DC optimization is=
 active.  If the profile only has to be changed while enabling the DC optim=
ization, we can just call it right before and right after the dc optimizati=
ons.  Something like the attached patches should be a good starting point.
> >
> > Alex
> >
> > Hi Alex,
> > In the attached patch, I guess smu->pause_workload is not needed since =
workload can be switched after idle optimization is triggered. And smu_paus=
e_power_profile may not need the bool flag since I still think that we don'=
t need to take care of the imbalance of workload setting.
> > That is said, we just need to set the workload to default when idle opt=
imization is requested. When the idle optimization is cancelled from DAL, i=
t doesn't need to restore the previous workload setting since the ring work=
 will set it.
> > Attached is my patch. It works on my system. Let me know your thoughts.
>
> This will race with any command submissions unless you add a lock.  I thi=
nk you want something like:
>
> /* switch to the bootup default profile */ amdgpu_dpm_pause_power_profile=
(adev, true); dc_allow_idle_optimizations(dm->dc, true);
> /* resume existing profiles */
> amdgpu_dpm_pause_power_profile(adev, false);
>
>
> Alex
>
> > Thanks.
> >
> > Kenneth
> >
> It works with your two patches, plus the attached one. Thanks.
> By the way,  do you think we need a mutex lock when accessing smu->pause_=
workload?

I think the pm.mutex handles this case.

Alex

> Kenneth
>
>
> > >
> > > Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> > > ---
> > >  .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 29 +++++++++++++++++=
+-
> > >  1 file changed, 28 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > > index 36a830a7440f..2adb3b72ed05 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > > @@ -244,6 +244,20 @@ static void amdgpu_dm_crtc_vblank_control_worker=
(struct work_struct *work)
> > >         struct vblank_control_work *vblank_work =3D
> > >                 container_of(work, struct vblank_control_work, work);
> > >         struct amdgpu_display_manager *dm =3D vblank_work->dm;
> > > +       u32 i, fences =3D 0;
> > > +       int r;
> > > +       enum PP_SMC_POWER_PROFILE profile;
> > > +       struct amdgpu_device *adev =3D drm_to_adev(dm->ddev);
> > > +
> > > +       if (adev->gfx.num_gfx_rings)
> > > +               profile =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> > > +       else
> > > +               profile =3D PP_SMC_POWER_PROFILE_COMPUTE;
> > > +
> > > +       for (i =3D 0; i < AMDGPU_MAX_GFX_RINGS; ++i)
> > > +               fences +=3D amdgpu_fence_count_emitted(&adev->gfx.gfx=
_ring[i]);
> > > +       for (i =3D 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_I=
NSTANCES); ++i)
> > > +               fences +=3D
> > > + amdgpu_fence_count_emitted(&adev->gfx.compute_ring[i]);
> > >
> > >         mutex_lock(&dm->dc_lock);
> > >
> > > @@ -271,8 +285,21 @@ static void amdgpu_dm_crtc_vblank_control_worker=
(struct work_struct *work)
> > >                         vblank_work->acrtc->dm_irq_params.allow_sr_en=
try);
> > >         }
> > >
> > > -       if (dm->active_vblank_irq_count =3D=3D 0)
> > > +       if (dm->active_vblank_irq_count =3D=3D 0) {
> > > +               if (adev->gfx.num_gfx_rings && !fences && !atomic_rea=
d(&adev->gfx.total_submission_cnt)) {
> > > +                       mutex_lock(&adev->gfx.workload_profile_mutex)=
;
> > > +                       if (adev->gfx.workload_profile_active) {
> > > +                               r =3D amdgpu_dpm_switch_power_profile=
(adev, profile, false);
> > > +                               if (r)
> > > +                               dev_warn(adev->dev, "(%d) failed to d=
isable %s power profile mode\n", r,
> > > +                                                                    =
   profile =3D=3D PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
> > > +                                                                    =
   "fullscreen 3D" : "compute");
> > > +                               adev->gfx.workload_profile_active =3D=
 false;
> > > +                       }
> > > +                       mutex_unlock(&adev->gfx.workload_profile_mute=
x);
> > > +               }
> > >                 dc_allow_idle_optimizations(dm->dc, true);
> > > +       }
> > >
> > >         mutex_unlock(&dm->dc_lock);
> > >
> > > --
> > > 2.34.1
> > >
