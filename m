Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BBFC2D0DB
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 19:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4E8020674
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 19:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYcAfKYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E8020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 747176F3CE;
	Tue, 28 Jan 2020 19:59:08 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C19266F3CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 19:59:06 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id k11so2841702wrd.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 11:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=dQVJxYZbSY9XRrXxG5o58HebUqZ+3xMGqbYCTgWWodM=;
 b=iYcAfKYpKQjIme43ES20dOA6n112tze2erfL2ojqcPSiPIMFfYw/RId/Y/CsbE/4BB
 eUdQrMl2FXNk6WGFvcM5cAlbk1ehw3x2hFy8ojtIDXq88t3OR7frW5AnZHLhT3cJh5iE
 cJP50U6TlmDK1g39pZ1B+a9xQP+r2O3qUcDTSxRPv+kGXoLH9ByesCSbjvI6AdYodzhn
 e71BoOrNRKi3h5WypkkojKK1Qq2gp2x2MoEXUZIuytz+dvlFEF1HLqa81IbL+QS61zqq
 9yRP5DmzabX0jOHfKGYcQ8iZopCv4Pv+Jgo2n0awA0nehi0AENe/FrkbSRvSG+9rPLmR
 e7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=dQVJxYZbSY9XRrXxG5o58HebUqZ+3xMGqbYCTgWWodM=;
 b=UctaaJ/XuqWCL4WPfjYbDD8gOjdZfiKJF7SHRuTqnGSoArJOVWmgcaPzh42rL83TV8
 j+rzY0ufiOH3ObXAS4hxoIqjETfCeMm9xx5EerYEBO4KU5ynyf6/nFhQunf7deEKXN1x
 stOE7XR5RuZ80XkVR+sUsn0eFeDM+jVg4HreaOvtZMF+AUUDI31ARuyGuLZ63ihtaTqz
 ZSZ7++qtQZF88oRJZEqaLE5RAZX/2Sf5/w+KjJgJKORxe44YlEzWWEN9ULa28dpljxQJ
 zcZOVdZ0BB8G/L+KrRkOx+XEkmrZhMF9HtcYBDqY5fdl3ISdjyjHca5STNApCvX+Yh4x
 9avA==
X-Gm-Message-State: APjAAAWu2ZHkmo3t9cyUBzMJAbFiqwORJDy61hQcG3LlT98kZ+bvA5cw
 YUKYbSokH9tQfEgKrqB31czss/oP
X-Google-Smtp-Source: APXvYqyhVDXjJoo47PN0mmx80TScoJfcx7RL9mIwvN/PDcPYjET+GmJWt+M6U6EDoxShoXu4wtD+hA==
X-Received: by 2002:adf:b60f:: with SMTP id f15mr31741115wre.372.1580241545285; 
 Tue, 28 Jan 2020 11:59:05 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id e18sm26217397wrw.70.2020.01.28.11.59.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 28 Jan 2020 11:59:04 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: correct vram mgr node size calculation
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200128195543.8286-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <fc39545c-7372-480d-2961-f8b899404a83@gmail.com>
Date: Tue, 28 Jan 2020 20:59:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200128195543.8286-1-Philip.Yang@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 28.01.20 um 20:55 schrieb Philip Yang:
> Use pages_per_node instead of mem->num_pages to alloc vram, this will
> increase the chance to get vram node after vram fragments.

NAK, this is intentional to aid TLB with continuous allocations.

The fallback to using pages_per_node is directly below, so your patch 
should be completely superfluous.

Regards,
Christian.

>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 82a3299e53c0..67a454f4c37a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -369,7 +369,7 @@ static int amdgpu_vram_mgr_new(struct ttm_mem_type_manager *man,
>   
>   	spin_lock(&mgr->lock);
>   	for (i = 0; pages_left >= pages_per_node; ++i) {
> -		unsigned long pages = rounddown_pow_of_two(pages_left);
> +		unsigned long pages = rounddown_pow_of_two(pages_per_node);
>   
>   		r = drm_mm_insert_node_in_range(mm, &nodes[i], pages,
>   						pages_per_node, 0,
> @@ -383,15 +383,11 @@ static int amdgpu_vram_mgr_new(struct ttm_mem_type_manager *man,
>   		pages_left -= pages;
>   	}
>   
> -	for (; pages_left; ++i) {
> -		unsigned long pages = min(pages_left, pages_per_node);
> +	if (pages_left) {
>   		uint32_t alignment = mem->page_alignment;
>   
> -		if (pages == pages_per_node)
> -			alignment = pages_per_node;
> -
>   		r = drm_mm_insert_node_in_range(mm, &nodes[i],
> -						pages, alignment, 0,
> +						pages_left, alignment, 0,
>   						place->fpfn, lpfn,
>   						mode);
>   		if (unlikely(r))
> @@ -399,7 +395,6 @@ static int amdgpu_vram_mgr_new(struct ttm_mem_type_manager *man,
>   
>   		vis_usage += amdgpu_vram_mgr_vis_size(adev, &nodes[i]);
>   		amdgpu_vram_mgr_virt_start(mem, &nodes[i]);
> -		pages_left -= pages;
>   	}
>   	spin_unlock(&mgr->lock);
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
