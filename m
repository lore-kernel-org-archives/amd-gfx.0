Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4A2D3C92F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 16:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21AAF10E276;
	Wed, 10 Dec 2025 16:37:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J5Y6fnv9";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44C6F10E276
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 16:37:43 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-299e43c1adbso57515ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 08:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765384663; x=1765989463; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bIZLVu7o4dmZETgTDZR8v01cUIwzTDg3oeYQwCMDbTY=;
 b=J5Y6fnv9TJiU1rtLrJexkNzSycHnyuK3R1jBz3yQFl2I4SSbI6Q8AvofvI3ZieymXe
 N8ajO8ohd3lR0BfuaB53NmynmhZ0VU1VvQ1KpK8fXWDfQl/5LPlTXU6bIXLy/r4ytg7z
 RS6nnhL3v6/rQSiLlPlYV2Ch9gRHNOcnrzgZn5WTKzmeZ9fVyDl7OTg5IiQxmWGooNSy
 UAje0kRJl2KPVhJ0PDgyuxrflF7EH05uabL3DEbGQGnhksZ80fOr/c2oOOmNZRIR9bZt
 YXM7Qm6V+igENGdbSsc1XK5F2P4jas4Hio/UMqXLsDQahosfL+OjaR2TTLid4jCuyD53
 uhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765384663; x=1765989463;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bIZLVu7o4dmZETgTDZR8v01cUIwzTDg3oeYQwCMDbTY=;
 b=t9f16Gy1PTGmenuNsqNrGxoJreGA257rrW38vTsglikwYcw0ckXmsspwjTzzXv0o4X
 l+WHlz/aL7MAEwGrxnUNW4R3baH8Gagtdtq5bwOfMWsW37mBhQegD4dJlJsKg78klWTD
 C/jvTJViXGl4ruHP7xFEVzttdHhBurSbdwdRY5FRlyl9oCrtE7qQkNeYU18dVqrBS/rv
 swD1Whi8O6Wpb/vXwi1H5guK1j1pENg80X5NdJ1ChtGwx9qIYOI7o01yFDHTj4rsJZ8H
 tJM1YOstos5hm5yZeyl73gih5D8yR0GStvWrb5E8oxGeZoyfZVeW8AjTTSIIjRp6bGHj
 VzlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs16+fyJMr+vpnJ1ggp0Z1vi7ALQYSNMG6/36pcXkZrHXfBRRH4BhZm6yaZht5pQ+zf5CdPKIO@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx553TKMG5I3GKi8DdAUSmXIQ1JJ0kuqyo6+elSNmL59xywdAiM
 JFdMNVJXEsmqtyepDD7SACagWmdEDRg65c7HXGmpYAXgtNsc5zNpBsHWG1foP0S/yzLzjKOE0Sz
 x5NUbNZ0ogmK4cGB3RgSw23M9H0wqg2o=
X-Gm-Gg: ASbGncsbqFJDrUArfB2c/vXcFKSFNajtBJYKvPtqs3LVkqucYfMYxBZYwIK+t00pSSv
 aeP7csIQc0eZOJb/a449tUm1fgvEEGk0WJcNaWH021nR2KyMcWVbVpbnasyqCCUbNEhgOlZp+PT
 8ruXelkL1OMBU1GY22tndFyLvf4/mia0OTW/bo0uHr8sqfOeWtHe47UIE5a6Y8bThWqw2k2sYFQ
 ASoski6CU4COWg4ScwWei/1mXM5CBTKc5vJAVZ+FrqsYB0bIF2d+r0YEAovx6tTke4XceQ=
X-Google-Smtp-Source: AGHT+IFlEz1r98TrYRI7AVFX4hlD7xkojCM9WFIZXPFxtyy0SiKDjJ/AqN7YppdjmoTB+eAPQftVqgVqBPEiUDCrftg=
X-Received: by 2002:a05:7022:6294:b0:11a:43fb:58dd with SMTP id
 a92af1059eb24-11f296d7428mr1307351c88.5.1765384662312; Wed, 10 Dec 2025
 08:37:42 -0800 (PST)
MIME-Version: 1.0
References: <20251210125740.9551-1-christian.koenig@amd.com>
 <3c90635b46f1a867365fba026edbc28a33ad9d9d.camel@mailbox.org>
In-Reply-To: <3c90635b46f1a867365fba026edbc28a33ad9d9d.camel@mailbox.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 Dec 2025 11:37:30 -0500
X-Gm-Features: AQt7F2qtv41qD_VN6SWYKqBPMoNPevstuSr6c5v-p07PqfplSPBclHOIbsNG4Uw
Message-ID: <CADnq5_MxQ45PWKL=e+nTq69LnQrk-OKPW4vqbV2UrJJvHgpGQQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: cache the pasid in amdgpu_device_gpu_recover
To: phasta@kernel.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 alexander.deucher@amd.com, SRINIVASAN.SHANMUGAM@amd.com, 
 vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
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

On Wed, Dec 10, 2025 at 10:34=E2=80=AFAM Philipp Stanner <phasta@mailbox.or=
g> wrote:
>
> On Wed, 2025-12-10 at 13:57 +0100, Christian K=C3=B6nig wrote:
> > The job might already be freed up here. So cache the pasid for later
> > use.
> >
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Suggested-by: Philipp Stanner <phasta@mailbox.org>
>
> No! :D
>
> You read the wrong quote.
> Matthew found your issue (in the middle of my time zone's night, while
> I was peacefully asleep).
>
> > Fixes: a72002cb181f ("drm/amdgpu: Make use of drm_wedge_task_info")
>
> I think there was a gitlab ticket about that a month ago? Could be
> added to Closes:
>
>
> P.
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 654f4844b7ad..84bb89498e12 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -6506,8 +6506,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_devic=
e *adev,
> >       struct list_head device_list;
> >       bool job_signaled =3D false;
> >       struct amdgpu_hive_info *hive =3D NULL;
> > -     int r =3D 0;
> >       bool need_emergency_restart =3D false;
> > +     unsigned int pasid =3D job->pasid;

I think job can be NULL here.

Alex

> > +     int r =3D 0;
> >
> >       /*
> >        * If it reaches here because of hang/timeout and a RAS error is
> > @@ -6605,7 +6606,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_devic=
e *adev,
> >               struct amdgpu_task_info *ti =3D NULL;
> >
> >               if (job)
> > -                     ti =3D amdgpu_vm_get_task_info_pasid(adev, job->p=
asid);
> > +                     ti =3D amdgpu_vm_get_task_info_pasid(adev, pasid)=
;
> >
> >               drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVER=
Y_NONE,
> >                                    ti ? &ti->task : NULL);
>
