Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F442C9830E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 10:05:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A730D10E9EB;
	Fri, 25 Sep 2026 10:05:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="oSxOyZVA";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8659110E9EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 10:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=+IHZSw9GJGB4eonCXrhw37O9NY3F+yFCYGgrvXozfn0=; b=oSxOyZVAfzfCvVHrO96XNALA3I
 IQmJ5DPlNDl5i1Hg8AO/fggbE38K+a5bAxmXB9m7l8CFneL13xsZLLnswFnYbjO405d27PTzdwFQE
 fy1nGXS9a78PjrlcscVyVibt9pKVFrEysZiHF9X6K/gI/PuKw2ClCORrt5Ox0sb6ktocrNL58sj/m
 SxBrMhnreAnaVbpmGSE0ZLSqx0Zfj+2WJAMDfj/vWE6Z/ST5NyChhH5Uhn42g5XkbnpixjBZCJ45+
 ZR6Fd9v/8OLS6YmFo51R6BdgzVslrNUmxx7c6uUEnqZbCP7hqeHHhBKRv7yf0sp1blQ5RQPGCIdWv
 UcI7FWpg==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xA2oB-0075ei-Ut; Fri, 25 Sep 2026 12:05:35 +0200
Message-ID: <90abbe7f-9f58-4fd6-9aae-13acb26b171b@igalia.com>
Date: Fri, 25 Sep 2026 11:05:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] drm/amd/display: remove redundant cast on
 amdgpu_dc_reg_template printk
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, aurabindo.pillai@amd.com,
 christian.koenig@amd.com, David.Francis@amd.com, harry.wentland@amd.com,
 simona@ffwll.ch, siqueira@igalia.com, sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org
References: <20260924211410.867686-1-mwen@igalia.com>
 <20260924211410.867686-7-mwen@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260924211410.867686-7-mwen@igalia.com>
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
> Commit 0cf5eb76e2b4 ("drm/amd/display: Add tracing to dc") prints and
> casts uint32_t fields in amdgpu_dc_reg_template to unsigned long
> unnecessarily. Just print those fields with %08x and remove the
> redundant cast.
> 
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> index 26c85d95bcc0..7de4fe355c5d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> @@ -57,9 +57,8 @@ DECLARE_EVENT_CLASS(amdgpu_dc_reg_template,
>   				   *count = *count + 1;
>   		    ),
>   
> -		    TP_printk("reg=0x%08lx, value=0x%08lx",
> -			      (unsigned long)__entry->reg,
> -			      (unsigned long)__entry->value)
> +		    TP_printk("reg=0x%08x, value=0x%08x",
> +			      __entry->reg, __entry->value)
>   );
>   
>   DEFINE_EVENT(amdgpu_dc_reg_template, amdgpu_dc_rreg,

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

