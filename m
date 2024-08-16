Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0178BC3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 13:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BF8B10E77D;
	Fri, 16 Aug 2024 13:43:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mHkHgI+p";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19CFE10E799
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 13:43:31 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2cb53da06a9so1376404a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 06:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723815810; x=1724420610; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LoxU/rp6k1oXcfMUEebZRoSo30Iju2lYYV9tiXnvJFM=;
 b=mHkHgI+pKQtdYsOoU6CmULiWzj4pMq+7Z1wc0pknoQsdLS6ctOOzMxecLpPsc6pEwA
 4rZUVpUOu6IkF0aee7QK5Kiq/1dehXUD8Sad/DreLRB7EyMf+3xCubINqCnO3ajbggYy
 TVIpDWqz/L1CXs4Q5/ZPWVmyGJ+Fco18/GvNLhrsv3O1WVzkUem423FDdogwMiwDNAlj
 7wTUi0Ejrr5akM9hWcia55rVxfyRiMyNIiV8HaOTPgLTuctrDnaxV179Pp9PPtXIahSN
 FCf1wYODKYuFQTWMsMgMTq1U6u7AOnOxDcJGYJLUnaakZPWTZj/G5ImiKqdlxXOdCpB/
 f98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723815810; x=1724420610;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LoxU/rp6k1oXcfMUEebZRoSo30Iju2lYYV9tiXnvJFM=;
 b=rET37qp0HpVEAER7rd60+WeDFIGjVOqePFf4yTlCgX96II3N1w4AHWuZh9CW4Eu2OT
 vkYHY7SSgTPCFauEl2vXo7FEAgxRGROC/DMpsZCPbtNTOOAZ+w6fpsphJOtvDhaJsf4P
 3Abw85nSvQqfcCSl7/vwMRKSOHD31uosRtdW9f+0cNY4po0hzT1FM1s2lQgFkMB8FsyY
 GBTR+hDy3DzC8rb9Q+DVBG1mIUGB4+/Mj7izaA7TR3aWS5Bcn2xOpuPxXQ7RXvUq8Te7
 lFwgZvk6Qz1PWup6VOcS5RO8VVHOfQ7KwhmTAWmlacGPavVCMsc8041LmMUxP94C+fWw
 k3Rg==
X-Gm-Message-State: AOJu0Yw7XpuYdAdVvcm2dOjn7XtDAoQsQAhJceaPrACflDw89EaaNUW6
 uH7ZhtgkgcKmn7bfa5zOGk6R9fL180t3JlIZCL9/xsnVhefntq5oGOA1Py+Euc6dpX/hbnBELeX
 gs5PWZvb2w951WOClbMwA6+QADsRFHWxZ
X-Google-Smtp-Source: AGHT+IF5Zdt7RySOJJBt7hie2HYKX+l4v9ty52Esfyl+8BrXlnou9CuXBvxqzk0PyDGBGmTco6bfpL4YBnPBSNDpevY=
X-Received: by 2002:a17:90a:bf09:b0:2d3:c365:53b1 with SMTP id
 98e67ed59e1d1-2d3e45529b3mr4087654a91.6.1723815810297; Fri, 16 Aug 2024
 06:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240815113836.399377-1-Trigger.Huang@amd.com>
 <20240815113836.399377-2-Trigger.Huang@amd.com>
 <CADnq5_NumwJ6ujpJERTF7gK7TAJMkG7MNMNgrtr3=k8pqYnBvg@mail.gmail.com>
 <SA1PR12MB74425F710D53EAA007A062F2FE812@SA1PR12MB7442.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB74425F710D53EAA007A062F2FE812@SA1PR12MB7442.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Aug 2024 09:43:18 -0400
Message-ID: <CADnq5_Oy=-54C-m1UHJijEL+LdgRMJ_aGusuo2pjdcp6nCg5xg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: Add gpu_coredump parameter
To: "Huang, Trigger" <Trigger.Huang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Khatri,
 Sunil" <Sunil.Khatri@amd.com>, 
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

On Fri, Aug 16, 2024 at 2:36=E2=80=AFAM Huang, Trigger <Trigger.Huang@amd.c=
om> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Friday, August 16, 2024 12:02 AM
> > To: Huang, Trigger <Trigger.Huang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Khatri, Sunil <Sunil.Khatri@amd.com>=
;
> > Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: Re: [PATCH 1/3] drm/amdgpu: Add gpu_coredump parameter
> >
> > On Thu, Aug 15, 2024 at 7:39=E2=80=AFAM <Trigger.Huang@amd.com> wrote:
> > >
> > > From: Trigger Huang <Trigger.Huang@amd.com>
> > >
> > > Add new separate parameter to control GPU coredump procedure. This ca=
n
> > > be used to decouple the coredump procedure from gpu recovery procedur=
e
> > >
> > > Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
> > >  2 files changed, 9 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > index 937de21a7142..4dd465ad14af 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > @@ -201,6 +201,7 @@ extern uint amdgpu_force_long_training;  extern
> > > int amdgpu_lbpw;  extern int amdgpu_compute_multipipe;  extern int
> > > amdgpu_gpu_recovery;
> > > +extern int amdgpu_gpu_coredump;
> > >  extern int amdgpu_emu_mode;
> > >  extern uint amdgpu_smu_memory_pool_size;  extern int
> > > amdgpu_smu_pptable_id; diff --git
> > > a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > index b9529948f2b2..c5d357420236 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > @@ -178,6 +178,7 @@ uint amdgpu_force_long_training;  int
> > amdgpu_lbpw
> > > =3D -1;  int amdgpu_compute_multipipe =3D -1;  int amdgpu_gpu_recover=
y =3D
> > > -1; /* auto */
> > > +int amdgpu_gpu_coredump;
> > >  int amdgpu_emu_mode;
> > >  uint amdgpu_smu_memory_pool_size;
> > >  int amdgpu_smu_pptable_id =3D -1;
> > > @@ -556,6 +557,13 @@ module_param_named(compute_multipipe,
> > > amdgpu_compute_multipipe, int, 0444);
> > MODULE_PARM_DESC(gpu_recovery,
> > > "Enable GPU recovery mechanism, (1 =3D enable, 0 =3D disable, -1 =3D
> > > auto)");  module_param_named(gpu_recovery, amdgpu_gpu_recovery, int,
> > > 0444);
> > >
> > > +/**
> > > + * DOC: gpu_coredump (int)
> > > + * Set to enable GPU coredump mechanism (1 =3D enable, 0 =3D disable=
).
> > > +The default is 0  */ MODULE_PARM_DESC(gpu_coredump, "Enable GPU
> > > +coredump mechanism, (1 =3D enable, 0 =3D disable (default))");
> > > +module_param_named(gpu_coredump, amdgpu_gpu_coredump, int,
> > 0444);
> >
> > I don't think we need a separate parameter for this, although if we do,=
 this
> > would need to be enabled by default.  If it needs to be decoupled from =
reset,
> > that's fine, but I don't see the need for a separate knob.
> >
> > Alex
>
> Hi Alex,
> It is fine to enable it by default
> There are several application scenarios that I can think of.
>         1, Customer may need to do the core dump with gpu_recovery disabl=
ed. This can be used for GPU hang debug
>         2, Customer may need to disable the core dump with gpu_recovery e=
nabled. This can be used for quick GPU recovery, especially for some lightw=
eight hangs that can be processed by soft recovery or per ring reset.
>         3, Customer may need to enable the core dump with gpu_recovery en=
abled. This can be used for GPU recovery but record the core dump for furth=
er check in stress test or system health check.
> It seems not easy to support all the scenarios by only using amdgpu_gpu_c=
oredump, right?

We always want devcoredump enabled by default for full adapter resets,
otherwise it kind of defeats the purpose of the feature.  Do we want
devcoredumps for cases where we can recover via soft recovery or per
queue reset?  If we mainly care about full adapter reset then we can
do something like:

1. in amdgpu_job_timedout(), we can do:
if (!amdgpu_gpu_recovery)
    amdgpu_dev_coredump()
between per ring reset and full adapter reset.  That way it won't get
called for soft recovery or per queue reset.

2. leave the current dev_coredump code in place for the case when
recovery is enabled.

If we want it for both soft-recovery and queue reset and full adapter
reset, then we just just unconditionally call it in
amdgpu_job_timedout().  If the finer grained resets don't work, we'll
get two dumps, but I think that's probably ok.

Alex

>
> Regards,
> Trigger
> >
> > > +
> > >  /**
> > >   * DOC: emu_mode (int)
> > >   * Set value 1 to enable emulation mode. This is only needed when ru=
nning
> > on an emulator. The default is 0 (disabled).
> > > --
> > > 2.34.1
> > >
