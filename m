Return-Path: <SRS0=lnB5=AU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40341C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 20:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DFC120672
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 20:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3cME9/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFC120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACC646EB37;
	Thu,  9 Jul 2020 20:54:36 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C36926EB37
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2020 20:54:35 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id f2so3748610wrp.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jul 2020 13:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YoGcXZFZ8BcTDEYFePvFfogWqMW037TK9tkm4Vei/0Q=;
 b=B3cME9/2WR877kw5Szo4bJqDCXMsFmuLNv7PuQCEZRBew1PaYcr3tOblIU3wLZkGcp
 37Ro559dbZhiymKgGtD55dUmbnSu/wRrJFyVydl5kzf62rNN6pNMuX/vOczHlYFGnIvx
 deaNTg8/U4CpSK1RebqGzNwkozNZQIYJAculKEYQ6kgyylxHsNcdNM6jrdqJJV3EeB3D
 SQSTAfyi7Y905TaTGlXJQSwNiLD+WJs3fwtswrJYUFlNjWzh/tMuIcihbcocjouKr5W0
 7PWWNFREAaZxK2NreV0kaT+fpupRUR6jUy6kCuS2Rk411JXQL6ygTnhdjFrqdRr2mROm
 7img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YoGcXZFZ8BcTDEYFePvFfogWqMW037TK9tkm4Vei/0Q=;
 b=AzjbfAPflzzswaCukN8x8TIJxMSXmxBqke1Kl6viUsfYm1eIuzTtx9CjNAfXhJ4cKe
 9G4s6g2U+oyiQKo1/x8dzX+W0j73TfKjNVZG6VKo7lhfWcbBeTZnbbzLlFGcSraRTqhX
 MVlUDRjSoYkTrruZnsUmoBPE90WM8e3O/hLE27kl0Oy3wqORX+VaFoRxIOq3WLhpzg1Q
 NGLsxwZmX/qexv/fylenbqUge0z0KX7WWj41LJ34Fb0yTMw+5HIoN5nT1a1g4lkYOpxq
 Gz71D60IepSKyNJV/+gpGDaB3XF0vKoheIVXJNdJL1bdTkenSE2iCQlGet7IvQ3jYSKz
 8NQA==
X-Gm-Message-State: AOAM530taN7dIRKEcMWLF3OLReHWmuUujs73XojoW1PiZIZurBu1Vni3
 hyAIzPnhtf1aMddurx14WajWvrkiPpZzHpesZzPdH8ES
X-Google-Smtp-Source: ABdhPJygFBN0MI0fBbbXpOaqXzWZHeVMR/On+e9VZoqBvv8PM6f/YjdKU+tSKtM2qkbmTgGY4XKcRPupFR9BnN9bJ3I=
X-Received: by 2002:adf:ef89:: with SMTP id d9mr69048169wro.124.1594328074438; 
 Thu, 09 Jul 2020 13:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200703085818.7800-1-evan.quan@amd.com>
 <20200703085818.7800-6-evan.quan@amd.com>
In-Reply-To: <20200703085818.7800-6-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Jul 2020 16:54:23 -0400
Message-ID: <CADnq5_NnQOKu2kG6-WLepoXpSXNRZz-wWgLVvJbCCfDYXQ74Xg@mail.gmail.com>
Subject: Re: [PATCH 6/6] drm/amd/powerplay: drop unused code around thermal
 range setting
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

On Fri, Jul 3, 2020 at 4:59 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Leftover of previous cleanups.
>
> Change-Id: I36a018349647125513e47edda66db2005bd8b0c5
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 32 -------------------
>  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 --
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 32 -------------------
>  .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 32 -------------------
>  drivers/gpu/drm/amd/powerplay/smu_internal.h  |  2 --
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 16 ++--------
>  6 files changed, 3 insertions(+), 113 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index 209ccf38c020..56dc20a617fd 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -2314,37 +2314,6 @@ static void arcturus_log_thermal_throttling_event(struct smu_context *smu)
>                         log_buf);
>  }
>
> -static int arcturus_set_thermal_range(struct smu_context *smu,
> -                                      struct smu_temperature_range range)
> -{
> -       struct amdgpu_device *adev = smu->adev;
> -       int low = SMU_THERMAL_MINIMUM_ALERT_TEMP;
> -       int high = SMU_THERMAL_MAXIMUM_ALERT_TEMP;
> -       uint32_t val;
> -       struct smu_table_context *table_context = &smu->smu_table;
> -       struct smu_11_0_powerplay_table *powerplay_table = table_context->power_play_table;
> -
> -       low = max(SMU_THERMAL_MINIMUM_ALERT_TEMP,
> -                       range.min / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
> -       high = min((uint16_t)SMU_THERMAL_MAXIMUM_ALERT_TEMP, powerplay_table->software_shutdown_temp);
> -
> -       if (low > high)
> -               return -EINVAL;
> -
> -       val = RREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL);
> -       val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT, 5);
> -       val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);
> -       val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTH_MASK, 0);
> -       val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTL_MASK, 0);
> -       val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (high & 0xff));
> -       val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (low & 0xff));
> -       val = val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
> -
> -       WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);
> -
> -       return 0;
> -}
> -
>  static const struct pptable_funcs arcturus_ppt_funcs = {
>         /* translate smu index into arcturus specific index */
>         .get_smu_msg_index = arcturus_get_smu_msg_index,
> @@ -2427,7 +2396,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
>         .set_df_cstate = arcturus_set_df_cstate,
>         .allow_xgmi_power_down = arcturus_allow_xgmi_power_down,
>         .log_thermal_throttling_event = arcturus_log_thermal_throttling_event,
> -       .set_thermal_range = arcturus_set_thermal_range,
>  };
>
>  void arcturus_set_ppt_funcs(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index dede24959652..52e5603dcc97 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -480,7 +480,6 @@ struct pptable_funcs {
>         int (*set_cpu_power_state)(struct smu_context *smu);
>         bool (*is_dpm_running)(struct smu_context *smu);
>         int (*tables_init)(struct smu_context *smu, struct smu_table *tables);
> -       int (*set_thermal_fan_table)(struct smu_context *smu);
>         int (*get_fan_speed_percent)(struct smu_context *smu, uint32_t *speed);
>         int (*get_fan_speed_rpm)(struct smu_context *smu, uint32_t *speed);
>         int (*set_watermarks_table)(struct smu_context *smu, void *watermarks,
> @@ -570,7 +569,6 @@ struct pptable_funcs {
>         int (*disable_umc_cdr_12gbps_workaround)(struct smu_context *smu);
>         int (*set_power_source)(struct smu_context *smu, enum smu_power_src_type power_src);
>         void (*log_thermal_throttling_event)(struct smu_context *smu);
> -       int (*set_thermal_range)(struct smu_context *smu, struct smu_temperature_range range);
>  };
>
>  typedef enum {
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index a04a0ba632a9..41bd6d157271 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -2340,37 +2340,6 @@ static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
>         return navi10_dummy_pstate_control(smu, true);
>  }
>
> -static int navi10_set_thermal_range(struct smu_context *smu,
> -                                      struct smu_temperature_range range)
> -{
> -       struct amdgpu_device *adev = smu->adev;
> -       int low = SMU_THERMAL_MINIMUM_ALERT_TEMP;
> -       int high = SMU_THERMAL_MAXIMUM_ALERT_TEMP;
> -       uint32_t val;
> -       struct smu_table_context *table_context = &smu->smu_table;
> -       struct smu_11_0_powerplay_table *powerplay_table = table_context->power_play_table;
> -
> -       low = max(SMU_THERMAL_MINIMUM_ALERT_TEMP,
> -                       range.min / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
> -       high = min((uint16_t)SMU_THERMAL_MAXIMUM_ALERT_TEMP, powerplay_table->software_shutdown_temp);
> -
> -       if (low > high)
> -               return -EINVAL;
> -
> -       val = RREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL);
> -       val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT, 5);
> -       val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);
> -       val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTH_MASK, 0);
> -       val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTL_MASK, 0);
> -       val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (high & 0xff));
> -       val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (low & 0xff));
> -       val = val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
> -
> -       WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);
> -
> -       return 0;
> -}
> -
>  static const struct pptable_funcs navi10_ppt_funcs = {
>         .tables_init = navi10_tables_init,
>         .alloc_dpm_context = navi10_allocate_dpm_context,
> @@ -2452,7 +2421,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
>         .run_btc = navi10_run_btc,
>         .disable_umc_cdr_12gbps_workaround = navi10_disable_umc_cdr_12gbps_workaround,
>         .set_power_source = smu_v11_0_set_power_source,
> -       .set_thermal_range = navi10_set_thermal_range,
>  };
>
>  void navi10_set_ppt_funcs(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> index 4180b9196504..ebe8b5a88f0b 100644
> --- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> @@ -1795,37 +1795,6 @@ static bool sienna_cichlid_is_baco_supported(struct smu_context *smu)
>         return (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true : false;
>  }
>
> -static int sienna_cichlid_set_thermal_range(struct smu_context *smu,
> -                                      struct smu_temperature_range range)
> -{
> -       struct amdgpu_device *adev = smu->adev;
> -       int low = SMU_THERMAL_MINIMUM_ALERT_TEMP;
> -       int high = SMU_THERMAL_MAXIMUM_ALERT_TEMP;
> -       uint32_t val;
> -       struct smu_table_context *table_context = &smu->smu_table;
> -       struct smu_11_0_7_powerplay_table *powerplay_table = table_context->power_play_table;
> -
> -       low = max(SMU_THERMAL_MINIMUM_ALERT_TEMP,
> -                       range.min / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
> -       high = min((uint16_t)SMU_THERMAL_MAXIMUM_ALERT_TEMP, powerplay_table->software_shutdown_temp);
> -
> -       if (low > high)
> -               return -EINVAL;
> -
> -       val = RREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL);
> -       val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT, 5);
> -       val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);
> -       val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTH_MASK, 0);
> -       val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTL_MASK, 0);
> -       val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (high & 0xff));
> -       val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (low & 0xff));
> -       val = val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
> -
> -       WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);
> -
> -       return 0;
> -}
> -
>  static void sienna_cichlid_dump_pptable(struct smu_context *smu)
>  {
>         struct smu_table_context *table_context = &smu->smu_table;
> @@ -2563,7 +2532,6 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>         .baco_exit = smu_v11_0_baco_exit,
>         .get_dpm_ultimate_freq = sienna_cichlid_get_dpm_ultimate_freq,
>         .set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
> -       .set_thermal_range = sienna_cichlid_set_thermal_range,
>  };
>
>  void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> index db11b9e28646..8c5cf3860e38 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> +++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> @@ -60,7 +60,6 @@
>  #define smu_populate_umd_state_clk(smu)                                        smu_ppt_funcs(populate_umd_state_clk, 0, smu)
>  #define smu_set_default_od8_settings(smu)                              smu_ppt_funcs(set_default_od8_settings, 0, smu)
>  #define smu_tables_init(smu, tab)                                      smu_ppt_funcs(tables_init, 0, smu, tab)
> -#define smu_set_thermal_fan_table(smu)                                 smu_ppt_funcs(set_thermal_fan_table, 0, smu)
>  #define smu_enable_thermal_alert(smu)                                  smu_ppt_funcs(enable_thermal_alert, 0, smu)
>  #define smu_disable_thermal_alert(smu)                                 smu_ppt_funcs(disable_thermal_alert, 0, smu)
>  #define smu_smc_read_sensor(smu, sensor, data, size)                   smu_ppt_funcs(read_sensor, -EINVAL, smu, sensor, data, size)
> @@ -90,7 +89,6 @@
>  #define smu_asic_set_performance_level(smu, level)                     smu_ppt_funcs(set_performance_level, -EINVAL, smu, level)
>  #define smu_dump_pptable(smu)                                          smu_ppt_funcs(dump_pptable, 0, smu)
>  #define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap)  smu_ppt_funcs(update_pcie_parameters, 0, smu, pcie_gen_cap, pcie_width_cap)
> -#define smu_set_thermal_range(smu, range)                              smu_ppt_funcs(set_thermal_range, 0, smu, range)
>  #define smu_disable_umc_cdr_12gbps_workaround(smu)                     smu_ppt_funcs(disable_umc_cdr_12gbps_workaround, 0, smu)
>  #define smu_set_power_source(smu, power_src)                           smu_ppt_funcs(set_power_source, 0, smu, power_src)
>  #define smu_i2c_eeprom_init(smu, control)                              smu_ppt_funcs(i2c_eeprom_init, 0, smu, control)
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 86a118a3a80c..f711c1da1cad 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1085,20 +1085,10 @@ int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
>
>  int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
>  {
> -       int ret = 0;
> -       struct amdgpu_device *adev = smu->adev;
> -
> -       if (smu->smu_table.thermal_controller_type) {
> -               ret = amdgpu_irq_get(adev, &smu->irq_source, 0);
> -               if (ret)
> -                       return ret;
> +       if (smu->smu_table.thermal_controller_type)
> +               return amdgpu_irq_get(smu->adev, &smu->irq_source, 0);
>
> -               ret = smu_set_thermal_fan_table(smu);
> -               if (ret)
> -                       return ret;
> -       }
> -
> -       return ret;
> +       return 0;
>  }
>
>  int smu_v11_0_disable_thermal_alert(struct smu_context *smu)
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
