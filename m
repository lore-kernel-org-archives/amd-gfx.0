Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EC8C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 15:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 443CF64FB8
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 15:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443CF64FB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF8066E909;
	Tue,  9 Mar 2021 15:47:50 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F7D06E909
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 15:47:49 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id t83so5424594oih.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Mar 2021 07:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8UxR555/Pdhmmy/b56mpEmJZNrlxEIEnrGzX4KHVY14=;
 b=aNtORq/IgcS/YJ58q/tO2eVy7VaWkJsVExgep0vbN6BeLKgAd74tO4FFX49LSF3e1X
 mkq7XGxjX9TJF/ZVGAswx/Vw1HK94KSMC2wKAzWktv2EK1MFyF6m+tfk28zMz07ybwbv
 OZxxS5VpUgCEQY84DV9PUtRuReFMZrcasiT+grlylsfZxwVyalAslzxomPzdABoYcFEX
 yNv5AHUVTEIPVaCvflx68zbeVrmI0TvRarmptlXvwUqJO6RvmKr+TH9jOQeQ8XLmiHhT
 5Oi2lwAWmld9OppT23L98mF/JjxQ/+Yd/EY9bTNU/ag8rvJW2tpLL4gamdfj5Iajoms9
 rOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8UxR555/Pdhmmy/b56mpEmJZNrlxEIEnrGzX4KHVY14=;
 b=QwbKkzRhmT3ss4FzLYPWVLlQ7oP9imsrmBAlu7TB0fovEkQEoWU/dKqA+UJvgV2YIj
 1DU8dL7afIahhGP0gWA27Tv2wSrYflGO0DTJMvoyRMw4WmpC4qoqElH4PJd7sXHFjokH
 TwNsyntLCdLfyu9KwPp2E/CrIKzNp7f9bCIozT/EP37ag39ibTdedLG6EPwF30pqkUnW
 nNqVgqitVMPzWaYW/oY+NrggvoGKJT0RKzCZ3DOcTSa+OBR/ZjZEq1k8mIW0y4vbFleo
 8ioqfNFTjpgoTdskETBwuJmlGINSQkDjIlsvVCoYq71Iu/T+uID3xQ197ccU2irTJ/cs
 huew==
X-Gm-Message-State: AOAM533c8CmrA70gn/ft6QCz47GGTYtu169uapYIku0IuYUlVpdnSP5i
 CJ7BM4rTFDRxIGQFSEEyx/f67hib1UlzRyNKvTAT4NDfoL0=
X-Google-Smtp-Source: ABdhPJytUdS2W/PNKOZKd21x969XWSEfQvWf1g6mwCqAhsB7fy27aqAsCcijUMMgObc09tri8AJeNxU9K7nc3NiyIDs=
X-Received: by 2002:a05:6808:f15:: with SMTP id
 m21mr3339371oiw.123.1615304868455; 
 Tue, 09 Mar 2021 07:47:48 -0800 (PST)
MIME-Version: 1.0
References: <20210309041012.23367-1-alexander.deucher@amd.com>
 <20210309041012.23367-4-alexander.deucher@amd.com>
 <MN2PR12MB4549198E8D86DC4176EC6C9E97929@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4549198E8D86DC4176EC6C9E97929@MN2PR12MB4549.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Mar 2021 10:47:37 -0500
Message-ID: <CADnq5_OauPrtpYZQb+C3qRkU15u5Hp3tpXXM7ERC63Lh9sj6TA@mail.gmail.com>
Subject: Re: [PATCH 4/7] drm/amdgpu: track what pmops flow we are in
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>
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
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 9, 2021 at 1:19 AM Lazar, Lijo <Lijo.Lazar@amd.com> wrote:
>
> [AMD Public Use]
>
> This seems a duplicate of dev_pm_info states. Can't we reuse that?

Are you referring to the PM_EVENT_ messages in
dev_pm_info.power_state?  Maybe.  I was not able to find much
documentation on how those should be used.  Do you know?

Alex


>
> Thanks,
> Lijo
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
> Sent: Tuesday, March 9, 2021 9:40 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 4/7] drm/amdgpu: track what pmops flow we are in
>
> We reuse the same suspend and resume functions for all of the pmops states, so flag what state we are in so that we can alter behavior deeper in the driver depending on the current flow.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h       | 20 +++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 58 +++++++++++++++++++----
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  3 +-
>  3 files changed, 70 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index d47626ce9bc5..4ddc5cc983c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -347,6 +347,24 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,  bool amdgpu_get_bios(struct amdgpu_device *adev);  bool amdgpu_read_bios(struct amdgpu_device *adev);
>
> +/*
> + * PM Ops
> + */
> +enum amdgpu_pmops_state {
> +       AMDGPU_PMOPS_NONE = 0,
> +       AMDGPU_PMOPS_PREPARE,
> +       AMDGPU_PMOPS_COMPLETE,
> +       AMDGPU_PMOPS_SUSPEND,
> +       AMDGPU_PMOPS_RESUME,
> +       AMDGPU_PMOPS_FREEZE,
> +       AMDGPU_PMOPS_THAW,
> +       AMDGPU_PMOPS_POWEROFF,
> +       AMDGPU_PMOPS_RESTORE,
> +       AMDGPU_PMOPS_RUNTIME_SUSPEND,
> +       AMDGPU_PMOPS_RUNTIME_RESUME,
> +       AMDGPU_PMOPS_RUNTIME_IDLE,
> +};
> +
>  /*
>   * Clocks
>   */
> @@ -1019,8 +1037,8 @@ struct amdgpu_device {
>         u8                              reset_magic[AMDGPU_RESET_MAGIC_NUM];
>
>         /* s3/s4 mask */
> +       enum amdgpu_pmops_state         pmops_state;
>         bool                            in_suspend;
> -       bool                            in_hibernate;
>
>         /*
>          * The combination flag in_poweroff_reboot_com used to identify the poweroff diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 3e6bb7d79652..0312c52bd39d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1297,34 +1297,54 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)  static int amdgpu_pmops_prepare(struct device *dev)  {
>         struct drm_device *drm_dev = dev_get_drvdata(dev);
> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
> +       int r;
>
> +       adev->pmops_state = AMDGPU_PMOPS_PREPARE;
>         /* Return a positive number here so
>          * DPM_FLAG_SMART_SUSPEND works properly
>          */
>         if (amdgpu_device_supports_boco(drm_dev))
> -               return pm_runtime_suspended(dev) &&
> +               r= pm_runtime_suspended(dev) &&
>                         pm_suspend_via_firmware();
> -
> -       return 0;
> +       else
> +               r = 0;
> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
> +       return r;
>  }
>
>  static void amdgpu_pmops_complete(struct device *dev)  {
> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
> +
> +       adev->pmops_state = AMDGPU_PMOPS_COMPLETE;
>         /* nothing to do */
> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>  }
>
>  static int amdgpu_pmops_suspend(struct device *dev)  {
>         struct drm_device *drm_dev = dev_get_drvdata(dev);
> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
> +       int r;
>
> -       return amdgpu_device_suspend(drm_dev, true);
> +       adev->pmops_state = AMDGPU_PMOPS_SUSPEND;
> +       r = amdgpu_device_suspend(drm_dev, true);
> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
> +       return r;
>  }
>
>  static int amdgpu_pmops_resume(struct device *dev)  {
>         struct drm_device *drm_dev = dev_get_drvdata(dev);
> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
> +       int r;
>
> -       return amdgpu_device_resume(drm_dev, true);
> +       adev->pmops_state = AMDGPU_PMOPS_RESUME;
> +       r = amdgpu_device_resume(drm_dev, true);
> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
> +       return r;
>  }
>
>  static int amdgpu_pmops_freeze(struct device *dev) @@ -1333,9 +1353,9 @@ static int amdgpu_pmops_freeze(struct device *dev)
>         struct amdgpu_device *adev = drm_to_adev(drm_dev);
>         int r;
>
> -       adev->in_hibernate = true;
> +       adev->pmops_state = AMDGPU_PMOPS_FREEZE;
>         r = amdgpu_device_suspend(drm_dev, true);
> -       adev->in_hibernate = false;
> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>         if (r)
>                 return r;
>         return amdgpu_asic_reset(adev);
> @@ -1344,8 +1364,13 @@ static int amdgpu_pmops_freeze(struct device *dev)  static int amdgpu_pmops_thaw(struct device *dev)  {
>         struct drm_device *drm_dev = dev_get_drvdata(dev);
> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
> +       int r;
>
> -       return amdgpu_device_resume(drm_dev, true);
> +       adev->pmops_state = AMDGPU_PMOPS_THAW;
> +       r = amdgpu_device_resume(drm_dev, true);
> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
> +       return r;
>  }
>
>  static int amdgpu_pmops_poweroff(struct device *dev) @@ -1354,17 +1379,24 @@ static int amdgpu_pmops_poweroff(struct device *dev)
>         struct amdgpu_device *adev = drm_to_adev(drm_dev);
>         int r;
>
> +       adev->pmops_state = AMDGPU_PMOPS_POWEROFF;
>         adev->in_poweroff_reboot_com = true;
>         r =  amdgpu_device_suspend(drm_dev, true);
>         adev->in_poweroff_reboot_com = false;
> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>         return r;
>  }
>
>  static int amdgpu_pmops_restore(struct device *dev)  {
>         struct drm_device *drm_dev = dev_get_drvdata(dev);
> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
> +       int r;
>
> -       return amdgpu_device_resume(drm_dev, true);
> +       adev->pmops_state = AMDGPU_PMOPS_RESTORE;
> +       r = amdgpu_device_resume(drm_dev, true);
> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
> +       return r;
>  }
>
>  static int amdgpu_pmops_runtime_suspend(struct device *dev) @@ -1389,6 +1421,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>                 }
>         }
>
> +       adev->pmops_state = AMDGPU_PMOPS_RUNTIME_SUSPEND;
>         adev->in_runpm = true;
>         if (amdgpu_device_supports_px(drm_dev))
>                 drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING; @@ -1396,6 +1429,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>         ret = amdgpu_device_suspend(drm_dev, false);
>         if (ret) {
>                 adev->in_runpm = false;
> +               adev->pmops_state = AMDGPU_PMOPS_NONE;
>                 return ret;
>         }
>
> @@ -1412,6 +1446,8 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>                 amdgpu_device_baco_enter(drm_dev);
>         }
>
> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
> +
>         return 0;
>  }
>
> @@ -1425,6 +1461,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>         if (!adev->runpm)
>                 return -EINVAL;
>
> +       adev->pmops_state = AMDGPU_PMOPS_RUNTIME_RESUME;
>         if (amdgpu_device_supports_px(drm_dev)) {
>                 drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>
> @@ -1449,6 +1486,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>         if (amdgpu_device_supports_px(drm_dev))
>                 drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
>         adev->in_runpm = false;
> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>         return 0;
>  }
>
> @@ -1464,6 +1502,7 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
>                 return -EBUSY;
>         }
>
> +       adev->pmops_state = AMDGPU_PMOPS_RUNTIME_IDLE;
>         if (amdgpu_device_has_dc_support(adev)) {
>                 struct drm_crtc *crtc;
>
> @@ -1504,6 +1543,7 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
>
>         pm_runtime_mark_last_busy(dev);
>         pm_runtime_autosuspend(dev);
> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>         return ret;
>  }
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 502e1b926a06..05a15f858a06 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1327,7 +1327,8 @@ static int smu_disable_dpms(struct smu_context *smu)
>         bool use_baco = !smu->is_apu &&
>                 ((amdgpu_in_reset(adev) &&
>                   (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
> -                ((adev->in_runpm || adev->in_hibernate) && amdgpu_asic_supports_baco(adev)));
> +                ((adev->in_runpm || (adev->pmops_state == AMDGPU_PMOPS_FREEZE))
> +                 && amdgpu_asic_supports_baco(adev)));
>
>         /*
>          * For custom pptable uploading, skip the DPM features
> --
> 2.29.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C522d9fee476f4075753008d8e2b14e6e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637508598450890140%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=pLFkgulTUPmA3C1RRbdJh2mxkGDWxoxTrkMRTs6HfjY%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
