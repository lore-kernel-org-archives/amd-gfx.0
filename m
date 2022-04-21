Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EBAC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 03:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE8B310E580;
	Thu, 21 Apr 2022 03:00:12 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AD8F10E580
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 03:00:12 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id w194so4221388oiw.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 20:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xBOVHSbtBs8UIClyXW87lRcpBoxQNPoZlsBLRO9ELEc=;
 b=NLCiRlh8hu5Sb1lyx5gDdUFVqemIBxMu/gmXDoYZ/+xxCFeC89oimTSXxDY2rlScXn
 Q6Zz/63jRMtTqwhmtVskWm6dbptsOsJegBiXJAOE/awwi9iqmvlpgND7stryLjqzSYUO
 /GyruhJC0n9Bs6Y+Pii0SDBMBcVXBrrIEfBYeiWO8r9CkmUhuNyiRneDs4iPD1kzSEVm
 GKn/Iho0FAosdUmokMWBl37gZv4RIil/IMhvN2hP62nu4eFkUj7STKiz59y5H0fFlKdW
 GLw03MPJggn8Ulrlt2sWlxT1h9GGh5DWJgSeXCcClYfHCqzGr+5/0WmfHwdsJVPGJPV6
 GOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xBOVHSbtBs8UIClyXW87lRcpBoxQNPoZlsBLRO9ELEc=;
 b=yx1zhmIwyKM3H1USLzxRG9iY87Zhxt2Nodd3DyVcOpdyDdu2b3m3VjJT6+kU8ZhKVC
 Xyoz8WsIpKWf+vUwLCxuh+AEl6rx8yPR7/lgBIfSc2ukv1j3HsYuAvglPOVYiMfmjIbt
 TwvIenHLHDYm7Emc5+g0jzhS+3sVt19ESRyDUvOnxHp3RIYCAs4U38UEBJK1Q6sjXdCd
 ye7/7dn3gikQF8fAyppg4kKV5ejms19DRdCZZiHZnRquYGGixdWhwlKtPnQDDP2CdoHO
 Cc5ZxghVS/DAACJgF1XGIOhf5y2c0o0QSxGnOfyZRunaI3OwQcnUlaXEGSBPT1glloH7
 nm1g==
X-Gm-Message-State: AOAM530gDpO6QrfehwaB+H5sW9RZJ3J31x6JeZUuWiAyXAITsHdfoqDQ
 hmHJ+t9/kK6JicBOrLJp+sCUiOMw1/Qa3i4yzUw=
X-Google-Smtp-Source: ABdhPJxfD5f7Abks5vWwDsQ313byDJ3hZguZkZoz80aWsQV5kx+Yq+TtbaDjiWnmHvuYVl6JAVvh+MYcHKMMzih4JPY=
X-Received: by 2002:a05:6808:1486:b0:2f9:e821:51d9 with SMTP id
 e6-20020a056808148600b002f9e82151d9mr3300388oiw.253.1650510011192; Wed, 20
 Apr 2022 20:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220413201522.2084041-1-alexander.deucher@amd.com>
 <DM6PR12MB261964F5BCF0D48BF1A8B911E4F49@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB261964F5BCF0D48BF1A8B911E4F49@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Apr 2022 23:00:00 -0400
Message-ID: <CADnq5_OQkH0So6H+NXZLR+HU-jnnb9Ni8BBDNeiUX9XcpoJLXw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: don't runtime suspend if there are displays
 attached (v2)
To: "Quan, Evan" <Evan.Quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Michele Ballabio <ballabio.m@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 20, 2022 at 10:54 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only]
>
>
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Thursday, April 14, 2022 4:15 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Michele Ballabio
> > <ballabio.m@gmail.com>
> > Subject: [PATCH] drm/amdgpu: don't runtime suspend if there are displays
> > attached (v2)
> >
> > We normally runtime suspend when there are displays attached if they
> > are in the DPMS off state, however, if something wakes the GPU
> > we send a hotplug event on resume (in case any displays were connected
> > while the GPU was in suspend) which can cause userspace to light
> > up the displays again soon after they were turned off.
> >
> > Prior to
> > commit 087451f372bf76 ("drm/amdgpu: use generic fb helpers instead of
> > setting up AMD own's."),
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
> > Fixes: 087451f372bf76 ("drm/amdgpu: use generic fb helpers instead of
> > setting up AMD own's.")
> > Tested-by: Michele Ballabio <ballabio.m@gmail.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 107 ++++++++++++++++---
> > -----
> >  1 file changed, 72 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 4efaa183abcd..97a1aa02d76e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -2395,6 +2395,71 @@ static int amdgpu_pmops_restore(struct device
> > *dev)
> >       return amdgpu_device_resume(drm_dev, true);
> >  }
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
> > +              * hotplug events in case any displays were connected while
> > +              * the GPU was in suspend.  Remove this once that is fixed.
> > +              */
> > +             mutex_lock(&drm_dev->mode_config.mutex);
> > +             drm_connector_list_iter_begin(drm_dev, &iter);
> > +             drm_for_each_connector_iter(list_connector, &iter) {
> > +                     if (list_connector->status ==
> > connector_status_connected) {
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
> > +                     drm_modeset_lock(&drm_dev-
> > >mode_config.connection_mutex, NULL);
> > +
> > +                     drm_connector_list_iter_begin(drm_dev, &iter);
> > +                     drm_for_each_connector_iter(list_connector, &iter)
> > {
> > +                             if (list_connector->dpms ==
> > DRM_MODE_DPMS_ON) {
> > +                                     ret = -EBUSY;
> > +                                     break;
> > +                             }
> > +                     }
> > +
> > +                     drm_connector_list_iter_end(&iter);
> > +
> > +                     drm_modeset_unlock(&drm_dev-
> > >mode_config.connection_mutex);
> > +                     mutex_unlock(&drm_dev->mode_config.mutex);
> > +             }
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static int amdgpu_pmops_runtime_suspend(struct device *dev)
> >  {
> >       struct pci_dev *pdev = to_pci_dev(dev);
> > @@ -2407,6 +2472,10 @@ static int
> > amdgpu_pmops_runtime_suspend(struct device *dev)
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
> > @@ -2516,41 +2585,9 @@ static int amdgpu_pmops_runtime_idle(struct
> > device *dev)
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
> > -             drm_modeset_lock(&drm_dev-
> > >mode_config.connection_mutex, NULL);
> > -
> > -             drm_connector_list_iter_begin(drm_dev, &iter);
> > -             drm_for_each_connector_iter(list_connector, &iter) {
> > -                     if (list_connector->dpms ==  DRM_MODE_DPMS_ON)
> > {
> > -                             ret = -EBUSY;
> > -                             break;
> > -                     }
> > -             }
> > -
> > -             drm_connector_list_iter_end(&iter);
> > -
> > -             drm_modeset_unlock(&drm_dev-
> > >mode_config.connection_mutex);
> > -             mutex_unlock(&drm_dev->mode_config.mutex);
> > -     }
> > -
> > -     if (ret == -EBUSY)
> > -             DRM_DEBUG_DRIVER("failing to power off - crtc active\n");
> > +     ret = amdgpu_runtime_idle_check_display(dev);
> > +     if (ret)
> > +             return ret;
> [Quan, Evan] Previously, the following actions(pm_runtime_mark_last_busy/pm_runtime_autosuspend) will be still performed even if ret is set as EBUSY.
> But with the new changes, it will abort directly without the following actions performed.
> Is that expected? Will that make any logical change?

Good point.  I'll fix that up.

Alex

>
> BR
> Evan
> >
> >       pm_runtime_mark_last_busy(dev);
> >       pm_runtime_autosuspend(dev);
> > --
> > 2.35.1
