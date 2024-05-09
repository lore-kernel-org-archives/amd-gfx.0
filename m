Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57076C25B10
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 12:40:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E37210E1F4;
	Thu,  9 May 2024 12:40:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="08RXUR8S";
	dkim-atps=neutral
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EC0C10E0D5
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 12:40:21 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-518931f8d23so870557e87.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 May 2024 05:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1715258419; x=1715863219;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n3NirfJeXWYYIR5R2uPMTQMrKgE4eFI2a/JfUV4vtog=;
 b=08RXUR8S0AAQrs65fLj8iOe0drfYqnIfXYIdb+T00eTyLbZIinOo9DP2ssHySYrhsY
 NSyGpCoAU2dAi7TaCDGRFiH5+2AkBAyYRwjrcVzo5GcKgBwzioorV0Wx0GvSxJqjet4Z
 sptRJ84fnLjl1p/XSf8dqt7Sd0KUuYPtT7TYykJZ2p36VnP7Uw1wuMUYbp2eacyx3ZMh
 EMFLJ8bX1x9H4ZUBl8QTda8vMl2p0xoLpjXlf2xQUXRbYNnhkadbVHGbmpW1CTKltnkZ
 HkkJv7T46xeaYyyRhhCDimT6a3jn2xs7U1SY1Ro2oFFecVt6paook4cSKgnANRoS6IMc
 sfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715258419; x=1715863219;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n3NirfJeXWYYIR5R2uPMTQMrKgE4eFI2a/JfUV4vtog=;
 b=p6qj8I7SrL06k1GdiXIXMzPign3H2NNnALf3zVYYsFogDtL8UWRFfC31bxkrGKxz2U
 hDuCJ1A5ByTL5JgY2mbwV4W5LoNfcmkhTr59HK5qir9TvK0r6yh5sXXbN35BKGnsKR2G
 z08ZRnqM1BfsnCHiskN9nKPNtF6TDgxIgcPZO/MmEVdkscpBxnT84ZIP/rglSsoUvZXp
 qPuyOAlvFKF1UF1aD7Rrdrjow7sv+NmtWcjKzl6MahOtSf5zg0k1jQD7mXcZK0KcwzrW
 IjAjSkfBqfnSr/9qXjnX3HJq7JNmtg1Nn5P0px62TqDE0JYuMNCkkIqhRSgdmaKbnEF2
 hFTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlnYDDgo+13Zl1HQODc6cBhP4Mj1ZOdUyDVEnte/ePmvCNKl4yWLAPa53TRfF6hEFWaSvUP+Uult+bjlJDlUsjSyv+Q5+0tIJ0fHMupA==
X-Gm-Message-State: AOJu0YzFSsZrwe5x5nrG0RfE/aXPpRHpdtXAy2P4waskTlOBR1GAKLdQ
 9FgjmWk/uOgksW0OODCrAk+FDRBISaYpLqJVglWeTXOh7ZSrYoTwZXzKBVVOiPc=
X-Google-Smtp-Source: AGHT+IHL0A6wEwx4JimOBgRRojYWD3H9Z5e/uxRyzaiU217ufBs0ILdpp0w4zg84WxySIS97nfeQIg==
X-Received: by 2002:a05:6512:344c:b0:519:2828:c284 with SMTP id
 2adb3069b0e04-5217ce42f3cmr3353348e87.65.1715258418996; 
 Thu, 09 May 2024 05:40:18 -0700 (PDT)
Received: from [192.168.0.101] ([84.69.19.168])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccfe1527sm24010745e9.44.2024.05.09.05.40.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 May 2024 05:40:18 -0700 (PDT)
Message-ID: <e39bcdd1-90e7-42f3-94a9-ea1af6b0d278@ursulin.net>
Date: Thu, 9 May 2024 13:40:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/5] Discussion around eviction improvements
Content-Language: en-GB
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Friedrich Vock <friedrich.vock@gmx.de>
References: <20240508180946.96863-1-tursulin@igalia.com>
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20240508180946.96863-1-tursulin@igalia.com>
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


On 08/05/2024 19:09, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> Last few days I was looking at the situation with VRAM over subscription, what
> happens versus what perhaps should happen. Browsing through the driver and
> running some simple experiments.
> 
> I ended up with this patch series which, as a disclaimer, may be completely
> wrong but as I found some suspicious things, to me at least, I thought it was a
> good point to stop and request some comments.
> 
> To perhaps summarise what are the main issues I think I found:
> 
>   * Migration rate limiting does not bother knowing if actual migration happened
>     and so can over-account and unfairly penalise.
> 
>   * Migration rate limiting does not even work, at least not for the common case
>     where userspace configures VRAM+GTT. It thinks it can stop migration attempts
>     by playing with bo->allowed_domains vs bo->preferred domains but, both from
>     the code, and from empirical experiments, I see that not working at all. Both
>     masks are identical so fiddling with them achieves nothing.
> 
>   * Idea of the fallback placement only works when VRAM has free space. As soon
>     as it does not, ttm_resource_compatible is happy to leave the buffers in the
>     secondary placement forever.
> 
>   * Driver thinks it will be re-validating evicted buffers on the next submission
>     but it does not for the very common case of VRAM+GTT because it only checks
>     if current placement is *none* of the preferred placements.
> 
> All those problems are addressed in individual patches.
> 
> End result of this series appears to be driver which will try harder to move
> buffers back into VRAM, but will be (more) correctly throttled in doing so by
> the existing rate limiting logic.
> 
> I have run a quick benchmark of Cyberpunk 2077 and cannot say that I saw a
> change but that could be a good thing too. At least I did not break anything,
> perhaps.. On one occassion I did see the rate limiting logic get confused while
> for a period of few minutes it went to a mode where it was constantly giving a
> high migration budget. But that recovered itself when I switched clients and did
> not come back so I don't know. If there is something wrong there I don't think
> it would be caused by any patches in this series.

Since yesterday I also briefly tested with Far Cry New Dawn. One run 
each so possibly doesn't mean anything apart that there isn't a 
regression aka migration throttling is keeping things at bay even with 
increased requests to migrate things back to VRAM:
			
		     before		 after
min/avg/max fps	    36/44/54		37/45/55

Cyberpunk 2077 from yesterday was similarly close:

		26.96/29.59/30.40	29.70/30.00/30.32

I guess the real story is proper DGPU where misplaced buffers have a 
real cost.

Regards,

Tvrtko

> Series is probably rough but should be good enough for dicsussion. I am curious
> to hear if I identified at least something correctly as a real problem.
> 
> It would also be good to hear what are the suggested games to check and see
> whether there is any improvement.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Friedrich Vock <friedrich.vock@gmx.de>
> 
> Tvrtko Ursulin (5):
>    drm/amdgpu: Fix migration rate limiting accounting
>    drm/amdgpu: Actually respect buffer migration budget
>    drm/ttm: Add preferred placement flag
>    drm/amdgpu: Use preferred placement for VRAM+GTT
>    drm/amdgpu: Re-validate evicted buffers
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     | 38 +++++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  8 +++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 21 ++++++++++--
>   drivers/gpu/drm/ttm/ttm_resource.c         | 13 +++++---
>   include/drm/ttm/ttm_placement.h            |  3 ++
>   5 files changed, 65 insertions(+), 18 deletions(-)
> 
