Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172F8C9832A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 09:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF21210E5F3;
	Fri, 25 Sep 2026 09:48:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Za+Lv1l9";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8942710E5F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 09:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=HKULrW6MBYNnvyuQr7iJHAnEwF/kgNiFWRtldSgfq/w=; b=Za+Lv1l9LRu01HAuh61J25DhnH
 D7X+zjKTXP3OBh7x76PMOkc0HDrQqAvYxPoezXQmWoTdP002xHSHwY1FG9uTMRKjfjLYwH5Beio6S
 JEASYF5LpR8oNrks2nXBM8U6IB4PBVG3SRsNi1YMG6jRfjLmnpVmodqdHXeiGP3OZQBAkuSnSiBu3
 NqL73Iokyk7w57Zv6rg2lNtEj5KLJVDvel+bR/DUCPG3UoK/eO3zNIW4Q5vs3O920DCZCiuzZpjhy
 mebfLfFuBkGNAFSDr6aqYuoWMdTItsF9BZg6T7QmoepZPMEhWsbLc5DXj/g6KLAuymiehiwdRhhed
 a5LEAQJQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xA2XB-0075Ad-00; Fri, 25 Sep 2026 11:48:00 +0200
Message-ID: <6926109d-7371-4098-8353-45361e306762@igalia.com>
Date: Fri, 25 Sep 2026 10:47:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drm/amd/display: fix vready offset assignment in
 dcn_optc_lock_unlock_state
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, aurabindo.pillai@amd.com,
 christian.koenig@amd.com, David.Francis@amd.com, harry.wentland@amd.com,
 simona@ffwll.ch, siqueira@igalia.com, sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org
References: <20260924211410.867686-1-mwen@igalia.com>
 <20260924211410.867686-4-mwen@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260924211410.867686-4-mwen@igalia.com>
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
> vready_offset is captured by optc_state, but the trace point entry is
> wrongly assigned to vupdate_offset. Fix vready_offset tracepoint field
> in dcn_optc_lock_unloack_state to record optc_state->vready_offset.

unlock

> 
> Fixes: f1943a51f0f9 ("drm/amd/display: Add events log to trace OPTC lock and unlock")
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> index 887ebac8c97e..f5c2f589f691 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> @@ -701,7 +701,7 @@ TRACE_EVENT(dcn_optc_lock_unlock_state,
>   			   __entry->vstartup_start = optc_state->vstartup_start;
>   			   __entry->vupdate_offset = optc_state->vupdate_offset;
>   			   __entry->vupdate_width = optc_state->vupdate_width;
> -			   __entry->vready_offset = optc_state->vupdate_offset;
> +			   __entry->vready_offset = optc_state->vready_offset;
>   	    ),
>   	    TP_printk("%s: %s()+%d: optc_instance=%d opp_count=%d max_h_total=%d max_v_total=%d "
>   		      "min_h_blank=%d min_h_sync_width=%d min_v_sync_width=%d min_v_blank=%d "

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

