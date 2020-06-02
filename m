Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AD7C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 14:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6083D2074B
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 14:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ucVGGUog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6083D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DB136E400;
	Tue,  2 Jun 2020 14:54:52 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D53F6E400
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 14:54:50 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id r15so3432170wmh.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jun 2020 07:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ThMJ4O6wOQjnSBjwULATfNggQeLzDkMuq+Rfd/kKvog=;
 b=ucVGGUogWFcWLS0SdKWv4EA8H70HVWWabRY5UPiNjwOhHV+Isug5AaST4sxGuW7GSA
 elvVRl47TQqQ/vbiOzGkZ6mfNowAahfmGPn2okadGNsLzvOabSjwFBeqNlhrY/64lPxG
 1dRIDl9LRE31kvUqBKbyi+AiQPr9YPbpvmSZEuCVjaM6lOEwgw62WIjesQTf8Nhr7cSl
 LO9ody42aQwXEOfQVwCIoZfs5nf4ivdC/k47tb/bjuDigq+vRdjDh4nj9VlppqBVXbzI
 feeG31dB7LXxwmKwP46rA5Y+Le14cb9/SfY87J8agUlKfLG4zuZnW0w+9tsrqfKT/seX
 pT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ThMJ4O6wOQjnSBjwULATfNggQeLzDkMuq+Rfd/kKvog=;
 b=DePRT743LPt7AjiHXkJNOctNwMxio0feAY1hlYQcWzVBC2v+5b0Dt9yJsoi+BGNamO
 boUn8RYedLrTAAchyt03xEdOR8I/ULDk2eYIhwdGJI8UIlz8U1bzkXaIWZpU5njanJ6r
 IK2Lq9Cv7PKuXvFCXnUNH+/ctcKOypsqVdjgA8CMa9rcnEnVC5Lvl0mrHFtcXdu4PQUV
 MrTwXcdFiLr/nth+wbXDSSLqLMsUp19lJknPzKKhVHZeqjZXTzyich7iKAZcZd+Y7hRB
 P6ZmDLgHzWAwGT6Mlaa298ZUM1d+y5hyrAnYLOGkDAKZLOxKyYJGr1Z9acrGYwAock4k
 I+5A==
X-Gm-Message-State: AOAM530sjGvH0/CYb4rrllAlNXnBQQ5/88bU8OiffmYeUs2xyUZv7Rrn
 AtKIQCZsaglu+isfFqswJ7zh9pZlGOtJm0IqG/n/Ig==
X-Google-Smtp-Source: ABdhPJy+FFBHR5YM9aYVFoV1p83RNQsGtMXmi3sU7zgN/LBqDrZk11ShzE/XYwbM4lnVq2IP32tHmSKT6Md+THx19q8=
X-Received: by 2002:a1c:9c85:: with SMTP id f127mr4600772wme.79.1591109689090; 
 Tue, 02 Jun 2020 07:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200601073003.13044-1-evan.quan@amd.com>
 <20200601073003.13044-2-evan.quan@amd.com>
In-Reply-To: <20200601073003.13044-2-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Jun 2020 10:54:37 -0400
Message-ID: <CADnq5_OQKS2pfkCiTjFGozB+34FC-UJ6PmPog8sy-5DsQzuCBA@mail.gmail.com>
Subject: Re: [PATCH 2/9] drm/amd/powerplay: some cosmetic fixes
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 1, 2020 at 3:30 AM Evan Quan <evan.quan@amd.com> wrote:
>
> To make code more clean and readable by moving ASIC
> specific code to its own file, more code sharing and
> dropping unused code.

There seem to be multiple things going on here.  It's kind of hard to
follow all of the changes.  Maybe split this patch up?  One additional
comment below.

Alex

>
> Change-Id: I6b299f9e98c7678b48281cbed9beb17b644bb4cc
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 213 ++++++++-------------
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c |  19 ++
>  2 files changed, 102 insertions(+), 130 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 4998ea942760..b4f108cb52fa 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -817,22 +817,10 @@ int smu_get_atom_data_table(struct smu_context *smu, uint32_t table,
>         return 0;
>  }
>
> -static int smu_initialize_pptable(struct smu_context *smu)
> -{
> -       /* TODO */
> -       return 0;
> -}
> -
>  static int smu_smc_table_sw_init(struct smu_context *smu)
>  {
>         int ret;
>
> -       ret = smu_initialize_pptable(smu);
> -       if (ret) {
> -               pr_err("Failed to init smu_initialize_pptable!\n");
> -               return ret;
> -       }
> -
>         /**
>          * Create smu_table structure, and init smc tables such as
>          * TABLE_PPTABLE, TABLE_WATERMARKS, TABLE_SMU_METRICS, and etc.
> @@ -860,6 +848,12 @@ static int smu_smc_table_sw_fini(struct smu_context *smu)
>  {
>         int ret;
>
> +       ret = smu_fini_power(smu);
> +       if (ret) {
> +               pr_err("Failed to init smu_fini_power!\n");
> +               return ret;
> +       }
> +
>         ret = smu_fini_smc_tables(smu);
>         if (ret) {
>                 pr_err("Failed to smu_fini_smc_tables!\n");
> @@ -950,12 +944,6 @@ static int smu_sw_fini(void *handle)
>                 return ret;
>         }
>
> -       ret = smu_fini_power(smu);
> -       if (ret) {
> -               pr_err("Failed to init smu_fini_power!\n");
> -               return ret;
> -       }
> -
>         return 0;
>  }
>
> @@ -1125,36 +1113,22 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>         if (ret)
>                 return ret;
>
> -       if (adev->asic_type == CHIP_NAVI10) {
> -               if ((adev->pdev->device == 0x731f && (adev->pdev->revision == 0xc2 ||
> -                                                     adev->pdev->revision == 0xc3 ||
> -                                                     adev->pdev->revision == 0xca ||
> -                                                     adev->pdev->revision == 0xcb)) ||
> -                   (adev->pdev->device == 0x66af && (adev->pdev->revision == 0xf3 ||
> -                                                     adev->pdev->revision == 0xf4 ||
> -                                                     adev->pdev->revision == 0xf5 ||
> -                                                     adev->pdev->revision == 0xf6))) {
> -                       ret = smu_disable_umc_cdr_12gbps_workaround(smu);
> -                       if (ret) {
> -                               pr_err("Workaround failed to disable UMC CDR feature on 12Gbps SKU!\n");
> -                               return ret;
> -                       }
> -               }
> +       ret = smu_disable_umc_cdr_12gbps_workaround(smu);
> +       if (ret) {
> +               pr_err("Workaround failed to disable UMC CDR feature on 12Gbps SKU!\n");
> +               return ret;
>         }
>
> -       if (smu->ppt_funcs->set_power_source) {
> -               /*
> -                * For Navi1X, manually switch it to AC mode as PMFW
> -                * may boot it with DC mode.
> -                */
> -               if (adev->pm.ac_power)
> -                       ret = smu_set_power_source(smu, SMU_POWER_SOURCE_AC);
> -               else
> -                       ret = smu_set_power_source(smu, SMU_POWER_SOURCE_DC);
> -               if (ret) {
> -                       pr_err("Failed to switch to %s mode!\n", adev->pm.ac_power ? "AC" : "DC");
> -                       return ret;
> -               }
> +       /*
> +        * For Navi1X, manually switch it to AC mode as PMFW
> +        * may boot it with DC mode.
> +        */
> +       ret = smu_set_power_source(smu,
> +                                  adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
> +                                  SMU_POWER_SOURCE_DC);
> +       if (ret) {
> +               pr_err("Failed to switch to %s mode!\n", adev->pm.ac_power ? "AC" : "DC");
> +               return ret;
>         }
>
>         ret = smu_notify_display_change(smu);
> @@ -1362,9 +1336,65 @@ static int smu_hw_init(void *handle)
>         return ret;
>  }
>
> -static int smu_stop_dpms(struct smu_context *smu)
> +static int smu_disable_dpms(struct smu_context *smu)
>  {
> -       return smu_system_features_control(smu, false);
> +       struct amdgpu_device *adev = smu->adev;
> +       int ret = 0;
> +       bool use_baco = !smu->is_apu &&
> +               ((adev->in_gpu_reset &&
> +                 (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
> +                ((adev->in_runpm || adev->in_hibernate) && amdgpu_asic_supports_baco(adev)));
> +
> +       /*
> +        * For custom pptable uploading, skip the DPM features
> +        * disable process on Navi1x ASICs.
> +        *   - As the gfx related features are under control of
> +        *     RLC on those ASICs. RLC reinitialization will be
> +        *     needed to reenable them. That will cost much more
> +        *     efforts.
> +        *
> +        *   - SMU firmware can handle the DPM reenablement
> +        *     properly.
> +        */
> +       if (smu->uploading_custom_pp_table &&
> +           (adev->asic_type >= CHIP_NAVI10) &&
> +           (adev->asic_type <= CHIP_NAVI12))
> +               return 0;
> +
> +       /*
> +        * Disable all enabled SMU features.
> +        * This should be handled in SMU FW, as a backup
> +        * driver can issue call to SMU FW until sequence
> +        * in SMU FW is operational.
> +        */
> +       ret = smu_system_features_control(smu, false);
> +       if (ret) {
> +               pr_err("Failed to disable smu features.\n");
> +               return ret;
> +       }
> +
> +       /*
> +        * For baco, need to leave BACO feature enabled
> +        *
> +        * Correct the way for checking whether SMU_FEATURE_BACO_BIT
> +        * is supported.
> +        *
> +        * Since 'smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)' will
> +        * always return false as the 'smu_system_features_control(smu, false)'
> +        * was just issued above which disabled all SMU features.
> +        *
> +        * Thus 'smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT)' is used
> +        * now for the checking.
> +        */
> +       if (use_baco && (smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT) >= 0)) {
> +               ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
> +               if (ret) {
> +                       pr_warn("set BACO feature enabled failed, return %d\n", ret);
> +                       return ret;
> +               }
> +       }
> +
> +       return ret;
>  }
>
>  static int smu_hw_fini(void *handle)
> @@ -1396,25 +1426,10 @@ static int smu_hw_fini(void *handle)
>                 return ret;
>         }
>
> -       /*
> -        * For custom pptable uploading, skip the DPM features
> -        * disable process on Navi1x ASICs.
> -        *   - As the gfx related features are under control of
> -        *     RLC on those ASICs. RLC reinitialization will be
> -        *     needed to reenable them. That will cost much more
> -        *     efforts.
> -        *
> -        *   - SMU firmware can handle the DPM reenablement
> -        *     properly.
> -        */
> -       if (!smu->uploading_custom_pp_table ||
> -                       !((adev->asic_type >= CHIP_NAVI10) &&
> -                               (adev->asic_type <= CHIP_NAVI12))) {
> -               ret = smu_stop_dpms(smu);
> -               if (ret) {
> -                       pr_warn("Fail to stop Dpms!\n");
> -                       return ret;
> -               }
> +       ret = smu_disable_dpms(smu);
> +       if (ret) {
> +               pr_warn("Fail to stop Dpms!\n");
> +               return ret;
>         }
>
>         kfree(table_context->driver_pptable);
> @@ -1453,68 +1468,6 @@ int smu_reset(struct smu_context *smu)
>         return ret;
>  }
>
> -static int smu_disable_dpm(struct smu_context *smu)
> -{
> -       struct amdgpu_device *adev = smu->adev;
> -       uint32_t smu_version;
> -       int ret = 0;
> -       bool use_baco = !smu->is_apu &&
> -               ((adev->in_gpu_reset &&
> -                 (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
> -                ((adev->in_runpm || adev->in_hibernate) && amdgpu_asic_supports_baco(adev)));
> -
> -       ret = smu_get_smc_version(smu, NULL, &smu_version);
> -       if (ret) {
> -               pr_err("Failed to get smu version.\n");
> -               return ret;
> -       }
> -
> -       /*
> -        * Disable all enabled SMU features.
> -        * This should be handled in SMU FW, as a backup
> -        * driver can issue call to SMU FW until sequence
> -        * in SMU FW is operational.
> -        */
> -       ret = smu_system_features_control(smu, false);
> -       if (ret) {
> -               pr_err("Failed to disable smu features.\n");
> -               return ret;
> -       }
> -
> -       /*
> -        * Arcturus does not have BACO bit in disable feature mask.
> -        * Enablement of BACO bit on Arcturus should be skipped.
> -        */
> -       if (adev->asic_type == CHIP_ARCTURUS) {
> -               if (use_baco && (smu_version > 0x360e00))
> -                       return 0;
> -       }
> -
> -       /* For baco, need to leave BACO feature enabled */
> -       if (use_baco) {
> -               /*
> -                * Correct the way for checking whether SMU_FEATURE_BACO_BIT
> -                * is supported.
> -                *
> -                * Since 'smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)' will
> -                * always return false as the 'smu_system_features_control(smu, false)'
> -                * was just issued above which disabled all SMU features.
> -                *
> -                * Thus 'smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT)' is used
> -                * now for the checking.
> -                */
> -               if (smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT) >= 0) {
> -                       ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
> -                       if (ret) {
> -                               pr_warn("set BACO feature enabled failed, return %d\n", ret);
> -                               return ret;
> -                       }
> -               }
> -       }
> -
> -       return ret;
> -}
> -
>  static int smu_suspend(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -1537,7 +1490,7 @@ static int smu_suspend(void *handle)
>                 return ret;
>         }
>
> -       ret = smu_disable_dpm(smu);
> +       ret = smu_disable_dpms(smu);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 68142f6798c6..652728f18271 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -2209,12 +2209,31 @@ static int navi10_dummy_pstate_control(struct smu_context *smu, bool enable)
>         return result;
>  }
>
> +static inline bool navi10_need_umc_cdr_12gbps_workaround(struct amdgpu_device *adev)
> +{
> +       if (adev->asic_type != CHIP_NAVI10)
> +               return false;
> +
> +       if ((adev->pdev->device == 0x731f && (adev->pdev->revision == 0xc2 ||
> +            adev->pdev->revision == 0xc3 || adev->pdev->revision == 0xca ||
> +            adev->pdev->revision == 0xcb)) ||
> +           (adev->pdev->device == 0x66af && (adev->pdev->revision == 0xf3 ||
> +            adev->pdev->revision == 0xf4 || adev->pdev->revision == 0xf5 ||
> +            adev->pdev->revision == 0xf6)))
> +               return true;
> +       else
> +               return false;
> +}

Do we need a separate function for this or can we just inline this
code in the function below?

> +
>  static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
>  {
>         uint32_t uclk_count, uclk_min, uclk_max;
>         uint32_t smu_version;
>         int ret = 0;
>
> +       if (!navi10_need_umc_cdr_12gbps_workaround(smu->adev))
> +               return 0;
> +
>         ret = smu_get_smc_version(smu, NULL, &smu_version);
>         if (ret)
>                 return ret;
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
