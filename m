Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B60C9830D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 10:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 293AB10E1DD;
	Fri, 25 Sep 2026 10:17:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="OKO3x2oK";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B0B610E1DD
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 10:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=OuvoNyS5AdXMnTVM7eQzGj6wt4EqiQ3I0jumuNv3mFg=; b=OKO3x2oKVpmp4ViPjVrmtoWMjr
 j/vwECpNDSNTh2nDiw4bM8rBhpQbWirgEsIRJksbYHUSHuyRkx/GcR4u4cvTRSqzZfXlct8Gcz783
 R3Ps7WQRVBldoh7YRlXVK9KsQAQBQvUO8NfnxLcIyPJZ+DILQtqRRsHnFs+3jg3Axbk5mKwL8d+3o
 jX8P66/v4i0Tm8MqRsMkPJe3TI6ZKnqi5CTPqK4z/PvHcu768ZrvhanGaYrLB4G8TvfmppFPrecOv
 QPgppudC/kfeAUICTYQS7IC42wozr0wI6bUAeeX6wcUsQj/9NzbOLCpGlC/oYNRuvFkmFdN5cw4rd
 44I6mrLw==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xA2zv-0075wY-7l; Fri, 25 Sep 2026 12:17:43 +0200
Message-ID: <725c0068-1185-4623-81ad-d2428db31682@igalia.com>
Date: Fri, 25 Sep 2026 11:17:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] drm/amd/display: copy function name into dcn_fpu
 trace event
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, aurabindo.pillai@amd.com,
 christian.koenig@amd.com, David.Francis@amd.com, harry.wentland@amd.com,
 simona@ffwll.ch, siqueira@igalia.com, sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org
References: <20260924211410.867686-1-mwen@igalia.com>
 <20260924211410.867686-8-mwen@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260924211410.867686-8-mwen@igalia.com>
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
> Userspace trace tools that use libtraceevent to read binary buffer only
> see a kernel address when printing const char *. Use string macros in
> dcn_fpu to copy the function name into the trace event.
> 
> Fixes: 96ee63730fa3 ("drm/amd/display: Add control mechanism for FPU")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> index 7de4fe355c5d..b2f38654e489 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> @@ -637,20 +637,20 @@ TRACE_EVENT(dcn_fpu,
>   
>   	    TP_STRUCT__entry(
>   			     __field(bool, begin)
> -			     __field(const char *, function)
> +			     __string(function, function)
>   			     __field(int, line)
>   			     __field(int, recursion_depth)
>   	    ),
>   	    TP_fast_assign(
>   			   __entry->begin = begin;
> -			   __entry->function = function;
> +			   __assign_str(function);
>   			   __entry->line = line;
>   			   __entry->recursion_depth = recursion_depth;
>   	    ),
>   	    TP_printk("%s: recursion_depth: %d: %s()+%d:",
>   		      __entry->begin ? "begin" : "end",
>   		      __entry->recursion_depth,
> -		      __entry->function,
> +		      __get_str(function),
>   		      __entry->line
>   	    )
>   );

The approach taken by TRACE_DCN_FPU is a bit over the top. Macro calling 
a function, calling a macro, calling a function.

Tracepoints are supposed to be ABI (said Linus, for better or worse) and 
tying kernel function names to ABI is a bad idea. Even line numbers. All 
very questionable IMO.

But as your patch fixes an obvious fail:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko



