Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7444FF8875
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 20:05:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CE6D10F165;
	Wed, 29 Apr 2026 20:05:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="jZcZR6lR";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F80D10F165
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 20:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L9eLRJeY/aRhnLUJ2CFO8d7N+e9WIDy8F22D3E5MiME=; b=jZcZR6lR2JxYxLahCVzqCZsGcA
 yHi4GOqA7a+xDmXsS+pXT0DUqtsrUgcAKYJPAuqNL7OhQ7pKsqxedGWYFn1Xw/ysKFEZYu0UJrjQb
 /IUHP2BEXIDXaoy9VFLIW0t3UUUSuol45eYgkUE63CijtMK/Opws0Xdi3OFayj+wozHtPXH9K3yo+
 LmnSy0pMH5fverFeD+W8niMeC5zfc6H1o/DhAFmbpTF3hhxSHEFkUejqRn/DeELQ4UpN28uLVLKgu
 yO5ZSaTEKGkhsNHXUWI9ifJ+lNn3ff4Rarl5F9laCWVPxAIMeQBGH0DvoOC+mLflKUA5TQ/vmHOiw
 OafRem8g==;
Received: from [186.208.73.228] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wIB9j-0046fk-Vg; Wed, 29 Apr 2026 22:05:11 +0200
Message-ID: <54315664-354d-4302-b4d3-8e28a181174d@igalia.com>
Date: Wed, 29 Apr 2026 17:05:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] drm/amd/display: Remove min/max clock levels from
 clk_mgr
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
 <20260423191519.73127-4-timur.kristof@gmail.com>
 <5132be76-3565-4b4d-8703-8fa49e652ea0@igalia.com>
 <3592022.LZWGnKmheA@timur-hyperion>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <3592022.LZWGnKmheA@timur-hyperion>
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



On 24/04/2026 13:28, Timur Kristóf wrote:
> On Friday, April 24, 2026 4:21:54 PM Central European Summer Time Melissa Wen
> wrote:
>> On 23/04/2026 16:15, Timur Kristóf wrote:
>>> These fields are not used by anything anymore.
>>>
>>> Signed-off-by: Timur Kristóf<timur.kristof@gmail.com>
>>> ---
>>>
>>>    .../amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 14 --------------
>>>    .../display/dc/clk_mgr/dce112/dce112_clk_mgr.c    | 15 ---------------
>>>    .../drm/amd/display/dc/inc/hw/clk_mgr_internal.h  |  2 --
>>>    3 files changed, 31 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
>>> b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c index
>>> 988eb6f841f54..2ba341df7fffd 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
>>> @@ -257,11 +257,6 @@ int dce_set_clock(
>>>
>>>    		actual_clock =
> pxl_clk_params.dfs_bypass_display_clock;
>>>    	
>>>    	}
>>>
>>> -	/* from power down, we need mark the clock state as
> ClocksStateNominal
>>> -	 * from HWReset, so when resume we will call pplib voltage
> regulator.*/
>>> -	if (requested_clk_khz == 0)
>>> -		clk_mgr_dce->cur_min_clks_state =
> DM_PP_CLOCKS_STATE_NOMINAL;
>>> -
>>>
>>>    	if (dmcu && dmcu->funcs->is_dmcu_initialized(dmcu))
>>>    	
>>>    		dmcu->funcs->set_psr_wait_loop(dmcu, actual_clock /
> 1000 / 7);
>>> @@ -425,7 +420,6 @@ void dce_clk_mgr_construct(
>>>
>>>    		struct clk_mgr_internal *clk_mgr)
>>>    
>>>    {
>>>    
>>>    	struct clk_mgr *base = &clk_mgr->base;
>>>
>>> -	struct dm_pp_static_clock_info static_clk_info = {0};
>>>
>>>    	if (ctx->dce_version <= DCE_VERSION_6_4)
>>>    	
>>>    		memcpy(clk_mgr->max_clks_by_state,
>>>
>>> @@ -451,14 +445,6 @@ void dce_clk_mgr_construct(
>>>
>>>    	clk_mgr->dprefclk_ss_divider = 1000;
>>>    	clk_mgr->ss_on_dprefclk = false;
>>>
>>> -	if (ctx->dce_version >= DCE_VERSION_8_0) {
>>> -		if (dm_pp_get_static_clocks(ctx, &static_clk_info))
>> and `dm_pp_get_static_clocks` becomes unused, right?
> Looks like nothing else is using dm_pp_get_static_clocks() so that can be
> deleted as well. I can do that in a follow-up series if that's OK.
Okay. After cleaning this too, this patch is

Reviewed-by: Melissa Wen <mwen@igalia.com>
>
>>> -			clk_mgr->max_clks_state =
> static_clk_info.max_clocks_state;
>>> -		else
>>> -			clk_mgr->max_clks_state =
> DM_PP_CLOCKS_STATE_NOMINAL;
>>> -		clk_mgr->cur_min_clks_state =
> DM_PP_CLOCKS_STATE_INVALID;
>>> -	}
>>> -
>>>
>>>    	base->clks.max_supported_dispclk_khz =
>>>    	
>>>    		clk_mgr-
>> max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk
>>>    		_khz;
>>>
>>> diff --git
>>> a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
>>> b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c index
>>> 48393c69735b6..0f3f8df4df96a 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
>>> @@ -89,13 +89,6 @@ int dce112_set_clock(struct clk_mgr *clk_mgr_base, int
>>> requested_clk_khz)>
>>>    	bp->funcs->set_dce_clock(bp, &dce_clk_params);
>>>    	actual_clock = dce_clk_params.target_clock_frequency;
>>>
>>> -	/*
>>> -	 * from power down, we need mark the clock state as
> ClocksStateNominal
>>> -	 * from HWReset, so when resume we will call pplib voltage
> regulator.
>>> -	 */
>>> -	if (requested_clk_khz == 0)
>>> -		clk_mgr_dce->cur_min_clks_state =
> DM_PP_CLOCKS_STATE_NOMINAL;
>>> -
>>>
>>>    	/*Program DP ref Clock*/
>>>    	/*VBIOS will determine DPREFCLK frequency, so we don't set it*/
>>>    	dce_clk_params.target_clock_frequency = 0;
>>>
>>> @@ -143,14 +136,6 @@ int dce112_set_dispclk(struct clk_mgr_internal
>>> *clk_mgr, int requested_clk_khz)>
>>>    	bp->funcs->set_dce_clock(bp, &dce_clk_params);
>>>    	actual_clock = dce_clk_params.target_clock_frequency;
>>>
>>> -	/*
>>> -	 * from power down, we need mark the clock state as
> ClocksStateNominal
>>> -	 * from HWReset, so when resume we will call pplib voltage
> regulator.
>>> -	 */
>>> -	if (requested_clk_khz == 0)
>>> -		clk_mgr->cur_min_clks_state =
> DM_PP_CLOCKS_STATE_NOMINAL;
>>> -
>>> -
>>>
>>>    	if (dmcu && dmcu->funcs->is_dmcu_initialized(dmcu)) {
>>>    	
>>>    		if (clk_mgr->dfs_bypass_disp_clk != actual_clock)
>>>    		
>>>    			dmcu->funcs->set_psr_wait_loop(dmcu,
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
>>> b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h index
>>> c69ccfcebeb5a..e01bf6bd7f3f4 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
>>> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
>>> @@ -477,8 +477,6 @@ struct clk_mgr_internal {
>>>
>>>    	 */
>>>    	
>>>    	int dprefclk_ss_divider;
>>>
>>> -	enum dm_pp_clocks_state max_clks_state;
>>> -	enum dm_pp_clocks_state cur_min_clks_state;
>>>
>>>    	bool periodic_retraining_disabled;
>>>    	
>>>    	unsigned int cur_phyclk_req_table[MAX_LINKS];
>
>
>

