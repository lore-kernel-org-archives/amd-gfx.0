Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86061C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 13:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08A9710F123;
	Wed, 20 Apr 2022 13:57:39 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26ED310F14C
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 13:57:37 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-d39f741ba0so1975348fac.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 06:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DpOgg3Kpk9iHHtPiAspA1efXCA5xLwUmidYPh6SGPLw=;
 b=EMlf8sTPlp3Zt25XoXW7/Z46yvEfesvXy6049HGvgTrP3R12CTQUIOuQ5Osg9jIbyY
 fAl2rPP/eVUN5c+y2AyPjJeDdR97yRigd/RH4LdRafu7u/Mc2NMHkO1k8sA0Gl1R2R9i
 q2CaxxTBlU2DTBHPk1qExtNcu7nag/mjSPYg5GZcfugnGqGDjEtkThhpLLhV7JPrIxun
 H9yIwl1s6ciFbHM8U3/vdtwpQ7aLNr6+CdgaqQ+TMr73Oh+pAIacXU+x5nZu2/Ko92fg
 FoPvgpKAr9yYlLfFxT5YO3azGRBJXKbrLPSlFDYQx5rbAEI9AvaPWrRWvoiiRUJ1oD4L
 rgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DpOgg3Kpk9iHHtPiAspA1efXCA5xLwUmidYPh6SGPLw=;
 b=T8vOj9wYhnOSPhW2OsYCfzNdvIBSatZbe/VarTSqPoigODYwQNcxuIq3/OaoOB4rjM
 e7q0PEB+jNEbPmZa+OX7lFL6xclJc02/ju1p7u/BKoqMlLnE4+7K8nPInw5ZZrK/4uom
 n5ADhLuGznZSftiovH3vF3bnZ1i8V+6p/Si8RCgEbsAUh27aLW+xgmZuIqQiV5uixTzV
 ZYYYZjUgDXX+MGulI/5S+DzutLhb0/kNTFe1dolPsLCYXycbt125mBFmZV5GjXjoQyoH
 /eH9cgoT2lw8piy2rmrKolCyb6iSfJjDFk670UqUTD+8D2ME7/cW6v+UctnG1fjL7jEh
 XVTg==
X-Gm-Message-State: AOAM533N06ucgCklx3jSfWxZgDuDTS556m2gH72OjHBSNZfWzVSJ7VJ4
 Z/v97yaR1Mw3gb1P4rG8MW1rsfq9DXMVUx/WoOs=
X-Google-Smtp-Source: ABdhPJwN+Chevna71Yq5pHzR+R1Jwo1aF8u5ozKVimYnL0Itz72b1vuctauDFFDVrHhcsw3ane2Paec9N3oiPbXNyyk=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr1675552oap.253.1650463056311; Wed, 20
 Apr 2022 06:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220413201522.2084041-1-alexander.deucher@amd.com>
 <CADnq5_PGe7L+sKw4+wiq5DO6OfDqvJfPS9R8eORnAUDbpw14pw@mail.gmail.com>
In-Reply-To: <CADnq5_PGe7L+sKw4+wiq5DO6OfDqvJfPS9R8eORnAUDbpw14pw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Apr 2022 09:57:25 -0400
Message-ID: <CADnq5_PO7v8nM2FueQNxmJfhuvHCLfhgsYaVeSHb0qmfppxbKw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: don't runtime suspend if there are displays
 attached (v2)
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: Michele Ballabio <ballabio.m@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?  Anyone care to review this?

Alex

On Tue, Apr 19, 2022 at 9:47 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Ping?
>
> On Wed, Apr 13, 2022 at 4:15 PM Alex Deucher <alexander.deucher@amd.com> wrote:
> >
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
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 107 ++++++++++++++++--------
> >  1 file changed, 72 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 4efaa183abcd..97a1aa02d76e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -2395,6 +2395,71 @@ static int amdgpu_pmops_restore(struct device *dev)
> >         return amdgpu_device_resume(drm_dev, true);
> >  }
> >
> > +static int amdgpu_runtime_idle_check_display(struct device *dev)
> > +{
> > +       struct pci_dev *pdev = to_pci_dev(dev);
> > +       struct drm_device *drm_dev = pci_get_drvdata(pdev);
> > +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
> > +
> > +       if (adev->mode_info.num_crtc) {
> > +               struct drm_connector *list_connector;
> > +               struct drm_connector_list_iter iter;
> > +               int ret = 0;
> > +
> > +               /* XXX: Return busy if any displays are connected to avoid
> > +                * possible display wake ups after runtime resume due to
> > +                * hotplug events in case any displays were connected while
> > +                * the GPU was in suspend.  Remove this once that is fixed.
> > +                */
> > +               mutex_lock(&drm_dev->mode_config.mutex);
> > +               drm_connector_list_iter_begin(drm_dev, &iter);
> > +               drm_for_each_connector_iter(list_connector, &iter) {
> > +                       if (list_connector->status == connector_status_connected) {
> > +                               ret = -EBUSY;
> > +                               break;
> > +                       }
> > +               }
> > +               drm_connector_list_iter_end(&iter);
> > +               mutex_unlock(&drm_dev->mode_config.mutex);
> > +
> > +               if (ret)
> > +                       return ret;
> > +
> > +               if (amdgpu_device_has_dc_support(adev)) {
> > +                       struct drm_crtc *crtc;
> > +
> > +                       drm_for_each_crtc(crtc, drm_dev) {
> > +                               drm_modeset_lock(&crtc->mutex, NULL);
> > +                               if (crtc->state->active)
> > +                                       ret = -EBUSY;
> > +                               drm_modeset_unlock(&crtc->mutex);
> > +                               if (ret < 0)
> > +                                       break;
> > +                       }
> > +               } else {
> > +                       mutex_lock(&drm_dev->mode_config.mutex);
> > +                       drm_modeset_lock(&drm_dev->mode_config.connection_mutex, NULL);
> > +
> > +                       drm_connector_list_iter_begin(drm_dev, &iter);
> > +                       drm_for_each_connector_iter(list_connector, &iter) {
> > +                               if (list_connector->dpms ==  DRM_MODE_DPMS_ON) {
> > +                                       ret = -EBUSY;
> > +                                       break;
> > +                               }
> > +                       }
> > +
> > +                       drm_connector_list_iter_end(&iter);
> > +
> > +                       drm_modeset_unlock(&drm_dev->mode_config.connection_mutex);
> > +                       mutex_unlock(&drm_dev->mode_config.mutex);
> > +               }
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static int amdgpu_pmops_runtime_suspend(struct device *dev)
> >  {
> >         struct pci_dev *pdev = to_pci_dev(dev);
> > @@ -2407,6 +2472,10 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
> >                 return -EBUSY;
> >         }
> >
> > +       ret = amdgpu_runtime_idle_check_display(dev);
> > +       if (ret)
> > +               return ret;
> > +
> >         /* wait for all rings to drain before suspending */
> >         for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> >                 struct amdgpu_ring *ring = adev->rings[i];
> > @@ -2516,41 +2585,9 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
> >                 return -EBUSY;
> >         }
> >
> > -       if (amdgpu_device_has_dc_support(adev)) {
> > -               struct drm_crtc *crtc;
> > -
> > -               drm_for_each_crtc(crtc, drm_dev) {
> > -                       drm_modeset_lock(&crtc->mutex, NULL);
> > -                       if (crtc->state->active)
> > -                               ret = -EBUSY;
> > -                       drm_modeset_unlock(&crtc->mutex);
> > -                       if (ret < 0)
> > -                               break;
> > -               }
> > -
> > -       } else {
> > -               struct drm_connector *list_connector;
> > -               struct drm_connector_list_iter iter;
> > -
> > -               mutex_lock(&drm_dev->mode_config.mutex);
> > -               drm_modeset_lock(&drm_dev->mode_config.connection_mutex, NULL);
> > -
> > -               drm_connector_list_iter_begin(drm_dev, &iter);
> > -               drm_for_each_connector_iter(list_connector, &iter) {
> > -                       if (list_connector->dpms ==  DRM_MODE_DPMS_ON) {
> > -                               ret = -EBUSY;
> > -                               break;
> > -                       }
> > -               }
> > -
> > -               drm_connector_list_iter_end(&iter);
> > -
> > -               drm_modeset_unlock(&drm_dev->mode_config.connection_mutex);
> > -               mutex_unlock(&drm_dev->mode_config.mutex);
> > -       }
> > -
> > -       if (ret == -EBUSY)
> > -               DRM_DEBUG_DRIVER("failing to power off - crtc active\n");
> > +       ret = amdgpu_runtime_idle_check_display(dev);
> > +       if (ret)
> > +               return ret;
> >
> >         pm_runtime_mark_last_busy(dev);
> >         pm_runtime_autosuspend(dev);
> > --
> > 2.35.1
> >
