Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBADEC1EB9
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 14:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2BD110E8D3;
	Thu,  5 Feb 2026 14:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="vMLX5Cb/";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="txKYFXLc";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 096D110E8D3
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 14:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1770301102;
 bh=njEARJ0yAn1ZTzgJLE3qQhL
 gcRiWNSt+GoyzsHDvWZg=; b=vMLX5Cb/fSULiC6pznsKOCVqGMyRQEKfzA2Qbj8aPcqwmrTJvS
 VIge5/E3WCwkxYxX/YkKiRFNZK69GjrpIErUl3ADE7wZar3K19nAghj22ozH2DwAFloDaLduMEd
 gLMd6hHx5cQdxMu3pIb8VthhIb0DONOlQIoJrAO43xHfl2n82oaXkMqQYXslLL8wStAL2OYQhCo
 ydMC0TUWHP/9TudNBANbSjGQBcw4Db25kdej30iwxEy1PbeVlo9KRHlQv4jdgbqnStOllo8CM8J
 Tyb41+cKznAVT6K3U82zDO8x49orpkUamDV1QyMXKUugpE6FH8o1BrWzNR6scsQYQWg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1770301102; bh=njEARJ0yAn1ZTzgJLE3qQhL
 gcRiWNSt+GoyzsHDvWZg=; b=txKYFXLc0MvmCYcFJXX8U1lhtYPJ2qF1dO6BPpui9X9xq/5k+q
 LXcwKJCpBTBovwsIy+fA+SQ9CUjlyXBmjgCw==;
Message-ID: <2785460c-b070-440d-871b-bbed36222da1@damsy.net>
Date: Thu, 5 Feb 2026 15:18:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] drm/amdgpu: add a helper to calculate ring distance
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com
References: <20260130173042.15008-1-alexander.deucher@amd.com>
 <20260130173042.15008-12-alexander.deucher@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <20260130173042.15008-12-alexander.deucher@amd.com>
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



Le 30/01/2026 à 18:30, Alex Deucher a écrit :
> Add a helper to calculate the distance in DWs between
> two wptrs.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index ce095427611fb..e196ffbdd1f3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -523,6 +523,17 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
>   	ring->count_dw -= count_dw;
>   }
>   
> +static inline unsigned int amdgpu_ring_get_dw_distance(struct amdgpu_ring *ring,
> +						       u64 start_wptr, u64 end_wptr)
> +{
> +	unsigned int start = start_wptr & ring->buf_mask;
> +	unsigned int end = end_wptr & ring->buf_mask;
> +
> +	if (end < start)
> +		end += ring->ring_size >> 2;
> +	return end - start;
> +}
> +
>   /**
>    * amdgpu_ring_patch_cond_exec - patch dw count of conditional execute
>    * @ring: amdgpu_ring structure
> @@ -533,18 +544,13 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
>   static inline void amdgpu_ring_patch_cond_exec(struct amdgpu_ring *ring,
>   					       unsigned int offset)
>   {
> -	unsigned cur;
> -
>   	if (!ring->funcs->init_cond_exec)
>   		return;
>   
>   	WARN_ON(offset > ring->buf_mask);
>   	WARN_ON(ring->ring[offset] != 0);
>   
> -	cur = (ring->wptr - 1) & ring->buf_mask;
> -	if (cur < offset)
> -		cur += ring->ring_size >> 2;
> -	ring->ring[offset] = cur - offset;
> +	ring->ring[offset] = amdgpu_ring_get_dw_distance(ring, offset, ring->wptr - 1);
>   }
>   
>   int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
