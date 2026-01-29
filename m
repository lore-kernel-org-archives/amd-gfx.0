Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E87D6B076
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 15:31:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB6FD10E87E;
	Thu, 29 Jan 2026 15:31:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="kP2yCQ6F";
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 442DA10E87E
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 15:31:24 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6582e8831aeso1878967a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 07:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1769700682; x=1770305482; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NuH9KkXBmYWyoBvjvQTjGgoOFh+6LbtJJ031oEMdiqk=;
 b=kP2yCQ6FLOpx0utNN+CEa5ST6sHSj3SAZtGElr32vz7KXGQPKsgtG3R+mW0/YVHbqn
 B+4fofU3+hLCdo/jdXCT/gaY3+Xrg8bAB1yN3+sm50nWZ7Azv65k3/nVejoskNEADNpc
 Ox1dN0f6+qQYI1YmOZacgJ3V4qnfBg+eZw/4z6P18Ie44qp1iJKc5YLJ5Wc68kMSTdcN
 xRYtI3PWZ50/0+QM8MlN8AXd2bq24IMiy2AgjyASBJRHDLD1S/Y0QQXPOuYMKlMUYLWn
 lsUYTFMj1CVf6lmXpHvxQR2F2/+IVQVEewiPWQz8F52J+fsCop2h+vNEPqekmVWAYBPI
 XIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769700682; x=1770305482;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NuH9KkXBmYWyoBvjvQTjGgoOFh+6LbtJJ031oEMdiqk=;
 b=v/aI2j3xdX2Aj37gmv6CU27nTzqG29blbE7Xh2/OXsPi/rr26sDIDZPHk3J4fSM4Mk
 uHDoVvALYZhQ6YI1snIOKgIcwkphdEUfuzdNcK12rujpXhWBw0qo7hL4rjxXERR5HYMt
 ldVB6sOilhr2IjJrwnb+Ukri+Kas4Mrbp2ftF8Kslog1V0Ey5rgUBp75nX/MGaHZLOc1
 jDfj3LK9Ih7vC5qI1pPY+2mO0Z1Qh9K4QvqA9IvQoxzQSVp8EGpBmZcxmz/7xDmeeOq3
 voifXcUhxE2YazkS/bGvjX1BPtfT79fGtmsGDccEj6gLWm2gBz7EGaZe+P/3i9IMDplO
 NDBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7J6XeD2Tj9KEOrK0KPTe5H8VpUT+0mTh8Q40gVRIdWwgVxuBxRs6Hd0i0dvgfPLMXHIZea95s@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFBZmRNOBKJKCbU8zY2Ejza3X57nCeCC0iSs/gzKlWSZSpOQtg
 XnslmUy+QIWmX1OmlKJADiSwuzRjj2V8DcHI145sYy0AMnd7HJNiU6pRTfsFsPlFcJv/W3jU3ft
 MRyJazpE=
X-Gm-Gg: AZuq6aIW3RxndzjrDxhpa6WZ+BJFfz/FptH54j9Ht9CHocULTcKIn050sA5u/DiLIzA
 MGXVL+B7BJNYrCGC4SqAIC6ivukhZfqxRfo1WrrQo5SXjcTVtZR1jWhmFh9ryxHDhfeuo/2DXTd
 Q0CQgtBjcEKIOoBXsYC+VZeYWJTbjqpQnaUkKSOCrktpLYhIRXmDwgmm7dFuRCO/rJ1x6gbsAZ1
 4LohZFBou0YZZtreoC8URY9HENP1r64ULOQg42RpdbZI6BQI1pMMAIZjHtaTeYRP14/jKn52Zmk
 +9mHAfm0H+6l0EdptNeSvlcs8UAEwzSePVowjQqutZaz1Za1ChZKncV4mtjFbtnfhrDPBoSzt3j
 lAq81wWdut44jUMvTY0gBBzxQ1Sy8u8MUtPfDBSykc3Z57Bv5/geuSjWJlA88j0UVIf/epAkEN/
 OA4acmF2UDl1jpNw9oRnzrLO/0sbMP+Pjb
X-Received: by 2002:a05:6402:51cc:b0:658:37dc:18ec with SMTP id
 4fb4d7f45d1cf-658a60b90d4mr6535652a12.33.1769700682394; 
 Thu, 29 Jan 2026 07:31:22 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-658b469e45fsm2959604a12.24.2026.01.29.07.31.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 07:31:21 -0800 (PST)
Message-ID: <6fbe8046-cb00-49ca-8bc0-c1f3b747767f@ursulin.net>
Date: Thu, 29 Jan 2026 15:31:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu/gfx10: fix wptr reset in KGQ init
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260129043446.33377-1-alexander.deucher@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260129043446.33377-1-alexander.deucher@amd.com>
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


On 29/01/2026 04:34, Alex Deucher wrote:
> wptr is a 64 bit value and we need to update the
> full value, not just 32 bits. Align with what we
> already do for KCQs.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index e9254ec3b6417..ef7d91a4437ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6883,7 +6883,7 @@ static int gfx_v10_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
>   			memcpy_toio(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
>   		/* reset the ring */
>   		ring->wptr = 0;
> -		*ring->wptr_cpu_addr = 0;
> +		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);

For my education could I ask if this just about writing the 64-bit value 
or the atomic part is also important?

Regards,

Tvrtko

>   		amdgpu_ring_clear_ring(ring);
>   	}
>   

