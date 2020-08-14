Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D67C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 05:01:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1157A20656
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 05:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="df45SM5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1157A20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C439B6E2D3;
	Fri, 14 Aug 2020 05:01:52 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86B446E2D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 05:01:52 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id 88so7224426wrh.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 22:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gi4n2uIEGSdWgY8L6CuUCh11sjqSLEnPvWWYbf6HCns=;
 b=df45SM5QixNaZeR5/9Lb0Sez3VA2Gn0F68GXPj5F+wTYCy7z6rpZDhxQUNm0PQd7Dc
 soqgPDIVszlxRju98HjR+JxjQU0ZgssV9iYhtKjV0RPtYl9Kc3CjWJ+MGQAN55m7Wwmb
 0yuyhLa/M4JXPBAcmNDph5Pzk6GtmTv4z58foUeZeAGHNW8DT0fPDCg3ab+y2gz1cQw8
 4QPFX6yMzci7MqQqC5JSf51HrjE4DCXnZAtLlcTkYry+2Z5evMhjmcGXpfPvXAd4BY7z
 Ohsad1v4aTzKMClT8mcYmw5YBakgwzkbKXG4VGBACp9dQFr1yYQWgMxMKyaFDJBHwblk
 ilsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gi4n2uIEGSdWgY8L6CuUCh11sjqSLEnPvWWYbf6HCns=;
 b=tZTqCuyWXD1rfYHDZ4ECVlKvabTxEVSZQ8IPd9Hb7KzFWuch5UdggiY63Zp05FySbF
 7gzml5NV35sNcYrYdUiGQxy6j1YaVKB5vx8hMoAaFlt/8pON20Sl00QN1+zT6KFfFqiT
 sMTxk6zpXpHuy5kBShFY1LwMt9Wo1XXdBEKFrA3cGXhkE95kW4bqTU2i2vbOnPJmWNWz
 At5JVkXHPDrbmPTy1reAV/jCSb8sFaK15oAK4T0p+mzGR8xkq3Zfx2Ag4V4yACHG+Kpf
 pbRa1wyo+sUzo5wPFlF3BKDpIHJEtnCLSSuOZKaOWRZw6ginLmOtAZBymCLytzdUxIId
 P1SA==
X-Gm-Message-State: AOAM530L+nThXbVraKkuOP6+XhXmOukvT2nJiWjARaTdX5piSxPWWNph
 9tVRyR8LZdvaKLUbHe2uNAeHirw84jbYd/bZ9aqGhgZk
X-Google-Smtp-Source: ABdhPJz13jTEE5oSuI4zgVUNNB0BRT8geZIKXyG5L7E2IdVRHLz7mXtTy6OXuTTBpiIXPdYts7GdFdWHbYmHWovpJFA=
X-Received: by 2002:a5d:6348:: with SMTP id b8mr954134wrw.362.1597381310989;
 Thu, 13 Aug 2020 22:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200811033813.1236-1-evan.quan@amd.com>
In-Reply-To: <20200811033813.1236-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Aug 2020 01:01:39 -0400
Message-ID: <CADnq5_PRm9fU-c2Nqv5YZ4JAs+WwunGA782mwe0tS++iu-f=PQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: minor cleanups
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

On Mon, Aug 10, 2020 at 11:38 PM Evan Quan <evan.quan@amd.com> wrote:
>
> Drop unnecessary lock protections during hw setup which was confirmed
> to have no race condition. Drop also unnecessary null pointer checker.
>

I think this would be cleaner as 4 patches:

1. remove the feature mutex locking and explain why it's safe.
2. remove baco mutex locking and explain why it's safe.
3. Removing smu_set_active_display_count
4. the rest.

> Change-Id: Ida301ae7bad1abae15285c4e019eda4f7dc6e297
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 20 --------
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  2 -
>  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 -
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  2 -
>  .../drm/amd/powerplay/sienna_cichlid_ppt.c    |  2 -
>  drivers/gpu/drm/amd/powerplay/smu_internal.h  |  1 +
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 50 ++++---------------
>  7 files changed, 11 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 1ffacc712e53..c70f94377644 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -361,20 +361,16 @@ static int smu_get_driver_allowed_feature_mask(struct smu_context *smu)
>         int ret = 0;
>         uint32_t allowed_feature_mask[SMU_FEATURE_MAX/32];
>
> -       mutex_lock(&feature->mutex);
>         bitmap_zero(feature->allowed, SMU_FEATURE_MAX);
> -       mutex_unlock(&feature->mutex);
>
>         ret = smu_get_allowed_feature_mask(smu, allowed_feature_mask,
>                                              SMU_FEATURE_MAX/32);
>         if (ret)
>                 return ret;
>
> -       mutex_lock(&feature->mutex);
>         bitmap_or(feature->allowed, feature->allowed,
>                       (unsigned long *)allowed_feature_mask,
>                       feature->feature_num);
> -       mutex_unlock(&feature->mutex);
>
>         return ret;
>  }
> @@ -576,9 +572,6 @@ static int smu_fini_fb_allocations(struct smu_context *smu)
>         struct smu_table *tables = smu_table->tables;
>         struct smu_table *driver_table = &(smu_table->driver_table);
>
> -       if (!tables)
> -               return 0;
> -
>         if (tables[SMU_TABLE_PMSTATUSLOG].mc_address)
>                 amdgpu_bo_free_kernel(&tables[SMU_TABLE_PMSTATUSLOG].bo,
>                                       &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
> @@ -2250,19 +2243,6 @@ int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk)
>         return ret;
>  }
>
> -int smu_set_active_display_count(struct smu_context *smu, uint32_t count)
> -{
> -       int ret = 0;
> -
> -       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> -               return -EOPNOTSUPP;
> -
> -       if (smu->ppt_funcs->set_active_display_count)
> -               ret = smu->ppt_funcs->set_active_display_count(smu, count);
> -
> -       return ret;
> -}
> -
>  int smu_get_clock_by_type(struct smu_context *smu,
>                           enum amd_pp_clock_type type,
>                           struct amd_pp_clocks *clocks)
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index 8b1025dc54fd..25679d60f7b4 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -386,11 +386,9 @@ static int arcturus_check_powerplay_table(struct smu_context *smu)
>                 table_context->power_play_table;
>         struct smu_baco_context *smu_baco = &smu->smu_baco;
>
> -       mutex_lock(&smu_baco->mutex);
>         if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_BACO ||
>             powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_MACO)
>                 smu_baco->platform_support = true;
> -       mutex_unlock(&smu_baco->mutex);
>
>         table_context->thermal_controller_type =
>                 powerplay_table->thermal_controller_type;
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 23c2279bd500..8de39b31e7c2 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -698,7 +698,6 @@ int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed);
>  int smu_get_fan_speed_rpm(struct smu_context *smu, uint32_t *speed);
>
>  int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk);
> -int smu_set_active_display_count(struct smu_context *smu, uint32_t count);
>
>  int smu_get_clock_by_type(struct smu_context *smu,
>                           enum amd_pp_clock_type type,
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 42a60769c52f..61e2971be9f3 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -346,11 +346,9 @@ static int navi10_check_powerplay_table(struct smu_context *smu)
>         if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_HARDWAREDC)
>                 smu->dc_controlled_by_gpio = true;
>
> -       mutex_lock(&smu_baco->mutex);
>         if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_BACO ||
>             powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_MACO)
>                 smu_baco->platform_support = true;
> -       mutex_unlock(&smu_baco->mutex);
>
>         table_context->thermal_controller_type =
>                 powerplay_table->thermal_controller_type;
> diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> index c5935f0a065b..f55dd0c2f3c8 100644
> --- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> @@ -294,11 +294,9 @@ static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
>                 table_context->power_play_table;
>         struct smu_baco_context *smu_baco = &smu->smu_baco;
>
> -       mutex_lock(&smu_baco->mutex);
>         if (powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_BACO ||
>             powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_MACO)
>                 smu_baco->platform_support = true;
> -       mutex_unlock(&smu_baco->mutex);
>
>         table_context->thermal_controller_type =
>                 powerplay_table->thermal_controller_type;
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> index 264073d4e263..e44d705780b9 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> +++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> @@ -42,6 +42,7 @@
>  #define smu_check_fw_version(smu)                                      smu_ppt_funcs(check_fw_version, 0, smu)
>  #define smu_write_pptable(smu)                                         smu_ppt_funcs(write_pptable, 0, smu)
>  #define smu_set_min_dcef_deep_sleep(smu, clk)                          smu_ppt_funcs(set_min_dcef_deep_sleep, 0, smu, clk)
> +#define smu_set_active_display_count(smu, count)                       smu_ppt_funcs(set_active_display_count, 0, smu, count)
>  #define smu_set_driver_table_location(smu)                             smu_ppt_funcs(set_driver_table_location, 0, smu)
>  #define smu_set_tool_table_location(smu)                               smu_ppt_funcs(set_tool_table_location, 0, smu)
>  #define smu_notify_memory_pool_location(smu)                           smu_ppt_funcs(notify_memory_pool_location, 0, smu)
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 580889a02a94..4b6162863ed6 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -453,9 +453,6 @@ int smu_v11_0_init_power(struct smu_context *smu)
>  {
>         struct smu_power_context *smu_power = &smu->smu_power;
>
> -       if (smu_power->power_context || smu_power->power_context_size != 0)
> -               return -EINVAL;
> -
>         smu_power->power_context = kzalloc(sizeof(struct smu_11_0_dpm_context),
>                                            GFP_KERNEL);
>         if (!smu_power->power_context)
> @@ -469,9 +466,6 @@ int smu_v11_0_fini_power(struct smu_context *smu)
>  {
>         struct smu_power_context *smu_power = &smu->smu_power;
>
> -       if (!smu_power->power_context || smu_power->power_context_size == 0)
> -               return -EINVAL;
> -
>         kfree(smu_power->power_context);
>         smu_power->power_context = NULL;
>         smu_power->power_context_size = 0;
> @@ -700,18 +694,16 @@ int smu_v11_0_set_tool_table_location(struct smu_context *smu)
>
>  int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)
>  {
> -       int ret = 0;
>         struct amdgpu_device *adev = smu->adev;
>
>         /* Navy_Flounder do not support to change display num currently */
>         if (adev->asic_type == CHIP_NAVY_FLOUNDER)
>                 return 0;
>
> -       if (!smu->pm_enabled)
> -               return ret;
> -
> -       ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays, count, NULL);
> -       return ret;
> +       return smu_cmn_send_smc_msg_with_param(smu,
> +                                              SMU_MSG_NumOfDisplays,
> +                                              count,
> +                                              NULL);
>  }
>
>
> @@ -721,7 +713,6 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
>         int ret = 0;
>         uint32_t feature_mask[2];
>
> -       mutex_lock(&feature->mutex);
>         if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->feature_num < 64)
>                 goto failed;
>
> @@ -738,7 +729,6 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
>                 goto failed;
>
>  failed:
> -       mutex_unlock(&feature->mutex);
>         return ret;
>  }
>
> @@ -775,9 +765,6 @@ int smu_v11_0_notify_display_change(struct smu_context *smu)
>  {
>         int ret = 0;
>
> -       if (!smu->pm_enabled)
> -               return ret;
> -
>         if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
>             smu->adev->gmc.vram_type == AMDGPU_VRAM_TYPE_HBM)
>                 ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetUclkFastSwitch, 1, NULL);
> @@ -1185,12 +1172,10 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
>  int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
>                                      uint32_t pstate)
>  {
> -       int ret = 0;
> -       ret = smu_cmn_send_smc_msg_with_param(smu,
> -                                         SMU_MSG_SetXgmiMode,
> -                                         pstate ? XGMI_MODE_PSTATE_D0 : XGMI_MODE_PSTATE_D3,
> +       return smu_cmn_send_smc_msg_with_param(smu,
> +                                              SMU_MSG_SetXgmiMode,
> +                                              pstate ? XGMI_MODE_PSTATE_D0 : XGMI_MODE_PSTATE_D3,
>                                           NULL);
> -       return ret;
>  }
>
>  static int smu_v11_0_set_irq_state(struct amdgpu_device *adev,
> @@ -1421,11 +1406,7 @@ int smu_v11_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
>
>  int smu_v11_0_set_azalia_d3_pme(struct smu_context *smu)
>  {
> -       int ret = 0;
> -
> -       ret = smu_cmn_send_smc_msg(smu, SMU_MSG_BacoAudioD3PME, NULL);
> -
> -       return ret;
> +       return smu_cmn_send_smc_msg(smu, SMU_MSG_BacoAudioD3PME, NULL);
>  }
>
>  static int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu, enum smu_v11_0_baco_seq baco_seq)
> @@ -1436,13 +1417,8 @@ static int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu, enum smu_v
>  bool smu_v11_0_baco_is_support(struct smu_context *smu)
>  {
>         struct smu_baco_context *smu_baco = &smu->smu_baco;
> -       bool baco_support;
> -
> -       mutex_lock(&smu_baco->mutex);
> -       baco_support = smu_baco->platform_support;
> -       mutex_unlock(&smu_baco->mutex);
>
> -       if (!baco_support)
> +       if (!smu_baco->platform_support)
>                 return false;
>
>         /* Arcturus does not support this bit mask */
> @@ -1529,13 +1505,7 @@ int smu_v11_0_baco_enter(struct smu_context *smu)
>
>  int smu_v11_0_baco_exit(struct smu_context *smu)
>  {
> -       int ret = 0;
> -
> -       ret = smu_v11_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);
> -       if (ret)
> -               return ret;
> -
> -       return ret;
> +       return smu_v11_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);
>  }
>
>  int smu_v11_0_mode1_reset(struct smu_context *smu)
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
