Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FDBC3ABAA
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 12:56:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AC0F10E917;
	Fri,  2 May 2025 12:56:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aVCNuVXF";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0303210E8CF
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 12:56:36 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-b1f2a3bf3c8so274373a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 May 2025 05:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746190596; x=1746795396; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M04cX16azKR2xFOxZIdnRiNooXmopKTYkeCBqoAsrCE=;
 b=aVCNuVXFH8lNCges35RUZL+737ve1UHRjE4PRgHv0u9RE2d/6ivWKo+xplEn11NXWq
 ye3LDBULh9JKdQjPstvX0/sx3TL+VmUQrGqWElmTcUOlcyFV3nY4H1JYmtDIjyPn5fXD
 lf/YF1VtTSjXgo39R777Thk21sd5YkDp0zm1Ma5aXPTXE+UR0wk7SH00k0Vu1vFo/uNH
 CrgEZDceQuBX2b7lQRMKWIfgSDhDKUgxitPQOF9WuCchDvAFGXgEHmKhxV712dIJOPIC
 PtCphN5YufwkLPRr9idmW87kqCTVNAkZf+KVyfdapr3xno2Y4OlRXYKst0+ajbaqIgyO
 IfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746190596; x=1746795396;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M04cX16azKR2xFOxZIdnRiNooXmopKTYkeCBqoAsrCE=;
 b=iJjjYDGlmXy5GKTxzLdUyodv5OJ42iweB99V/cxqkZAv7tFJ8FoWcIo/8knZ+HABoq
 G8Sjmmo8PJZ+U6t4mNpYmiQ/B/H6+JPJzu3STT6rhbsx7/Pf10cOKfL2J+rFOfO68M4Z
 OdkPveJL9POIz/kYJuWY1ox2U61l70g/rmwjVy7HRUnF4/4oZcd552GP4YXsXZEfCvDn
 YIapM4tXb/XjBaU/xxr9h7yVMZltXmLpj+07w4aOnlTAKwIgprXkITXU+sYj/VXbPaM7
 SK3d9zvrFw6x9d9aGkWEuckX2xVv38TDwwLrK4dnTVlO6Q9+KDI3YFNXGIRobO680y8d
 5bxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9XmFmI3/l7m1mBCEE+fhhiQ5gqoq5Bxjje+x88ncO0SPRBhZsQWOHwkDi8Vo2ZyIUPzfPbgGT@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCRCDW/CAxUgQ9dJbFIMWFUvKbCYybDXd5H1hJ6nuU0EAs7uJ4
 e1c3talMYoBmJZ/QsmarmEK+YHO95tHxgguYJRX8hqYSOF5ODBCaaU5RbtkCJqHY0+84dag/YEA
 E51QZ8oFb5HElePGAAEVE1Rbsi+Q=
X-Gm-Gg: ASbGnctR2dNn9dyLyD/31pDO4lFBjrT1oclMZmXggu2nm3KQRHB83JnXMSXexgvSLzS
 ldB/jxxU8S4KEiWbWFO6gh/Qpg5Sx2cBIXaVou90O83Fb6XNqNjbnzacebHOgfIUjpgE2m85N4H
 cym0wD5o0ofxsRRELlOoUP++btSR72USNb
X-Google-Smtp-Source: AGHT+IFkhRzVo4myyldW4kk/BE/VHuMqlLkYkK6Y4MUMWFNjhfesqxcgTf9ZXQak5/wG+ocq1S28rn1c/W/0y3yqQ2U=
X-Received: by 2002:a17:90b:4b49:b0:2ff:4b7a:f0a4 with SMTP id
 98e67ed59e1d1-30a4e6c0e69mr1665377a91.3.1746190596414; Fri, 02 May 2025
 05:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250501200931.358989-1-alexander.deucher@amd.com>
 <20250501200931.358989-2-alexander.deucher@amd.com>
 <591ce362-8150-4c81-a9b0-2752e0f27d15@amd.com>
In-Reply-To: <591ce362-8150-4c81-a9b0-2752e0f27d15@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 2 May 2025 08:56:25 -0400
X-Gm-Features: ATxdqUEzHL1NzPH28J4f63VujZs4xD3jzXSQmP2j1bdfcYkLx6vD5w_DARmPvgs
Message-ID: <CADnq5_M8KQyCPZ5iXJBqmHyuzHOomXWNfDvxwJnmXZ45a=T-6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix pm notifier handling
To: Mario Limonciello <mario.limonciello@amd.com>
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

On Thu, May 1, 2025 at 5:19=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 5/1/2025 3:09 PM, Alex Deucher wrote:
> > Set the s3/s0ix and s4 flags in the pm notifier so that we can skip
> > the resource evictions properly in pm prepare based on whether
> > we are suspending or hibernating.  Drop the eviction as processes
> > are not frozen at this time, we we can end up getting stuck trying
> > to evict VRAM while applications continue to submit work which
> > causes the buffers to get pulled back into VRAM.
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4178
> > Fixes: 2965e6355dcd ("drm/amd: Add Suspend/Hibernate notification callb=
ack support")
> > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> Rather than removing the callbacks (and thus introducing the "other"
> bugs with memory pressure), I've sent an alternative series.  LMK what
> you think of this instead.
>
> https://lore.kernel.org/amd-gfx/20250501211734.2434369-1-superm1@kernel.o=
rg/T/#m6cdc075af911868667ea6fc849bcd196477d6c20

Series looks good to me, but I think a variant of this patch (with the
evictions still in place) still makes sense so that we can properly
set the suspend and hibernate flags in amdgpu so that we can optimize
the evictions for suspend on APUs.  Will respin.

Alex

>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 +++++++++++----------=
-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 22 ++-----------------
> >   2 files changed, 15 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 71d95f16067a4..d232e4a26d7bf 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -4974,28 +4974,29 @@ static int amdgpu_device_evict_resources(struct=
 amdgpu_device *adev)
> >    * @data: data
> >    *
> >    * This function is called when the system is about to suspend or hib=
ernate.
> > - * It is used to evict resources from the device before the system goe=
s to
> > - * sleep while there is still access to swap.
> > + * It is used to set the appropriate flags so that eviction can be opt=
imized
> > + * in the pm prepare callback.
> >    */
> >   static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsig=
ned long mode,
> >                                    void *data)
> >   {
> >       struct amdgpu_device *adev =3D container_of(nb, struct amdgpu_dev=
ice, pm_nb);
> > -     int r;
> >
> >       switch (mode) {
> >       case PM_HIBERNATION_PREPARE:
> >               adev->in_s4 =3D true;
> > -             fallthrough;
> > +             break;
> > +     case PM_POST_HIBERNATION:
> > +             adev->in_s4 =3D false;
> > +             break;
> >       case PM_SUSPEND_PREPARE:
> > -             r =3D amdgpu_device_evict_resources(adev);
> > -             /*
> > -              * This is considered non-fatal at this time because
> > -              * amdgpu_device_prepare() will also fatally evict resour=
ces.
> > -              * See https://gitlab.freedesktop.org/drm/amd/-/issues/37=
81
> > -              */
> > -             if (r)
> > -                     drm_warn(adev_to_drm(adev), "Failed to evict reso=
urces, freeze active processes if problems occur: %d\n", r);
> > +             if (amdgpu_acpi_is_s0ix_active(adev))
> > +                     adev->in_s0ix =3D true;
> > +             else if (amdgpu_acpi_is_s3_active(adev))
> > +                     adev->in_s3 =3D true;
> > +             break;
> > +     case PM_POST_SUSPEND:
> > +             adev->in_s0ix =3D adev->in_s3 =3D false;
> >               break;
> >       }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> > index cec041a556013..6599fb6313220 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -2572,10 +2572,6 @@ static int amdgpu_pmops_suspend(struct device *d=
ev)
> >       struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> >       struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> >
> > -     if (amdgpu_acpi_is_s0ix_active(adev))
> > -             adev->in_s0ix =3D true;
> > -     else if (amdgpu_acpi_is_s3_active(adev))
> > -             adev->in_s3 =3D true;
> >       if (!adev->in_s0ix && !adev->in_s3) {
> >               /* don't allow going deep first time followed by s2idle t=
he next time */
> >               if (adev->last_suspend_state !=3D PM_SUSPEND_ON &&
> > @@ -2608,7 +2604,6 @@ static int amdgpu_pmops_resume(struct device *dev=
)
> >   {
> >       struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> >       struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> > -     int r;
> >
> >       if (!adev->in_s0ix && !adev->in_s3)
> >               return 0;
> > @@ -2617,12 +2612,7 @@ static int amdgpu_pmops_resume(struct device *de=
v)
> >       if (!pci_device_is_present(adev->pdev))
> >               adev->no_hw_access =3D true;
> >
> > -     r =3D amdgpu_device_resume(drm_dev, true);
> > -     if (amdgpu_acpi_is_s0ix_active(adev))
> > -             adev->in_s0ix =3D false;
> > -     else
> > -             adev->in_s3 =3D false;
> > -     return r;
> > +     return amdgpu_device_resume(drm_dev, true);
> >   }
> >
> >   static int amdgpu_pmops_freeze(struct device *dev)
> > @@ -2643,13 +2633,8 @@ static int amdgpu_pmops_freeze(struct device *de=
v)
> >   static int amdgpu_pmops_thaw(struct device *dev)
> >   {
> >       struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> > -     struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> > -     int r;
> >
> > -     r =3D amdgpu_device_resume(drm_dev, true);
> > -     adev->in_s4 =3D false;
> > -
> > -     return r;
> > +     return amdgpu_device_resume(drm_dev, true);
> >   }
> >
> >   static int amdgpu_pmops_poweroff(struct device *dev)
> > @@ -2662,9 +2647,6 @@ static int amdgpu_pmops_poweroff(struct device *d=
ev)
> >   static int amdgpu_pmops_restore(struct device *dev)
> >   {
> >       struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> > -     struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> > -
> > -     adev->in_s4 =3D false;
> >
> >       return amdgpu_device_resume(drm_dev, true);
> >   }
>
