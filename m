Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3DAC9830D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 10:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 317D110F9B0;
	Fri, 25 Sep 2026 10:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="mdyNfE6M";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B4FD10F9B0
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 10:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=bROpSOOrf9zmK3zbUGISWrTidMlRNy186ZZ7M09II4g=; b=mdyNfE6Mz27wro5CXxCQDRRVW7
 u7aYvnYixFBnUVN0RGLuKdqKPWaH0P4irjDNxcPdrrTgaeuezLQ+rAbqENT5AMMjWKUF5SvGgh2v/
 MC7epgFlZhpfpE8kRBh9bfuTrlxFFtS0lOVBd1UE/oW6fLqTFj/WrmwbW8UKKrZF2y4gfbD4feqFg
 PLSgC8W5qcAy3TxZXAwmu0LS2axwrdcqhc2AYqQtlrwZbKMeRtad2017+SrCcXJH7WGiugABwp36O
 55yscdjcSWIUYkixq79+khpmN6TrKjH9i/BDDSvzlZ/6xrTYIwCEPZZckzk0THo1zyciYS51oPdhY
 YlIUgkfg==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xA356-00764O-Dp; Fri, 25 Sep 2026 12:23:04 +0200
Message-ID: <f21d5d36-9ced-4e03-a9a7-752d1f4cb9d9@igalia.com>
Date: Fri, 25 Sep 2026 11:23:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] drm/amd/display: copy function name into
 dcn_optc_lock_unlock_state trace event
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, aurabindo.pillai@amd.com,
 christian.koenig@amd.com, David.Francis@amd.com, harry.wentland@amd.com,
 simona@ffwll.ch, siqueira@igalia.com, sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org
References: <20260924211410.867686-1-mwen@igalia.com>
 <20260924211410.867686-9-mwen@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260924211410.867686-9-mwen@igalia.com>
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
> dcn_optc_lock_unlock_state to copy the function name into the trace
> event.
> 
> Fixes: f1943a51f0f9 ("drm/amd/display: Add events log to trace OPTC lock and unlock")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> index b2f38654e489..7f05f73e5b33 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> @@ -660,7 +660,7 @@ TRACE_EVENT(dcn_optc_lock_unlock_state,
>   	    TP_ARGS(optc_state, instance, lock, function, line),
>   
>   	    TP_STRUCT__entry(
> -			     __field(const char *, function)
> +			     __string(function, function)
>   			     __field(int, instance)
>   			     __field(bool, lock)
>   			     __field(int, line)
> @@ -678,7 +678,7 @@ TRACE_EVENT(dcn_optc_lock_unlock_state,
>   			     __field(int, vready_offset)
>   	    ),
>   	    TP_fast_assign(
> -			   __entry->function = function;
> +			   __assign_str(function);
>   			   __entry->instance = instance;
>   			   __entry->lock = lock;
>   			   __entry->line = line;
> @@ -700,7 +700,7 @@ TRACE_EVENT(dcn_optc_lock_unlock_state,
>   		      "min_v_blank_interlace=%d vstartup_start=%d vupdate_offset=%d vupdate_width=%d "
>   		      "vready_offset=%d",
>   		      __entry->lock ? "Lock" : "Unlock",
> -		      __entry->function,
> +		      __get_str(function),
>   		      __entry->line,
>   		      __entry->instance,
>   		      __entry->opp_count,

Hmm this one does have the macro->function->macro->function trick unlike 
the previous patch so unless I am wrong function name and line number 
are always the same? Ie. it could be converted to two separate 
tracepoints and would just lose the (questionable) line number.

Regards,

Tvrtko

