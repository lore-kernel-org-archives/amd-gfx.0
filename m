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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64A4C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 20:29:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6884A206DF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 20:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wy3LxzCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6884A206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 343A26EB2D;
	Thu,  9 Jul 2020 20:29:21 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ED026EB2D
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2020 20:29:20 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id g10so6985849wmc.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jul 2020 13:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HxN/pR+gEQ0oBr6/1JVic57ZB6YAseAnhk7XaZhFgRQ=;
 b=Wy3LxzCiUeuX/iMqLXmkQeviH9mBwm+m7zeAUb5YidkSwQMXoTXW4CqKRWawBwLUtJ
 O3GbVKK9Swock2p2xtP7pJsKUsLuJaB8wfuwjK3r1y6t3Eh9bah8E//rp5Kta90VHJAi
 5AwkJF5cXUPcD2E/z/RAcB2Y5LLOJE6kk/LG4FbW3c695E2AABonKnMZ3gF6lVcfz6g6
 0Qx9xxTO0NqyVuGzWCmS7AIa6CtNJ99pZ+Z4yOqhIaCmlKnkyjND+8U3zTEjMOXo2Wtl
 PUW6jHoxtdGipYZsDqRK8PyB917g4XHdWYM20Q3Z3rw06F4TAnl1yUGyqKbDYBsiTq7/
 7zXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HxN/pR+gEQ0oBr6/1JVic57ZB6YAseAnhk7XaZhFgRQ=;
 b=E0fhjMDyOnrqUTzoyz6hQbyPESmXrtvTPngQdEWQKwmPBHYqKJ6AJSi8abHgHNpA8P
 j02L0hyoLKJjAdwZTi3S39rFarl9Hxrtq/Bb5HoLhTOpTBWyWBoW/22BPNuzP+NXJEXN
 pX8STzxjk9b4TF2qbm8bFLRwIwKKeEccnbfauW/mmv6IjDjKhRP6P6kKECav/vSjPGMT
 GbPFJxUzFvHyb1aCnvkpf+2fZhU1n81XxiuIIAIFz93LHrd/na6eimmpSncuu3uqsP9r
 xnlKp38rG3OeZbR6tG8s01O0B08cQ1glc+T61rMTlq+C/sWF5+akC71V6vHTwrnsjldo
 I5vw==
X-Gm-Message-State: AOAM533WxVvEcaFwEC8NcKVw6oJux+5OKoKhZI5BiGNcoqGNuKjdge8X
 MvYEYNoKVikN9varZ6Kcsljw2gQ5sSz1qNfodws=
X-Google-Smtp-Source: ABdhPJyonV1YZAnce9bgMZcad0sdWQ0nG6jFc3ilLmallshs4UrgjvWBnSRqyhk++Q0FHVruS9yiFkyKDdtA3Sezh8g=
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr1650992wmk.39.1594326557418;
 Thu, 09 Jul 2020 13:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200702094447.8158-1-evan.quan@amd.com>
 <20200702094447.8158-4-evan.quan@amd.com>
In-Reply-To: <20200702094447.8158-4-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Jul 2020 16:29:06 -0400
Message-ID: <CADnq5_MBEE4+SxV9XMCVr1X+M4ZxWwfvL4_pTH3Oxkm8O+Z8Aw@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amd/powerplay: drop unused code and wrapper
 around clock retrieving
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

On Thu, Jul 2, 2020 at 5:45 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Clean code by dropping unnecessary ones.
>
> Change-Id: Idf89ef6fa787b61cd8baf8ded7e3f323bdcef189
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  8 +++-
>  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  3 --
>  drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  8 +---
>  drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |  8 ----
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  8 +++-
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  4 +-
>  .../drm/amd/powerplay/sienna_cichlid_ppt.c    |  8 +++-
>  drivers/gpu/drm/amd/powerplay/smu_internal.h  |  1 -
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 47 +------------------
>  drivers/gpu/drm/amd/powerplay/smu_v12_0.c     | 41 ----------------
>  10 files changed, 22 insertions(+), 114 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index 2e04ac1d8ff9..5b793e354704 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -1212,8 +1212,13 @@ static int arcturus_read_sensor(struct smu_context *smu,
>                 *(uint32_t *)data *= 100;
>                 *size = 4;
>                 break;
> +       case AMDGPU_PP_SENSOR_VDDGFX:
> +               ret = smu_v11_0_get_gfx_vdd(smu, (uint32_t *)data);
> +               *size = 4;
> +               break;
>         default:
> -               ret = smu_v11_0_read_sensor(smu, sensor, data, size);
> +               ret = -EOPNOTSUPP;
> +               break;
>         }
>         mutex_unlock(&smu->sensor_lock);
>
> @@ -2566,7 +2571,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
>         .set_default_dpm_table = arcturus_set_default_dpm_table,
>         .populate_umd_state_clk = arcturus_populate_umd_state_clk,
>         .get_thermal_temperature_range = arcturus_get_thermal_temperature_range,
> -       .get_current_clk_freq_by_table = arcturus_get_current_clk_freq_by_table,
>         .print_clk_levels = arcturus_print_clk_levels,
>         .force_clk_levels = arcturus_force_clk_levels,
>         .read_sensor = arcturus_read_sensor,
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index f3bc1f16b0a4..43b4a31b0ffd 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -476,9 +476,6 @@ struct pptable_funcs {
>         int (*get_fan_speed_rpm)(struct smu_context *smu, uint32_t *speed);
>         int (*set_watermarks_table)(struct smu_context *smu, void *watermarks,
>                                     struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges);
> -       int (*get_current_clk_freq_by_table)(struct smu_context *smu,
> -                                            enum smu_clk_type clk_type,
> -                                            uint32_t *value);
>         int (*get_thermal_temperature_range)(struct smu_context *smu, struct smu_temperature_range *range);
>         int (*get_uclk_dpm_states)(struct smu_context *smu, uint32_t *clocks_in_khz, uint32_t *num_states);
>         int (*set_default_od_settings)(struct smu_context *smu);
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> index d07bf4fe6e4a..f2f0b738fb4c 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> @@ -197,19 +197,13 @@ int smu_v11_0_get_current_power_limit(struct smu_context *smu,
>
>  int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n);
>
> -int smu_v11_0_get_current_clk_freq(struct smu_context *smu,
> -                                         enum smu_clk_type clk_id,
> -                                         uint32_t *value);
> -
>  int smu_v11_0_init_max_sustainable_clocks(struct smu_context *smu);
>
>  int smu_v11_0_enable_thermal_alert(struct smu_context *smu);
>
>  int smu_v11_0_disable_thermal_alert(struct smu_context *smu);
>
> -int smu_v11_0_read_sensor(struct smu_context *smu,
> -                                enum amd_pp_sensors sensor,
> -                                void *data, uint32_t *size);
> +int smu_v11_0_get_gfx_vdd(struct smu_context *smu, uint32_t *value);
>
>  int smu_v11_0_set_min_deep_sleep_dcefclk(struct smu_context *smu, uint32_t clk);
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
> index d29f75223987..0c1e1455c68f 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
> @@ -60,10 +60,6 @@ int smu_v12_0_powergate_jpeg(struct smu_context *smu, bool gate);
>
>  int smu_v12_0_set_gfx_cgpg(struct smu_context *smu, bool enable);
>
> -int smu_v12_0_read_sensor(struct smu_context *smu,
> -                         enum amd_pp_sensors sensor,
> -                         void *data, uint32_t *size);
> -
>  uint32_t smu_v12_0_get_gfxoff_status(struct smu_context *smu);
>
>  int smu_v12_0_gfx_off_control(struct smu_context *smu, bool enable);
> @@ -77,10 +73,6 @@ int smu_v12_0_set_default_dpm_tables(struct smu_context *smu);
>  int smu_v12_0_get_enabled_mask(struct smu_context *smu,
>                                       uint32_t *feature_mask, uint32_t num);
>
> -int smu_v12_0_get_current_clk_freq(struct smu_context *smu,
> -                                         enum smu_clk_type clk_id,
> -                                         uint32_t *value);
> -
>  int smu_v12_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
>                                                  uint32_t *min, uint32_t *max);
>
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 3dab6f0e9578..1f96a8ac3fa8 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -1707,8 +1707,13 @@ static int navi10_read_sensor(struct smu_context *smu,
>                 *(uint32_t *)data *= 100;
>                 *size = 4;
>                 break;
> +       case AMDGPU_PP_SENSOR_VDDGFX:
> +               ret = smu_v11_0_get_gfx_vdd(smu, (uint32_t *)data);
> +               *size = 4;
> +               break;
>         default:
> -               ret = smu_v11_0_read_sensor(smu, sensor, data, size);
> +               ret = -EOPNOTSUPP;
> +               break;
>         }
>         mutex_unlock(&smu->sensor_lock);
>
> @@ -2399,7 +2404,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
>         .set_default_dpm_table = navi10_set_default_dpm_table,
>         .dpm_set_vcn_enable = navi10_dpm_set_vcn_enable,
>         .dpm_set_jpeg_enable = navi10_dpm_set_jpeg_enable,
> -       .get_current_clk_freq_by_table = navi10_get_current_clk_freq_by_table,
>         .print_clk_levels = navi10_print_clk_levels,
>         .force_clk_levels = navi10_force_clk_levels,
>         .populate_umd_state_clk = navi10_populate_umd_state_clk,
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index d77e6de95b18..00fac13f06d6 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -907,7 +907,8 @@ static int renoir_read_sensor(struct smu_context *smu,
>                 *size = 4;
>                 break;
>         default:
> -               ret = smu_v12_0_read_sensor(smu, sensor, data, size);
> +               ret = -EOPNOTSUPP;
> +               break;
>         }
>         mutex_unlock(&smu->sensor_lock);
>
> @@ -941,7 +942,6 @@ static const struct pptable_funcs renoir_ppt_funcs = {
>         .get_current_power_state = renoir_get_current_power_state,
>         .dpm_set_vcn_enable = renoir_dpm_set_vcn_enable,
>         .dpm_set_jpeg_enable = renoir_dpm_set_jpeg_enable,
> -       .get_current_clk_freq_by_table = renoir_get_current_clk_freq_by_table,
>         .force_dpm_limit_value = renoir_force_dpm_limit_value,
>         .unforce_dpm_levels = renoir_unforce_dpm_levels,
>         .get_workload_type = renoir_get_workload_type,
> diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> index e6e9583b1180..7078afbd9a6b 100644
> --- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> @@ -1510,8 +1510,13 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
>                 *(uint32_t *)data *= 100;
>                 *size = 4;
>                 break;
> +       case AMDGPU_PP_SENSOR_VDDGFX:
> +               ret = smu_v11_0_get_gfx_vdd(smu, (uint32_t *)data);
> +               *size = 4;
> +               break;
>         default:
> -               ret = smu_v11_0_read_sensor(smu, sensor, data, size);
> +               ret = -EOPNOTSUPP;
> +               break;
>         }
>         mutex_unlock(&smu->sensor_lock);
>
> @@ -2480,7 +2485,6 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>         .set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
>         .dpm_set_vcn_enable = sienna_cichlid_dpm_set_vcn_enable,
>         .dpm_set_jpeg_enable = sienna_cichlid_dpm_set_jpeg_enable,
> -       .get_current_clk_freq_by_table = sienna_cichlid_get_current_clk_freq_by_table,
>         .print_clk_levels = sienna_cichlid_print_clk_levels,
>         .force_clk_levels = sienna_cichlid_force_clk_levels,
>         .populate_umd_state_clk = sienna_cichlid_populate_umd_state_clk,
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> index f0fb74a05f80..8fbfa0562007 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> +++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> @@ -86,7 +86,6 @@
>  #define smu_dpm_set_vcn_enable(smu, enable)                            smu_ppt_funcs(dpm_set_vcn_enable, 0, smu, enable)
>  #define smu_dpm_set_jpeg_enable(smu, enable)                           smu_ppt_funcs(dpm_set_jpeg_enable, 0, smu, enable)
>  #define smu_set_watermarks_table(smu, tab, clock_ranges)               smu_ppt_funcs(set_watermarks_table, 0, smu, tab, clock_ranges)
> -#define smu_get_current_clk_freq_by_table(smu, clk_type, value)                smu_ppt_funcs(get_current_clk_freq_by_table, 0, smu, clk_type, value)
>  #define smu_thermal_temperature_range_update(smu, range, rw)           smu_ppt_funcs(thermal_temperature_range_update, 0, smu, range, rw)
>  #define smu_get_thermal_temperature_range(smu, range)                  smu_ppt_funcs(get_thermal_temperature_range, 0, smu, range)
>  #define smu_register_irq_handler(smu)                                  smu_ppt_funcs(register_irq_handler, 0, smu)
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 952e21234929..560ddf382e4f 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1084,26 +1084,6 @@ int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
>         return 0;
>  }
>
> -int smu_v11_0_get_current_clk_freq(struct smu_context *smu,
> -                                         enum smu_clk_type clk_id,
> -                                         uint32_t *value)
> -{
> -       int ret = 0;
> -       uint32_t freq = 0;
> -
> -       if (clk_id >= SMU_CLK_COUNT || !value)
> -               return -EINVAL;
> -
> -       ret =  smu_get_current_clk_freq_by_table(smu, clk_id, &freq);
> -       if (ret)
> -               return ret;
> -
> -       freq *= 100;
> -       *value = freq;
> -
> -       return ret;
> -}
> -
>  int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
>  {
>         int ret = 0;
> @@ -1153,7 +1133,7 @@ static uint16_t convert_to_vddc(uint8_t vid)
>         return (uint16_t) ((6200 - (vid * 25)) / SMU11_VOLTAGE_SCALE);
>  }
>
> -static int smu_v11_0_get_gfx_vdd(struct smu_context *smu, uint32_t *value)
> +int smu_v11_0_get_gfx_vdd(struct smu_context *smu, uint32_t *value)
>  {
>         struct amdgpu_device *adev = smu->adev;
>         uint32_t vdd = 0, val_vid = 0;
> @@ -1172,31 +1152,6 @@ static int smu_v11_0_get_gfx_vdd(struct smu_context *smu, uint32_t *value)
>
>  }
>
> -int smu_v11_0_read_sensor(struct smu_context *smu,
> -                                enum amd_pp_sensors sensor,
> -                                void *data, uint32_t *size)
> -{
> -       int ret = 0;
> -
> -       if(!data || !size)
> -               return -EINVAL;
> -
> -       switch (sensor) {
> -       case AMDGPU_PP_SENSOR_VDDGFX:
> -               ret = smu_v11_0_get_gfx_vdd(smu, (uint32_t *)data);
> -               *size = 4;
> -               break;
> -       default:
> -               ret = -EOPNOTSUPP;
> -               break;
> -       }
> -
> -       if (ret)
> -               *size = 0;
> -
> -       return ret;
> -}
> -
>  int
>  smu_v11_0_display_clock_voltage_request(struct smu_context *smu,
>                                         struct pp_display_clock_request
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> index 4fb3f4984206..e46fc6178235 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> @@ -203,27 +203,6 @@ int smu_v12_0_set_gfx_cgpg(struct smu_context *smu, bool enable)
>                 NULL);
>  }
>
> -int smu_v12_0_read_sensor(struct smu_context *smu,
> -                                enum amd_pp_sensors sensor,
> -                                void *data, uint32_t *size)
> -{
> -       int ret = 0;
> -
> -       if(!data || !size)
> -               return -EINVAL;
> -
> -       switch (sensor) {
> -       default:
> -               ret = -EOPNOTSUPP;
> -               break;
> -       }
> -
> -       if (ret)
> -               *size = 0;
> -
> -       return ret;
> -}
> -
>  /**
>   * smu_v12_0_get_gfxoff_status - get gfxoff status
>   *
> @@ -337,26 +316,6 @@ int smu_v12_0_get_enabled_mask(struct smu_context *smu,
>         return ret;
>  }
>
> -int smu_v12_0_get_current_clk_freq(struct smu_context *smu,
> -                                         enum smu_clk_type clk_id,
> -                                         uint32_t *value)
> -{
> -       int ret = 0;
> -       uint32_t freq = 0;
> -
> -       if (clk_id >= SMU_CLK_COUNT || !value)
> -               return -EINVAL;
> -
> -       ret = smu_get_current_clk_freq_by_table(smu, clk_id, &freq);
> -       if (ret)
> -               return ret;
> -
> -       freq *= 100;
> -       *value = freq;
> -
> -       return ret;
> -}
> -
>  int smu_v12_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
>                                                  uint32_t *min, uint32_t *max)
>  {
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
