Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2104C9830D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 09:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C0F810F9B7;
	Fri, 25 Sep 2026 09:45:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="labMJmPE";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCB8E10F9B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 09:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=CFfVx5+oFFnU1AL0DobMmqx7JLTRcaMuiNwwn3CLh9Q=; b=labMJmPEQorWLCGpc/0RBibfof
 16GsxBdFlTB+ix7mpbZ0Ga1Dha5rMhfCmxAE0dlCSwMxknIYFi0L7SR1qtnrlFdPBkh+P7OGPpVF1
 HX/5SZ4K2LVZd0giHCU7v98032/QLCzQ5CECsm0oNmc4WPtUngn3WgCQdFbdU/cmb8BvmGNZMVlmY
 /8RqPoEuRt5SB2I3qjzLd4XD+Pqxq750RzGiKeVm2JjQuPrOwwCGjnNqHrb5qog9JR0OHqhdVbIFz
 MLWYujfjgxlOTUYsPs+SMD8mH8dPPt2VDs/5Th68Drq57Y4TVYkogplbKvJdHfD9pgAhUXwvUBh0L
 sJZx0v7w==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xA2Us-00757b-90; Fri, 25 Sep 2026 11:45:38 +0200
Message-ID: <4e7f1494-722b-4a09-9b8a-b26e879be2fa@igalia.com>
Date: Fri, 25 Sep 2026 10:45:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] drm/amd/display: remove duplicated
 prev_p_state_change_support assignment
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, aurabindo.pillai@amd.com,
 christian.koenig@amd.com, David.Francis@amd.com, harry.wentland@amd.com,
 simona@ffwll.ch, siqueira@igalia.com, sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org
References: <20260924211410.867686-1-mwen@igalia.com>
 <20260924211410.867686-3-mwen@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260924211410.867686-3-mwen@igalia.com>
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
> The prev_p_state_change_support trace entry is assigned and printed
> twice, remove the unnecessary duplicates.
> 
> Fixes: 13b5ca42ca9c ("drm/amd/display: Add tracepoint for capturing clocks state")
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> index cc70aeb75798..887ebac8c97e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> @@ -523,7 +523,6 @@ TRACE_EVENT(amdgpu_dm_dc_clocks_state,
>   			   __entry->p_state_change_support = clk->p_state_change_support;
>   			   __entry->prev_p_state_change_support = clk->prev_p_state_change_support;
>   			   __entry->pwr_state = clk->pwr_state;
> -			   __entry->prev_p_state_change_support = clk->prev_p_state_change_support;
>   			   __entry->dtm_level = clk->dtm_level;
>   			   __entry->max_supported_dppclk_khz = clk->max_supported_dppclk_khz;
>   			   __entry->max_supported_dispclk_khz = clk->max_supported_dispclk_khz;
> @@ -533,8 +532,8 @@ TRACE_EVENT(amdgpu_dm_dc_clocks_state,
>   	    TP_printk("dispclk_khz=%d dppclk_khz=%d disp_dpp_voltage_level_khz=%d dcfclk_khz=%d socclk_khz=%d "
>   		      "dcfclk_deep_sleep_khz=%d fclk_khz=%d phyclk_khz=%d "
>   		      "dramclk_khz=%d p_state_change_support=%d "
> -		      "prev_p_state_change_support=%d pwr_state=%d prev_p_state_change_support=%d "
> -		      "dtm_level=%d max_supported_dppclk_khz=%d max_supported_dispclk_khz=%d "
> +		      "prev_p_state_change_support=%d pwr_state=%d dtm_level=%d "
> +		      "max_supported_dppclk_khz=%d max_supported_dispclk_khz=%d "
>   		      "bw_dppclk_khz=%d bw_dispclk_khz=%d ",
>   		      __entry->dispclk_khz,
>   		      __entry->dppclk_khz,
> @@ -548,7 +547,6 @@ TRACE_EVENT(amdgpu_dm_dc_clocks_state,
>   		      __entry->p_state_change_support,
>   		      __entry->prev_p_state_change_support,
>   		      __entry->pwr_state,
> -		      __entry->prev_p_state_change_support,
>   		      __entry->dtm_level,
>   		      __entry->max_supported_dppclk_khz,
>   		      __entry->max_supported_dispclk_khz,

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

