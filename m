Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EF7C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 06:56:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E763920825
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 06:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfzPZeHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E763920825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A27706E13C;
	Fri, 28 Aug 2020 06:56:28 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAA416E13C
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 06:56:26 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id w186so133905qkd.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2020 23:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=LqNvP5thK4PK0J0vLFSaXD8y+7e6bP9uczU1Ou/r0C8=;
 b=XfzPZeHVu2ErlS949rIPtgd0huwItZYhw4kAzQ2p94XM/uGjRFelxtJAjFqK6RaLT8
 RW8KG4tOztKYIKDE5FA6k9KyOVuBcUYS2+2uTlnu9D+oCx1NrdAgRhRx2TmrtIqUNyFB
 +iPj0PHyrA+sbfuq/MokcrLkCpMOFcTbqONpDPamkFxCg+RnlorCnpJgKue3JztWyNbm
 SAkmxSumBcUIcNK/MsLsPa12pZt02PSZJQmUKRlxBfNK3qEHlIAk/oYDNsuwsbWJWCfV
 3+xqC+LEy+WpiEuiAIplcGyGpxkzEtaHpf9+dF5eXn95Y8f5mit6adGNainOUtvdAFh0
 0hYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language;
 bh=LqNvP5thK4PK0J0vLFSaXD8y+7e6bP9uczU1Ou/r0C8=;
 b=BDDLN2zxEtp3UueUqJkofRMvOvVBFfrjzRGKTIov3yjsVqnAUxxMZKnKyc+rA6lVsV
 zfUiWJmQsSQiHJLvMBSB8wyqbX6+NvmV6evzxPKg7pbALpE1/7n20rmf9rhEGqSEUGCk
 RoulY3ajsXzJ6yNpis/GegpAGAvFdrZNVqV1lM1Icn95hX2VCdGdjEcV2WpZg1/TlDT/
 BbDqg5/WvMOru0VmPexVX8pph13wabd0uGBThupvCY7WYHvj6uKFXrdcAwtDmbnaujFv
 DZtNKs3Xu6sIZB+JfF79snCGjm7RuhAHG7ZjP/ZHUarhJo5FYkeryvg6SIsyBHk3duMy
 kTkw==
X-Gm-Message-State: AOAM5310lEEoGrALVNXh7kIPP6LXAmJArSrwQH2Y+Ibaj4N2yb2RAAgw
 OKykXpdak3Nyt6b33UBZkS/aQcuMVik=
X-Google-Smtp-Source: ABdhPJzV+XKtFlSq4b8jf1KpZXxCz61QsnPAVP1JYIoCh3ITbpAXqgAFREw9KrdN/bzT7EoOJpwhWw==
X-Received: by 2002:a05:620a:21d9:: with SMTP id
 h25mr7461619qka.444.1598597785483; 
 Thu, 27 Aug 2020 23:56:25 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id e63sm56319qkf.29.2020.08.27.23.56.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2020 23:56:24 -0700 (PDT)
Subject: Re: [PATCH 5/7] drm/amdgpu: Fix consecutive DPC recoveries failure.
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598453182-6946-6-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_NtAaNd3_XYrs4K8uLFF49Xv-46801Cy3Y0fNuLG_YPoA@mail.gmail.com>
 <0c2ada8e-5dde-0165-c8b3-cf6d6d3fba46@amd.com>
 <DM6PR12MB434022205C4915275751D413EA520@DM6PR12MB4340.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c50196a0-7044-9502-994a-abceed374c7e@gmail.com>
Date: Fri, 28 Aug 2020 08:56:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB434022205C4915275751D413EA520@DM6PR12MB4340.namprd12.prod.outlook.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Das,
 Nirmoy" <Nirmoy.Das@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1662151734=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1662151734==
Content-Type: multipart/alternative;
 boundary="------------0C563480B3FB1C8A5C1B2D30"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------0C563480B3FB1C8A5C1B2D30
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Am 28.08.20 um 02:00 schrieb Grodzovsky, Andrey:
> Ping
>
> Andrey
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> *Sent:* 27 August 2020 10:54
> *To:* Alex Deucher <alexdeucher@gmail.com>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Das, Nirmoy 
> <Nirmoy.Das@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: [PATCH 5/7] drm/amdgpu: Fix consecutive DPC recoveries 
> failure.
>
> On 8/26/20 11:20 AM, Alex Deucher wrote:
> > On Wed, Aug 26, 2020 at 10:46 AM Andrey Grodzovsky
> > <andrey.grodzovsky@amd.com> wrote:
> >> DPC recovery after prev. DPC recovery or after prev. MODE1 reset fails
> >> unles you save the cashe the saved PCI confspace to load it after
> >> each new reset.
> >> Also use same cached state for other use case of restoring PCI 
> confspace
> >> such as GPU mode1 or VGA switheroo.
> >>
> > We don't want to keep the saved state around in the pci core
> > otherwise, the pci core will assume we are managing the saved state
> > for suspend and resume.  I think we want logic like this:
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
> Actually, as we already discussed - caching the PCI confspace only 
> once on boot
> and not doing it again after each subsequent
> controlled or spontaneous reset runs the risk of loading back outdated 
> confspace
> settings. I am not sure if and when but, is it indeed
> possible we make changes to PCI confspace registers during runtime and 
> so the
> cached state from boot might be outdated
> to load back ?

Well we change the confspace settings for quite a bunch of things. For 
example during BAR resize or link speed adjustment.

Christian.

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
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  6 +++
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60 
> +++++++++++++++++++++++++++---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +-
> >>   drivers/gpu/drm/amd/amdgpu/nv.c            |  4 +-
> >>   drivers/gpu/drm/amd/amdgpu/soc15.c         |  4 +-
> >>   5 files changed, 66 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> index 3489622..42ee208 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> @@ -992,7 +992,9 @@ struct amdgpu_device {
> >>          atomic_t throttling_logging_enabled;
> >>          struct ratelimit_state throttling_logging_rs;
> >>          uint32_t ras_features;
> >> +
> > Unrelated whitespace changes.
> >
> >>          bool                            in_dpc;
> >> +       struct pci_saved_state *pci_state;
> >>   };
> >>
> >>   static inline struct amdgpu_device *drm_to_adev(struct drm_device 
> *ddev)
> >> @@ -1272,6 +1274,10 @@ pci_ers_result_t 
> amdgpu_pci_mmio_enabled(struct pci_dev *pdev);
> >>   pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev);
> >>   void amdgpu_pci_resume(struct pci_dev *pdev);
> >>
> >> +bool amdgpu_device_cache_pci_state(struct pci_dev *pdev);
> >> +bool amdgpu_device_load_pci_state(struct pci_dev *pdev);
> >> +
> >> +
> >>
> >>   #include "amdgpu_object.h"
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> index d9e3994..2c088df 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> @@ -1283,7 +1283,7 @@ static void 
> amdgpu_switcheroo_set_state(struct pci_dev *pdev,
> >>                  dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
> >>
> >> pci_set_power_state(dev->pdev, PCI_D0);
> >> -               pci_restore_state(dev->pdev);
> >> + amdgpu_device_load_pci_state(dev->pdev);
> >>                  r = pci_enable_device(dev->pdev);
> >>                  if (r)
> >> DRM_WARN("pci_enable_device failed (%d)\n", r);
> >> @@ -1296,7 +1296,7 @@ static void 
> amdgpu_switcheroo_set_state(struct pci_dev *pdev,
> >> drm_kms_helper_poll_disable(dev);
> >>                  dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
> >>                  amdgpu_device_suspend(dev, true);
> >> -               pci_save_state(dev->pdev);
> >> + amdgpu_device_cache_pci_state(dev->pdev);
> >>                  /* Shut down the device */
> >> pci_disable_device(dev->pdev);
> >> pci_set_power_state(dev->pdev, PCI_D3cold);
> >> @@ -3401,8 +3401,9 @@ int amdgpu_device_init(struct amdgpu_device 
> *adev,
> >>          if (r)
> >>                  dev_err(adev->dev, "amdgpu_pmu_init failed\n");
> >>
> >> -       if (pci_save_state(pdev))
> >> -               DRM_ERROR("Failed to save PCI state!!\n");
> >> +       /* Have stored pci confspace at hand for restore in sudden 
> PCI error */
> >> +       if (!amdgpu_device_cache_pci_state(adev->pdev))
> >> +               DRM_WARN("Failed to cache PCI state!");
> >>
> >>          return 0;
> >>
> >> @@ -3430,6 +3431,8 @@ void amdgpu_device_fini(struct amdgpu_device 
> *adev)
> >> flush_delayed_work(&adev->delayed_init_work);
> >>          adev->shutdown = true;
> >>
> >> +       kfree(adev->pci_state);
> >> +
> >>          /* make sure IB test finished before entering exclusive mode
> >>           * to avoid preemption on IB test
> >>           * */
> >> @@ -4855,7 +4858,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct 
> pci_dev *pdev)
> >>          /* wait for asic to come out of reset */
> >>          msleep(500);
> >>
> >> -       pci_restore_state(pdev);
> >> +       amdgpu_device_load_pci_state(pdev);
> >>
> >>          /* confirm  ASIC came out of reset */
> >>          for (i = 0; i < adev->usec_timeout; i++) {
> >> @@ -4934,8 +4937,10 @@ pci_ers_result_t 
> amdgpu_pci_slot_reset(struct pci_dev *pdev)
> >>
> >>   out:
> >>
> >> -       if (!r)
> >> +       if (!r) {
> >> + amdgpu_device_cache_pci_state(adev->pdev);
> >>                  DRM_INFO("PCIe error recovery succeeded\n");
> >> +       }
> >>          else {
> >>                  DRM_ERROR("PCIe error recovery failed, err:%d", r);
> >>                  amdgpu_device_unlock_adev(adev);
> >> @@ -4974,3 +4979,46 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
> >>
> >>          amdgpu_device_unlock_adev(adev);
> >>   }
> >> +
> >> +bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
> >> +{
> >> +       struct drm_device *dev = pci_get_drvdata(pdev);
> >> +       struct amdgpu_device *adev = drm_to_adev(dev);
> >> +       int r;
> >> +
> >> +       r = pci_save_state(pdev);
> >> +       if (!r) {
> >> +               kfree(adev->pci_state);
> >> +
> >> +               adev->pci_state = pci_store_saved_state(pdev);
> >> +
> >> +               if (!adev->pci_state) {
> >> +                       DRM_ERROR("Failed to store PCI saved state");
> >> +                       return false;
> >> +               }
> >> +       } else {
> >> +               DRM_WARN("Failed to save PCI state, err:%d\n", r);
> >> +               return false;
> >> +       }
> >> +
> >> +       return true;
> >> +}
> >> +
> >> +bool amdgpu_device_load_pci_state(struct pci_dev *pdev)
> >> +{
> >> +       struct drm_device *dev = pci_get_drvdata(pdev);
> >> +       struct amdgpu_device *adev = drm_to_adev(dev);
> >> +       int r;
> >> +
> >> +       if (!adev->pci_state)
> >> +               return false;
> >> +
> >> +       r = pci_load_saved_state(pdev, adev->pci_state);
> >> +
> >> +       if (!r) {
> >> +               pci_restore_state(pdev);
> >> +       } else {
> >> +               DRM_WARN("Failed to load PCI state, err:%d\n", r);
> >> +               return false;
> >> +       }
> >> +}
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> index 4bbcc70..7a6482a 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> @@ -1320,7 +1320,7 @@ static int 
> amdgpu_pmops_runtime_suspend(struct device *dev)
> >>                  if (amdgpu_is_atpx_hybrid()) {
> >> pci_ignore_hotplug(pdev);
> >>                  } else {
> >> -                       pci_save_state(pdev);
> >> + amdgpu_device_cache_pci_state(pdev);
> >> pci_disable_device(pdev);
> >> pci_ignore_hotplug(pdev);
> >> pci_set_power_state(pdev, PCI_D3cold);
> >> @@ -1353,7 +1353,7 @@ static int amdgpu_pmops_runtime_resume(struct 
> device *dev)
> >>                          pci_set_master(pdev);
> >>                  } else {
> >> pci_set_power_state(pdev, PCI_D0);
> >> -                       pci_restore_state(pdev);
> >> + amdgpu_device_load_pci_state(pdev);
> >>                          ret = pci_enable_device(pdev);
> >>                          if (ret)
> >>                                  return ret;
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c 
> b/drivers/gpu/drm/amd/amdgpu/nv.c
> >> index 4d14023..0ec6603 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> >> @@ -311,7 +311,7 @@ static int nv_asic_mode1_reset(struct 
> amdgpu_device *adev)
> >>          /* disable BM */
> >>          pci_clear_master(adev->pdev);
> >>
> >> -       pci_save_state(adev->pdev);
> >> + amdgpu_device_cache_pci_state(adev->pdev);
> >>
> >>          if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
> >>                  dev_info(adev->dev, "GPU smu mode1 reset\n");
> >> @@ -323,7 +323,7 @@ static int nv_asic_mode1_reset(struct 
> amdgpu_device *adev)
> >>
> >>          if (ret)
> >>                  dev_err(adev->dev, "GPU mode1 reset failed\n");
> >> -       pci_restore_state(adev->pdev);
> >> + amdgpu_device_load_pci_state(adev->pdev);
> >>
> >>          /* wait for asic to come out of reset */
> >>          for (i = 0; i < adev->usec_timeout; i++) {
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c 
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> >> index 2f93c47..ddd55e3 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> >> @@ -484,13 +484,13 @@ static int soc15_asic_mode1_reset(struct 
> amdgpu_device *adev)
> >>          /* disable BM */
> >>          pci_clear_master(adev->pdev);
> >>
> >> -       pci_save_state(adev->pdev);
> >> + amdgpu_device_cache_pci_state(adev->pdev);
> >>
> >>          ret = psp_gpu_reset(adev);
> >>          if (ret)
> >>                  dev_err(adev->dev, "GPU mode1 reset failed\n");
> >>
> >> -       pci_restore_state(adev->pdev);
> >> + amdgpu_device_load_pci_state(adev->pdev);
> >>
> >>          /* wait for asic to come out of reset */
> >>          for (i = 0; i < adev->usec_timeout; i++) {
> >> --
> >> 2.7.4
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Candrey.grodzovsky%40amd.com%7Cf7e5e09330074d176b5b08d84a99236e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637341368926287137&amp;sdata=HTTP5xt%2BFTc%2F%2BlcI37wkRQ0BqTHOXOQVpSlR%2FDEnFlM%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Candrey.grodzovsky%40amd.com%7Cf7e5e09330074d176b5b08d84a99236e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637341368926287137&amp;sdata=HTTP5xt%2BFTc%2F%2BlcI37wkRQ0BqTHOXOQVpSlR%2FDEnFlM%3D&amp;reserved=0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------0C563480B3FB1C8A5C1B2D30
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 28.08.20 um 02:00 schrieb
      Grodzovsky, Andrey:<br>
    </div>
    <blockquote type="cite"
cite="mid:DM6PR12MB434022205C4915275751D413EA520@DM6PR12MB4340.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <div>Ping</div>
      <div><br>
      </div>
      <div>Andrey</div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b>
          amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on
          behalf of Andrey Grodzovsky <a class="moz-txt-link-rfc2396E" href="mailto:Andrey.Grodzovsky@amd.com">&lt;Andrey.Grodzovsky@amd.com&gt;</a><br>
          <b>Sent:</b> 27 August 2020 10:54<br>
          <b>To:</b> Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com">&lt;alexdeucher@gmail.com&gt;</a><br>
          <b>Cc:</b> Deucher, Alexander
          <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Das, Nirmoy
          <a class="moz-txt-link-rfc2396E" href="mailto:Nirmoy.Das@amd.com">&lt;Nirmoy.Das@amd.com&gt;</a>; amd-gfx list
          <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
          <b>Subject:</b> Re: [PATCH 5/7] drm/amdgpu: Fix consecutive
          DPC recoveries failure.</font>
        <div> </div>
      </div>
      <div class="BodyFragment"><font size="2"><span
            style="font-size:11pt;">
            <div class="PlainText"><br>
              On 8/26/20 11:20 AM, Alex Deucher wrote:<br>
              &gt; On Wed, Aug 26, 2020 at 10:46 AM Andrey Grodzovsky<br>
              &gt; <a class="moz-txt-link-rfc2396E" href="mailto:andrey.grodzovsky@amd.com">&lt;andrey.grodzovsky@amd.com&gt;</a> wrote:<br>
              &gt;&gt; DPC recovery after prev. DPC recovery or after
              prev. MODE1 reset fails<br>
              &gt;&gt; unles you save the cashe the saved PCI confspace
              to load it after<br>
              &gt;&gt; each new reset.<br>
              &gt;&gt; Also use same cached state for other use case of
              restoring PCI confspace<br>
              &gt;&gt; such as GPU mode1 or VGA switheroo.<br>
              &gt;&gt;<br>
              &gt; We don't want to keep the saved state around in the
              pci core<br>
              &gt; otherwise, the pci core will assume we are managing
              the saved state<br>
              &gt; for suspend and resume.  I think we want logic like
              this:<br>
              &gt;<br>
              &gt; At driver load time:<br>
              &gt; pci_save_state(pdev);<br>
              &gt; adev-&gt;pci_state = pci_store_saved_state(pdev);<br>
              &gt; pci_restore_state(adev-&gt;pdev);<br>
              &gt;<br>
              &gt; then in the case of dpc, do:<br>
              &gt; pci_load_saved_state(pdev, adev-&gt;pci_state);<br>
              &gt;<br>
              &gt; For all the other cases, just leave the code as is.<br>
              <br>
              <br>
              Actually, as we already discussed - caching the PCI
              confspace only once on boot <br>
              and not doing it again after each subsequent<br>
              controlled or spontaneous reset runs the risk of loading
              back outdated confspace <br>
              settings. I am not sure if and when but, is it indeed<br>
              possible we make changes to PCI confspace registers during
              runtime and so the <br>
              cached state from boot might be outdated<br>
              to load back ?<br>
            </div>
          </span></font></div>
    </blockquote>
    <br>
    Well we change the confspace settings for quite a bunch of things.
    For example during BAR resize or link speed adjustment.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:DM6PR12MB434022205C4915275751D413EA520@DM6PR12MB4340.namprd12.prod.outlook.com">
      <div class="BodyFragment"><font size="2"><span
            style="font-size:11pt;">
            <div class="PlainText">
              <br>
              Andrey<br>
              <br>
              <br>
              &gt;<br>
              &gt; Alex<br>
              &gt;<br>
              &gt;<br>
              &gt;&gt; Signed-off-by: Andrey Grodzovsky
              <a class="moz-txt-link-rfc2396E" href="mailto:andrey.grodzovsky@amd.com">&lt;andrey.grodzovsky@amd.com&gt;</a><br>
              &gt;&gt; ---<br>
              &gt;&gt;   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  6
              +++<br>
              &gt;&gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60
              +++++++++++++++++++++++++++---<br>
              &gt;&gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4
              +-<br>
              &gt;&gt;   drivers/gpu/drm/amd/amdgpu/nv.c            |  4
              +-<br>
              &gt;&gt;   drivers/gpu/drm/amd/amdgpu/soc15.c         |  4
              +-<br>
              &gt;&gt;   5 files changed, 66 insertions(+), 12
              deletions(-)<br>
              &gt;&gt;<br>
              &gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
              b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
              &gt;&gt; index 3489622..42ee208 100644<br>
              &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
              &gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
              &gt;&gt; @@ -992,7 +992,9 @@ struct amdgpu_device {<br>
              &gt;&gt;          atomic_t                       
              throttling_logging_enabled;<br>
              &gt;&gt;          struct ratelimit_state         
              throttling_logging_rs;<br>
              &gt;&gt;          uint32_t                       
              ras_features;<br>
              &gt;&gt; +<br>
              &gt; Unrelated whitespace changes.<br>
              &gt;<br>
              &gt;&gt;          bool                            in_dpc;<br>
              &gt;&gt; +       struct pci_saved_state         
              *pci_state;<br>
              &gt;&gt;   };<br>
              &gt;&gt;<br>
              &gt;&gt;   static inline struct amdgpu_device
              *drm_to_adev(struct drm_device *ddev)<br>
              &gt;&gt; @@ -1272,6 +1274,10 @@ pci_ers_result_t
              amdgpu_pci_mmio_enabled(struct pci_dev *pdev);<br>
              &gt;&gt;   pci_ers_result_t amdgpu_pci_slot_reset(struct
              pci_dev *pdev);<br>
              &gt;&gt;   void amdgpu_pci_resume(struct pci_dev *pdev);<br>
              &gt;&gt;<br>
              &gt;&gt; +bool amdgpu_device_cache_pci_state(struct
              pci_dev *pdev);<br>
              &gt;&gt; +bool amdgpu_device_load_pci_state(struct pci_dev
              *pdev);<br>
              &gt;&gt; +<br>
              &gt;&gt; +<br>
              &gt;&gt;<br>
              &gt;&gt;   #include "amdgpu_object.h"<br>
              &gt;&gt;<br>
              &gt;&gt; diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
              &gt;&gt; index d9e3994..2c088df 100644<br>
              &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
              &gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
              &gt;&gt; @@ -1283,7 +1283,7 @@ static void
              amdgpu_switcheroo_set_state(struct pci_dev *pdev,<br>
              &gt;&gt;                  dev-&gt;switch_power_state =
              DRM_SWITCH_POWER_CHANGING;<br>
              &gt;&gt;<br>
              &gt;&gt;                 
              pci_set_power_state(dev-&gt;pdev, PCI_D0);<br>
              &gt;&gt; -               pci_restore_state(dev-&gt;pdev);<br>
              &gt;&gt; +              
              amdgpu_device_load_pci_state(dev-&gt;pdev);<br>
              &gt;&gt;                  r =
              pci_enable_device(dev-&gt;pdev);<br>
              &gt;&gt;                  if (r)<br>
              &gt;&gt;                         
              DRM_WARN("pci_enable_device failed (%d)\n", r);<br>
              &gt;&gt; @@ -1296,7 +1296,7 @@ static void
              amdgpu_switcheroo_set_state(struct pci_dev *pdev,<br>
              &gt;&gt;                 
              drm_kms_helper_poll_disable(dev);<br>
              &gt;&gt;                  dev-&gt;switch_power_state =
              DRM_SWITCH_POWER_CHANGING;<br>
              &gt;&gt;                  amdgpu_device_suspend(dev,
              true);<br>
              &gt;&gt; -               pci_save_state(dev-&gt;pdev);<br>
              &gt;&gt; +              
              amdgpu_device_cache_pci_state(dev-&gt;pdev);<br>
              &gt;&gt;                  /* Shut down the device */<br>
              &gt;&gt;                 
              pci_disable_device(dev-&gt;pdev);<br>
              &gt;&gt;                 
              pci_set_power_state(dev-&gt;pdev, PCI_D3cold);<br>
              &gt;&gt; @@ -3401,8 +3401,9 @@ int
              amdgpu_device_init(struct amdgpu_device *adev,<br>
              &gt;&gt;          if (r)<br>
              &gt;&gt;                  dev_err(adev-&gt;dev,
              "amdgpu_pmu_init failed\n");<br>
              &gt;&gt;<br>
              &gt;&gt; -       if (pci_save_state(pdev))<br>
              &gt;&gt; -               DRM_ERROR("Failed to save PCI
              state!!\n");<br>
              &gt;&gt; +       /* Have stored pci confspace at hand for
              restore in sudden PCI error */<br>
              &gt;&gt; +       if
              (!amdgpu_device_cache_pci_state(adev-&gt;pdev))<br>
              &gt;&gt; +               DRM_WARN("Failed to cache PCI
              state!");<br>
              &gt;&gt;<br>
              &gt;&gt;          return 0;<br>
              &gt;&gt;<br>
              &gt;&gt; @@ -3430,6 +3431,8 @@ void
              amdgpu_device_fini(struct amdgpu_device *adev)<br>
              &gt;&gt;         
              flush_delayed_work(&amp;adev-&gt;delayed_init_work);<br>
              &gt;&gt;          adev-&gt;shutdown = true;<br>
              &gt;&gt;<br>
              &gt;&gt; +       kfree(adev-&gt;pci_state);<br>
              &gt;&gt; +<br>
              &gt;&gt;          /* make sure IB test finished before
              entering exclusive mode<br>
              &gt;&gt;           * to avoid preemption on IB test<br>
              &gt;&gt;           * */<br>
              &gt;&gt; @@ -4855,7 +4858,7 @@ pci_ers_result_t
              amdgpu_pci_slot_reset(struct pci_dev *pdev)<br>
              &gt;&gt;          /* wait for asic to come out of reset */<br>
              &gt;&gt;          msleep(500);<br>
              &gt;&gt;<br>
              &gt;&gt; -       pci_restore_state(pdev);<br>
              &gt;&gt; +       amdgpu_device_load_pci_state(pdev);<br>
              &gt;&gt;<br>
              &gt;&gt;          /* confirm  ASIC came out of reset */<br>
              &gt;&gt;          for (i = 0; i &lt;
              adev-&gt;usec_timeout; i++) {<br>
              &gt;&gt; @@ -4934,8 +4937,10 @@ pci_ers_result_t
              amdgpu_pci_slot_reset(struct pci_dev *pdev)<br>
              &gt;&gt;<br>
              &gt;&gt;   out:<br>
              &gt;&gt;<br>
              &gt;&gt; -       if (!r)<br>
              &gt;&gt; +       if (!r) {<br>
              &gt;&gt; +              
              amdgpu_device_cache_pci_state(adev-&gt;pdev);<br>
              &gt;&gt;                  DRM_INFO("PCIe error recovery
              succeeded\n");<br>
              &gt;&gt; +       }<br>
              &gt;&gt;          else {<br>
              &gt;&gt;                  DRM_ERROR("PCIe error recovery
              failed, err:%d", r);<br>
              &gt;&gt;                  amdgpu_device_unlock_adev(adev);<br>
              &gt;&gt; @@ -4974,3 +4979,46 @@ void
              amdgpu_pci_resume(struct pci_dev *pdev)<br>
              &gt;&gt;<br>
              &gt;&gt;          amdgpu_device_unlock_adev(adev);<br>
              &gt;&gt;   }<br>
              &gt;&gt; +<br>
              &gt;&gt; +bool amdgpu_device_cache_pci_state(struct
              pci_dev *pdev)<br>
              &gt;&gt; +{<br>
              &gt;&gt; +       struct drm_device *dev =
              pci_get_drvdata(pdev);<br>
              &gt;&gt; +       struct amdgpu_device *adev =
              drm_to_adev(dev);<br>
              &gt;&gt; +       int r;<br>
              &gt;&gt; +<br>
              &gt;&gt; +       r = pci_save_state(pdev);<br>
              &gt;&gt; +       if (!r) {<br>
              &gt;&gt; +               kfree(adev-&gt;pci_state);<br>
              &gt;&gt; +<br>
              &gt;&gt; +               adev-&gt;pci_state =
              pci_store_saved_state(pdev);<br>
              &gt;&gt; +<br>
              &gt;&gt; +               if (!adev-&gt;pci_state) {<br>
              &gt;&gt; +                       DRM_ERROR("Failed to
              store PCI saved state");<br>
              &gt;&gt; +                       return false;<br>
              &gt;&gt; +               }<br>
              &gt;&gt; +       } else {<br>
              &gt;&gt; +               DRM_WARN("Failed to save PCI
              state, err:%d\n", r);<br>
              &gt;&gt; +               return false;<br>
              &gt;&gt; +       }<br>
              &gt;&gt; +<br>
              &gt;&gt; +       return true;<br>
              &gt;&gt; +}<br>
              &gt;&gt; +<br>
              &gt;&gt; +bool amdgpu_device_load_pci_state(struct pci_dev
              *pdev)<br>
              &gt;&gt; +{<br>
              &gt;&gt; +       struct drm_device *dev =
              pci_get_drvdata(pdev);<br>
              &gt;&gt; +       struct amdgpu_device *adev =
              drm_to_adev(dev);<br>
              &gt;&gt; +       int r;<br>
              &gt;&gt; +<br>
              &gt;&gt; +       if (!adev-&gt;pci_state)<br>
              &gt;&gt; +               return false;<br>
              &gt;&gt; +<br>
              &gt;&gt; +       r = pci_load_saved_state(pdev,
              adev-&gt;pci_state);<br>
              &gt;&gt; +<br>
              &gt;&gt; +       if (!r) {<br>
              &gt;&gt; +               pci_restore_state(pdev);<br>
              &gt;&gt; +       } else {<br>
              &gt;&gt; +               DRM_WARN("Failed to load PCI
              state, err:%d\n", r);<br>
              &gt;&gt; +               return false;<br>
              &gt;&gt; +       }<br>
              &gt;&gt; +}<br>
              &gt;&gt; diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
              &gt;&gt; index 4bbcc70..7a6482a 100644<br>
              &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
              &gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
              &gt;&gt; @@ -1320,7 +1320,7 @@ static int
              amdgpu_pmops_runtime_suspend(struct device *dev)<br>
              &gt;&gt;                  if (amdgpu_is_atpx_hybrid()) {<br>
              &gt;&gt;                         
              pci_ignore_hotplug(pdev);<br>
              &gt;&gt;                  } else {<br>
              &gt;&gt; -                       pci_save_state(pdev);<br>
              &gt;&gt; +                      
              amdgpu_device_cache_pci_state(pdev);<br>
              &gt;&gt;                         
              pci_disable_device(pdev);<br>
              &gt;&gt;                         
              pci_ignore_hotplug(pdev);<br>
              &gt;&gt;                         
              pci_set_power_state(pdev, PCI_D3cold);<br>
              &gt;&gt; @@ -1353,7 +1353,7 @@ static int
              amdgpu_pmops_runtime_resume(struct device *dev)<br>
              &gt;&gt;                          pci_set_master(pdev);<br>
              &gt;&gt;                  } else {<br>
              &gt;&gt;                         
              pci_set_power_state(pdev, PCI_D0);<br>
              &gt;&gt; -                       pci_restore_state(pdev);<br>
              &gt;&gt; +                      
              amdgpu_device_load_pci_state(pdev);<br>
              &gt;&gt;                          ret =
              pci_enable_device(pdev);<br>
              &gt;&gt;                          if (ret)<br>
              &gt;&gt;                                  return ret;<br>
              &gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
              b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
              &gt;&gt; index 4d14023..0ec6603 100644<br>
              &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
              &gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
              &gt;&gt; @@ -311,7 +311,7 @@ static int
              nv_asic_mode1_reset(struct amdgpu_device *adev)<br>
              &gt;&gt;          /* disable BM */<br>
              &gt;&gt;          pci_clear_master(adev-&gt;pdev);<br>
              &gt;&gt;<br>
              &gt;&gt; -       pci_save_state(adev-&gt;pdev);<br>
              &gt;&gt; +      
              amdgpu_device_cache_pci_state(adev-&gt;pdev);<br>
              &gt;&gt;<br>
              &gt;&gt;          if
              (amdgpu_dpm_is_mode1_reset_supported(adev)) {<br>
              &gt;&gt;                  dev_info(adev-&gt;dev, "GPU smu
              mode1 reset\n");<br>
              &gt;&gt; @@ -323,7 +323,7 @@ static int
              nv_asic_mode1_reset(struct amdgpu_device *adev)<br>
              &gt;&gt;<br>
              &gt;&gt;          if (ret)<br>
              &gt;&gt;                  dev_err(adev-&gt;dev, "GPU mode1
              reset failed\n");<br>
              &gt;&gt; -       pci_restore_state(adev-&gt;pdev);<br>
              &gt;&gt; +      
              amdgpu_device_load_pci_state(adev-&gt;pdev);<br>
              &gt;&gt;<br>
              &gt;&gt;          /* wait for asic to come out of reset */<br>
              &gt;&gt;          for (i = 0; i &lt;
              adev-&gt;usec_timeout; i++) {<br>
              &gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
              b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
              &gt;&gt; index 2f93c47..ddd55e3 100644<br>
              &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
              &gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
              &gt;&gt; @@ -484,13 +484,13 @@ static int
              soc15_asic_mode1_reset(struct amdgpu_device *adev)<br>
              &gt;&gt;          /* disable BM */<br>
              &gt;&gt;          pci_clear_master(adev-&gt;pdev);<br>
              &gt;&gt;<br>
              &gt;&gt; -       pci_save_state(adev-&gt;pdev);<br>
              &gt;&gt; +      
              amdgpu_device_cache_pci_state(adev-&gt;pdev);<br>
              &gt;&gt;<br>
              &gt;&gt;          ret = psp_gpu_reset(adev);<br>
              &gt;&gt;          if (ret)<br>
              &gt;&gt;                  dev_err(adev-&gt;dev, "GPU mode1
              reset failed\n");<br>
              &gt;&gt;<br>
              &gt;&gt; -       pci_restore_state(adev-&gt;pdev);<br>
              &gt;&gt; +      
              amdgpu_device_load_pci_state(adev-&gt;pdev);<br>
              &gt;&gt;<br>
              &gt;&gt;          /* wait for asic to come out of reset */<br>
              &gt;&gt;          for (i = 0; i &lt;
              adev-&gt;usec_timeout; i++) {<br>
              &gt;&gt; --<br>
              &gt;&gt; 2.7.4<br>
              &gt;&gt;<br>
              &gt;&gt; _______________________________________________<br>
              &gt;&gt; amd-gfx mailing list<br>
              &gt;&gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
              &gt;&gt; <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Candrey.grodzovsky%40amd.com%7Cf7e5e09330074d176b5b08d84a99236e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637341368926287137&amp;amp;sdata=HTTP5xt%2BFTc%2F%2BlcI37wkRQ0BqTHOXOQVpSlR%2FDEnFlM%3D&amp;amp;reserved=0"
                moz-do-not-send="true">
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Candrey.grodzovsky%40amd.com%7Cf7e5e09330074d176b5b08d84a99236e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637341368926287137&amp;amp;sdata=HTTP5xt%2BFTc%2F%2BlcI37wkRQ0BqTHOXOQVpSlR%2FDEnFlM%3D&amp;amp;reserved=0</a><br>
              _______________________________________________<br>
              amd-gfx mailing list<br>
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
              <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Candrey.grodzovsky%40amd.com%7Cf7e5e09330074d176b5b08d84a99236e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637341368926287137&amp;amp;sdata=HTTP5xt%2BFTc%2F%2BlcI37wkRQ0BqTHOXOQVpSlR%2FDEnFlM%3D&amp;amp;reserved=0"
                moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Candrey.grodzovsky%40amd.com%7Cf7e5e09330074d176b5b08d84a99236e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637341368926287137&amp;amp;sdata=HTTP5xt%2BFTc%2F%2BlcI37wkRQ0BqTHOXOQVpSlR%2FDEnFlM%3D&amp;amp;reserved=0</a><br>
            </div>
          </span></font></div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------0C563480B3FB1C8A5C1B2D30--

--===============1662151734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1662151734==--
