Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA68FF8873
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 18:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C68E10E251;
	Thu, 30 Apr 2026 18:07:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="niX6xC2B";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D069910E251
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 18:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gQi780pV/nGEE3g3+yolT+TW1OS2X3gDYFj79MFW/WU=; b=niX6xC2BCAO4LW+gEmvgfAAsua
 bovHwLH84J5hXIDTCOhT/WKnfeYLkwnQOjbYriukCfyF6bVFEKt0UJfJ2KHPc34YJgcXasGrITJG2
 KLinN9R0HpbVsM0pj1SJ5g+6nUGom72wPHcOh9aOVz5DQkMpfW5T0qhwcRyYmWVqhsAc2daVuD5+A
 FDPCVTh6qaX6Yb00lphgFg7Knh3F65pZaYzw5uRnZh+st1N7gqZrRynuIgPWP0Hct5O8mSV+T5li6
 Ezz8eFjTY5G8raBHCatiyIo6oKBepzg1W4zGVs5D3KdjmKvCfknOaYib3on236YeEtQqHnrOdgEoC
 21qm6A0A==;
Received: from [186.208.73.228] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wIVmz-004XcB-6q; Thu, 30 Apr 2026 20:07:04 +0200
Message-ID: <0da277a3-27d7-4e0d-b65f-b41810fa9510@igalia.com>
Date: Thu, 30 Apr 2026 15:06:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] drm/amd/display: Set max supported display clock
 without max_clks_by_state
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
 <20260423191519.73127-6-timur.kristof@gmail.com>
 <a16bce0b-6d7c-49a8-85c0-77458dd4bacb@igalia.com>
 <3591364.LZWGnKmheA@timur-max>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <3591364.LZWGnKmheA@timur-max>
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



On 30/04/2026 09:28, Timur Kristóf wrote:
> On 2026. április 29., szerda 22:24:38 közép-európai nyári idő Melissa Wen
> wrote:
>> On 23/04/2026 16:15, Timur Kristóf wrote:
>>> The max_clks_by_state was based on hardcoded values, which are
>>> not really used anywhere, only to know the maximum clock.
>>> Just hardcode the same maximum clock for each DCE version.
>>>
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>
>>>    .../amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c  | 16 +++++++++++-----
>>>    1 file changed, 11 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
>>> b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c index
>>> 2ba341df7fffd..bef9a72f3382f 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
>>> @@ -391,9 +391,7 @@ static void dce_update_clocks(struct clk_mgr
>>> *clk_mgr_base,>
>>>    			struct dc_state *context,
>>>    			bool safe_to_lower)
>>>    
>>>    {
>>>
>>> -	struct clk_mgr_internal *clk_mgr_dce =
>>> TO_CLK_MGR_INTERNAL(clk_mgr_base);
>>> -	const int max_disp_clk =
>>> -		clk_mgr_dce-
>> max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_
>>> clk_khz; +	const int max_disp_clk =
>>> clk_mgr_base->clks.max_supported_dispclk_khz;>
>>>    	int patched_disp_clk = MIN(max_disp_clk,
>>>    	context->bw_ctx.bw.dce.dispclk_khz);
>>>    	
>>>    	if (should_set_clock(safe_to_lower, patched_disp_clk,
>>>    	clk_mgr_base->clks.dispclk_khz)) {>
>>> @@ -445,8 +443,16 @@ void dce_clk_mgr_construct(
>>>
>>>    	clk_mgr->dprefclk_ss_divider = 1000;
>>>    	clk_mgr->ss_on_dprefclk = false;
>>>
>>> -	base->clks.max_supported_dispclk_khz =
>>> -		clk_mgr-
>> max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_
>>> khz; +	if (ctx->dce_version >= DCE_VERSION_12_0)
>>> +		base->clks.max_supported_dispclk_khz = 1133000;
>>> +	else if (ctx->dce_version >= DCE_VERSION_11_2)
>>> +		base->clks.max_supported_dispclk_khz = 1108000;
>> For DCE 11.2, I see ClocksStatePerformance is 1132000 instead of
>> 1108000, right?
> Hi Melissa,
>
> For DCE11.2, nobody really knows what the maximum supported display clock is.
> There are different values hardcoded in different parts of the code base.
>
> dce112_max_clks_by_state says it's 1132 MHz
> bw_calcs says it's 1108 MHz
> and dce112_update_clocks() adds 15%
>
> In this patch, I chose to go for 1108 MHz to match bw_calcs, but I can edit
> that if you feel that 1132 MHz is better. What do you think?

I see. I'd keep 1132000 for consistency with the next patch.
If you believe 1108000 is the right value, I'd add a separate patch 
fixing it before this one.

Melissa

>
> Thanks,
> Timur
>
>
>> With the value fixed, this is:
>>
>> Reviewed-by: Melissa Wen <mwen@igalia.com>
>>
>>> +	else if (ctx->dce_version >= DCE_VERSION_11_0)
>>> +		base->clks.max_supported_dispclk_khz = 643000;
>>> +	else if (ctx->dce_version >= DCE_VERSION_8_0)
>>> +		base->clks.max_supported_dispclk_khz = 625000;
>>> +	else
>>> +		base->clks.max_supported_dispclk_khz = 600000;
>>>
>>>    	dce_clock_read_integrated_info(clk_mgr);
>>>    	dce_clock_read_ss_info(clk_mgr);
>
>
>

