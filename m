Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4163CC433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 14:13:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051CB2086A
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 14:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjTfhM3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051CB2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B99E16E4B5;
	Fri, 28 Aug 2020 14:13:16 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3F776E4B5
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 14:13:15 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id a65so1063593wme.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 07:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4btmyjFhxXB73f0ymB/dEdWzv7GS9M/oazn8nCZPiKE=;
 b=FjTfhM3Hl6dNnXLRURR63YcgJ6eMkfk9Vf9kkTCuj6EqRs7mVoaEfN0NqThB4Fr8Nx
 cRI2D84i1R0kiBa7aVt5NaXQNPkc6QQvtipOeznoN1K1jyMUR081T3A0I8kdxf5l66dW
 C1Ruow9K+Cr0BRKD3dOJcR47zmkcinehi3F2YvuBMkxsaoNeLIiWGD03ALlIAnqUsiZ+
 +ojtHBKqm1fuF9rPpx01gA+NGZ2vg5qFDtG1swMJJyNUc/BKdpx3mnxktWV1OUgFwbTb
 dipQqYAZ4EVwaIJocdqpT/QqlCGNoEbLpI9yFdk9LPTU6Mq6krwPYMzJBPmZBwJ44kPM
 rbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4btmyjFhxXB73f0ymB/dEdWzv7GS9M/oazn8nCZPiKE=;
 b=QmopXpZO60YUqOwMuBrxfxbLBTRkIRGEbrULMaxCOKD4yVbXFtlyS/QmTI5/+hreIm
 ecnXSuC4NJSfpCgcwFqKXEa/HD2ho7Kg95QR1ysc9l6IlI4pU/ftAIr6y426uLu6agyZ
 o7bNF7r+9QXkeDDV61+6H2r6tQaMfAnCHk7poPS01+7ec1KfRyl+gaNJJVscRo84Scwq
 PZaOvUjtUHOFAtQa8ksj38ojhHS8fCw9LBD7MQHfmLG60Ui1lTsYWrpASoQ4fIjKOB8A
 nXG1fzRUgydgp6UXxYqNBvLUaVKDJuH53A+WOfZTaf2jp/6LjNqzzGkROZuoPtI5o0ZN
 WzIg==
X-Gm-Message-State: AOAM5307qGlZMuVO8uedXAP4yrqTNQszlcJ2MGPYG9bGE2pQXJ6Y9ejA
 LeY/EyOWPiSjtt590dCJIu7DLiM5KcMlN+rZoWI4gmNfUvg=
X-Google-Smtp-Source: ABdhPJz5uQxCMevK+LNGteK787BAyiFPHX2v4hCqI2r72mHUzMAgq7ixnM78Gq24pvCKBBv8h76G3WGC1OMsQ5vqZaM=
X-Received: by 2002:a7b:c941:: with SMTP id i1mr1805067wml.73.1598623994414;
 Fri, 28 Aug 2020 07:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598453182-6946-6-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_NtAaNd3_XYrs4K8uLFF49Xv-46801Cy3Y0fNuLG_YPoA@mail.gmail.com>
 <0c2ada8e-5dde-0165-c8b3-cf6d6d3fba46@amd.com>
In-Reply-To: <0c2ada8e-5dde-0165-c8b3-cf6d6d3fba46@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Aug 2020 10:13:03 -0400
Message-ID: <CADnq5_MJEsSp1UKXDf-1saNTKV_i3E6vtnMCgGesAz=Resk78Q@mail.gmail.com>
Subject: Re: [PATCH 5/7] drm/amdgpu: Fix consecutive DPC recoveries failure.
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
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

On Thu, Aug 27, 2020 at 10:54 AM Andrey Grodzovsky
<Andrey.Grodzovsky@amd.com> wrote:
>
>
> On 8/26/20 11:20 AM, Alex Deucher wrote:
> > On Wed, Aug 26, 2020 at 10:46 AM Andrey Grodzovsky
> > <andrey.grodzovsky@amd.com> wrote:
> >> DPC recovery after prev. DPC recovery or after prev. MODE1 reset fails
> >> unles you save the cashe the saved PCI confspace to load it after
> >> each new reset.
> >> Also use same cached state for other use case of restoring PCI confspace
> >> such as GPU mode1 or VGA switheroo.
> >>
> > We don't want to keep the saved state around in the pci core
> > otherwise, the pci core will assume we are managing the saved state
> > for suspend and resume.  I think we want logic like this:
> >
> > At driver load time:
> > pci_save_state(pdev);
> > adev->pci_state = pci_store_saved_state(pdev);
> > pci_restore_state(adev->pdev);
> >
> > then in the case of dpc, do:
> > pci_load_saved_state(pdev, adev->pci_state);
> >
> > For all the other cases, just leave the code as is.
>
>
> Actually, as we already discussed - caching the PCI confspace only once on boot
> and not doing it again after each subsequent
> controlled or spontaneous reset runs the risk of loading back outdated confspace
> settings. I am not sure if and when but, is it indeed
> possible we make changes to PCI confspace registers during runtime and so the
> cached state from boot might be outdated
> to load back ?

As Christain noted we may change config space at load time if we
resize the BAR.  So we should probably save config space at the end of
the driver load init sequence.  This saved state is just a backup in
case something kills pci config space without saving it.  I think it's
fine to update the cached copy whenever we call pci_save_state(), but
what we don't want to do is call pci_save_state() at init time without
calling pci_restore_state().  pci_save_state() caches a copy of the
save state in the pdev structure.  The pci core uses the presence of
this cached state to make decisions about whether the driver or the
core should handle a bunch of stuff at suspend/resume.  If the cached
state is present, it assumes the driver will be handling all of the
pci related state management for power management.  I'd rather keep
that in the core.  I think the patch is good, but this part needs to
be reworked:

@@ -3401,8 +3401,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        if (r)
                dev_err(adev->dev, "amdgpu_pmu_init failed\n");

-       if (pci_save_state(pdev))
-               DRM_ERROR("Failed to save PCI state!!\n");
+       /* Have stored pci confspace at hand for restore in sudden PCI error */
+       if (!amdgpu_device_cache_pci_state(adev->pdev))
+               DRM_WARN("Failed to cache PCI state!");

Something like this:

@@ -3401,8 +3401,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        if (r)
                dev_err(adev->dev, "amdgpu_pmu_init failed\n");

-       if (pci_save_state(pdev))
-               DRM_ERROR("Failed to save PCI state!!\n");
+       /* Have stored pci confspace at hand for restore in sudden PCI error */
+       if (!amdgpu_device_cache_pci_state(adev->pdev))
+               DRM_WARN("Failed to cache PCI state!");
+       if (!amdgpu_device_load_pci_state(adev->pdev))
+               DRM_WARN("Failed to restore PCI state!");

This way we have a cached copy in the driver but not in the pci core.


Alex


>
> Andrey
>
>
> >
> > Alex
> >
> >
> >> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  6 +++
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60 +++++++++++++++++++++++++++---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +-
> >>   drivers/gpu/drm/amd/amdgpu/nv.c            |  4 +-
> >>   drivers/gpu/drm/amd/amdgpu/soc15.c         |  4 +-
> >>   5 files changed, 66 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> index 3489622..42ee208 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> @@ -992,7 +992,9 @@ struct amdgpu_device {
> >>          atomic_t                        throttling_logging_enabled;
> >>          struct ratelimit_state          throttling_logging_rs;
> >>          uint32_t                        ras_features;
> >> +
> > Unrelated whitespace changes.
> >
> >>          bool                            in_dpc;
> >> +       struct pci_saved_state          *pci_state;
> >>   };
> >>
> >>   static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> >> @@ -1272,6 +1274,10 @@ pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev);
> >>   pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev);
> >>   void amdgpu_pci_resume(struct pci_dev *pdev);
> >>
> >> +bool amdgpu_device_cache_pci_state(struct pci_dev *pdev);
> >> +bool amdgpu_device_load_pci_state(struct pci_dev *pdev);
> >> +
> >> +
> >>
> >>   #include "amdgpu_object.h"
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> index d9e3994..2c088df 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> @@ -1283,7 +1283,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
> >>                  dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
> >>
> >>                  pci_set_power_state(dev->pdev, PCI_D0);
> >> -               pci_restore_state(dev->pdev);
> >> +               amdgpu_device_load_pci_state(dev->pdev);
> >>                  r = pci_enable_device(dev->pdev);
> >>                  if (r)
> >>                          DRM_WARN("pci_enable_device failed (%d)\n", r);
> >> @@ -1296,7 +1296,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
> >>                  drm_kms_helper_poll_disable(dev);
> >>                  dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
> >>                  amdgpu_device_suspend(dev, true);
> >> -               pci_save_state(dev->pdev);
> >> +               amdgpu_device_cache_pci_state(dev->pdev);
> >>                  /* Shut down the device */
> >>                  pci_disable_device(dev->pdev);
> >>                  pci_set_power_state(dev->pdev, PCI_D3cold);
> >> @@ -3401,8 +3401,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
> >>          if (r)
> >>                  dev_err(adev->dev, "amdgpu_pmu_init failed\n");
> >>
> >> -       if (pci_save_state(pdev))
> >> -               DRM_ERROR("Failed to save PCI state!!\n");
> >> +       /* Have stored pci confspace at hand for restore in sudden PCI error */
> >> +       if (!amdgpu_device_cache_pci_state(adev->pdev))
> >> +               DRM_WARN("Failed to cache PCI state!");
> >>
> >>          return 0;
> >>
> >> @@ -3430,6 +3431,8 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
> >>          flush_delayed_work(&adev->delayed_init_work);
> >>          adev->shutdown = true;
> >>
> >> +       kfree(adev->pci_state);
> >> +
> >>          /* make sure IB test finished before entering exclusive mode
> >>           * to avoid preemption on IB test
> >>           * */
> >> @@ -4855,7 +4858,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
> >>          /* wait for asic to come out of reset */
> >>          msleep(500);
> >>
> >> -       pci_restore_state(pdev);
> >> +       amdgpu_device_load_pci_state(pdev);
> >>
> >>          /* confirm  ASIC came out of reset */
> >>          for (i = 0; i < adev->usec_timeout; i++) {
> >> @@ -4934,8 +4937,10 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
> >>
> >>   out:
> >>
> >> -       if (!r)
> >> +       if (!r) {
> >> +               amdgpu_device_cache_pci_state(adev->pdev);
> >>                  DRM_INFO("PCIe error recovery succeeded\n");
> >> +       }
> >>          else {
> >>                  DRM_ERROR("PCIe error recovery failed, err:%d", r);
> >>                  amdgpu_device_unlock_adev(adev);
> >> @@ -4974,3 +4979,46 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
> >>
> >>          amdgpu_device_unlock_adev(adev);
> >>   }
> >> +
> >> +bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
> >> +{
> >> +       struct drm_device *dev = pci_get_drvdata(pdev);
> >> +       struct amdgpu_device *adev = drm_to_adev(dev);
> >> +       int r;
> >> +
> >> +       r = pci_save_state(pdev);
> >> +       if (!r) {
> >> +               kfree(adev->pci_state);
> >> +
> >> +               adev->pci_state = pci_store_saved_state(pdev);
> >> +
> >> +               if (!adev->pci_state) {
> >> +                       DRM_ERROR("Failed to store PCI saved state");
> >> +                       return false;
> >> +               }
> >> +       } else {
> >> +               DRM_WARN("Failed to save PCI state, err:%d\n", r);
> >> +               return false;
> >> +       }
> >> +
> >> +       return true;
> >> +}
> >> +
> >> +bool amdgpu_device_load_pci_state(struct pci_dev *pdev)
> >> +{
> >> +       struct drm_device *dev = pci_get_drvdata(pdev);
> >> +       struct amdgpu_device *adev = drm_to_adev(dev);
> >> +       int r;
> >> +
> >> +       if (!adev->pci_state)
> >> +               return false;
> >> +
> >> +       r = pci_load_saved_state(pdev, adev->pci_state);
> >> +
> >> +       if (!r) {
> >> +               pci_restore_state(pdev);
> >> +       } else {
> >> +               DRM_WARN("Failed to load PCI state, err:%d\n", r);
> >> +               return false;
> >> +       }
> >> +}
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> index 4bbcc70..7a6482a 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> @@ -1320,7 +1320,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
> >>                  if (amdgpu_is_atpx_hybrid()) {
> >>                          pci_ignore_hotplug(pdev);
> >>                  } else {
> >> -                       pci_save_state(pdev);
> >> +                       amdgpu_device_cache_pci_state(pdev);
> >>                          pci_disable_device(pdev);
> >>                          pci_ignore_hotplug(pdev);
> >>                          pci_set_power_state(pdev, PCI_D3cold);
> >> @@ -1353,7 +1353,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
> >>                          pci_set_master(pdev);
> >>                  } else {
> >>                          pci_set_power_state(pdev, PCI_D0);
> >> -                       pci_restore_state(pdev);
> >> +                       amdgpu_device_load_pci_state(pdev);
> >>                          ret = pci_enable_device(pdev);
> >>                          if (ret)
> >>                                  return ret;
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> >> index 4d14023..0ec6603 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> >> @@ -311,7 +311,7 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
> >>          /* disable BM */
> >>          pci_clear_master(adev->pdev);
> >>
> >> -       pci_save_state(adev->pdev);
> >> +       amdgpu_device_cache_pci_state(adev->pdev);
> >>
> >>          if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
> >>                  dev_info(adev->dev, "GPU smu mode1 reset\n");
> >> @@ -323,7 +323,7 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
> >>
> >>          if (ret)
> >>                  dev_err(adev->dev, "GPU mode1 reset failed\n");
> >> -       pci_restore_state(adev->pdev);
> >> +       amdgpu_device_load_pci_state(adev->pdev);
> >>
> >>          /* wait for asic to come out of reset */
> >>          for (i = 0; i < adev->usec_timeout; i++) {
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> >> index 2f93c47..ddd55e3 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> >> @@ -484,13 +484,13 @@ static int soc15_asic_mode1_reset(struct amdgpu_device *adev)
> >>          /* disable BM */
> >>          pci_clear_master(adev->pdev);
> >>
> >> -       pci_save_state(adev->pdev);
> >> +       amdgpu_device_cache_pci_state(adev->pdev);
> >>
> >>          ret = psp_gpu_reset(adev);
> >>          if (ret)
> >>                  dev_err(adev->dev, "GPU mode1 reset failed\n");
> >>
> >> -       pci_restore_state(adev->pdev);
> >> +       amdgpu_device_load_pci_state(adev->pdev);
> >>
> >>          /* wait for asic to come out of reset */
> >>          for (i = 0; i < adev->usec_timeout; i++) {
> >> --
> >> 2.7.4
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Candrey.grodzovsky%40amd.com%7C5faaaf11d6024193cb2508d849d38fae%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637340520282366646&amp;sdata=ziPLmwT95XAnKftzplY2QBHq%2BL1961d0SdaMPAlVMcE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
