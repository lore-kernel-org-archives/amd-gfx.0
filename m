Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD04C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 20:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA5820775
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 20:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSj2TLya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA5820775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D8776E99D;
	Mon,  8 Jun 2020 20:12:20 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBCAB6E99B
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 20:12:18 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id y17so18823277wrn.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Jun 2020 13:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2dqKc7caspYLIvWYum2Hs1Zz16go4sRWut7BnykP0Dw=;
 b=KSj2TLya+47/Y5bXT4PI4MKDbzRn8aCuAuePA/uludl/RjJhdh1kEldLKaA0tMydDC
 Pmol4xFsQxIWD2NWXjDECzvQ5zb19aU3LioQDk0DuOduWy8kfMpK9qjlQYXIjV6wS75Y
 Q/zQJ6s/S38dhPCng7n3mNeteTlvalUqYNvcKWwvOtr6rPdVkTukrny9pApm0OaUr+4B
 80hZjc3irdhF92+qCDcIKqn51Uuz3JFtaf/QMtrg6kggTMVXAw+K+wJf6UA6Wz/OD5//
 9YYInMsQTt/+B47Jse1HN+a0z1wefajUV932KbfhFoz6vKskPruvbkfzL9tMn7BcAgna
 g6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2dqKc7caspYLIvWYum2Hs1Zz16go4sRWut7BnykP0Dw=;
 b=ooe8MIGlq/295aKRTRDy9wr8/7c4JDj4Zxds1ggcpKPk5nK3tr/yDlkYOB3/wVs9h+
 bcxS1RhnjqquDtHcBqwE4SQYmK+1W79BD/jcY/RczcclhP/rn88La9giGkLQjRXf6yaO
 /cYW/8B3LmlKDDEKISUqBC/MROajk8sC03mpycggKQf8ibFJ0M56LNfFezQiy0Y4iTc6
 qRT9keagktB3baZqDTP+exAfsYJUxZ0x1kZ3jqHziT11Qbwo7t2qHQe7ISLLZh0rrAgE
 0qpmO5wp1at1D/L5BtAr3o9F3O2vrU970EubraRNzfCDWfviTkfRClJKwHcke68E31tr
 eddQ==
X-Gm-Message-State: AOAM532A84HmpVYngfcWWFK68NxGZu+jvAHhiZSwVaDflyb0JxxJlNiD
 D9j0CCx9tXvGipQPAvG+9fXTqrRgRF8dD5O4Ch6mwg==
X-Google-Smtp-Source: ABdhPJyCFq5g2SX0/VdPONdHPBeSGnOKVc0Tb/caF2iV1RBJZsX9IsZ4ElAZbv34ir7Qf/uwMO8/9uuw8vHl7Q1i21k=
X-Received: by 2002:a5d:400f:: with SMTP id n15mr486146wrp.419.1591647137457; 
 Mon, 08 Jun 2020 13:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200605110200.27206-1-evan.quan@amd.com>
 <20200605110200.27206-3-evan.quan@amd.com>
In-Reply-To: <20200605110200.27206-3-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Jun 2020 16:12:06 -0400
Message-ID: <CADnq5_PsRvEjYu2OdiOk-OLrSp=0HDTZtFMa03ceM7TOfJBuuA@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/powerplay: add error messages on some
 critical paths
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

On Fri, Jun 5, 2020 at 7:02 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Helpful for error diagnostic.
>
> Change-Id: I983ca308a2ee6ed11e16ec59ad97040d98b90512
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 118 +++++++++++++++------
>  1 file changed, 87 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 0c5e062a21a7..11538477da93 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -457,18 +457,30 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
>         switch (block_type) {
>         case AMD_IP_BLOCK_TYPE_UVD:
>                 ret = smu_dpm_set_uvd_enable(smu, !gate);
> +               if (ret)
> +                       dev_err(smu->adev->dev, "Failed to power %s UVD!\n",
> +                               gate ? "gate" : "ungate");
>                 break;
>         case AMD_IP_BLOCK_TYPE_VCE:
>                 ret = smu_dpm_set_vce_enable(smu, !gate);
>                 break;
>         case AMD_IP_BLOCK_TYPE_GFX:
>                 ret = smu_gfx_off_control(smu, gate);
> +               if (ret)
> +                       dev_err(smu->adev->dev, "Failed to %s gfxoff!\n",
> +                               gate ? "enable" : "disable");
>                 break;
>         case AMD_IP_BLOCK_TYPE_SDMA:
>                 ret = smu_powergate_sdma(smu, gate);
> +               if (ret)
> +                       dev_err(smu->adev->dev, "Failed to power %s SDMA!\n",
> +                               gate ? "gate" : "ungate");
>                 break;
>         case AMD_IP_BLOCK_TYPE_JPEG:
>                 ret = smu_dpm_set_jpeg_enable(smu, !gate);
> +               if (ret)
> +                       dev_err(smu->adev->dev, "Failed to power %s JPEG!\n",
> +                               gate ? "gate" : "ungate");
>                 break;
>         default:
>                 break;
> @@ -788,8 +800,10 @@ static int smu_late_init(void *handle)
>                 return 0;
>
>         ret = smu_set_default_od_settings(smu);
> -       if (ret)
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to setup default OD settings!\n");
>                 return ret;
> +       }
>
>         /*
>          * Set initialized values (get from vbios) to dpm tables context such as
> @@ -797,20 +811,28 @@ static int smu_late_init(void *handle)
>          * type of clks.
>          */
>         ret = smu_populate_smc_tables(smu);
> -       if (ret)
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to setup default dpm clock tables!\n");
>                 return ret;
> +       }
>
>         ret = smu_init_max_sustainable_clocks(smu);
> -       if (ret)
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to init max sustainable clocks!\n");
>                 return ret;
> +       }
>
>         ret = smu_populate_umd_state_clk(smu);
> -       if (ret)
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to populate UMD state clocks!\n");
>                 return ret;
> +       }
>
>         ret = smu_get_power_limit(smu, &smu->default_power_limit, false, false);
> -       if (ret)
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to get default power limit!\n");
>                 return ret;
> +       }
>
>         smu_get_unique_id(smu);
>
> @@ -954,6 +976,8 @@ static int smu_alloc_memory_pool(struct smu_context *smu)
>                                               &memory_pool->bo,
>                                               &memory_pool->mc_address,
>                                               &memory_pool->cpu_addr);
> +               if (ret)
> +                       dev_err(adev->dev, "VRAM allocation for dramlog failed!\n");
>                 break;
>         default:
>                 break;
> @@ -1147,27 +1171,35 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>         }
>
>         ret = smu_init_display_count(smu, 0);
> -       if (ret)
> +       if (ret) {
> +               dev_info(adev->dev, "Failed to pre-set display count as 0!\n");
>                 return ret;
> +       }
>
>         ret = smu_set_driver_table_location(smu);
> -       if (ret)
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to SetDriverDramAddr!\n");
>                 return ret;
> +       }
>
>         /*
>          * Set PMSTATUSLOG table bo address with SetToolsDramAddr MSG for tools.
>          */
>         ret = smu_set_tool_table_location(smu);
> -       if (ret)
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to SetToolsDramAddr!\n");
>                 return ret;
> +       }
>
>         /*
>          * Use msg SetSystemVirtualDramAddr and DramLogSetDramAddr can notify
>          * pool location.
>          */
>         ret = smu_notify_memory_pool_location(smu);
> -       if (ret)
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to SetDramLogDramAddr!\n");
>                 return ret;
> +       }
>
>         /* smu_dump_pptable(smu); */
>         /*
> @@ -1175,8 +1207,10 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>          * SetDriverDramAddr and TransferTableDram2Smu.
>          */
>         ret = smu_write_pptable(smu);
> -       if (ret)
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to transfer pptable to SMC!\n");
>                 return ret;
> +       }
>
>         /* issue Run*Btc msg */
>         ret = smu_run_btc(smu);
> @@ -1184,12 +1218,16 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>                 return ret;
>
>         ret = smu_feature_set_allowed_mask(smu);
> -       if (ret)
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to set driver allowed features mask!\n");
>                 return ret;
> +       }
>
>         ret = smu_system_features_control(smu, true);
> -       if (ret)
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to enable requested dpm features!\n");
>                 return ret;
> +       }
>
>         if (!smu_is_dpm_running(smu))
>                 dev_info(adev->dev, "dpm has been disabled\n");
> @@ -1199,8 +1237,10 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>                 return ret;
>
>         ret = smu_enable_thermal_alert(smu);
> -       if (ret)
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to enable thermal alert!\n");
>                 return ret;
> +       }
>
>         ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
>         if (ret)
> @@ -1284,7 +1324,7 @@ static int smu_hw_init(void *handle)
>
>         ret = smu_start_smc_engine(smu);
>         if (ret) {
> -               dev_err(adev->dev, "SMU is not ready yet!\n");
> +               dev_err(adev->dev, "SMC engine is not correctly up!\n");
>                 return ret;
>         }
>
> @@ -1300,29 +1340,32 @@ static int smu_hw_init(void *handle)
>
>         /* get boot_values from vbios to set revision, gfxclk, and etc. */
>         ret = smu_get_vbios_bootup_values(smu);
> -       if (ret)
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to get VBIOS boot clock values!\n");
>                 return ret;
> +       }
>
>         ret = smu_setup_pptable(smu);
> -       if (ret)
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to setup pptable!\n");
>                 return ret;
> +       }
>
>         ret = smu_get_driver_allowed_feature_mask(smu);
>         if (ret)
> -               goto failed;
> +               return ret;
>
>         ret = smu_smc_hw_setup(smu);
> -       if (ret)
> -               goto failed;
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to setup smc hw!\n");
> +               return ret;
> +       }
>
>         adev->pm.dpm_enabled = true;
>
>         dev_info(adev->dev, "SMU is initialized successfully!\n");
>
>         return 0;
> -
> -failed:
> -       return ret;
>  }
>
>  static int smu_disable_dpms(struct smu_context *smu)
> @@ -1395,13 +1438,15 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
>
>         ret = smu_disable_thermal_alert(smu);
>         if (ret) {
> -               dev_warn(adev->dev, "Fail to stop thermal control!\n");
> +               dev_err(adev->dev, "Fail to disable thermal alert!\n");
>                 return ret;
>         }
>
>         ret = smu_disable_dpms(smu);
> -       if (ret)
> +       if (ret) {
> +               dev_err(adev->dev, "Fail to disable dpm features!\n");
>                 return ret;
> +       }
>
>         return 0;
>  }
> @@ -1493,13 +1538,15 @@ static int smu_resume(void *handle)
>
>         ret = smu_start_smc_engine(smu);
>         if (ret) {
> -               dev_err(adev->dev, "SMU is not ready yet!\n");
> -               goto failed;
> +               dev_err(adev->dev, "SMC engine is not correctly up!\n");
> +               return ret;
>         }
>
>         ret = smu_smc_hw_setup(smu);
> -       if (ret)
> -               goto failed;
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to setup smc hw!\n");
> +               return ret;
> +       }
>
>         if (smu->is_apu)
>                 smu_set_gfx_cgpg(&adev->smu, true);
> @@ -1511,9 +1558,6 @@ static int smu_resume(void *handle)
>         dev_info(adev->dev, "SMU is resumed successfully!\n");
>
>         return 0;
> -
> -failed:
> -       return ret;
>  }
>
>  int smu_display_configuration_change(struct smu_context *smu,
> @@ -2589,6 +2633,9 @@ int smu_set_xgmi_pstate(struct smu_context *smu,
>
>         mutex_unlock(&smu->mutex);
>
> +       if(ret)
> +               dev_err(smu->adev->dev, "Failed to set XGMI pstate!\n");
> +
>         return ret;
>  }
>
> @@ -2660,6 +2707,9 @@ int smu_baco_enter(struct smu_context *smu)
>
>         mutex_unlock(&smu->mutex);
>
> +       if (ret)
> +               dev_err(smu->adev->dev, "Failed to enter BACO state!\n");
> +
>         return ret;
>  }
>
> @@ -2677,6 +2727,9 @@ int smu_baco_exit(struct smu_context *smu)
>
>         mutex_unlock(&smu->mutex);
>
> +       if (ret)
> +               dev_err(smu->adev->dev, "Failed to exit BACO state!\n");
> +
>         return ret;
>  }
>
> @@ -2694,6 +2747,9 @@ int smu_mode2_reset(struct smu_context *smu)
>
>         mutex_unlock(&smu->mutex);
>
> +       if (ret)
> +               dev_err(smu->adev->dev, "Mode2 reset failed!\n");
> +
>         return ret;
>  }
>
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
