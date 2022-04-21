Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C117C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 04:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 036D110F330;
	Thu, 21 Apr 2022 04:40:38 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05BCD10F330
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 04:40:37 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-d6e29fb3d7so4253131fac.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 21:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jMje/M6zAwzIg9LXDgsLMT9wngdo5n1MHKVh8BPYFsk=;
 b=LrOmBbqQbr1Bs1q8zPhIAbB36n3s7Rc9T/aJBG6bPRSPCquYmSMkTLCL6ZU/WEzmdo
 BcCu7uG0C8cSfJbb/6JYBrvB8Z6uqA8Feis0RAIBmzuNKwhS81riDu51LC9VoBQCSqxh
 pQKgx2d5aOkGgb+kDpmpLBAX22ZabVETGp5/l1TTQdiSoZ2HIBUfhWMa6j4vl8+hnO6J
 r+pwIKN0Cb7VhFnnWyHRDB1deFQzAd1RoX/n7pps/aQNuBywrTE6zkloSk6dxRwrU6wj
 O7CKd72G6iFV91xkPYFnwYrcAD9f7nRANvmeLrGAbKICo65IbafNclpUQASwrREqREwi
 VV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jMje/M6zAwzIg9LXDgsLMT9wngdo5n1MHKVh8BPYFsk=;
 b=D+KCJDZAtVVe97Bikk9WUWz4ofVMY0+/RVAuNDhR5XZNbS2Gg9Os58lkKqmhom8ilP
 ST/0Tdy5oJBsRIttAp6vFhGrjyn0iins93vHHSnEr+ja/zkwUwlma9363kvTwIDrp7oQ
 CZyaPh4wn54aoKVd41JKGhAXLXM6fGpBFm/M7TM6jD7OfKxek66pgS1OwZSMHNKEgPlS
 yf3veJIzBZaNYwtGLj89L49BNxA5FhhvRiptv8kOkCUtKlnDZlBPtSumD/5q6yqmyxA/
 28I7qm5Hp/ZeTMmr/PrL1MNiR0zrGgw8XL+Kv/FtEc/A3E/CU5+r78cdG83r9okCV/eK
 Ozew==
X-Gm-Message-State: AOAM533TQuRewDBPz3H9HO4Qprrixx0ltVwdj6kFOjJa974sHqi/bG6P
 dJ98vtONC1lWY0DIchRgjaMqeAGavGrT1M8kl35HwJ2s
X-Google-Smtp-Source: ABdhPJx7+XgGnihqfozk75qAc7KUnU0yXpF+zrdRLIVMRQcT/MKEkOyg2RHtqHW+wBRCb4p3kYeviSf/Hj+/x7shbjw=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr3184802oap.253.1650516036186; Wed, 20
 Apr 2022 21:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220421031607.1745623-1-alexander.deucher@amd.com>
In-Reply-To: <20220421031607.1745623-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Apr 2022 00:40:25 -0400
Message-ID: <CADnq5_Ox3=tFbV595QNKq_DYwQey=+u8O-T=CoHU7jf4dJJ8bg@mail.gmail.com>
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

Should be v3, fixed locally.

Alex

On Wed, Apr 20, 2022 at 11:16 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> We normally runtime suspend when there are displays attached if they
> are in the DPMS off state, however, if something wakes the GPU
> we send a hotplug event on resume (in case any displays were connected
> while the GPU was in suspend) which can cause userspace to light
> up the displays again soon after they were turned off.
>
> Prior to
> commit 087451f372bf76 ("drm/amdgpu: use generic fb helpers instead of setting up AMD own's."),
> the driver took a runtime pm reference when the fbdev emulation was
> enabled because we didn't implement proper shadowing support for
> vram access when the device was off so the device never runtime
> suspended when there was a console bound.  Once that commit landed,
> we now utilize the core fb helper implementation which properly
> handles the emulation, so runtime pm now suspends in cases where it did
> not before.  Ultimately, we need to sort out why runtime suspend in not
> working in this case for some users, but this should restore similar
> behavior to before.
>
> v2: move check into runtime_suspend
> v3: wake ups -> wakeups in comment, retain pm_runtime behavior in
>     runtime_idle callback
>
> Fixes: 087451f372bf76 ("drm/amdgpu: use generic fb helpers instead of setting up AMD own's.")
> Tested-by: Michele Ballabio <ballabio.m@gmail.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 105 ++++++++++++++++--------
>  1 file changed, 70 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4efaa183abcd..ebd37fb19cdb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2395,6 +2395,71 @@ static int amdgpu_pmops_restore(struct device *dev)
>         return amdgpu_device_resume(drm_dev, true);
>  }
>
> +static int amdgpu_runtime_idle_check_display(struct device *dev)
> +{
> +       struct pci_dev *pdev = to_pci_dev(dev);
> +       struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
> +
> +       if (adev->mode_info.num_crtc) {
> +               struct drm_connector *list_connector;
> +               struct drm_connector_list_iter iter;
> +               int ret = 0;
> +
> +               /* XXX: Return busy if any displays are connected to avoid
> +                * possible display wakeups after runtime resume due to
> +                * hotplug events in case any displays were connected while
> +                * the GPU was in suspend.  Remove this once that is fixed.
> +                */
> +               mutex_lock(&drm_dev->mode_config.mutex);
> +               drm_connector_list_iter_begin(drm_dev, &iter);
> +               drm_for_each_connector_iter(list_connector, &iter) {
> +                       if (list_connector->status == connector_status_connected) {
> +                               ret = -EBUSY;
> +                               break;
> +                       }
> +               }
> +               drm_connector_list_iter_end(&iter);
> +               mutex_unlock(&drm_dev->mode_config.mutex);
> +
> +               if (ret)
> +                       return ret;
> +
> +               if (amdgpu_device_has_dc_support(adev)) {
> +                       struct drm_crtc *crtc;
> +
> +                       drm_for_each_crtc(crtc, drm_dev) {
> +                               drm_modeset_lock(&crtc->mutex, NULL);
> +                               if (crtc->state->active)
> +                                       ret = -EBUSY;
> +                               drm_modeset_unlock(&crtc->mutex);
> +                               if (ret < 0)
> +                                       break;
> +                       }
> +               } else {
> +                       mutex_lock(&drm_dev->mode_config.mutex);
> +                       drm_modeset_lock(&drm_dev->mode_config.connection_mutex, NULL);
> +
> +                       drm_connector_list_iter_begin(drm_dev, &iter);
> +                       drm_for_each_connector_iter(list_connector, &iter) {
> +                               if (list_connector->dpms ==  DRM_MODE_DPMS_ON) {
> +                                       ret = -EBUSY;
> +                                       break;
> +                               }
> +                       }
> +
> +                       drm_connector_list_iter_end(&iter);
> +
> +                       drm_modeset_unlock(&drm_dev->mode_config.connection_mutex);
> +                       mutex_unlock(&drm_dev->mode_config.mutex);
> +               }
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
>  static int amdgpu_pmops_runtime_suspend(struct device *dev)
>  {
>         struct pci_dev *pdev = to_pci_dev(dev);
> @@ -2407,6 +2472,10 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>                 return -EBUSY;
>         }
>
> +       ret = amdgpu_runtime_idle_check_display(dev);
> +       if (ret)
> +               return ret;
> +
>         /* wait for all rings to drain before suspending */
>         for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>                 struct amdgpu_ring *ring = adev->rings[i];
> @@ -2516,41 +2585,7 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
>                 return -EBUSY;
>         }
>
> -       if (amdgpu_device_has_dc_support(adev)) {
> -               struct drm_crtc *crtc;
> -
> -               drm_for_each_crtc(crtc, drm_dev) {
> -                       drm_modeset_lock(&crtc->mutex, NULL);
> -                       if (crtc->state->active)
> -                               ret = -EBUSY;
> -                       drm_modeset_unlock(&crtc->mutex);
> -                       if (ret < 0)
> -                               break;
> -               }
> -
> -       } else {
> -               struct drm_connector *list_connector;
> -               struct drm_connector_list_iter iter;
> -
> -               mutex_lock(&drm_dev->mode_config.mutex);
> -               drm_modeset_lock(&drm_dev->mode_config.connection_mutex, NULL);
> -
> -               drm_connector_list_iter_begin(drm_dev, &iter);
> -               drm_for_each_connector_iter(list_connector, &iter) {
> -                       if (list_connector->dpms ==  DRM_MODE_DPMS_ON) {
> -                               ret = -EBUSY;
> -                               break;
> -                       }
> -               }
> -
> -               drm_connector_list_iter_end(&iter);
> -
> -               drm_modeset_unlock(&drm_dev->mode_config.connection_mutex);
> -               mutex_unlock(&drm_dev->mode_config.mutex);
> -       }
> -
> -       if (ret == -EBUSY)
> -               DRM_DEBUG_DRIVER("failing to power off - crtc active\n");
> +       ret = amdgpu_runtime_idle_check_display(dev);
>
>         pm_runtime_mark_last_busy(dev);
>         pm_runtime_autosuspend(dev);
> --
> 2.35.1
>
