Return-Path: <SRS0=FRS3=EE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91D7C55178
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2020 09:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F7A32076E
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2020 09:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhD/Mwtk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7A32076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96B616E0D5;
	Thu, 29 Oct 2020 09:46:27 +0000 (UTC)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com
 [IPv6:2a00:1450:4864:20::641])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE8256E0D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2020 09:46:26 +0000 (UTC)
Received: by mail-ej1-x641.google.com with SMTP id j24so2875550ejc.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2020 02:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=xR+pimkRBkVxQKmz8+Y1c1P6bvdZE/j3e5Or8kp9I7I=;
 b=LhD/Mwtkpcwdn1eAGiZ4/3Lhlfh/ocxL2KlhGyFgJ4mKxSuYs2k37+jQ/BGtz4e65R
 kz5ZNa3gEFUncQPI65G+iP/DeR1HKfDFBjP/XjgRtSB/ZorXkD11/PBjDavvCn7nmEpo
 SyoZIhgfobkqqFB5KHqaLBI/Jem5jKgvqXKrF8WQPn/NvPmwQaVVF6DEjE+PWo1nPvwL
 ncBONpQajb8cfa+Chl4JCKWMprkCE+Gw5R0h/4qehRBR1IbzGpg7lkwH1BRGmDTO82QA
 zvc/nl665iuILjJzrtYfhNIXWr7DGE2oy2lvaaolQq5Or8MEokdVpdzj14DBojFzrBAp
 YupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=xR+pimkRBkVxQKmz8+Y1c1P6bvdZE/j3e5Or8kp9I7I=;
 b=qhkvCOO5rnvX/7KuFqFw5bd9hwzGf0Me+JswF60kNqq9DiC3+NixjZDJ7bMxi8U0Mi
 lguqIS5SBYl64ZWt1se/Z668vowsq7v2f41EangbSNo+wrRVBR9Hc69duDfO0ejU4TfR
 xNYTxYQcA99tLRVXrCULNqZ08Xuz9m32lF/THVyS8IlDMP27o1zvrIaT/KX1o6/XIS95
 bBEKEqQJIJGZUG+cmOHuGZkdjL94X1Unr9YAFuwPXXGspU+WXiWSy2sMdwWyA/O5xIAN
 zhO2KXXCyPkg3qdaIpxYpk9y6sB3IxGBD6CavYG+P7LIomn01lZFqFYBFB3tTW/XIPwc
 wPCQ==
X-Gm-Message-State: AOAM531me0OnTE3965yEquQ0OQCNx2JKDjvrHkPsWePvQn6uUB6+krwj
 zR/kOFiRjr4512eGBM4WkOQ=
X-Google-Smtp-Source: ABdhPJwqNGeVqyWeTi9UgLXG6JDvUSxQR9npz1/3FoGNZoqcQAZ2B0rbPSEXmfO7XPR4HIFWvcAwvA==
X-Received: by 2002:a17:906:4155:: with SMTP id
 l21mr3339784ejk.204.1603964785449; 
 Thu, 29 Oct 2020 02:46:25 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id b1sm803539ejg.60.2020.10.29.02.46.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 02:46:24 -0700 (PDT)
Subject: Re: [PATCH 37/40] drm/amd/pm: enable Polaris watermark table setting
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201016032652.507-1-evan.quan@amd.com>
 <20201016032652.507-38-evan.quan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9dc45588-d70e-0e3d-5131-22994ab2c757@gmail.com>
Date: Thu, 29 Oct 2020 10:46:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016032652.507-38-evan.quan@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi guys,

this commit here completely breaks Vega20.

Any idea why a change for Polaris should have that effect? Can we please 
fix this ASAP?

Thanks,
Christian.

Am 16.10.20 um 05:26 schrieb Evan Quan:
> Enable watermark table setting for Polaris.
>
> Change-Id: I395b74f2ce5b74e6d1c7659816ee386ba556e14c
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  | 11 +++-
>   .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 50 +++++++++++++++++++
>   2 files changed, 60 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> index deb9164eb5fe..fd39dd67bfa4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> @@ -458,7 +458,16 @@ bool dm_pp_notify_wm_clock_changes(
>   	const struct dc_context *ctx,
>   	struct dm_pp_wm_sets_with_clock_ranges *wm_with_clock_ranges)
>   {
> -	/* TODO: to be implemented */
> +	struct amdgpu_device *adev = ctx->driver_context;
> +	void *pp_handle = adev->powerplay.pp_handle;
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (pp_funcs && pp_funcs->set_watermarks_for_clocks_ranges) {
> +		if (!pp_funcs->set_watermarks_for_clocks_ranges(pp_handle,
> +						(void *)wm_with_clock_ranges))
> +			return true;
> +	}
> +
>   	return false;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index 3700352286c5..ce8f368c0a8c 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -49,6 +49,8 @@
>   #include "processpptables.h"
>   #include "pp_thermal.h"
>   #include "smu7_baco.h"
> +#include "smu7_smumgr.h"
> +#include "polaris10_smumgr.h"
>   
>   #include "ivsrcid/ivsrcid_vislands30.h"
>   
> @@ -5107,6 +5109,53 @@ static int smu7_get_clock_by_type_with_latency(struct pp_hwmgr *hwmgr,
>   	return 0;
>   }
>   
> +static int smu7_set_watermarks_for_clocks_ranges(struct pp_hwmgr *hwmgr,
> +						 void *clock_range)
> +{
> +	struct phm_ppt_v1_information *table_info =
> +			(struct phm_ppt_v1_information *)hwmgr->pptable;
> +	struct phm_ppt_v1_clock_voltage_dependency_table *dep_mclk_table =
> +			table_info->vdd_dep_on_mclk;
> +	struct phm_ppt_v1_clock_voltage_dependency_table *dep_sclk_table =
> +			table_info->vdd_dep_on_sclk;
> +	struct polaris10_smumgr *smu_data =
> +			(struct polaris10_smumgr *)(hwmgr->smu_backend);
> +	SMU74_Discrete_DpmTable  *table = &(smu_data->smc_state_table);
> +	struct dm_pp_wm_sets_with_clock_ranges *watermarks =
> +			(struct dm_pp_wm_sets_with_clock_ranges *)clock_range;
> +	uint32_t i, j, k;
> +	bool valid_entry;
> +
> +	if (!(hwmgr->chip_id >= CHIP_POLARIS10 &&
> +	      hwmgr->chip_id <= CHIP_VEGAM))
> +		return -EINVAL;
> +
> +	for (i = 0; i < dep_mclk_table->count; i++) {
> +		for (j = 0; j < dep_sclk_table->count; j++) {
> +			valid_entry = false;
> +			for (k = 0; k < watermarks->num_wm_sets; k++) {
> +				if (dep_sclk_table->entries[i].clk / 10 >= watermarks->wm_clk_ranges[k].wm_min_eng_clk_in_khz &&
> +				    dep_sclk_table->entries[i].clk / 10 < watermarks->wm_clk_ranges[k].wm_max_eng_clk_in_khz &&
> +				    dep_mclk_table->entries[i].clk / 10 >= watermarks->wm_clk_ranges[k].wm_min_mem_clk_in_khz &&
> +				    dep_mclk_table->entries[i].clk / 10 < watermarks->wm_clk_ranges[k].wm_max_mem_clk_in_khz) {
> +					valid_entry = true;
> +					table->DisplayWatermark[i][j] = watermarks->wm_clk_ranges[k].wm_set_id;
> +					break;
> +				}
> +			}
> +			PP_ASSERT_WITH_CODE(valid_entry,
> +					"Clock is not in range of specified clock range for watermark from DAL!  Using highest water mark set.",
> +					table->DisplayWatermark[i][j] = watermarks->wm_clk_ranges[k - 1].wm_set_id);
> +		}
> +	}
> +
> +	return smu7_copy_bytes_to_smc(hwmgr,
> +				      smu_data->smu7_data.dpm_table_start + offsetof(SMU74_Discrete_DpmTable, DisplayWatermark),
> +				      (uint8_t *)table->DisplayWatermark,
> +				      sizeof(uint8_t) * SMU74_MAX_LEVELS_MEMORY * SMU74_MAX_LEVELS_GRAPHICS,
> +				      SMC_RAM_END);
> +}
> +
>   static int smu7_notify_cac_buffer_info(struct pp_hwmgr *hwmgr,
>   					uint32_t virtual_addr_low,
>   					uint32_t virtual_addr_hi,
> @@ -5525,6 +5574,7 @@ static const struct pp_hwmgr_func smu7_hwmgr_funcs = {
>   	.set_mclk_od = smu7_set_mclk_od,
>   	.get_clock_by_type = smu7_get_clock_by_type,
>   	.get_clock_by_type_with_latency = smu7_get_clock_by_type_with_latency,
> +	.set_watermarks_for_clocks_ranges = smu7_set_watermarks_for_clocks_ranges,
>   	.read_sensor = smu7_read_sensor,
>   	.dynamic_state_management_disable = smu7_disable_dpm_tasks,
>   	.avfs_control = smu7_avfs_control,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
