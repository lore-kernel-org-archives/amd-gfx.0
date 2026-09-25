Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA17CC9830E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 09:45:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76DFB10F9B6;
	Fri, 25 Sep 2026 09:45:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="qv31wrhi";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A3E910F9B6
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 09:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=EbKmQmawPcLMgSKHp45FiPglETAC7VTaq1PXQmNkJEY=; b=qv31wrhiEqpDx9nkhKl0+jAhYy
 fpXevY49UoUNJk8YlVXJYlDX+Y40bP6T2KhhY1HOsY8WnF2W2DcHtnBmr9ReEA21gpmhjhpt2flde
 /h1/+FRlbpbJuTMJ3/9yH8HDAc46Pql/vDL3Haf49Ga2pc+qUeDrWGghy9E9vaD4IAUdQ3x9zNYEH
 BEwQIedbhypYtD18Plw2zG/LGsPf8michkHHaIt/4dSBk351NQjp6liwBqnmgI0ITXSlCbhjF621Q
 45QlZSAEYtjmOdKimq8ZVR9eRY50VkmVT5Tp8D67/QPeWE4bxmtu7Qei480urF9Hg+ruP9QTfulJz
 D15wrsnQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xA2Ui-007575-Qe; Fri, 25 Sep 2026 11:45:28 +0200
Message-ID: <3f2c2f1b-e6ea-4ef0-a405-a840fdca6ce5@igalia.com>
Date: Fri, 25 Sep 2026 10:45:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] drm/amd/display: assign missing trace entry in
 amdgpu_dm_dc_clocks_state
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, aurabindo.pillai@amd.com,
 christian.koenig@amd.com, David.Francis@amd.com, harry.wentland@amd.com,
 simona@ffwll.ch, siqueira@igalia.com, sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org
References: <20260924211410.867686-1-mwen@igalia.com>
 <20260924211410.867686-2-mwen@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260924211410.867686-2-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 24/09/2026 22:10, Melissa Wen wrote:
> disp_dpp_voltage_level_khz is declared and printed, but never assigned.
> So when using clock tracepoint the value of this clock is just garbage.
> Assign clk->disp_dpp_voltage_level_khz since this is stored in dc_clocks
> as other entries.
> 
> Fixes: 13b5ca42ca9c ("drm/amd/display: Add tracepoint for capturing clocks state")
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> index f33a2c1e0da5..cc70aeb75798 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> @@ -513,6 +513,7 @@ TRACE_EVENT(amdgpu_dm_dc_clocks_state,
>   	    TP_fast_assign(
>   			   __entry->dispclk_khz = clk->dispclk_khz;
>   			   __entry->dppclk_khz = clk->dppclk_khz;
> +			   __entry->disp_dpp_voltage_level_khz = clk->disp_dpp_voltage_level_khz;
>   			   __entry->dcfclk_khz = clk->dcfclk_khz;
>   			   __entry->socclk_khz = clk->socclk_khz;
>   			   __entry->dcfclk_deep_sleep_khz = clk->dcfclk_deep_sleep_khz;

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

