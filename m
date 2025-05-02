Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49678C3ABAA
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 20:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6BE610E072;
	Fri,  2 May 2025 20:32:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GUXzI+wW";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A745710E072
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 20:32:20 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-73de145c639so342469b3a.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 May 2025 13:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746217940; x=1746822740; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9uqjNvIOmpv9qHMV2mSEQ2E6PQfnDmIC+9gPYhzGLRA=;
 b=GUXzI+wWcBWFBoyaMqAHoOmkSG+ZIyEff4SRtD1mwwu0bksuH89LEQQOmW0XMNXQ9S
 1YBbwY6TeK8GokHns0GmdrxPdPSOcBVFNihr6IYL1WYGwB93b+ihVlYmzcNTP8rqb5hs
 maL+1Ou1ln2Gbc9GmM6sZcZFcIn5h5ZFzUJFBErNMKN95rKkXRX8EeFlQx5E+w5JY51g
 m96RnUhnO947+dfzXub4pLQg9il2orQ9p9BfucoNjxSmbc7tI8/2VOoDJCiM6uWvIFmh
 5bLJhJPaweO1+shUe5jhev9TIsIdA4/SXPj+WLpU4dMgpD50XVqlmoZ0BgnLAuSdPPM0
 OqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746217940; x=1746822740;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9uqjNvIOmpv9qHMV2mSEQ2E6PQfnDmIC+9gPYhzGLRA=;
 b=C8j9JbyXlTfyX6nQ1eJumR1GOOyx65x8y2ex+vh0JNb2gIKiP1qNIuhjQ5++94dTaH
 szFoPOKtNzXPUdtoplWf+Qq6qxfad6cBNOmqg1NWjXogEgpKKXlptO8SebNlJPkHV4tG
 LmZomCbUg8syMQSIqQdVGD4oS6VNScvxpJKM79yoKeYIkG8yJsZQCV4gmlAT3pBO2EZz
 Y/MCTOC2To3t43M8MeUnbrxrSnGSYdvAO757rzKarqVQ5FkjE6wAT8UQ011g/LmqgruI
 aO9niFoO0SzQbSp1UOYmj3OfNRfn+ZW/PgzeewEQ0x19GYeh/4qwGAXuEPQ0bY4aubcu
 ol7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0RHXyn1PuLqdxAWX8/wRDLW/osIR+3VQ+kbb32xqqCG6dHoTTJ974Sx6WfV+FJEtENmwjKEvS@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWM77aDqb+drsJY84oHMdRknC31pxcHTPkC9nVrOBEX7TK5yNN
 hAJ3HexEUC7aV99cnaR7S2wfS8+qc5N6LPFdqGq4PNJNQ1cafeIW+DY7QMv7OZG33C25ss5o3m1
 i6eP5cpjYJRRwFA6qTJRtis3ysX0=
X-Gm-Gg: ASbGnct/Ipws354YNh7tswwFjYiDLCGf/wGFQ8yUs/3TesNkQZQWqJbvRIA0VFV5lia
 tfwlKf/qW5+liO5029jGLA4Arl2iHIYUfFywV3eCa5xqsUFhkY0PT0ko3F4T308ddcmtBTIUdbV
 qEjoMHt3j5q/qEstovSELd1g==
X-Google-Smtp-Source: AGHT+IGpsEn3LlaUachssPzQdIGJifZvj7NlRUDTsSVHRPHj46wHC+wyc1b0wMa3GftKzRnBxeW0Uio24lplzLCZ2V8=
X-Received: by 2002:a17:90b:4d07:b0:306:b6ae:4d7a with SMTP id
 98e67ed59e1d1-30a4e69f90dmr2387811a91.3.1746217939904; Fri, 02 May 2025
 13:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250501200931.358989-1-alexander.deucher@amd.com>
 <20250501200931.358989-2-alexander.deucher@amd.com>
 <b9884f1d-91fd-4b0c-9a81-acc5bd53c891@amd.com>
In-Reply-To: <b9884f1d-91fd-4b0c-9a81-acc5bd53c891@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 2 May 2025 16:32:08 -0400
X-Gm-Features: ATxdqUF4zRt_117_Jb3vv3IrsPkpN6hXjQv9ZtYrWhQxIIxcqZI97IMC7LoQXKM
Message-ID: <CADnq5_P2GgCTWihgCQp=tKiatRqe-VY5acKgcVRMYiYdvwnVdQ@mail.gmail.com>
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

On Fri, May 2, 2025 at 3:39=E2=80=AFPM Mario Limonciello
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
>
> I don't believe this is valid "this early".
>
> pm_suspend()
> ->enter_state()
> ->->suspend_prepare()
> ->->-> Call notification chains for PM_SUSPEND_PREPARE
> ->->suspend_devices_and_enter()
> ->->-> Set pm_suspend_target_state

hmmm.  Is there a way to determine whether we are going into hibernate
vs. suspend in the pm prepare function?  I guess we could set
adev->in_s4 here and then check if in_s4 is set in pm prepare, and if
not, then call this logic to set the suspend flags in the prepare
callback.

Alex

>
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
