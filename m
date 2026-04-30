Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCACCD13D3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 18:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ECEA10E04F;
	Thu, 30 Apr 2026 18:42:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="iPid1Dea";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F52910E04F
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 18:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gNX7wNLv9rmoVJ45KPpdwUihX8nqLZ/6/6OwVdtd4jM=; b=iPid1DeaHqmbq4JAObiWKqfmQi
 5+Ahndy22oEw0tyrhbhWRNayam2zn/ajpLKTyVMzm7VUJMK03nEsBradZ9YNNeDGFiEBPWwtNmtXB
 mHNAuC3NQCBkJ/frH6Id0RtvyipUtm8PWeoehRx4pmJxPlSNMBTouzdE2FP56iKpjqU5MFwpm7X/W
 44hK/hvotoHwygSmitQwmCNgyrW51rLFzZ7JcHNM6MIewbjeMbRhWG1C2iY7GQB7d+GD6V8LT2fyT
 Bza+7YA3gO3xm2amF86FMvMGO92Tn8vdCdWAAtQo+jwM723+VupJZm/oNh9HBedYbqMg0s1n0Q6CP
 djmDZuqA==;
Received: from [186.208.73.228] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wIWLL-004YFZ-Up; Thu, 30 Apr 2026 20:42:35 +0200
Message-ID: <f11dd353-eb7f-4ac7-abbd-1812fd2de615@igalia.com>
Date: Thu, 30 Apr 2026 15:42:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] drm/amd/pm: Delete dummy get_dal_power_level
 implementations
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
 <20260423191519.73127-11-timur.kristof@gmail.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260423191519.73127-11-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 23/04/2026 16:15, Timur Kristóf wrote:
> These implementations did not actually return
> the DAL power level, so they were effectively
> a no-op.

Nice catch!

Reviewed-by: Melissa Wen <mwen@igalia.com>

>
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c    |  7 -------
>   .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c   | 15 ---------------
>   .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c   | 16 ----------------
>   .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c   | 17 -----------------
>   4 files changed, 55 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index 8de8d66df95f4..5be6f82ecc6f5 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -963,12 +963,6 @@ static int smu10_store_cc6_data(struct pp_hwmgr *hwmgr, uint32_t separation_time
>   	return 0;
>   }
>   
> -static int smu10_get_dal_power_level(struct pp_hwmgr *hwmgr,
> -		struct amd_pp_simple_clock_info *info)
> -{
> -	return -EINVAL;
> -}
> -
>   static int smu10_force_clock_level(struct pp_hwmgr *hwmgr,
>   		enum pp_clock_type type, uint32_t mask)
>   {
> @@ -1664,7 +1658,6 @@ static const struct pp_hwmgr_func smu10_hwmgr_funcs = {
>   	.store_cc6_data = smu10_store_cc6_data,
>   	.force_clock_level = smu10_force_clock_level,
>   	.emit_clock_levels = smu10_emit_clock_levels,
> -	.get_dal_power_level = smu10_get_dal_power_level,
>   	.get_performance_level = smu10_get_performance_level,
>   	.get_current_shallow_sleep_clocks = smu10_get_current_shallow_sleep_clocks,
>   	.get_clock_by_type_with_latency = smu10_get_clock_by_type_with_latency,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index 1b8a57d987597..12f47ec87997d 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -4387,20 +4387,6 @@ static uint32_t vega10_get_fan_control_mode(struct pp_hwmgr *hwmgr)
>   		return AMD_FAN_CTRL_AUTO;
>   }
>   
> -static int vega10_get_dal_power_level(struct pp_hwmgr *hwmgr,
> -		struct amd_pp_simple_clock_info *info)
> -{
> -	struct phm_ppt_v2_information *table_info =
> -			(struct phm_ppt_v2_information *)hwmgr->pptable;
> -	struct phm_clock_and_voltage_limits *max_limits =
> -			&table_info->max_clock_voltage_on_ac;
> -
> -	info->engine_max_clock = max_limits->sclk;
> -	info->memory_max_clock = max_limits->mclk;
> -
> -	return 0;
> -}
> -
>   static void vega10_get_sclks(struct pp_hwmgr *hwmgr,
>   		struct pp_clock_levels_with_latency *clocks)
>   {
> @@ -5645,7 +5631,6 @@ static const struct pp_hwmgr_func vega10_hwmgr_funcs = {
>   	.set_fan_control_mode = vega10_set_fan_control_mode,
>   	.get_fan_control_mode = vega10_get_fan_control_mode,
>   	.read_sensor = vega10_read_sensor,
> -	.get_dal_power_level = vega10_get_dal_power_level,
>   	.get_clock_by_type_with_latency = vega10_get_clock_by_type_with_latency,
>   	.get_clock_by_type_with_voltage = vega10_get_clock_by_type_with_voltage,
>   	.set_watermarks_for_clocks_ranges = vega10_set_watermarks_for_clocks_ranges,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> index 5a987a535e73e..6f2bb8fe0317e 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> @@ -1822,21 +1822,6 @@ static uint32_t vega12_get_fan_control_mode(struct pp_hwmgr *hwmgr)
>   		return AMD_FAN_CTRL_AUTO;
>   }
>   
> -static int vega12_get_dal_power_level(struct pp_hwmgr *hwmgr,
> -		struct amd_pp_simple_clock_info *info)
> -{
> -#if 0
> -	struct phm_ppt_v2_information *table_info =
> -			(struct phm_ppt_v2_information *)hwmgr->pptable;
> -	struct phm_clock_and_voltage_limits *max_limits =
> -			&table_info->max_clock_voltage_on_ac;
> -
> -	info->engine_max_clock = max_limits->sclk;
> -	info->memory_max_clock = max_limits->mclk;
> -#endif
> -	return 0;
> -}
> -
>   static int vega12_get_clock_ranges(struct pp_hwmgr *hwmgr,
>   		uint32_t *clock,
>   		PPCLK_e clock_select,
> @@ -2963,7 +2948,6 @@ static const struct pp_hwmgr_func vega12_hwmgr_funcs = {
>   	.set_fan_control_mode = vega12_set_fan_control_mode,
>   	.get_fan_control_mode = vega12_get_fan_control_mode,
>   	.read_sensor = vega12_read_sensor,
> -	.get_dal_power_level = vega12_get_dal_power_level,
>   	.get_clock_by_type_with_latency = vega12_get_clock_by_type_with_latency,
>   	.get_clock_by_type_with_voltage = vega12_get_clock_by_type_with_voltage,
>   	.set_watermarks_for_clocks_ranges = vega12_set_watermarks_for_clocks_ranges,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> index 5193b7d0e11be..2a06d3e0253fb 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> @@ -2796,22 +2796,6 @@ static void vega20_set_fan_control_mode(struct pp_hwmgr *hwmgr, uint32_t mode)
>   	}
>   }
>   
> -static int vega20_get_dal_power_level(struct pp_hwmgr *hwmgr,
> -		struct amd_pp_simple_clock_info *info)
> -{
> -#if 0
> -	struct phm_ppt_v2_information *table_info =
> -			(struct phm_ppt_v2_information *)hwmgr->pptable;
> -	struct phm_clock_and_voltage_limits *max_limits =
> -			&table_info->max_clock_voltage_on_ac;
> -
> -	info->engine_max_clock = max_limits->sclk;
> -	info->memory_max_clock = max_limits->mclk;
> -#endif
> -	return 0;
> -}
> -
> -
>   static int vega20_get_sclks(struct pp_hwmgr *hwmgr,
>   		struct pp_clock_levels_with_latency *clocks)
>   {
> @@ -4446,7 +4430,6 @@ static const struct pp_hwmgr_func vega20_hwmgr_funcs = {
>   	/* export to DAL */
>   	.get_sclk = vega20_dpm_get_sclk,
>   	.get_mclk = vega20_dpm_get_mclk,
> -	.get_dal_power_level = vega20_get_dal_power_level,
>   	.get_clock_by_type_with_latency = vega20_get_clock_by_type_with_latency,
>   	.get_clock_by_type_with_voltage = vega20_get_clock_by_type_with_voltage,
>   	.set_watermarks_for_clocks_ranges = vega20_set_watermarks_for_clocks_ranges,

