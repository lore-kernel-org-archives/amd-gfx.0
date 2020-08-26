Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8609C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 15:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE7D214F1
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 15:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAMCBGQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE7D214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D78FC6EAB8;
	Wed, 26 Aug 2020 15:20:52 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C5386EAAF
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 15:20:27 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id t14so2170194wmi.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 08:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+ebH4Cwi6RUM6dSfpENRMQscRVOf098pNTiV6uRLh9c=;
 b=GAMCBGQxAllP0MpFZJHBRPGZDO+MUjHSkx/Hr0XN21DbUDw4r2xg3crVBmpU7Azs9T
 gxPpwzoaY40Lneca8IX2zYTDzzFDUsugWzzj26H9m9wlXCtLpXoU13goyTNZU+OVc21g
 D1DlA6H1apgSNZG1k3W8f434rUjGV6eLAcZc5xBeb/P/J4RoFJYE2NL/nimOLc+q+Dy4
 p2UzJzPl9D+POaIkOl1wW1ae0xBt9TUVKAj0K59/62MS+MD1Kh/JWBenM0xJQm840UX7
 QHZ2dR4NAjxQn4WYw9N5uIYqL7TSDSVRKAZBkQcogVAC5HrGiompP7AhTWN1xR2XisOb
 IRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+ebH4Cwi6RUM6dSfpENRMQscRVOf098pNTiV6uRLh9c=;
 b=SqVGc2efkgx15EaYDotI2eWcmJBTYwP4ZwqtcldsHC2KlE+3ONbOmdGUXQ44dPQevv
 t8+Lsrz55TGG0ltyY8BRkczuTj19u+n4+Fi5+XNEik/q6lHO1q1T5L+csertYcz5D3m3
 YRQHV9S/WZwWjg2pU0uVbLfKOMZJu/BtB7Qjih6KLeRMp0Lz0/WvaZipqmL8V+ae+ZU9
 zCpVQNkR574sGQMlq8f0J8mVvexO1GrDbxLkoa8zaJ6sGUyHzFR/skqqSu3I+/fafGFv
 Nke452l53/Lb3GTaVGtENBnSRj9asOoleo3RRNT/hj/d9aukqRP5yCBZalo3QXfFOxjl
 6QHQ==
X-Gm-Message-State: AOAM530HhLPtVpzDG4yvqtanW3LmnLgILNoOsBy8GIH8Iy0oZVyT5V48
 SREQNYOTGD8KPYOE+w5wWvU0xo8GptY6XQw0iM5gHLMuQUU=
X-Google-Smtp-Source: ABdhPJzE+yDduXNS0MOZlBcBU4U8AJqh6YlSy++OudicXAJH/QDZJdwdIqM/b4QdF9ejkRrenrz3sYkG8jD7n8taPK8=
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr7582921wmh.39.1598455225834; 
 Wed, 26 Aug 2020 08:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598453182-6946-6-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1598453182-6946-6-git-send-email-andrey.grodzovsky@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Aug 2020 11:20:14 -0400
Message-ID: <CADnq5_NtAaNd3_XYrs4K8uLFF49Xv-46801Cy3Y0fNuLG_YPoA@mail.gmail.com>
Subject: Re: [PATCH 5/7] drm/amdgpu: Fix consecutive DPC recoveries failure.
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Nirmoy <nirmodas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Aug 26, 2020 at 10:46 AM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> DPC recovery after prev. DPC recovery or after prev. MODE1 reset fails
> unles you save the cashe the saved PCI confspace to load it after
> each new reset.
> Also use same cached state for other use case of restoring PCI confspace
> such as GPU mode1 or VGA switheroo.
>

We don't want to keep the saved state around in the pci core
otherwise, the pci core will assume we are managing the saved state
for suspend and resume.  I think we want logic like this:

At driver load time:
pci_save_state(pdev);
adev->pci_state = pci_store_saved_state(pdev);
pci_restore_state(adev->pdev);

then in the case of dpc, do:
pci_load_saved_state(pdev, adev->pci_state);

For all the other cases, just leave the code as is.

Alex


> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  6 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60 +++++++++++++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +-
>  drivers/gpu/drm/amd/amdgpu/nv.c            |  4 +-
>  drivers/gpu/drm/amd/amdgpu/soc15.c         |  4 +-
>  5 files changed, 66 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3489622..42ee208 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -992,7 +992,9 @@ struct amdgpu_device {
>         atomic_t                        throttling_logging_enabled;
>         struct ratelimit_state          throttling_logging_rs;
>         uint32_t                        ras_features;
> +

Unrelated whitespace changes.

>         bool                            in_dpc;
> +       struct pci_saved_state          *pci_state;
>  };
>
>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> @@ -1272,6 +1274,10 @@ pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev);
>  pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev);
>  void amdgpu_pci_resume(struct pci_dev *pdev);
>
> +bool amdgpu_device_cache_pci_state(struct pci_dev *pdev);
> +bool amdgpu_device_load_pci_state(struct pci_dev *pdev);
> +
> +
>
>  #include "amdgpu_object.h"
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d9e3994..2c088df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1283,7 +1283,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
>                 dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>
>                 pci_set_power_state(dev->pdev, PCI_D0);
> -               pci_restore_state(dev->pdev);
> +               amdgpu_device_load_pci_state(dev->pdev);
>                 r = pci_enable_device(dev->pdev);
>                 if (r)
>                         DRM_WARN("pci_enable_device failed (%d)\n", r);
> @@ -1296,7 +1296,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
>                 drm_kms_helper_poll_disable(dev);
>                 dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>                 amdgpu_device_suspend(dev, true);
> -               pci_save_state(dev->pdev);
> +               amdgpu_device_cache_pci_state(dev->pdev);
>                 /* Shut down the device */
>                 pci_disable_device(dev->pdev);
>                 pci_set_power_state(dev->pdev, PCI_D3cold);
> @@ -3401,8 +3401,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         if (r)
>                 dev_err(adev->dev, "amdgpu_pmu_init failed\n");
>
> -       if (pci_save_state(pdev))
> -               DRM_ERROR("Failed to save PCI state!!\n");
> +       /* Have stored pci confspace at hand for restore in sudden PCI error */
> +       if (!amdgpu_device_cache_pci_state(adev->pdev))
> +               DRM_WARN("Failed to cache PCI state!");
>
>         return 0;
>
> @@ -3430,6 +3431,8 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>         flush_delayed_work(&adev->delayed_init_work);
>         adev->shutdown = true;
>
> +       kfree(adev->pci_state);
> +
>         /* make sure IB test finished before entering exclusive mode
>          * to avoid preemption on IB test
>          * */
> @@ -4855,7 +4858,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>         /* wait for asic to come out of reset */
>         msleep(500);
>
> -       pci_restore_state(pdev);
> +       amdgpu_device_load_pci_state(pdev);
>
>         /* confirm  ASIC came out of reset */
>         for (i = 0; i < adev->usec_timeout; i++) {
> @@ -4934,8 +4937,10 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>
>  out:
>
> -       if (!r)
> +       if (!r) {
> +               amdgpu_device_cache_pci_state(adev->pdev);
>                 DRM_INFO("PCIe error recovery succeeded\n");
> +       }
>         else {
>                 DRM_ERROR("PCIe error recovery failed, err:%d", r);
>                 amdgpu_device_unlock_adev(adev);
> @@ -4974,3 +4979,46 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
>
>         amdgpu_device_unlock_adev(adev);
>  }
> +
> +bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
> +{
> +       struct drm_device *dev = pci_get_drvdata(pdev);
> +       struct amdgpu_device *adev = drm_to_adev(dev);
> +       int r;
> +
> +       r = pci_save_state(pdev);
> +       if (!r) {
> +               kfree(adev->pci_state);
> +
> +               adev->pci_state = pci_store_saved_state(pdev);
> +
> +               if (!adev->pci_state) {
> +                       DRM_ERROR("Failed to store PCI saved state");
> +                       return false;
> +               }
> +       } else {
> +               DRM_WARN("Failed to save PCI state, err:%d\n", r);
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +bool amdgpu_device_load_pci_state(struct pci_dev *pdev)
> +{
> +       struct drm_device *dev = pci_get_drvdata(pdev);
> +       struct amdgpu_device *adev = drm_to_adev(dev);
> +       int r;
> +
> +       if (!adev->pci_state)
> +               return false;
> +
> +       r = pci_load_saved_state(pdev, adev->pci_state);
> +
> +       if (!r) {
> +               pci_restore_state(pdev);
> +       } else {
> +               DRM_WARN("Failed to load PCI state, err:%d\n", r);
> +               return false;
> +       }
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4bbcc70..7a6482a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1320,7 +1320,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>                 if (amdgpu_is_atpx_hybrid()) {
>                         pci_ignore_hotplug(pdev);
>                 } else {
> -                       pci_save_state(pdev);
> +                       amdgpu_device_cache_pci_state(pdev);
>                         pci_disable_device(pdev);
>                         pci_ignore_hotplug(pdev);
>                         pci_set_power_state(pdev, PCI_D3cold);
> @@ -1353,7 +1353,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>                         pci_set_master(pdev);
>                 } else {
>                         pci_set_power_state(pdev, PCI_D0);
> -                       pci_restore_state(pdev);
> +                       amdgpu_device_load_pci_state(pdev);
>                         ret = pci_enable_device(pdev);
>                         if (ret)
>                                 return ret;
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 4d14023..0ec6603 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -311,7 +311,7 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
>         /* disable BM */
>         pci_clear_master(adev->pdev);
>
> -       pci_save_state(adev->pdev);
> +       amdgpu_device_cache_pci_state(adev->pdev);
>
>         if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
>                 dev_info(adev->dev, "GPU smu mode1 reset\n");
> @@ -323,7 +323,7 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
>
>         if (ret)
>                 dev_err(adev->dev, "GPU mode1 reset failed\n");
> -       pci_restore_state(adev->pdev);
> +       amdgpu_device_load_pci_state(adev->pdev);
>
>         /* wait for asic to come out of reset */
>         for (i = 0; i < adev->usec_timeout; i++) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 2f93c47..ddd55e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -484,13 +484,13 @@ static int soc15_asic_mode1_reset(struct amdgpu_device *adev)
>         /* disable BM */
>         pci_clear_master(adev->pdev);
>
> -       pci_save_state(adev->pdev);
> +       amdgpu_device_cache_pci_state(adev->pdev);
>
>         ret = psp_gpu_reset(adev);
>         if (ret)
>                 dev_err(adev->dev, "GPU mode1 reset failed\n");
>
> -       pci_restore_state(adev->pdev);
> +       amdgpu_device_load_pci_state(adev->pdev);
>
>         /* wait for asic to come out of reset */
>         for (i = 0; i < adev->usec_timeout; i++) {
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
