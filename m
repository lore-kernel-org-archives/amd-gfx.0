Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931D1C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 04:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3476164F9E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 04:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3476164F9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A86906EA81;
	Thu, 11 Mar 2021 04:43:45 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84BF86EA81
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 04:43:44 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id w195so15176070oif.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 20:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kXiNCtGbnV+6+ofsIvCaf5o7m+ej/QH4Pfz2buFuY4Q=;
 b=nS1HfeTY5pyXbFK7wrxSfbrqu5e1vm0R6YL8R4iHfhl9ixdoBzwqFkFse2649/tCwa
 OrvLH8spLbQK0rDe2zta2FVWXE81jRBZEwzVp6kFFjUb75adwXN5erY+CQuhXlt76ZCW
 L/H0t2N3VutZ+DzVvBYdPspltxuePvxITjA1dS4zwp4NU7wDPKbHfELWjZHa3pm8Z+J9
 yfSiekcNg2/U3P2DyyzbjMpiraJI5mc/2FbpuI6p/SIg/0v4ydqj1qReuJs+m3iqzaCt
 MeGvDJCMa06w07yvpUYDtQIgbx56WxsIJtN0rZUe3gO8kQI1EKo+CKFQ9LF8JpvcHvVJ
 dB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kXiNCtGbnV+6+ofsIvCaf5o7m+ej/QH4Pfz2buFuY4Q=;
 b=k4E3bSWXYFmwAnsuoYdVxms2P7rWAGVKfJbJqZCRSa8ut0WRe6zkCoti7waSVh3Upl
 zouPKNlerEqI7j2cFeWeu3wRmXjXL0T2bVvhtIjeyLaPYWxfcX7958vz6lg4DIJD2qdE
 CKiEgyuGtSmFe/mWXKVyarBv5Xo5JcGfm4ANHOH2TZ5QOZoB7TPTXjPMiBj8OtTKbIBA
 v0+YJT12x5CSO4jfj8UNeRk5l8zKz22lshXmYfG5bWsVvzE1Wrgr63ZC/MTFjvn3/fkx
 XMbbgdkLNMmFdLfJ5+GBfKHh6Dvm8ikyc9s+QnfbqkE9mb1vUbn4Ib/xvPBOctEz0+5n
 jOZg==
X-Gm-Message-State: AOAM530DOTTyejHSFD9TkEvfSTtcnBNoCRk0zx4Z7kU24iMCJrhZjGCC
 KXctpLTaj+xCz75Sj5KuL5a+MLckL/6pv7wYip4=
X-Google-Smtp-Source: ABdhPJwHU0MqEKJiYaPKCG3yxBnbbvJfmGrY3Z6oVw34fnr9TkvEuzxZm/7K8xydXS8EDgnmtE+NYGKxPdI2NX9Epcc=
X-Received: by 2002:aca:fccb:: with SMTP id a194mr4802892oii.5.1615437823732; 
 Wed, 10 Mar 2021 20:43:43 -0800 (PST)
MIME-Version: 1.0
References: <20210311042802.10793-1-kenneth.feng@amd.com>
In-Reply-To: <20210311042802.10793-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 Mar 2021 23:43:32 -0500
Message-ID: <CADnq5_Ma1r8jH6c5NuA9w_71g3_AqF_qjOEjmWuKVBuWtPSC9Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: workaround for audio noise issue
To: Kenneth Feng <kenneth.feng@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 10, 2021 at 11:27 PM Kenneth Feng <kenneth.feng@amd.com> wrote:
>
> On some Intel platforms, audio noise can be detected due to
> high pcie speed switch latency.
> This patch leaverages ppfeaturemask to fix to the highest pcie
> speed then disable pcie switching.

You may want a follow up patch to check the vendor of the pcie root
port in amdgpu_device_get_pcie_info() and change the ppfeaturemask in
that case.

Alex

>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 54 ++++++++++++++
>  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 74 ++++++++++++++++---
>  .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 25 +++++++
>  .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 26 +++++++
>  4 files changed, 168 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index a58f92249c53..54bbee310e57 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -587,6 +587,48 @@ static int smu7_force_switch_to_arbf0(struct pp_hwmgr *hwmgr)
>                         tmp, MC_CG_ARB_FREQ_F0);
>  }
>
> +static uint16_t smu7_override_pcie_speed(struct pp_hwmgr *hwmgr)
> +{
> +       struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
> +       uint16_t pcie_gen = 0;
> +
> +       if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4 &&
> +           adev->pm.pcie_gen_mask & CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN4)
> +               pcie_gen = 3;
> +       else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3 &&
> +               adev->pm.pcie_gen_mask & CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN3)
> +               pcie_gen = 2;
> +       else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2 &&
> +               adev->pm.pcie_gen_mask & CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN2)
> +               pcie_gen = 1;
> +       else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN1 &&
> +               adev->pm.pcie_gen_mask & CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN1)
> +               pcie_gen = 0;
> +
> +       return pcie_gen;
> +}
> +
> +static uint16_t smu7_override_pcie_width(struct pp_hwmgr *hwmgr)
> +{
> +       struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
> +       uint16_t pcie_width = 0;
> +
> +       if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X16)
> +               pcie_width = 16;
> +       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X12)
> +               pcie_width = 12;
> +       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X8)
> +               pcie_width = 8;
> +       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X4)
> +               pcie_width = 4;
> +       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X2)
> +               pcie_width = 2;
> +       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X1)
> +               pcie_width = 1;
> +
> +       return pcie_width;
> +}
> +
>  static int smu7_setup_default_pcie_table(struct pp_hwmgr *hwmgr)
>  {
>         struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
> @@ -683,6 +725,11 @@ static int smu7_setup_default_pcie_table(struct pp_hwmgr *hwmgr)
>                                         PP_Min_PCIEGen),
>                         get_pcie_lane_support(data->pcie_lane_cap,
>                                         PP_Max_PCIELane));
> +
> +               if (data->pcie_dpm_key_disabled)
> +                       phm_setup_pcie_table_entry(&data->dpm_table.pcie_speed_table,
> +                               data->dpm_table.pcie_speed_table.count,
> +                               smu7_override_pcie_speed(hwmgr), smu7_override_pcie_width(hwmgr));
>         }
>         return 0;
>  }
> @@ -1248,6 +1295,13 @@ static int smu7_start_dpm(struct pp_hwmgr *hwmgr)
>                                                 NULL)),
>                                 "Failed to enable pcie DPM during DPM Start Function!",
>                                 return -EINVAL);
> +       } else {
> +               PP_ASSERT_WITH_CODE(
> +                               (0 == smum_send_msg_to_smc(hwmgr,
> +                                               PPSMC_MSG_PCIeDPM_Disable,
> +                                               NULL)),
> +                               "Failed to disble pcie DPM during DPM Start Function!",
> +                               return -EINVAL);
>         }
>
>         if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index 408b35866704..f5a32654cde7 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -54,6 +54,9 @@
>  #include "smuio/smuio_9_0_offset.h"
>  #include "smuio/smuio_9_0_sh_mask.h"
>
> +#define smnPCIE_LC_SPEED_CNTL                  0x11140290
> +#define smnPCIE_LC_LINK_WIDTH_CNTL             0x11140288
> +
>  #define HBM_MEMORY_CHANNEL_WIDTH    128
>
>  static const uint32_t channel_number[] = {1, 2, 0, 4, 0, 8, 0, 16, 2};
> @@ -443,8 +446,7 @@ static void vega10_init_dpm_defaults(struct pp_hwmgr *hwmgr)
>         if (PP_CAP(PHM_PlatformCaps_VCEDPM))
>                 data->smu_features[GNLD_DPM_VCE].supported = true;
>
> -       if (!data->registry_data.pcie_dpm_key_disabled)
> -               data->smu_features[GNLD_DPM_LINK].supported = true;
> +       data->smu_features[GNLD_DPM_LINK].supported = true;
>
>         if (!data->registry_data.dcefclk_dpm_key_disabled)
>                 data->smu_features[GNLD_DPM_DCEFCLK].supported = true;
> @@ -1544,6 +1546,13 @@ static int vega10_override_pcie_parameters(struct pp_hwmgr *hwmgr)
>                         pp_table->PcieLaneCount[i] = pcie_width;
>         }
>
> +       if (data->registry_data.pcie_dpm_key_disabled) {
> +               for (i = 0; i < NUM_LINK_LEVELS; i++) {
> +                       pp_table->PcieGenSpeed[i] = pcie_gen;
> +                       pp_table->PcieLaneCount[i] = pcie_width;
> +               }
> +       }
> +
>         return 0;
>  }
>
> @@ -2966,6 +2975,14 @@ static int vega10_start_dpm(struct pp_hwmgr *hwmgr, uint32_t bitmap)
>                 }
>         }
>
> +       if (data->registry_data.pcie_dpm_key_disabled) {
> +               PP_ASSERT_WITH_CODE(!vega10_enable_smc_features(hwmgr,
> +                               false, data->smu_features[GNLD_DPM_LINK].smu_feature_bitmap),
> +               "Attempt to Disable Link DPM feature Failed!", return -EINVAL);
> +               data->smu_features[GNLD_DPM_LINK].enabled = false;
> +               data->smu_features[GNLD_DPM_LINK].supported = false;
> +       }
> +
>         return 0;
>  }
>
> @@ -4584,6 +4601,24 @@ static int vega10_set_ppfeature_status(struct pp_hwmgr *hwmgr, uint64_t new_ppfe
>         return 0;
>  }
>
> +static int vega10_get_current_pcie_link_width_level(struct pp_hwmgr *hwmgr)
> +{
> +       struct amdgpu_device *adev = hwmgr->adev;
> +
> +       return (RREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL) &
> +               PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK)
> +               >> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
> +}
> +
> +static int vega10_get_current_pcie_link_speed_level(struct pp_hwmgr *hwmgr)
> +{
> +       struct amdgpu_device *adev = hwmgr->adev;
> +
> +       return (RREG32_PCIE(smnPCIE_LC_SPEED_CNTL) &
> +               PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK)
> +               >> PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
> +}
> +
>  static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
>                 enum pp_clock_type type, char *buf)
>  {
> @@ -4592,8 +4627,9 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
>         struct vega10_single_dpm_table *mclk_table = &(data->dpm_table.mem_table);
>         struct vega10_single_dpm_table *soc_table = &(data->dpm_table.soc_table);
>         struct vega10_single_dpm_table *dcef_table = &(data->dpm_table.dcef_table);
> -       struct vega10_pcie_table *pcie_table = &(data->dpm_table.pcie_table);
>         struct vega10_odn_clock_voltage_dependency_table *podn_vdd_dep = NULL;
> +       uint32_t gen_speed, lane_width, current_gen_speed, current_lane_width;
> +       PPTable_t *pptable = &(data->smc_state_table.pp_table);
>
>         int i, now, size = 0, count = 0;
>
> @@ -4650,15 +4686,31 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
>                                         "*" : "");
>                 break;
>         case PP_PCIE:
> -               smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentLinkIndex, &now);
> -
> -               for (i = 0; i < pcie_table->count; i++)
> -                       size += sprintf(buf + size, "%d: %s %s\n", i,
> -                                       (pcie_table->pcie_gen[i] == 0) ? "2.5GT/s, x1" :
> -                                       (pcie_table->pcie_gen[i] == 1) ? "5.0GT/s, x16" :
> -                                       (pcie_table->pcie_gen[i] == 2) ? "8.0GT/s, x16" : "",
> -                                       (i == now) ? "*" : "");
> +               current_gen_speed =
> +                       vega10_get_current_pcie_link_speed_level(hwmgr);
> +               current_lane_width =
> +                       vega10_get_current_pcie_link_width_level(hwmgr);
> +               for (i = 0; i < NUM_LINK_LEVELS; i++) {
> +                       gen_speed = pptable->PcieGenSpeed[i];
> +                       lane_width = pptable->PcieLaneCount[i];
> +
> +                       size += sprintf(buf + size, "%d: %s %s %s\n", i,
> +                                       (gen_speed == 0) ? "2.5GT/s," :
> +                                       (gen_speed == 1) ? "5.0GT/s," :
> +                                       (gen_speed == 2) ? "8.0GT/s," :
> +                                       (gen_speed == 3) ? "16.0GT/s," : "",
> +                                       (lane_width == 1) ? "x1" :
> +                                       (lane_width == 2) ? "x2" :
> +                                       (lane_width == 3) ? "x4" :
> +                                       (lane_width == 4) ? "x8" :
> +                                       (lane_width == 5) ? "x12" :
> +                                       (lane_width == 6) ? "x16" : "",
> +                                       (current_gen_speed == gen_speed) &&
> +                                       (current_lane_width == lane_width) ?
> +                                       "*" : "");
> +               }
>                 break;
> +
>         case OD_SCLK:
>                 if (hwmgr->od_enabled) {
>                         size = sprintf(buf, "%s:\n", "OD_SCLK");
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> index 196ac2a4d145..f3d37acbf663 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> @@ -133,6 +133,8 @@ static void vega12_set_default_registry_data(struct pp_hwmgr *hwmgr)
>         data->registry_data.auto_wattman_debug = 0;
>         data->registry_data.auto_wattman_sample_period = 100;
>         data->registry_data.auto_wattman_threshold = 50;
> +       data->registry_data.pcie_dpm_key_disabled =
> +                       hwmgr->feature_mask & PP_PCIE_DPM_MASK ? false : true;

You don't need the false : true.  You can just do:
data->registry_data.pcie_dpm_key_disabled = !(hwmgr->feature_mask &
PP_PCIE_DPM_MASK);
Same comment on the other cases of this.


>  }
>
>  static int vega12_set_features_platform_caps(struct pp_hwmgr *hwmgr)
> @@ -539,6 +541,29 @@ static int vega12_override_pcie_parameters(struct pp_hwmgr *hwmgr)
>                 pp_table->PcieLaneCount[i] = pcie_width_arg;
>         }
>
> +       /* override to the highest if it's disabled from ppfeaturmask */
> +       if (data->registry_data.pcie_dpm_key_disabled) {
> +               for (i = 0; i < NUM_LINK_LEVELS; i++) {
> +                       smu_pcie_arg = (i << 16) | (pcie_gen << 8) | pcie_width;
> +                       ret = smum_send_msg_to_smc_with_parameter(hwmgr,
> +                               PPSMC_MSG_OverridePcieParameters, smu_pcie_arg,
> +                               NULL);
> +                       PP_ASSERT_WITH_CODE(!ret,
> +                               "[OverridePcieParameters] Attempt to override pcie params failed!",
> +                               return ret);
> +
> +                       pp_table->PcieGenSpeed[i] = pcie_gen;
> +                       pp_table->PcieLaneCount[i] = pcie_width;
> +               }
> +               ret = vega12_enable_smc_features(hwmgr,
> +                               false,
> +                               data->smu_features[GNLD_DPM_LINK].smu_feature_bitmap);
> +               PP_ASSERT_WITH_CODE(!ret,
> +                               "Attempt to Disable DPM LINK Failed!",
> +                               return ret);
> +               data->smu_features[GNLD_DPM_LINK].enabled = false;
> +               data->smu_features[GNLD_DPM_LINK].supported = false;
> +       }
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> index 78bbd4d666f2..2df637727d1b 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> @@ -171,6 +171,8 @@ static void vega20_set_default_registry_data(struct pp_hwmgr *hwmgr)
>         data->registry_data.gfxoff_controlled_by_driver = 1;
>         data->gfxoff_allowed = false;
>         data->counter_gfxoff = 0;
> +       data->registry_data.pcie_dpm_key_disabled =
> +                       hwmgr->feature_mask & PP_PCIE_DPM_MASK ? false : true;
>  }
>
>  static int vega20_set_features_platform_caps(struct pp_hwmgr *hwmgr)
> @@ -884,6 +886,30 @@ static int vega20_override_pcie_parameters(struct pp_hwmgr *hwmgr)
>                 pp_table->PcieLaneCount[i] = pcie_width_arg;
>         }
>
> +       /* override to the highest if it's disabled from ppfeaturmask */
> +       if (data->registry_data.pcie_dpm_key_disabled) {
> +               for (i = 0; i < NUM_LINK_LEVELS; i++) {
> +                       smu_pcie_arg = (i << 16) | (pcie_gen << 8) | pcie_width;
> +                       ret = smum_send_msg_to_smc_with_parameter(hwmgr,
> +                               PPSMC_MSG_OverridePcieParameters, smu_pcie_arg,
> +                               NULL);
> +                       PP_ASSERT_WITH_CODE(!ret,
> +                               "[OverridePcieParameters] Attempt to override pcie params failed!",
> +                               return ret);
> +
> +                       pp_table->PcieGenSpeed[i] = pcie_gen;
> +                       pp_table->PcieLaneCount[i] = pcie_width;
> +               }
> +               ret = vega20_enable_smc_features(hwmgr,
> +                               false,
> +                               data->smu_features[GNLD_DPM_LINK].smu_feature_bitmap);
> +               PP_ASSERT_WITH_CODE(!ret,
> +                               "Attempt to Disable DPM LINK Failed!",
> +                               return ret);
> +               data->smu_features[GNLD_DPM_LINK].enabled = false;
> +               data->smu_features[GNLD_DPM_LINK].supported = false;
> +       }
> +
>         return 0;
>  }
>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
