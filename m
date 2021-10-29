Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354ABC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 03:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE3461056
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 03:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EDE3461056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 979006E9B5;
	Fri, 29 Oct 2021 03:08:37 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98F166E9B5
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 03:08:36 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 l24-20020a9d1c98000000b00552a5c6b23cso11620943ota.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Oct 2021 20:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QTAyFCBpU4W0neuuyfBOJ5cm1UOQJ7OCDqlqRkfhgLg=;
 b=Uqu+k0E1ZdUAnfaf8Sjdgaqtv3ILy3w5iZcLNXoPrJOz5uQE2qpBdWh+jMktnouA9f
 FDxP0qoonN9lE4PplDbh5PfReW4lyUh/FuMAJlqOpC//M/GFmK9ziX4aSEMB7wJ02Kv7
 ESdh4/9b7CFNT+ZaJFR9D0wavzfk4UqYXY6/jBv+Vg9CUanrFKojp2UVhHkSt2+Ndb5m
 o6XTH0M1EB5ychKPNhrU1A4dfQqikX9UhUaHccZH/Wyyqu3b3D+i+/Fy1hiUsnx5ZMmV
 Tixz76PbL5tPwIGhUqZhrz35kfka3HgXi9pSRqkl3TfAQc2Um/B6QqYkBsNOCu8eq+jc
 skag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QTAyFCBpU4W0neuuyfBOJ5cm1UOQJ7OCDqlqRkfhgLg=;
 b=s7isIEiEdGq1STDAc/R2iI6ZzG93njr7iqmq/jiBGikuabcTn31SYwY0TWMIjVD+qn
 DMy9/mjRUAzijTSvWb2ZRw/0xyGQ4IsL/BTXoW0S/iqvigqimq9EcaG8IXne90/F3gfz
 FRdf569UDk4dxSzM/0gizmwgjag2JXAZbT0N9u1TX0vRxDNHmNfj4TIttQ8NkIhclTTs
 4I9g8z1SjUkFwtgRTlbHPGrKsgHg3SbDEINxt+Cr/u5s/g1rAhZ273kqSorbeFdU/1OM
 CGurQ2LVjV8extDGGQ70JPz8lAOMTsaRPhP1ZwCwiPGM0OiLTTIN+lR4jHNbnpxKB0Kf
 2/ew==
X-Gm-Message-State: AOAM5318ibOGLvcoXPXiFOf4jW3rBuq4bFod3M4fyvqMAjHDA7tt2JdZ
 bEzLlLzY/51YfBPoj7ZUF+7U+LAXql0CQfO4gJ0=
X-Google-Smtp-Source: ABdhPJz76iiF2xkZGDyxKM0aivVV/+eUQ8xeW/DL4vDvm/FlJUSlu9OAd8pAeiRnMOVZuWlltGo6X9k1qJEFN6wPZos=
X-Received: by 2002:a9d:61d9:: with SMTP id h25mr6792534otk.357.1635476915470; 
 Thu, 28 Oct 2021 20:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211028155336.2990-1-mario.limonciello@amd.com>
 <YXtd7LmF7Brsjrpk@hr-amd>
In-Reply-To: <YXtd7LmF7Brsjrpk@hr-amd>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Oct 2021 23:08:24 -0400
Message-ID: <CADnq5_Oq_foFBO3fDCa=Zij53J_ULp=brHkMOm6h_9j0ow1J8w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/pm: drop pp_power_profile_mode support for APUs
To: Huang Rui <ray.huang@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Thu, Oct 28, 2021 at 10:35 PM Huang Rui <ray.huang@amd.com> wrote:
>
> On Thu, Oct 28, 2021 at 10:53:36AM -0500, Mario Limonciello wrote:
> > Although this has been plumbed for Renoir, Green Sardine, Van Gogh,
> > and Yellow Carp the functionality in the SMU doesn't do anything for
>
> I double confirmed them in the firmware. These messages are actually
> existed in SMU firmware of Renoir, Van Gogh, and Green Sardine, we should
> not remove them in these platforms.

I heard that at least on renoir variants, the messages still exist,
but they no longer do anything.

Alex


>
> And for Yellow Carp, it is better to use a firmware check to skip the
> function than remove them entirely in case somebody doesn't upgrade his/her
> SBIOS.
>
> Thanks,
> Ray
>
> > these APUs.  Drop the associated code with them.
> >
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  .../gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h    |  4 +-
> >  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 86 ------------------
> >  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 87 -------------------
> >  .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 87 -------------------
> >  4 files changed, 2 insertions(+), 262 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
> > index 1d3447991d0c..23d24173bc5d 100644
> > --- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
> > +++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
> > @@ -51,7 +51,7 @@
> >  #define PPSMC_MSG_PowerUpVcn                    0x07 ///< Power up VCN; VCN is power gated by default
> >  #define PPSMC_MSG_SetHardMinVcn                 0x08 ///< For wireless display
> >  #define PPSMC_MSG_SetSoftMinGfxclk              0x09 ///< Set SoftMin for GFXCLK, argument is frequency in MHz
> > -#define PPSMC_MSG_ActiveProcessNotify           0x0A ///< Set active work load type
> > +#define PPSMC_MSG_SPARE0                        0x0A ///< Spare
> >  #define PPSMC_MSG_ForcePowerDownGfx             0x0B ///< Force power down GFX, i.e. enter GFXOFF
> >  #define PPSMC_MSG_PrepareMp1ForUnload           0x0C ///< Prepare PMFW for GFX driver unload
> >  #define PPSMC_MSG_SetDriverDramAddrHigh         0x0D ///< Set high 32 bits of DRAM address for Driver table transfer
> > @@ -63,7 +63,7 @@
> >  #define PPSMC_MSG_SetHardMinSocclkByFreq        0x13 ///< Set hard min for SOC CLK
> >  #define PPSMC_MSG_SetSoftMinFclk                0x14 ///< Set hard min for FCLK
> >  #define PPSMC_MSG_SetSoftMinVcn                 0x15 ///< Set soft min for VCN clocks (VCLK and DCLK)
> > -#define PPSMC_MSG_SPARE0                        0x16 ///< Spared
> > +#define PPSMC_MSG_SPARE1                        0x16 ///< Spare
> >  #define PPSMC_MSG_GetGfxclkFrequency            0x17 ///< Get GFX clock frequency
> >  #define PPSMC_MSG_GetFclkFrequency              0x18 ///< Get FCLK frequency
> >  #define PPSMC_MSG_AllowGfxOff                   0x19 ///< Inform PMFW of allowing GFXOFF entry
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > index 421f38e8dada..2451d990d577 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > @@ -72,7 +72,6 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
> >       MSG_MAP(RlcPowerNotify,                 PPSMC_MSG_RlcPowerNotify,               0),
> >       MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,                0),
> >       MSG_MAP(SetSoftMinGfxclk,               PPSMC_MSG_SetSoftMinGfxclk,             0),
> > -     MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,          0),
> >       MSG_MAP(SetHardMinIspiclkByFreq,        PPSMC_MSG_SetHardMinIspiclkByFreq,      0),
> >       MSG_MAP(SetHardMinIspxclkByFreq,        PPSMC_MSG_SetHardMinIspxclkByFreq,      0),
> >       MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh,        0),
> > @@ -182,14 +181,6 @@ static struct cmn2asic_mapping vangogh_table_map[SMU_TABLE_COUNT] = {
> >       TAB_MAP_VALID(DPMCLOCKS),
> >  };
> >
> > -static struct cmn2asic_mapping vangogh_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
> > -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,         WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
> > -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,                WORKLOAD_PPLIB_VIDEO_BIT),
> > -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,                   WORKLOAD_PPLIB_VR_BIT),
> > -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,              WORKLOAD_PPLIB_COMPUTE_BIT),
> > -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,               WORKLOAD_PPLIB_CUSTOM_BIT),
> > -};
> > -
> >  static const uint8_t vangogh_throttler_map[] = {
> >       [THROTTLER_STATUS_BIT_SPL]      = (SMU_THROTTLER_SPL_BIT),
> >       [THROTTLER_STATUS_BIT_FPPT]     = (SMU_THROTTLER_FPPT_BIT),
> > @@ -1010,80 +1001,6 @@ static int vangogh_get_dpm_ultimate_freq(struct smu_context *smu,
> >       return ret;
> >  }
> >
> > -static int vangogh_get_power_profile_mode(struct smu_context *smu,
> > -                                        char *buf)
> > -{
> > -     static const char *profile_name[] = {
> > -                                     "BOOTUP_DEFAULT",
> > -                                     "3D_FULL_SCREEN",
> > -                                     "POWER_SAVING",
> > -                                     "VIDEO",
> > -                                     "VR",
> > -                                     "COMPUTE",
> > -                                     "CUSTOM"};
> > -     uint32_t i, size = 0;
> > -     int16_t workload_type = 0;
> > -
> > -     if (!buf)
> > -             return -EINVAL;
> > -
> > -     for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
> > -             /*
> > -              * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
> > -              * Not all profile modes are supported on vangogh.
> > -              */
> > -             workload_type = smu_cmn_to_asic_specific_index(smu,
> > -                                                            CMN2ASIC_MAPPING_WORKLOAD,
> > -                                                            i);
> > -
> > -             if (workload_type < 0)
> > -                     continue;
> > -
> > -             size += sysfs_emit_at(buf, size, "%2d %14s%s\n",
> > -                     i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
> > -     }
> > -
> > -     return size;
> > -}
> > -
> > -static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
> > -{
> > -     int workload_type, ret;
> > -     uint32_t profile_mode = input[size];
> > -
> > -     if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
> > -             return -EINVAL;
> > -     }
> > -
> > -     if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> > -                     profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
> > -             return 0;
> > -
> > -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> > -     workload_type = smu_cmn_to_asic_specific_index(smu,
> > -                                                    CMN2ASIC_MAPPING_WORKLOAD,
> > -                                                    profile_mode);
> > -     if (workload_type < 0) {
> > -             dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on VANGOGH\n",
> > -                                     profile_mode);
> > -             return -EINVAL;
> > -     }
> > -
> > -     ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
> > -                                 1 << workload_type,
> > -                                 NULL);
> > -     if (ret) {
> > -             dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
> > -                                     workload_type);
> > -             return ret;
> > -     }
> > -
> > -     smu->power_profile_mode = profile_mode;
> > -
> > -     return 0;
> > -}
> > -
> >  static int vangogh_set_soft_freq_limited_range(struct smu_context *smu,
> >                                         enum smu_clk_type clk_type,
> >                                         uint32_t min,
> > @@ -2190,8 +2107,6 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
> >       .set_fine_grain_gfx_freq_parameters = vangogh_set_fine_grain_gfx_freq_parameters,
> >       .system_features_control = vangogh_system_features_control,
> >       .feature_is_enabled = smu_cmn_feature_is_enabled,
> > -     .set_power_profile_mode = vangogh_set_power_profile_mode,
> > -     .get_power_profile_mode = vangogh_get_power_profile_mode,
> >       .get_dpm_clock_table = vangogh_get_dpm_clock_table,
> >       .force_clk_levels = vangogh_force_clk_levels,
> >       .set_performance_level = vangogh_set_performance_level,
> > @@ -2210,6 +2125,5 @@ void vangogh_set_ppt_funcs(struct smu_context *smu)
> >       smu->message_map = vangogh_message_map;
> >       smu->feature_map = vangogh_feature_mask_map;
> >       smu->table_map = vangogh_table_map;
> > -     smu->workload_map = vangogh_workload_map;
> >       smu->is_apu = true;
> >  }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> > index 145f13b8c977..21da7989f1ba 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> > @@ -58,7 +58,6 @@ static struct cmn2asic_msg_mapping renoir_message_map[SMU_MSG_MAX_COUNT] = {
> >       MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,                1),
> >       MSG_MAP(SetAllowFclkSwitch,             PPSMC_MSG_SetAllowFclkSwitch,           1),
> >       MSG_MAP(SetMinVideoGfxclkFreq,          PPSMC_MSG_SetMinVideoGfxclkFreq,        1),
> > -     MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,          1),
> >       MSG_MAP(SetCustomPolicy,                PPSMC_MSG_SetCustomPolicy,              1),
> >       MSG_MAP(SetVideoFps,                    PPSMC_MSG_SetVideoFps,                  1),
> >       MSG_MAP(NumOfDisplays,                  PPSMC_MSG_SetDisplayCount,              1),
> > @@ -120,14 +119,6 @@ static struct cmn2asic_mapping renoir_table_map[SMU_TABLE_COUNT] = {
> >       TAB_MAP_VALID(SMU_METRICS),
> >  };
> >
> > -static struct cmn2asic_mapping renoir_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
> > -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,         WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
> > -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,                WORKLOAD_PPLIB_VIDEO_BIT),
> > -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,                   WORKLOAD_PPLIB_VR_BIT),
> > -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,              WORKLOAD_PPLIB_COMPUTE_BIT),
> > -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,               WORKLOAD_PPLIB_CUSTOM_BIT),
> > -};
> > -
> >  static const uint8_t renoir_throttler_map[] = {
> >       [THROTTLER_STATUS_BIT_SPL]              = (SMU_THROTTLER_SPL_BIT),
> >       [THROTTLER_STATUS_BIT_FPPT]             = (SMU_THROTTLER_FPPT_BIT),
> > @@ -854,46 +845,6 @@ static int renoir_force_clk_levels(struct smu_context *smu,
> >       return ret;
> >  }
> >
> > -static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
> > -{
> > -     int workload_type, ret;
> > -     uint32_t profile_mode = input[size];
> > -
> > -     if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
> > -             return -EINVAL;
> > -     }
> > -
> > -     if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> > -                     profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
> > -             return 0;
> > -
> > -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> > -     workload_type = smu_cmn_to_asic_specific_index(smu,
> > -                                                    CMN2ASIC_MAPPING_WORKLOAD,
> > -                                                    profile_mode);
> > -     if (workload_type < 0) {
> > -             /*
> > -              * TODO: If some case need switch to powersave/default power mode
> > -              * then can consider enter WORKLOAD_COMPUTE/WORKLOAD_CUSTOM for power saving.
> > -              */
> > -             dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on RENOIR\n", profile_mode);
> > -             return -EINVAL;
> > -     }
> > -
> > -     ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
> > -                                 1 << workload_type,
> > -                                 NULL);
> > -     if (ret) {
> > -             dev_err_once(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
> > -             return ret;
> > -     }
> > -
> > -     smu->power_profile_mode = profile_mode;
> > -
> > -     return 0;
> > -}
> > -
> >  static int renoir_set_peak_clock_by_device(struct smu_context *smu)
> >  {
> >       int ret = 0;
> > @@ -1092,41 +1043,6 @@ static int renoir_set_watermarks_table(
> >       return 0;
> >  }
> >
> > -static int renoir_get_power_profile_mode(struct smu_context *smu,
> > -                                        char *buf)
> > -{
> > -     static const char *profile_name[] = {
> > -                                     "BOOTUP_DEFAULT",
> > -                                     "3D_FULL_SCREEN",
> > -                                     "POWER_SAVING",
> > -                                     "VIDEO",
> > -                                     "VR",
> > -                                     "COMPUTE",
> > -                                     "CUSTOM"};
> > -     uint32_t i, size = 0;
> > -     int16_t workload_type = 0;
> > -
> > -     if (!buf)
> > -             return -EINVAL;
> > -
> > -     for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
> > -             /*
> > -              * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
> > -              * Not all profile modes are supported on arcturus.
> > -              */
> > -             workload_type = smu_cmn_to_asic_specific_index(smu,
> > -                                                            CMN2ASIC_MAPPING_WORKLOAD,
> > -                                                            i);
> > -             if (workload_type < 0)
> > -                     continue;
> > -
> > -             size += sysfs_emit_at(buf, size, "%2d %14s%s\n",
> > -                     i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
> > -     }
> > -
> > -     return size;
> > -}
> > -
> >  static int renoir_get_smu_metrics_data(struct smu_context *smu,
> >                                      MetricsMember_t member,
> >                                      uint32_t *value)
> > @@ -1389,11 +1305,9 @@ static const struct pptable_funcs renoir_ppt_funcs = {
> >       .dpm_set_vcn_enable = renoir_dpm_set_vcn_enable,
> >       .dpm_set_jpeg_enable = renoir_dpm_set_jpeg_enable,
> >       .force_clk_levels = renoir_force_clk_levels,
> > -     .set_power_profile_mode = renoir_set_power_profile_mode,
> >       .set_performance_level = renoir_set_performance_level,
> >       .get_dpm_clock_table = renoir_get_dpm_clock_table,
> >       .set_watermarks_table = renoir_set_watermarks_table,
> > -     .get_power_profile_mode = renoir_get_power_profile_mode,
> >       .read_sensor = renoir_read_sensor,
> >       .check_fw_status = smu_v12_0_check_fw_status,
> >       .check_fw_version = smu_v12_0_check_fw_version,
> > @@ -1429,7 +1343,6 @@ void renoir_set_ppt_funcs(struct smu_context *smu)
> >       smu->message_map = renoir_message_map;
> >       smu->clock_map = renoir_clk_map;
> >       smu->table_map = renoir_table_map;
> > -     smu->workload_map = renoir_workload_map;
> >       smu->smc_driver_if_version = SMU12_DRIVER_IF_VERSION;
> >       smu->is_apu = true;
> >  }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> > index a403657151ba..8215bbf5ed7c 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> > @@ -64,7 +64,6 @@ static struct cmn2asic_msg_mapping yellow_carp_message_map[SMU_MSG_MAX_COUNT] =
> >       MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,                 1),
> >       MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,                   1),
> >       MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,                1),
> > -     MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,          1),
> >       MSG_MAP(PrepareMp1ForUnload,            PPSMC_MSG_PrepareMp1ForUnload,      1),
> >       MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh,        1),
> >       MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAddrLow,         1),
> > @@ -135,14 +134,6 @@ static struct cmn2asic_mapping yellow_carp_table_map[SMU_TABLE_COUNT] = {
> >       TAB_MAP_VALID(CUSTOM_DPM),
> >       TAB_MAP_VALID(DPMCLOCKS),
> >  };
> > -
> > -static struct cmn2asic_mapping yellow_carp_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
> > -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,         WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
> > -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,                WORKLOAD_PPLIB_VIDEO_BIT),
> > -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,                   WORKLOAD_PPLIB_VR_BIT),
> > -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,              WORKLOAD_PPLIB_COMPUTE_BIT),
> > -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,               WORKLOAD_PPLIB_CUSTOM_BIT),
> > -};
> >
> >  static int yellow_carp_init_smc_tables(struct smu_context *smu)
> >  {
> > @@ -543,81 +534,6 @@ static int yellow_carp_set_watermarks_table(struct smu_context *smu,
> >       return 0;
> >  }
> >
> > -static int yellow_carp_get_power_profile_mode(struct smu_context *smu,
> > -                                             char *buf)
> > -{
> > -     static const char *profile_name[] = {
> > -                                     "BOOTUP_DEFAULT",
> > -                                     "3D_FULL_SCREEN",
> > -                                     "POWER_SAVING",
> > -                                     "VIDEO",
> > -                                     "VR",
> > -                                     "COMPUTE",
> > -                                     "CUSTOM"};
> > -     uint32_t i, size = 0;
> > -     int16_t workload_type = 0;
> > -
> > -     if (!buf)
> > -             return -EINVAL;
> > -
> > -     for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
> > -             /*
> > -              * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT.
> > -              * Not all profile modes are supported on yellow carp.
> > -              */
> > -             workload_type = smu_cmn_to_asic_specific_index(smu,
> > -                                                            CMN2ASIC_MAPPING_WORKLOAD,
> > -                                                            i);
> > -
> > -             if (workload_type < 0)
> > -                     continue;
> > -
> > -             size += sysfs_emit_at(buf, size, "%2d %14s%s\n",
> > -                     i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
> > -     }
> > -
> > -     return size;
> > -}
> > -
> > -static int yellow_carp_set_power_profile_mode(struct smu_context *smu,
> > -                                             long *input, uint32_t size)
> > -{
> > -     int workload_type, ret;
> > -     uint32_t profile_mode = input[size];
> > -
> > -     if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
> > -             return -EINVAL;
> > -     }
> > -
> > -     if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> > -                     profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
> > -             return 0;
> > -
> > -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> > -     workload_type = smu_cmn_to_asic_specific_index(smu,
> > -                                                    CMN2ASIC_MAPPING_WORKLOAD,
> > -                                                    profile_mode);
> > -     if (workload_type < 0) {
> > -             dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on YELLOWCARP\n",
> > -                                     profile_mode);
> > -             return -EINVAL;
> > -     }
> > -
> > -     ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
> > -                                 1 << workload_type,
> > -                                 NULL);
> > -     if (ret) {
> > -             dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
> > -                                     workload_type);
> > -             return ret;
> > -     }
> > -
> > -     smu->power_profile_mode = profile_mode;
> > -
> > -     return 0;
> > -}
> > -
> >  static ssize_t yellow_carp_get_gpu_metrics(struct smu_context *smu,
> >                                               void **table)
> >  {
> > @@ -1238,8 +1154,6 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
> >       .read_sensor = yellow_carp_read_sensor,
> >       .is_dpm_running = yellow_carp_is_dpm_running,
> >       .set_watermarks_table = yellow_carp_set_watermarks_table,
> > -     .get_power_profile_mode = yellow_carp_get_power_profile_mode,
> > -     .set_power_profile_mode = yellow_carp_set_power_profile_mode,
> >       .get_gpu_metrics = yellow_carp_get_gpu_metrics,
> >       .get_enabled_mask = smu_cmn_get_enabled_32_bits_mask,
> >       .get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
> > @@ -1261,6 +1175,5 @@ void yellow_carp_set_ppt_funcs(struct smu_context *smu)
> >       smu->message_map = yellow_carp_message_map;
> >       smu->feature_map = yellow_carp_feature_mask_map;
> >       smu->table_map = yellow_carp_table_map;
> > -     smu->workload_map = yellow_carp_workload_map;
> >       smu->is_apu = true;
> >  }
> > --
> > 2.25.1
> >
