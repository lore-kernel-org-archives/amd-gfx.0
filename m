Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F84CD13D3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 19:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 492FD10F421;
	Thu, 30 Apr 2026 19:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="S4qu2P6C";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5813510F421
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 19:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f2Jbo2hWo5W/Cpde2r1PzowlvLjhd6dJ7GiWXKk+gO8=; b=S4qu2P6CKJwOeub58euGRzQwjb
 C5FTxZL1JwHxQIASUGbOs6eCN6j2gUueRPx1RyMJST6xwqD9yj7lILVYkNnHQiuZWUFKPcH7X8Zv4
 mg9cTLELn3A0cMuletL8R3sUgTDU0x5PEcseXmfKmA4KYz9qR4jDaWvgBc+m6DmW2G4aSNaw6uM9N
 TVMokI7AmUcbR8PFo6T6Rd0pB6WWpRinIqqZcdNafpdI1yvWHdMRRXBqGffkX+6399pT9V6vBVRAE
 qrLOdmu3w25WA0CUpXt68+tLurVpBqhOqZLKa6ZD6uc55iQqE8JQfZJKtYSWRBzUBE8I4ZgQoZWNQ
 ch8LPyCA==;
Received: from [186.208.73.228] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wIWg5-004YdX-W5; Thu, 30 Apr 2026 21:04:01 +0200
Message-ID: <bd03df18-c750-4317-abbc-25a811e3ddda@igalia.com>
Date: Thu, 30 Apr 2026 16:03:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] drm/amd/pm: Delete get_dal_power_level
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
 <20260423191519.73127-14-timur.kristof@gmail.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260423191519.73127-14-timur.kristof@gmail.com>
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
> Not needed anymore.
Reviewed-by: Melissa Wen <mwen@igalia.com>
>
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   |  3 ---
>   drivers/gpu/drm/amd/include/dm_pp_interface.h          |  1 -
>   drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c       | 10 ----------
>   .../gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c   | 10 ----------
>   drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h |  3 ---
>   drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h           |  2 --
>   6 files changed, 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> index 2247969aa9acb..90f79d70874cd 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> @@ -288,7 +288,6 @@ bool dm_pp_get_clock_levels_by_type(
>   		DRM_INFO("DM_PPLIB: Warning: using default validation clocks!\n");
>   		validation_clks.engine_max_clock = 72000;
>   		validation_clks.memory_max_clock = 80000;
> -		validation_clks.level = 0;
>   	}
>   
>   	DRM_INFO("DM_PPLIB: Validation clocks:\n");
> @@ -296,8 +295,6 @@ bool dm_pp_get_clock_levels_by_type(
>   			validation_clks.engine_max_clock);
>   	DRM_INFO("DM_PPLIB:    memory_max_clock: %d\n",
>   			validation_clks.memory_max_clock);
> -	DRM_INFO("DM_PPLIB:    level           : %d\n",
> -			validation_clks.level);
>   
>   	/* Translate 10 kHz to kHz. */
>   	validation_clks.engine_max_clock *= 10;
> diff --git a/drivers/gpu/drm/amd/include/dm_pp_interface.h b/drivers/gpu/drm/amd/include/dm_pp_interface.h
> index 349544504c93c..10747a1ceda9a 100644
> --- a/drivers/gpu/drm/amd/include/dm_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/dm_pp_interface.h
> @@ -113,7 +113,6 @@ struct amd_pp_display_configuration {
>   struct amd_pp_simple_clock_info {
>   	uint32_t	engine_max_clock;
>   	uint32_t	memory_max_clock;
> -	uint32_t	level;
>   };
>   
>   enum PP_DAL_POWERLEVEL {
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index 4c2c40e8123bf..a53577a83f1b3 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -1023,7 +1023,6 @@ static int pp_display_configuration_change(void *handle,
>   static int pp_get_current_clocks(void *handle,
>   		struct amd_pp_clock_info *clocks)
>   {
> -	struct amd_pp_simple_clock_info simple_clocks = { 0 };
>   	struct pp_clock_info hw_clocks;
>   	struct pp_hwmgr *hwmgr = handle;
>   	int ret = 0;
> @@ -1031,8 +1030,6 @@ static int pp_get_current_clocks(void *handle,
>   	if (!hwmgr || !hwmgr->pm_en)
>   		return -EINVAL;
>   
> -	phm_get_dal_power_level(hwmgr, &simple_clocks);
> -
>   	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
>   					PHM_PlatformCaps_PowerContainment))
>   		ret = phm_get_clock_info(hwmgr, &hwmgr->current_ps->hardware,
> @@ -1057,11 +1054,6 @@ static int pp_get_current_clocks(void *handle,
>   	clocks->max_engine_clock_in_sr = hw_clocks.max_eng_clk;
>   	clocks->min_engine_clock_in_sr = hw_clocks.min_eng_clk;
>   
> -	if (simple_clocks.level == 0)
> -		clocks->max_clocks_state = PP_DAL_POWERLEVEL_7;
> -	else
> -		clocks->max_clocks_state = simple_clocks.level;
> -
>   	if (0 == phm_get_current_shallow_sleep_clocks(hwmgr, &hwmgr->current_ps->hardware, &hw_clocks)) {
>   		clocks->max_engine_clock_in_sr = hw_clocks.max_eng_clk;
>   		clocks->min_engine_clock_in_sr = hw_clocks.min_eng_clk;
> @@ -1138,8 +1130,6 @@ static int pp_get_display_mode_validation_clocks(void *handle,
>   	if (!hwmgr || !hwmgr->pm_en || !clocks)
>   		return -EINVAL;
>   
> -	clocks->level = PP_DAL_POWERLEVEL_7;
> -
>   	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_PlatformCaps_DynamicPatchPowerState))
>   		ret = phm_get_max_high_clocks(hwmgr, clocks);
>   
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
> index a59677cf8dfc8..72c2d3b69a038 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
> @@ -328,16 +328,6 @@ int phm_store_dal_configuration_data(struct pp_hwmgr *hwmgr,
>   	return 0;
>   }
>   
> -int phm_get_dal_power_level(struct pp_hwmgr *hwmgr,
> -		struct amd_pp_simple_clock_info *info)
> -{
> -	PHM_FUNC_CHECK(hwmgr);
> -
> -	if (info == NULL || hwmgr->hwmgr_func->get_dal_power_level == NULL)
> -		return -EINVAL;
> -	return hwmgr->hwmgr_func->get_dal_power_level(hwmgr, info);
> -}
> -
>   int phm_set_cpu_power_state(struct pp_hwmgr *hwmgr)
>   {
>   	PHM_FUNC_CHECK(hwmgr);
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
> index 915f1b8e4dbad..36dcad065faeb 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
> @@ -426,9 +426,6 @@ extern int phm_check_states_equal(struct pp_hwmgr *hwmgr,
>   extern int phm_store_dal_configuration_data(struct pp_hwmgr *hwmgr,
>   		const struct amd_pp_display_configuration *display_config);
>   
> -extern int phm_get_dal_power_level(struct pp_hwmgr *hwmgr,
> -		struct amd_pp_simple_clock_info *info);
> -
>   extern int phm_set_cpu_power_state(struct pp_hwmgr *hwmgr);
>   
>   extern int phm_power_down_asic(struct pp_hwmgr *hwmgr);
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> index 1ee7e3044272d..fc1ffe1b2c97f 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> @@ -292,8 +292,6 @@ struct pp_hwmgr_func {
>   	int (*store_cc6_data)(struct pp_hwmgr *hwmgr, uint32_t separation_time,
>   				bool cc6_disable, bool pstate_disable,
>   				bool pstate_switch_disable);
> -	int (*get_dal_power_level)(struct pp_hwmgr *hwmgr,
> -			struct amd_pp_simple_clock_info *info);
>   	int (*get_performance_level)(struct pp_hwmgr *, const struct pp_hw_power_state *,
>   			PHM_PerformanceLevelDesignation, uint32_t, PHM_PerformanceLevel *);
>   	int (*get_current_shallow_sleep_clocks)(struct pp_hwmgr *hwmgr,

