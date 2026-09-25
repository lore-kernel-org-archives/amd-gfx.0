Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0346C9830E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 10:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3532010E6E5;
	Fri, 25 Sep 2026 10:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="n/5SAIYp";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D44A10E6E5
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 10:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=M9TE5rTGnhIZ7qdQJFga3tFEl5iQvSEQZerS3YSmH9M=; b=n/5SAIYpdWANYIH5d+yNiQFRV9
 lp8P8unQeNQBsHmdR7YnMCc4/ejEX/jSooA7VXX4qeY0FmNYbIhz9l8lUIWaGtu36wBBQyLNrAate
 jNzyqHWLVHDFOh6idb4teSqvfH0IvlJhrc1b69vTGZXhXb8lDG3B7jqA29rGhykeOsjj7OJdvCvSu
 3t7vvGdLJ0Z7SI+xSTrgF0tgRgvadv/xOEKpJ/yTS+kd4y1Z8ihjWUHWOp88N7/soql/4XfMGozqX
 Q+Jn41uDI2eCKisrOAJQoJOoIvLSITaNjb3NCajf8MI3MrFg8HkntSuGo0Ar+HQL8Iju4eq0SuLld
 n0hmH4Pg==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xA2md-0075bp-39; Fri, 25 Sep 2026 12:03:58 +0200
Message-ID: <cdef6f02-6361-49ce-a1e8-ab50d83bb81d@igalia.com>
Date: Fri, 25 Sep 2026 11:03:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] drm/amd/display: use right type for
 amdgpu_dc_performance event entries
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, aurabindo.pillai@amd.com,
 christian.koenig@amd.com, David.Francis@amd.com, harry.wentland@amd.com,
 simona@ffwll.ch, siqueira@igalia.com, sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org
References: <20260924211410.867686-1-mwen@igalia.com>
 <20260924211410.867686-6-mwen@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260924211410.867686-6-mwen@igalia.com>
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
> Some amdgpu_dc_performance trace event params are passed as unsigned
> long but stored as uint32_t, cutting them off on 64-bit. Use the right
> type on entry fields and on printk use unsigned format accordingly.
> 
> Fixes: 0cf5eb76e2b4 ("drm/amd/display: Add tracing to dc")
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h | 17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> index c59ba41a9721..26c85d95bcc0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> @@ -76,10 +76,10 @@ TRACE_EVENT(amdgpu_dc_performance,
>   		const char *func, unsigned int line),
>   	TP_ARGS(read_count, write_count, last_read, last_write, func, line),
>   	TP_STRUCT__entry(
> -			__field(uint32_t, reads)
> -			__field(uint32_t, writes)
> -			__field(uint32_t, read_delta)
> -			__field(uint32_t, write_delta)
> +			__field(unsigned long, reads)
> +			__field(unsigned long, writes)
> +			__field(unsigned long, read_delta)
> +			__field(unsigned long, write_delta)
>   			__string(func, func)
>   			__field(uint32_t, line)
>   			),
> @@ -93,12 +93,9 @@ TRACE_EVENT(amdgpu_dc_performance,
>   			*last_read = read_count;
>   			*last_write = write_count;
>   			),
> -	TP_printk("%s:%d reads=%08ld (%08ld total), writes=%08ld (%08ld total)",
> -			__get_str(func), __entry->line,
> -			(unsigned long)__entry->read_delta,
> -			(unsigned long)__entry->reads,
> -			(unsigned long)__entry->write_delta,
> -			(unsigned long)__entry->writes)
> +	TP_printk("%s:%u reads=%08lu (%08lu total), writes=%08lu (%08lu total)",
> +		  __get_str(func), __entry->line, __entry->read_delta,
> +		  __entry->reads, __entry->write_delta, __entry->writes)
>   );
>   
>   TRACE_EVENT(amdgpu_dm_connector_atomic_check,

8 character width might be insufficient now. I have no idea if it can 
happen in practice, probably not?

Do fields in struct dc_perf_trace need to be 64-bit wide is a related 
question?

Regards,

Tvrtko

