Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D116EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 14:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6558510EF79;
	Tue, 19 Apr 2022 14:44:56 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29D2E10EEBD
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 14:44:55 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 r12-20020a056830418c00b006054e1142acso3635308otu.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 07:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9K65g1hRf6K53lqOqvVgP99E8FuHQSNA9FMLkby6pyw=;
 b=l4kuThPiXFPCLa5zusMnTir2NCm+LICvmHe0u4k280aitDwzJkm9kLElUDkg47Ctgl
 NocxE8+pUS0n7fbznLlxnCteC6zJjKIlAzPtvXN5yT5ZxYkQS6Vp3jpAHwNk1pLG1bHi
 ifGH16qckWFRgbUTQpxXTkfZru6YK/cc0Qcvr1oHwF9WL29UovvdVJVzu32lOsRntBNX
 U/6DfLBAQcMPMfRnFoQcw2A/z82oSwbBv7ovRP8XLNWdCuKoN4r8RPly2fqqj/dmlN6B
 rlDGU9L39nzkXHJwOiAJDQKprOn7SURkrHdA0tHB0Ze4Bx+CzNCcaG2wwbfScJNb5mX0
 9KuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9K65g1hRf6K53lqOqvVgP99E8FuHQSNA9FMLkby6pyw=;
 b=0SAfEnwxjIezxliEhhDTtdNgBYVSAez0NokOPVVXtvbyh/i/UU48IkVDQND+x1/Zqk
 z12QF6GyOqzg5nsNYDLmIWjoatIJdm+f5txIvWOaU5o5e7Zui4coi5He0IHQWg4mor/Y
 yOZIK3JxEAbR5rZ506/SMC+FRuZ1WP4dl5M23o42lyBVE0fXgmeCf6r8/e/tEkKDrHgS
 ftPWiw98c/xVacVHYofCbexP87YBHBglRKx77oQqyaKswq5uBc7Ofmr+3ACtZxmc1R1x
 McVhFsgJUSG92EcER1YOoozmjm4Z7Lf5P7K8p5Qjbx5D+ndMr4/H0hDAIkEl4+ngP4lO
 46pw==
X-Gm-Message-State: AOAM533VmYDYkDjz2LhgfLSfYppxGK6h9hVCG+9OKXz9NxH5//VQmtmH
 T5vaQB4mMtGVV5BXVxMOSbXSRUBGyFlhenwpsCA=
X-Google-Smtp-Source: ABdhPJxf9+e80dA25ioKF7cuP2djAsvLngyNI6JHMufyNJtgnd2BCNjgbVMKnCpAU8wSeAM08+QbbnAR4d71J/2UMJw=
X-Received: by 2002:a9d:7a8f:0:b0:604:25d0:f231 with SMTP id
 l15-20020a9d7a8f000000b0060425d0f231mr6108928otn.200.1650379494365; Tue, 19
 Apr 2022 07:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220413201522.2084041-1-alexander.deucher@amd.com>
 <6729c3d4-c3e9-d3d8-d23a-3892384794f6@molgen.mpg.de>
In-Reply-To: <6729c3d4-c3e9-d3d8-d23a-3892384794f6@molgen.mpg.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Apr 2022 10:44:43 -0400
Message-ID: <CADnq5_MnfM7h5KUnedgrYiYwu5O29UeJHGnGKuaQc9dHQv7MFQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: don't runtime suspend if there are displays
 attached (v2)
To: Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Michele Ballabio <ballabio.m@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 19, 2022 at 10:04 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Alex,
>
>
> Thank you for the patch.
>
> Am 13.04.22 um 22:15 schrieb Alex Deucher:
> > We normally runtime suspend when there are displays attached if they
> > are in the DPMS off state, however, if something wakes the GPU
> > we send a hotplug event on resume (in case any displays were connected
> > while the GPU was in suspend) which can cause userspace to light
> > up the displays again soon after they were turned off.
> >
> > Prior to
> > commit 087451f372bf76 ("drm/amdgpu: use generic fb helpers instead of setting up AMD own's."),
> > the driver took a runtime pm reference when the fbdev emulation was
> > enabled because we didn't implement proper shadowing support for
> > vram access when the device was off so the device never runtime
> > suspended when there was a console bound.  Once that commit landed,
> > we now utilize the core fb helper implementation which properly
> > handles the emulation, so runtime pm now suspends in cases where it did
> > not before.  Ultimately, we need to sort out why runtime suspend in not
> > working in this case for some users, but this should restore similar
> > behavior to before.
> >
> > v2: move check into runtime_suspend
> >
> > Fixes: 087451f372bf76 ("drm/amdgpu: use generic fb helpers instead of setting up AMD own's.")
> > Tested-by: Michele Ballabio <ballabio.m@gmail.com>
>
> On what system and device?

It was a polaris dGPU, but it has been seen on other GPUs as well.
It's not device specific.  The issue is hard to reproduce at least in
our testing unfortunately.

>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 107 ++++++++++++++++--------
> >   1 file changed, 72 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 4efaa183abcd..97a1aa02d76e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -2395,6 +2395,71 @@ static int amdgpu_pmops_restore(struct device *dev)
> >       return amdgpu_device_resume(drm_dev, true);
> >   }
> >
> > +static int amdgpu_runtime_idle_check_display(struct device *dev)
> > +{
> > +     struct pci_dev *pdev = to_pci_dev(dev);
> > +     struct drm_device *drm_dev = pci_get_drvdata(pdev);
> > +     struct amdgpu_device *adev = drm_to_adev(drm_dev);
> > +
> > +     if (adev->mode_info.num_crtc) {
> > +             struct drm_connector *list_connector;
> > +             struct drm_connector_list_iter iter;
> > +             int ret = 0;
> > +
> > +             /* XXX: Return busy if any displays are connected to avoid
> > +              * possible display wake ups after runtime resume due to
>
> Nit: wakeups

Ack.

>
> > +              * hotplug events in case any displays were connected while
> > +              * the GPU was in suspend.  Remove this once that is fixed.
> > +              */
>
> Do you have an (internal) issue to track this?

Yes, we are tracking it.

Alex

>
> > +             mutex_lock(&drm_dev->mode_config.mutex);
> > +             drm_connector_list_iter_begin(drm_dev, &iter);
> > +             drm_for_each_connector_iter(list_connector, &iter) {
> > +                     if (list_connector->status == connector_status_connected) {
> > +                             ret = -EBUSY;
> > +                             break;
> > +                     }
> > +             }
> > +             drm_connector_list_iter_end(&iter);
> > +             mutex_unlock(&drm_dev->mode_config.mutex);
> > +
> > +             if (ret)
> > +                     return ret;
> > +
> > +             if (amdgpu_device_has_dc_support(adev)) {
> > +                     struct drm_crtc *crtc;
> > +
> > +                     drm_for_each_crtc(crtc, drm_dev) {
> > +                             drm_modeset_lock(&crtc->mutex, NULL);
> > +                             if (crtc->state->active)
> > +                                     ret = -EBUSY;
> > +                             drm_modeset_unlock(&crtc->mutex);
> > +                             if (ret < 0)
> > +                                     break;
> > +                     }
> > +             } else {
> > +                     mutex_lock(&drm_dev->mode_config.mutex);
> > +                     drm_modeset_lock(&drm_dev->mode_config.connection_mutex, NULL);
> > +
> > +                     drm_connector_list_iter_begin(drm_dev, &iter);
> > +                     drm_for_each_connector_iter(list_connector, &iter) {
> > +                             if (list_connector->dpms ==  DRM_MODE_DPMS_ON) {
> > +                                     ret = -EBUSY;
> > +                                     break;
> > +                             }
> > +                     }
> > +
> > +                     drm_connector_list_iter_end(&iter);
> > +
> > +                     drm_modeset_unlock(&drm_dev->mode_config.connection_mutex);
> > +                     mutex_unlock(&drm_dev->mode_config.mutex);
> > +             }
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >   static int amdgpu_pmops_runtime_suspend(struct device *dev)
> >   {
> >       struct pci_dev *pdev = to_pci_dev(dev);
> > @@ -2407,6 +2472,10 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
> >               return -EBUSY;
> >       }
> >
> > +     ret = amdgpu_runtime_idle_check_display(dev);
> > +     if (ret)
> > +             return ret;
> > +
> >       /* wait for all rings to drain before suspending */
> >       for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> >               struct amdgpu_ring *ring = adev->rings[i];
> > @@ -2516,41 +2585,9 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
> >               return -EBUSY;
> >       }
> >
> > -     if (amdgpu_device_has_dc_support(adev)) {
> > -             struct drm_crtc *crtc;
> > -
> > -             drm_for_each_crtc(crtc, drm_dev) {
> > -                     drm_modeset_lock(&crtc->mutex, NULL);
> > -                     if (crtc->state->active)
> > -                             ret = -EBUSY;
> > -                     drm_modeset_unlock(&crtc->mutex);
> > -                     if (ret < 0)
> > -                             break;
> > -             }
> > -
> > -     } else {
> > -             struct drm_connector *list_connector;
> > -             struct drm_connector_list_iter iter;
> > -
> > -             mutex_lock(&drm_dev->mode_config.mutex);
> > -             drm_modeset_lock(&drm_dev->mode_config.connection_mutex, NULL);
> > -
> > -             drm_connector_list_iter_begin(drm_dev, &iter);
> > -             drm_for_each_connector_iter(list_connector, &iter) {
> > -                     if (list_connector->dpms ==  DRM_MODE_DPMS_ON) {
> > -                             ret = -EBUSY;
> > -                             break;
> > -                     }
> > -             }
> > -
> > -             drm_connector_list_iter_end(&iter);
> > -
> > -             drm_modeset_unlock(&drm_dev->mode_config.connection_mutex);
> > -             mutex_unlock(&drm_dev->mode_config.mutex);
> > -     }
> > -
> > -     if (ret == -EBUSY)
> > -             DRM_DEBUG_DRIVER("failing to power off - crtc active\n");
> > +     ret = amdgpu_runtime_idle_check_display(dev);
> > +     if (ret)
> > +             return ret;
> >
> >       pm_runtime_mark_last_busy(dev);
> >       pm_runtime_autosuspend(dev);
>
> The overall change looks good.
>
>
> Kind regards,
>
> Paul
