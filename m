Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFB4C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 15:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B097206C3
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 15:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQaynrRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B097206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D2FE6E417;
	Tue,  2 Jun 2020 15:11:46 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A45786E415
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 15:11:45 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id y17so3745790wrn.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jun 2020 08:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a1KULXnmqWWWyajAJ6UasmtVQ7VEDr0ev7nSVX74mhM=;
 b=KQaynrRkFhfLyrpVqVAKwL85FqNpnTUY0ZKV1IytdKxede1wt6yepHBuvOvpLoIRkb
 6/FonzEXIpTIQTekHq/4GPRtlmaRmkLGAwfRlR3zFqqHu/HJcWzbxIqZEYsuYou+hCK5
 2F33kIma3m23AGSTo4D+Vo4Rh4MBgoM1Eo2OWO0NMp0CMmoIeL+IDzF1AVG87Z+du5QG
 f+u6g2mwjYpqOkJ6WVw7++6ANfH6DE/v5fLHtg67l3WJ3bsq2VCgOnLN6kHQKdCgHtsf
 Z2WAs3HLps7c4jTjOTcAQq8Y8aWjDcZNlNCWWT2w1TDh+3jiuHucwIdARdFT6S/lBHQ/
 wQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a1KULXnmqWWWyajAJ6UasmtVQ7VEDr0ev7nSVX74mhM=;
 b=CvOM3+iI+i5w7i+BS+TUOAGE3MIAN+CdezjNc38a27vcdTpuOi0P4/uDInjmwEzgog
 9sb78EO84/P/ORPsXZsXPztIdzCFv4PwgNvHmIM8tgE2WyyxrRGiwmbe+YK8x99rXBU2
 xh0Om/Oi9HN4PMCt2YhWRGBzaDSX76PirfFvnCTIkzUw/HgcDcYYb1i8604hn349C4Os
 1EhoY40epLfFLU8PrVPztQ6GVDjBjRyHDVY9ikqvAta13J69sPGb931Ijwi7XlkrpGT+
 J9mbNQtvxaBZZ6eKBygodQvpX2muuTrUsGNsVEK0bJoL3mAdeTXFz+/2mMpYbcb3UPxO
 NdMQ==
X-Gm-Message-State: AOAM532oh3ZsSf3+OiwLQgSv0e0jRTkVFKWtJL/4e9s+0NZzzJgHJMuP
 drFbAS+dL2xXtrK9pxFuA6AEGqmUwU7QeMHuvRQ=
X-Google-Smtp-Source: ABdhPJykz022Qu49KkrCuUWfhyDgAfFAT+36m6KmhxCMPAdNUMMtsTxOI+Sm8xn1xxFNnHWX8fycxA0VwPZDa8+OoYY=
X-Received: by 2002:a5d:6789:: with SMTP id v9mr28578019wru.124.1591110704186; 
 Tue, 02 Jun 2020 08:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200601073003.13044-1-evan.quan@amd.com>
 <20200601073003.13044-7-evan.quan@amd.com>
In-Reply-To: <20200601073003.13044-7-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Jun 2020 11:11:33 -0400
Message-ID: <CADnq5_N+T1mpYhO-gbsKXZmOhueVxve-F1JnNqgg1Yj2M67Www@mail.gmail.com>
Subject: Re: [PATCH 7/9] drm/amd/powerplay: clean up the SMU hw setup
 operations
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

On Mon, Jun 1, 2020 at 3:31 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Postpone some operations which are not must for hw setup to
> late_init. Thus, code sharing is possible between hw_init/fini and
> suspend/resume. Also this makes code more clean and readable.
>
> Change-Id: Id3996fd9e2dbf2ff59d8a6032cc5f6730db1295c
> Signed-off-by: Evan Quan <evan.quan@amd.com>

I'm having trouble parsing all of the changes in this patch.  I get
the general idea, but Is there any way to break this up into more
logical patches or provide a more detailed description?

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 327 ++++++++++-----------
>  1 file changed, 157 insertions(+), 170 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 9b81b6519a96..e55c6458b212 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -789,10 +789,36 @@ static int smu_late_init(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>         struct smu_context *smu = &adev->smu;
> +       int ret = 0;
>
>         if (!smu->pm_enabled)
>                 return 0;
>
> +       ret = smu_set_default_od_settings(smu);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Set initialized values (get from vbios) to dpm tables context such as
> +        * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
> +        * type of clks.
> +        */
> +       ret = smu_populate_smc_tables(smu);
> +       if (ret)
> +               return ret;
> +
> +       ret = smu_init_max_sustainable_clocks(smu);
> +       if (ret)
> +               return ret;
> +
> +       ret = smu_populate_umd_state_clk(smu);
> +       if (ret)
> +               return ret;
> +
> +       ret = smu_get_power_limit(smu, &smu->default_power_limit, false, false);
> +       if (ret)
> +               return ret;
> +
>         smu_handle_task(&adev->smu,
>                         smu->smu_dpm.dpm_level,
>                         AMD_PP_TASK_COMPLETE_INIT,
> @@ -1107,8 +1133,7 @@ static int smu_sw_fini(void *handle)
>         return 0;
>  }
>
> -static int smu_smc_table_hw_init(struct smu_context *smu,
> -                                bool initialize)
> +static int smu_internal_hw_setup(struct smu_context *smu)
>  {
>         struct amdgpu_device *adev = smu->adev;
>         int ret;
> @@ -1122,26 +1147,22 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>         if (ret)
>                 return ret;
>
> -       if (initialize) {
> -               /* get boot_values from vbios to set revision, gfxclk, and etc. */
> -               ret = smu_get_vbios_bootup_values(smu);
> -               if (ret)
> -                       return ret;
> -
> -               ret = smu_setup_pptable(smu);
> -               if (ret)
> -                       return ret;
> +       ret = smu_set_driver_table_location(smu);
> +       if (ret)
> +               return ret;
>
> -               /*
> -                * Send msg GetDriverIfVersion to check if the return value is equal
> -                * with DRIVER_IF_VERSION of smc header.
> -                */
> -               ret = smu_check_fw_version(smu);
> -               if (ret)
> -                       return ret;
> -       }
> +       /*
> +        * Set PMSTATUSLOG table bo address with SetToolsDramAddr MSG for tools.
> +        */
> +       ret = smu_set_tool_table_location(smu);
> +       if (ret)
> +               return ret;
>
> -       ret = smu_set_driver_table_location(smu);
> +       /*
> +        * Use msg SetSystemVirtualDramAddr and DramLogSetDramAddr can notify
> +        * pool location.
> +        */
> +       ret = smu_notify_memory_pool_location(smu);
>         if (ret)
>                 return ret;
>
> @@ -1158,6 +1179,11 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>         ret = smu_run_btc(smu);
>         if (ret)
>                 return ret;
> +
> +       ret = smu_feature_init_dpm(smu);
> +       if (ret)
> +               return ret;
> +
>         ret = smu_feature_set_allowed_mask(smu);
>         if (ret)
>                 return ret;
> @@ -1166,12 +1192,19 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>         if (ret)
>                 return ret;
>
> +       if (!smu_is_dpm_running(smu))
> +               pr_info("dpm has been disabled\n");
> +
>         ret = smu_disable_umc_cdr_12gbps_workaround(smu);
>         if (ret) {
>                 pr_err("Workaround failed to disable UMC CDR feature on 12Gbps SKU!\n");
>                 return ret;
>         }
>
> +       ret = smu_override_pcie_parameters(smu);
> +       if (ret)
> +               return ret;
> +
>         /*
>          * For Navi1X, manually switch it to AC mode as PMFW
>          * may boot it with DC mode.
> @@ -1184,6 +1217,14 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>                 return ret;
>         }
>
> +       ret = smu_enable_thermal_alert(smu);
> +       if (ret)
> +               return ret;
> +
> +       ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
> +       if (ret)
> +               return ret;
> +
>         ret = smu_notify_display_change(smu);
>         if (ret)
>                 return ret;
> @@ -1193,51 +1234,89 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>          * SetMinDeepSleepDcefclk MSG.
>          */
>         ret = smu_set_min_dcef_deep_sleep(smu);
> -       if (ret)
> -               return ret;
> +
> +       return ret;
> +}
> +
> +static int smu_disable_dpms(struct smu_context *smu)
> +{
> +       struct amdgpu_device *adev = smu->adev;
> +       int ret = 0;
> +       bool use_baco = !smu->is_apu &&
> +               ((adev->in_gpu_reset &&
> +                 (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
> +                ((adev->in_runpm || adev->in_hibernate) && amdgpu_asic_supports_baco(adev)));
>
>         /*
> -        * Set initialized values (get from vbios) to dpm tables context such as
> -        * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
> -        * type of clks.
> +        * For custom pptable uploading, skip the DPM features
> +        * disable process on Navi1x ASICs.
> +        *   - As the gfx related features are under control of
> +        *     RLC on those ASICs. RLC reinitialization will be
> +        *     needed to reenable them. That will cost much more
> +        *     efforts.
> +        *
> +        *   - SMU firmware can handle the DPM reenablement
> +        *     properly.
>          */
> -       if (initialize) {
> -               ret = smu_populate_smc_tables(smu);
> -               if (ret)
> -                       return ret;
> +       if (smu->uploading_custom_pp_table &&
> +           (adev->asic_type >= CHIP_NAVI10) &&
> +           (adev->asic_type <= CHIP_NAVI12))
> +               return 0;
>
> -               ret = smu_init_max_sustainable_clocks(smu);
> -               if (ret)
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
>                         return ret;
> +               }
>         }
>
> -       ret = smu_override_pcie_parameters(smu);
> -       if (ret)
> -               return ret;
> +       return ret;
> +}
>
> -       ret = smu_set_default_od_settings(smu);
> -       if (ret)
> -               return ret;
> +static int smu_internal_hw_cleanup(struct smu_context *smu)
> +{
> +       struct amdgpu_device *adev = smu->adev;
> +       int ret = 0;
>
> -       if (initialize) {
> -               ret = smu_populate_umd_state_clk(smu);
> -               if (ret)
> -                       return ret;
> +       smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
>
> -               ret = smu_get_power_limit(smu, &smu->default_power_limit, false, false);
> -               if (ret)
> -                       return ret;
> +       ret = smu_disable_thermal_alert(smu);
> +       if (ret) {
> +               pr_warn("Fail to stop thermal control!\n");
> +               return ret;
>         }
>
> -       /*
> -        * Set PMSTATUSLOG table bo address with SetToolsDramAddr MSG for tools.
> -        */
> -       ret = smu_set_tool_table_location(smu);
> -
> -       if (!smu_is_dpm_running(smu))
> -               pr_info("dpm has been disabled\n");
> +       ret = smu_disable_dpms(smu);
> +       if (ret)
> +               return ret;
>
> -       return ret;
> +       return 0;
>  }
>
>  static int smu_start_smc_engine(struct smu_context *smu)
> @@ -1257,10 +1336,20 @@ static int smu_start_smc_engine(struct smu_context *smu)
>
>         if (smu->ppt_funcs->check_fw_status) {
>                 ret = smu->ppt_funcs->check_fw_status(smu);
> -               if (ret)
> +               if (ret) {
>                         pr_err("SMC is not ready\n");
> +                       return ret;
> +               }
>         }
>
> +       /*
> +        * Send msg GetDriverIfVersion to check if the return value is equal
> +        * with DRIVER_IF_VERSION of smc header.
> +        */
> +       ret = smu_check_fw_version(smu);
> +       if (ret)
> +               return ret;
> +
>         return ret;
>  }
>
> @@ -1289,99 +1378,24 @@ static int smu_hw_init(void *handle)
>         if (!smu->pm_enabled)
>                 return 0;
>
> -       ret = smu_feature_init_dpm(smu);
> -       if (ret)
> -               goto failed;
> -
> -       ret = smu_smc_table_hw_init(smu, true);
> -       if (ret)
> -               goto failed;
> -
> -       /*
> -        * Use msg SetSystemVirtualDramAddr and DramLogSetDramAddr can notify
> -        * pool location.
> -        */
> -       ret = smu_notify_memory_pool_location(smu);
> +       /* get boot_values from vbios to set revision, gfxclk, and etc. */
> +       ret = smu_get_vbios_bootup_values(smu);
>         if (ret)
> -               goto failed;
> +               return ret;
>
> -       ret = smu_enable_thermal_alert(smu);
> +       ret = smu_setup_pptable(smu);
>         if (ret)
> -               goto failed;
> +               return ret;
>
> -       ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
> +       ret = smu_internal_hw_setup(smu);
>         if (ret)
> -               goto failed;
> +               return ret;
>
>         adev->pm.dpm_enabled = true;
>
>         pr_info("SMU is initialized successfully!\n");
>
>         return 0;
> -
> -failed:
> -       return ret;
> -}
> -
> -static int smu_disable_dpms(struct smu_context *smu)
> -{
> -       struct amdgpu_device *adev = smu->adev;
> -       int ret = 0;
> -       bool use_baco = !smu->is_apu &&
> -               ((adev->in_gpu_reset &&
> -                 (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
> -                ((adev->in_runpm || adev->in_hibernate) && amdgpu_asic_supports_baco(adev)));
> -
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
> -       if (smu->uploading_custom_pp_table &&
> -           (adev->asic_type >= CHIP_NAVI10) &&
> -           (adev->asic_type <= CHIP_NAVI12))
> -               return 0;
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
> -        * For baco, need to leave BACO feature enabled
> -        *
> -        * Correct the way for checking whether SMU_FEATURE_BACO_BIT
> -        * is supported.
> -        *
> -        * Since 'smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)' will
> -        * always return false as the 'smu_system_features_control(smu, false)'
> -        * was just issued above which disabled all SMU features.
> -        *
> -        * Thus 'smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT)' is used
> -        * now for the checking.
> -        */
> -       if (use_baco && (smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT) >= 0)) {
> -               ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
> -               if (ret) {
> -                       pr_warn("set BACO feature enabled failed, return %d\n", ret);
> -                       return ret;
> -               }
> -       }
> -
> -       return ret;
>  }
>
>  static int smu_hw_fini(void *handle)
> @@ -1404,19 +1418,9 @@ static int smu_hw_fini(void *handle)
>
>         adev->pm.dpm_enabled = false;
>
> -       smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
> -
> -       ret = smu_disable_thermal_alert(smu);
> -       if (ret) {
> -               pr_warn("Fail to stop thermal control!\n");
> -               return ret;
> -       }
> -
> -       ret = smu_disable_dpms(smu);
> -       if (ret) {
> -               pr_warn("Fail to stop Dpms!\n");
> +       ret = smu_internal_hw_cleanup(smu);
> +       if (ret)
>                 return ret;
> -       }
>
>         return 0;
>  }
> @@ -1434,6 +1438,8 @@ int smu_reset(struct smu_context *smu)
>         if (ret)
>                 return ret;
>
> +       ret = smu_late_init(adev);
> +
>         return ret;
>  }
>
> @@ -1451,15 +1457,7 @@ static int smu_suspend(void *handle)
>
>         adev->pm.dpm_enabled = false;
>
> -       smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
> -
> -       ret = smu_disable_thermal_alert(smu);
> -       if (ret) {
> -               pr_warn("Fail to stop thermal control!\n");
> -               return ret;
> -       }
> -
> -       ret = smu_disable_dpms(smu);
> +       ret = smu_internal_hw_cleanup(smu);
>         if (ret)
>                 return ret;
>
> @@ -1491,20 +1489,12 @@ static int smu_resume(void *handle)
>         ret = smu_start_smc_engine(smu);
>         if (ret) {
>                 pr_err("SMU is not ready yet!\n");
> -               goto failed;
> +               return ret;
>         }
>
> -       ret = smu_smc_table_hw_init(smu, false);
> -       if (ret)
> -               goto failed;
> -
> -       ret = smu_enable_thermal_alert(smu);
> -       if (ret)
> -               goto failed;
> -
> -       ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
> +       ret = smu_internal_hw_setup(smu);
>         if (ret)
> -               goto failed;
> +               return ret;
>
>         if (smu->is_apu)
>                 smu_set_gfx_cgpg(&adev->smu, true);
> @@ -1516,9 +1506,6 @@ static int smu_resume(void *handle)
>         pr_info("SMU is resumed successfully!\n");
>
>         return 0;
> -
> -failed:
> -       return ret;
>  }
>
>  int smu_display_configuration_change(struct smu_context *smu,
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
