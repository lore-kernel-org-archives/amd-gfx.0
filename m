Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A61C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 20:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 712F560FC3
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 20:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 712F560FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E58386EA89;
	Fri, 29 Oct 2021 20:57:53 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81EE86EA89
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 20:57:53 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 v2-20020a05683018c200b0054e3acddd91so15260030ote.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 13:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=du5GGxGUR3u3thbcA7iAEUPiRUiwh6l2DN4Aeiif38w=;
 b=PKINzI5Ws//XiO8S92uYWuUpNdqSrAI0ZF4pK9ZOjhkDNuZBKvj7oGipk9d0szVVDR
 DYKiPJl4pVS6ekXdRT+3CBEotFTpiw2jemBo9YlrYYVtkHQcZQ71PKLrurSivKzMK0nM
 CvJjh483MCPTduOUALFKl/EV57JA0wLM1viPvGIh7ug1ppmujrmcf5w5YlKiDRGTSkOb
 FWV9yiWLT+Vqkh6FVeUJjp5+361w0kIP6tFEUWPTW5WjOQBGVASinnY7kp+78F+VZ7uT
 uEoFWOvUD0WQA6bGIRpfX+B9XrM6wumt556g3UMF2xerVZPH5UpOxelQmURLak/RyOZA
 /lNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=du5GGxGUR3u3thbcA7iAEUPiRUiwh6l2DN4Aeiif38w=;
 b=ZJ7moSKJUhvqjz4cbo2ynJV+ZE0VGd7hG6OmlBsWfeWy7Gy5GDuL/tfa79JdnI3e1i
 tySRDbDGOCFBhYCkaKudr7Pepn4CkgESm8uatNnlq7hTZrokpf1i1eINlAErE+ysjm/1
 9zzdvoVgOYLc2imQbwiK26XfRTVVbXgsrDq6dNP/wPuxhv5zBb1pw9pgS0NFx2fpEq9W
 Jm9UgIjc9JXSl4hN8oxChjJR46857G6AnlrgyUJWLNikyrtrRG4rDVroVLOm29Nbts69
 IMVrtOdH5hUfZTv97QGKSxtgl3xRYLiMw7U7UwV4IbnrfXFPWQ7I07iUQ4f4pzZViOcw
 K4CQ==
X-Gm-Message-State: AOAM5329waI/J2v7/k0PgFpa11cHoKnjKrRE4J/qX5K9I6X5W2yNb7G8
 DRpHql9Fv8cUhDmP2C2/5O80O3Eu557tbdmQ8hvNokZWrRtBEQ==
X-Google-Smtp-Source: ABdhPJwVNqrrMjHtBLoZ0TvP3EBJpdSECGvf0upK7DFAS2OY+cwn24I8qu97lWL6ZCu3OLPA+4Bo4m6os28ODCjzWSk=
X-Received: by 2002:a9d:61d9:: with SMTP id h25mr10597714otk.357.1635541072757; 
 Fri, 29 Oct 2021 13:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211029153343.17437-1-mario.limonciello@amd.com>
In-Reply-To: <20211029153343.17437-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 29 Oct 2021 16:57:41 -0400
Message-ID: <CADnq5_MYeJF38_-FzHU7GPwhDpUiZwMQQ+naOpgXsTig_42D_A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/pm: drop pp_power_profile_mode support for
 yellow carp
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 29, 2021 at 11:34 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> This was added by commit bd8dcea93a7d ("drm/amd/pm: add callbacks to
> read/write sysfs file pp_power_profile_mode") but the feature was
> deprecated from PMFW.  Remove it from the driver.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Probably want something like the following too:
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index c255b4b8e685..c1b8ed9f7ba8 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2092,6 +2092,9 @@ static int default_attr_update(struct
amdgpu_device *adev, struct amdgpu_device_
        } else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
                if (!(asic_type == CHIP_VANGOGH || asic_type ==
CHIP_SIENNA_CICHLID))
                        *states = ATTR_STATE_UNSUPPORTED;
+       } else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
+               if (asic_type == CHIP_YELLOW_CARP)
+                       *states = ATTR_STATE_UNSUPPORTED;
        }

        switch (asic_type) {

So we don't expose the sysfs knob on the YC, but that can be a follow
up patch if you want.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> Changes from v1->v2:
>  * Drop changes to RN and VGH as the deprecation is only in YC.
>  * Leave PPSMC_MSG_ActiveProcessNotify message but mark deprecated
>  * Rename PPSMC_MSG_SPARE0 to align to the name used by PMFW (PPSMC_MSG_SPARE)
>
>  .../gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h    |  4 +-
>  .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 87 -------------------
>  2 files changed, 2 insertions(+), 89 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
> index 1d3447991d0c..fc9198846e70 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
> @@ -51,7 +51,7 @@
>  #define PPSMC_MSG_PowerUpVcn                    0x07 ///< Power up VCN; VCN is power gated by default
>  #define PPSMC_MSG_SetHardMinVcn                 0x08 ///< For wireless display
>  #define PPSMC_MSG_SetSoftMinGfxclk              0x09 ///< Set SoftMin for GFXCLK, argument is frequency in MHz
> -#define PPSMC_MSG_ActiveProcessNotify           0x0A ///< Set active work load type
> +#define PPSMC_MSG_ActiveProcessNotify           0x0A ///< Deprecated (Not to be used)
>  #define PPSMC_MSG_ForcePowerDownGfx             0x0B ///< Force power down GFX, i.e. enter GFXOFF
>  #define PPSMC_MSG_PrepareMp1ForUnload           0x0C ///< Prepare PMFW for GFX driver unload
>  #define PPSMC_MSG_SetDriverDramAddrHigh         0x0D ///< Set high 32 bits of DRAM address for Driver table transfer
> @@ -63,7 +63,7 @@
>  #define PPSMC_MSG_SetHardMinSocclkByFreq        0x13 ///< Set hard min for SOC CLK
>  #define PPSMC_MSG_SetSoftMinFclk                0x14 ///< Set hard min for FCLK
>  #define PPSMC_MSG_SetSoftMinVcn                 0x15 ///< Set soft min for VCN clocks (VCLK and DCLK)
> -#define PPSMC_MSG_SPARE0                        0x16 ///< Spared
> +#define PPSMC_MSG_SPARE                         0x16 ///< Spare
>  #define PPSMC_MSG_GetGfxclkFrequency            0x17 ///< Get GFX clock frequency
>  #define PPSMC_MSG_GetFclkFrequency              0x18 ///< Get FCLK frequency
>  #define PPSMC_MSG_AllowGfxOff                   0x19 ///< Inform PMFW of allowing GFXOFF entry
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index a403657151ba..8215bbf5ed7c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -64,7 +64,6 @@ static struct cmn2asic_msg_mapping yellow_carp_message_map[SMU_MSG_MAX_COUNT] =
>         MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,                 1),
>         MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,                   1),
>         MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,                1),
> -       MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,          1),
>         MSG_MAP(PrepareMp1ForUnload,            PPSMC_MSG_PrepareMp1ForUnload,      1),
>         MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh,        1),
>         MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAddrLow,         1),
> @@ -135,14 +134,6 @@ static struct cmn2asic_mapping yellow_carp_table_map[SMU_TABLE_COUNT] = {
>         TAB_MAP_VALID(CUSTOM_DPM),
>         TAB_MAP_VALID(DPMCLOCKS),
>  };
> -
> -static struct cmn2asic_mapping yellow_carp_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
> -       WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,         WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
> -       WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,                WORKLOAD_PPLIB_VIDEO_BIT),
> -       WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,                   WORKLOAD_PPLIB_VR_BIT),
> -       WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,              WORKLOAD_PPLIB_COMPUTE_BIT),
> -       WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,               WORKLOAD_PPLIB_CUSTOM_BIT),
> -};
>
>  static int yellow_carp_init_smc_tables(struct smu_context *smu)
>  {
> @@ -543,81 +534,6 @@ static int yellow_carp_set_watermarks_table(struct smu_context *smu,
>         return 0;
>  }
>
> -static int yellow_carp_get_power_profile_mode(struct smu_context *smu,
> -                                               char *buf)
> -{
> -       static const char *profile_name[] = {
> -                                       "BOOTUP_DEFAULT",
> -                                       "3D_FULL_SCREEN",
> -                                       "POWER_SAVING",
> -                                       "VIDEO",
> -                                       "VR",
> -                                       "COMPUTE",
> -                                       "CUSTOM"};
> -       uint32_t i, size = 0;
> -       int16_t workload_type = 0;
> -
> -       if (!buf)
> -               return -EINVAL;
> -
> -       for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
> -               /*
> -                * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT.
> -                * Not all profile modes are supported on yellow carp.
> -                */
> -               workload_type = smu_cmn_to_asic_specific_index(smu,
> -                                                              CMN2ASIC_MAPPING_WORKLOAD,
> -                                                              i);
> -
> -               if (workload_type < 0)
> -                       continue;
> -
> -               size += sysfs_emit_at(buf, size, "%2d %14s%s\n",
> -                       i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
> -       }
> -
> -       return size;
> -}
> -
> -static int yellow_carp_set_power_profile_mode(struct smu_context *smu,
> -                                               long *input, uint32_t size)
> -{
> -       int workload_type, ret;
> -       uint32_t profile_mode = input[size];
> -
> -       if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> -               dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
> -               return -EINVAL;
> -       }
> -
> -       if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> -                       profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
> -               return 0;
> -
> -       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> -       workload_type = smu_cmn_to_asic_specific_index(smu,
> -                                                      CMN2ASIC_MAPPING_WORKLOAD,
> -                                                      profile_mode);
> -       if (workload_type < 0) {
> -               dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on YELLOWCARP\n",
> -                                       profile_mode);
> -               return -EINVAL;
> -       }
> -
> -       ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
> -                                   1 << workload_type,
> -                                   NULL);
> -       if (ret) {
> -               dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
> -                                       workload_type);
> -               return ret;
> -       }
> -
> -       smu->power_profile_mode = profile_mode;
> -
> -       return 0;
> -}
> -
>  static ssize_t yellow_carp_get_gpu_metrics(struct smu_context *smu,
>                                                 void **table)
>  {
> @@ -1238,8 +1154,6 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
>         .read_sensor = yellow_carp_read_sensor,
>         .is_dpm_running = yellow_carp_is_dpm_running,
>         .set_watermarks_table = yellow_carp_set_watermarks_table,
> -       .get_power_profile_mode = yellow_carp_get_power_profile_mode,
> -       .set_power_profile_mode = yellow_carp_set_power_profile_mode,
>         .get_gpu_metrics = yellow_carp_get_gpu_metrics,
>         .get_enabled_mask = smu_cmn_get_enabled_32_bits_mask,
>         .get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
> @@ -1261,6 +1175,5 @@ void yellow_carp_set_ppt_funcs(struct smu_context *smu)
>         smu->message_map = yellow_carp_message_map;
>         smu->feature_map = yellow_carp_feature_mask_map;
>         smu->table_map = yellow_carp_table_map;
> -       smu->workload_map = yellow_carp_workload_map;
>         smu->is_apu = true;
>  }
>
> base-commit: b785098f70a5ed2488becbdd5921054053034439
> --
> 2.25.1
>
