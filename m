Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5E2C433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 19:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E9E2073A
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 19:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evnoEYva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E9E2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BFA16E519;
	Fri, 28 Aug 2020 19:19:50 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 516816E519
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 19:19:49 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id c19so250457wmd.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 12:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xIo15YsjT5D7Ga8CTcYbUiWome3UMxrIjS2BSzNSYu4=;
 b=evnoEYvakkdyZ9J6pn5ZlLzthcVysK9pABuOPCFc7pG07MjC7HRQh2W1GLF2Xiyg3d
 TPNctTGu/pEuEXnmLEXW3ePSV7rA7090bvhnBaUZbomvFJnSFxyFjX9mO76QP/ZdpLfN
 nEKM0RGFDZolyMVVV8giAom4gisnvqqUcrzU0DghkSR55WKfSggX9hMjjxeVqJJsj/qY
 WjvK6emTvDyt2zIS3yeUr4mzJldaoyUn7LOFBz10qe6xzfRS6r++9YNNN8+U887sRaNt
 hX+9BsHY97FN9l1FQHeZt2QVaLcoXztG6pCUHeAG7ocd4Nfgu8JEqtyFfRi8cWyP87Tb
 WUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xIo15YsjT5D7Ga8CTcYbUiWome3UMxrIjS2BSzNSYu4=;
 b=ck2cLRHBttDMR05f/ny7zm/5Yc7n+0FiO+PtEwleSgFsIHi6gQXXwWuFvNY4SLA7DG
 SyNE1nvQ4dAOAne0ZfMbLtMiYJfsruz6N3+J4MXTuj62OjW5vcNmHXsRUsvgGU7gC0bZ
 OH0nfgAW1/5/1CdCDZuIWWHN6UiiCL6ouTJPXarCJxn6m2iGRSyccu23jMO6JNhPdyqn
 nFnOPFie27f3ujH1GrJZZsHNn5FO8oQ30G30Q5geDVCJB37DiQWZYW6MaTc7n+UMqKO+
 m3DAyv/0ywJ/uu9djTzqGpq5TgLO4UeXCQ0qiiBGUdABau0iZ73191fwyZ7KIHm4TQs0
 S2bg==
X-Gm-Message-State: AOAM530kirfSfIwUaSSIXSdA/HY4BA2Ox5xlhYl0yPqt1ItiperP6RRh
 EQ4jnjr6GI8+IFybjzMy/R42Glb4vAE5sxL8WBc=
X-Google-Smtp-Source: ABdhPJxU5Olc2BOER0DvE4MiOx8ipDz4LgExoveLAUa2226XNb0bSvOFXQJVM8Bf5ya6yQC+1Bb3Ftss4GfsmN4jZwg=
X-Received: by 2002:a7b:c941:: with SMTP id i1mr148931wml.73.1598642387874;
 Fri, 28 Aug 2020 12:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <1598630743-21155-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598630743-21155-6-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1598630743-21155-6-git-send-email-andrey.grodzovsky@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Aug 2020 15:19:36 -0400
Message-ID: <CADnq5_PrsW0rrkeKOgYm5ZG7f86etycgmnbYYbewGXozGLwoqA@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] drm/amdgpu: Fix consecutive DPC recovery failures.
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
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Aug 28, 2020 at 12:06 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> Cache the PCI state on boot and before each case were we might
> loose it.
>
> v2: Add pci_restore_state while caching the PCI state to avoid
> breaking PCI core logic for stuff like suspend/resume.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  6 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 59 ++++++++++++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +-
>  drivers/gpu/drm/amd/amdgpu/nv.c            |  4 +-
>  drivers/gpu/drm/amd/amdgpu/soc15.c         |  4 +-
>  5 files changed, 67 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index cac51e8..5e74db6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -992,7 +992,9 @@ struct amdgpu_device {
>         atomic_t                        throttling_logging_enabled;
>         struct ratelimit_state          throttling_logging_rs;
>         uint32_t                        ras_features;
> +
>         bool                            in_pci_err_recovery;
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
> index 06664a9..7f1b970 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1284,7 +1284,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
>                 dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>
>                 pci_set_power_state(dev->pdev, PCI_D0);
> -               pci_restore_state(dev->pdev);
> +               amdgpu_device_load_pci_state(dev->pdev);
>                 r = pci_enable_device(dev->pdev);
>                 if (r)
>                         DRM_WARN("pci_enable_device failed (%d)\n", r);
> @@ -1297,7 +1297,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
>                 drm_kms_helper_poll_disable(dev);
>                 dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>                 amdgpu_device_suspend(dev, true);
> -               pci_save_state(dev->pdev);
> +               amdgpu_device_cache_pci_state(dev->pdev);
>                 /* Shut down the device */
>                 pci_disable_device(dev->pdev);
>                 pci_set_power_state(dev->pdev, PCI_D3cold);
> @@ -3402,6 +3402,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         if (r)
>                 dev_err(adev->dev, "amdgpu_pmu_init failed\n");
>
> +       /* Have stored pci confspace at hand for restore in sudden PCI error */
> +       if (!amdgpu_device_cache_pci_state(adev->pdev))
> +               DRM_WARN("Failed to cache PCI state!");

We should call pci_restore_state(pdev) here rather than in the helpers
otherwise we incur the extra overhead in all cases and it's not
necessary.

>         return 0;
>
>  failed:
> @@ -3428,6 +3431,8 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>         flush_delayed_work(&adev->delayed_init_work);
>         adev->shutdown = true;
>
> +       kfree(adev->pci_state);
> +
>         /* make sure IB test finished before entering exclusive mode
>          * to avoid preemption on IB test
>          * */
> @@ -4853,7 +4858,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>         /* wait for asic to come out of reset */
>         msleep(500);
>
> -       pci_restore_state(pdev);
> +       amdgpu_device_load_pci_state(pdev);
>
>         /* confirm  ASIC came out of reset */
>         for (i = 0; i < adev->usec_timeout; i++) {
> @@ -4932,8 +4937,10 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
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
> @@ -4972,3 +4979,47 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
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
> +               pci_restore_state(pdev);

We don't want to restore this here.  See my comment above.

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
