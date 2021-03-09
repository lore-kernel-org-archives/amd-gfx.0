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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2688BC432C3
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 15:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E1F652B7
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 15:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E1F652B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5321A6E907;
	Tue,  9 Mar 2021 15:19:28 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0BC46E0CF
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 15:19:26 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id n23so7515349otq.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Mar 2021 07:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I28s0ILr6N+iOsrHWWL1o89r47JqRWI3X+Y/3A4oiWM=;
 b=AiEBHGbTkhxdftiBmyXq9tj7mMSiWnREZ4TbzXinmpQt8+cftQsJG0KSLINmgQplGt
 2pXR9waDCSfcoNLSVi9iGDj//JdLlKOVapMjX/C44rfSDZ6W1LiuQd6oit7SA1SJredp
 4SNHJ1yf6BhF7GXyHPbFK3NzcQXptuoHp2wOG2G3XL48LhkrK9NUnNIiZKLaEiPaaDcx
 w37D7+31k7v+2tXw6xKXOOHbQMR62bPFvgWro2u5xvYR/yJ47ysiV1CMEjo4md+xd4Jm
 M220jqazul1YTWQBXDQ46f0xhYPrWxgcD1ePHj/zZhNV2uvas7ZOY02StdmkIIN0rqdn
 EdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I28s0ILr6N+iOsrHWWL1o89r47JqRWI3X+Y/3A4oiWM=;
 b=DMiJvEXlg31jIDcyDROyo3ZIYKCY+6HMMhizIEgCNb6IIPiyZOcxx3CMF1OHicEAYx
 tRvHcypdB2IcZyjXS1jnIfZQ7xLi4nOIy9Ci8qRFYSatT424ZqVERhrJch0rqdaase72
 zV3RVhr6ZkpYkz+YI4m02fa2FSkEva59w8LAXedq9JXzceK5rXhJ0pu//zKegq83BRkf
 DIO3wTyCWxKpSTIsabCukz80ukSxRU/Zsfk6eDniyl83q1lJuZCPvZ0ygbvY2Ea510rz
 8oK8BgCWp/XMDHybgR8sUpBPzo4tzgI10WKmOpE9v4LMG09NHgrVR8TZrSi4cs8OVBta
 C5mQ==
X-Gm-Message-State: AOAM530XwJRMChcWfKC53GMywHds+84p2oQ38Y8CJyY20+iW78t+XK7c
 VLxGNct+JqSnMyYw3X1rk3g0+59Ccdwpm5Aw32E=
X-Google-Smtp-Source: ABdhPJwsDq51NAGF/xMugui2lhY2HoKB4RBT+j3RXd56bACgJGeibFkHjTu/T+0DAckMiscEHXlNK0WGFH8akxZ+g5A=
X-Received: by 2002:a05:6830:408f:: with SMTP id
 x15mr25361208ott.132.1615303166013; 
 Tue, 09 Mar 2021 07:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20210309131745.3866-1-kenneth.feng@amd.com>
In-Reply-To: <20210309131745.3866-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Mar 2021 10:19:15 -0500
Message-ID: <CADnq5_PJ=Ot9-M3EBv7KewHobHTS6GTBiB+rqcAB1X95y4X8jQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: bug fix for pcie dpm
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

On Tue, Mar 9, 2021 at 8:17 AM Kenneth Feng <kenneth.feng@amd.com> wrote:
>
> Currently the pcie dpm has two problems.
> 1. Only the high dpm level speed/width can be overrided
> if the requested values are out of the pcie capability.
> 2. The high dpm level is always overrided though sometimes
> it's not necesarry.
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 48 ++++++++++++++
>  .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 66 +++++++++++++++++++
>  .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 48 ++++++++------
>  3 files changed, 141 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index 5e875ad8d633..408b35866704 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -1505,6 +1505,48 @@ static int vega10_populate_single_lclk_level(struct pp_hwmgr *hwmgr,
>         return 0;
>  }
>
> +static int vega10_override_pcie_parameters(struct pp_hwmgr *hwmgr)
> +{
> +       struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
> +       struct vega10_hwmgr *data =
> +                       (struct vega10_hwmgr *)(hwmgr->backend);
> +       uint32_t pcie_gen = 0, pcie_width = 0;
> +       PPTable_t *pp_table = &(data->smc_state_table.pp_table);
> +       int i;
> +
> +       if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
> +               pcie_gen = 3;
> +       else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
> +               pcie_gen = 2;
> +       else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2)
> +               pcie_gen = 1;
> +       else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN1)
> +               pcie_gen = 0;
> +
> +       if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X16)
> +               pcie_width = 6;
> +       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X12)
> +               pcie_width = 5;
> +       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X8)
> +               pcie_width = 4;
> +       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X4)
> +               pcie_width = 3;
> +       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X2)
> +               pcie_width = 2;
> +       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X1)
> +               pcie_width = 1;
> +
> +       for (i = 0; i < NUM_LINK_LEVELS; i++) {
> +               if (pp_table->PcieGenSpeed[i] > pcie_gen)
> +                       pp_table->PcieGenSpeed[i] = pcie_gen;
> +
> +               if (pp_table->PcieLaneCount[i] > pcie_width)
> +                       pp_table->PcieLaneCount[i] = pcie_width;
> +       }
> +
> +       return 0;
> +}
> +
>  static int vega10_populate_smc_link_levels(struct pp_hwmgr *hwmgr)
>  {
>         int result = -1;
> @@ -2556,6 +2598,11 @@ static int vega10_init_smc_table(struct pp_hwmgr *hwmgr)
>                         "Failed to initialize Link Level!",
>                         return result);
>
> +       result = vega10_override_pcie_parameters(hwmgr);
> +       PP_ASSERT_WITH_CODE(!result,
> +                       "Failed to override pcie parameters!",
> +                       return result);
> +
>         result = vega10_populate_all_graphic_levels(hwmgr);
>         PP_ASSERT_WITH_CODE(!result,
>                         "Failed to initialize Graphics Level!",
> @@ -2922,6 +2969,7 @@ static int vega10_start_dpm(struct pp_hwmgr *hwmgr, uint32_t bitmap)
>         return 0;
>  }
>
> +
>  static int vega10_enable_disable_PCC_limit_feature(struct pp_hwmgr *hwmgr, bool enable)
>  {
>         struct vega10_hwmgr *data = hwmgr->backend;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> index a827f2bc7904..196ac2a4d145 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> @@ -481,6 +481,67 @@ static void vega12_init_dpm_state(struct vega12_dpm_state *dpm_state)
>         dpm_state->hard_max_level = 0xffff;
>  }
>
> +static int vega12_override_pcie_parameters(struct pp_hwmgr *hwmgr)
> +{
> +       struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
> +       struct vega12_hwmgr *data =
> +                       (struct vega12_hwmgr *)(hwmgr->backend);
> +       uint32_t pcie_gen = 0, pcie_width = 0, smu_pcie_arg, pcie_gen_arg, pcie_width_arg;
> +       PPTable_t *pp_table = &(data->smc_state_table.pp_table);
> +       int i;
> +       int ret;
> +
> +       if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
> +               pcie_gen = 3;
> +       else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
> +               pcie_gen = 2;
> +       else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2)
> +               pcie_gen = 1;
> +       else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN1)
> +               pcie_gen = 0;
> +
> +       if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X16)
> +               pcie_width = 6;
> +       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X12)
> +               pcie_width = 5;
> +       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X8)
> +               pcie_width = 4;
> +       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X4)
> +               pcie_width = 3;
> +       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X2)
> +               pcie_width = 2;
> +       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X1)
> +               pcie_width = 1;
> +
> +       /* Bit 31:16: LCLK DPM level. 0 is DPM0, and 1 is DPM1
> +        * Bit 15:8:  PCIE GEN, 0 to 3 corresponds to GEN1 to GEN4
> +        * Bit 7:0:   PCIE lane width, 1 to 7 corresponds is x1 to x32
> +        */
> +       for (i = 0; i < NUM_LINK_LEVELS; i++) {
> +               pcie_gen_arg = (pp_table->PcieGenSpeed[i] > pcie_gen) ? pcie_gen :
> +                       pp_table->PcieGenSpeed[i];
> +               pcie_width_arg = (pp_table->PcieLaneCount[i] > pcie_width) ? pcie_width :
> +                       pp_table->PcieLaneCount[i];
> +
> +               if (pcie_gen_arg != pp_table->PcieGenSpeed[i] || pcie_width_arg !=
> +                   pp_table->PcieLaneCount[i]) {
> +                       smu_pcie_arg = (i << 16) | (pcie_gen_arg << 8) | pcie_width_arg;
> +                       ret = smum_send_msg_to_smc_with_parameter(hwmgr,
> +                               PPSMC_MSG_OverridePcieParameters, smu_pcie_arg,
> +                               NULL);
> +                       PP_ASSERT_WITH_CODE(!ret,
> +                               "[OverridePcieParameters] Attempt to override pcie params failed!",
> +                               return ret);
> +               }
> +
> +               /* update the pptable */
> +               pp_table->PcieGenSpeed[i] = pcie_gen_arg;
> +               pp_table->PcieLaneCount[i] = pcie_width_arg;
> +       }
> +
> +       return 0;
> +}
> +
>  static int vega12_get_number_of_dpm_level(struct pp_hwmgr *hwmgr,
>                 PPCLK_e clk_id, uint32_t *num_of_levels)
>  {
> @@ -968,6 +1029,11 @@ static int vega12_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
>                         "Failed to enable all smu features!",
>                         return result);
>
> +       result = vega12_override_pcie_parameters(hwmgr);
> +       PP_ASSERT_WITH_CODE(!result,
> +                       "[EnableDPMTasks] Failed to override pcie parameters!",
> +                       return result);
> +
>         tmp_result = vega12_power_control_set_level(hwmgr);
>         PP_ASSERT_WITH_CODE(!tmp_result,
>                         "Failed to power control set level!",
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> index e8eec2539c17..78bbd4d666f2 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> @@ -831,7 +831,9 @@ static int vega20_override_pcie_parameters(struct pp_hwmgr *hwmgr)
>         struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
>         struct vega20_hwmgr *data =
>                         (struct vega20_hwmgr *)(hwmgr->backend);
> -       uint32_t pcie_gen = 0, pcie_width = 0, smu_pcie_arg;
> +       uint32_t pcie_gen = 0, pcie_width = 0, smu_pcie_arg, pcie_gen_arg, pcie_width_arg;
> +       PPTable_t *pp_table = &(data->smc_state_table.pp_table);
> +       int i;
>         int ret;
>
>         if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
> @@ -860,17 +862,27 @@ static int vega20_override_pcie_parameters(struct pp_hwmgr *hwmgr)
>          * Bit 15:8:  PCIE GEN, 0 to 3 corresponds to GEN1 to GEN4
>          * Bit 7:0:   PCIE lane width, 1 to 7 corresponds is x1 to x32
>          */
> -       smu_pcie_arg = (1 << 16) | (pcie_gen << 8) | pcie_width;
> -       ret = smum_send_msg_to_smc_with_parameter(hwmgr,
> -                       PPSMC_MSG_OverridePcieParameters, smu_pcie_arg,
> -                       NULL);
> -       PP_ASSERT_WITH_CODE(!ret,
> -               "[OverridePcieParameters] Attempt to override pcie params failed!",
> -               return ret);
> +       for (i = 0; i < NUM_LINK_LEVELS; i++) {
> +               pcie_gen_arg = (pp_table->PcieGenSpeed[i] > pcie_gen) ? pcie_gen :
> +                       pp_table->PcieGenSpeed[i];
> +               pcie_width_arg = (pp_table->PcieLaneCount[i] > pcie_width) ? pcie_width :
> +                       pp_table->PcieLaneCount[i];
> +
> +               if (pcie_gen_arg != pp_table->PcieGenSpeed[i] || pcie_width_arg !=
> +                   pp_table->PcieLaneCount[i]) {
> +                       smu_pcie_arg = (i << 16) | (pcie_gen_arg << 8) | pcie_width_arg;
> +                       ret = smum_send_msg_to_smc_with_parameter(hwmgr,
> +                               PPSMC_MSG_OverridePcieParameters, smu_pcie_arg,
> +                               NULL);
> +                       PP_ASSERT_WITH_CODE(!ret,
> +                               "[OverridePcieParameters] Attempt to override pcie params failed!",
> +                               return ret);
> +               }
>
> -       data->pcie_parameters_override = true;
> -       data->pcie_gen_level1 = pcie_gen;
> -       data->pcie_width_level1 = pcie_width;
> +               /* update the pptable */
> +               pp_table->PcieGenSpeed[i] = pcie_gen_arg;
> +               pp_table->PcieLaneCount[i] = pcie_width_arg;
> +       }
>
>         return 0;
>  }
> @@ -3319,9 +3331,7 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
>                         data->od8_settings.od8_settings_array;
>         OverDriveTable_t *od_table =
>                         &(data->smc_state_table.overdrive_table);
> -       struct phm_ppt_v3_information *pptable_information =
> -               (struct phm_ppt_v3_information *)hwmgr->pptable;
> -       PPTable_t *pptable = (PPTable_t *)pptable_information->smc_pptable;
> +       PPTable_t *pptable = &(data->smc_state_table.pp_table);
>         struct pp_clock_levels_with_latency clocks;
>         struct vega20_single_dpm_table *fclk_dpm_table =
>                         &(data->dpm_table.fclk_table);
> @@ -3420,13 +3430,9 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
>                 current_lane_width =
>                         vega20_get_current_pcie_link_width_level(hwmgr);
>                 for (i = 0; i < NUM_LINK_LEVELS; i++) {
> -                       if (i == 1 && data->pcie_parameters_override) {
> -                               gen_speed = data->pcie_gen_level1;
> -                               lane_width = data->pcie_width_level1;
> -                       } else {
> -                               gen_speed = pptable->PcieGenSpeed[i];
> -                               lane_width = pptable->PcieLaneCount[i];
> -                       }
> +                       gen_speed = pptable->PcieGenSpeed[i];
> +                       lane_width = pptable->PcieLaneCount[i];
> +
>                         size += sprintf(buf + size, "%d: %s %s %dMhz %s\n", i,
>                                         (gen_speed == 0) ? "2.5GT/s," :
>                                         (gen_speed == 1) ? "5.0GT/s," :
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
