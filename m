Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF58C3A5A7
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 07:15:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36E6D10E464;
	Thu,  8 Dec 2022 07:15:54 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F33910E464
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 07:15:51 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id z92so942068ede.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Dec 2022 23:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=re8Tfwq7hNxxMbsmrcdFmskJP7a0KUq37homQVC4VgM=;
 b=ZCacS/DS9I3xnlHFM4ybEeLGmCrppM5kQHvP/n/XAHMLcnlzrRN8tiDvs5CcGmy5u9
 HE43ZUuAu4cLW3WtkuPKj1j4K9KnG61PomiNrkya8LABEQ6IXtKGFeFC3NPzyQXn142u
 ODqXy4nz2FWHmd0kEh5FgS3uMFZNZQ3IxlJmS+iT0n77CwoL0fQjW104reBy472FYoye
 T7EqMooCROjVfzEmya1uRxkOQLK31iGHYb9I5JfCWylFIJi0i4sodTw2p6NUFH5rvb04
 KsBA+6FJ2nYTCni6wMogcJoNVRe8xbdeX3YrL18rrNI9vlVWbGnUR4E8FW3Zv+hvknwh
 g/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=re8Tfwq7hNxxMbsmrcdFmskJP7a0KUq37homQVC4VgM=;
 b=tRAoxPm3+iPQYG0p1mJLfL+ZzHkNJbenaI9TKAGjbR60FPnnutmmV70Jdz0AewgEZ+
 XQ356G3820YPYjFz1ciMO4+D53mTyxfZeHi4p91Ztq+zAAHOesD4Yjv8IWZ0ghbU+Ij5
 uKKMs+JVDW3Q4Ob/+bR57UqH6dXesda1UvsuJu8ZJTV/4nY7TeV1E9PfB0gS2lnM4d7B
 ecE282k+pP911zBgbBb5XzlbL2kmWjb5+c1R+HF5Lg1bLpt1pqksGiKqsZOygpzN+CR3
 mK3NYYaopXhumSMf4CoCsHs7vRxb/WWeLR+upOhrNQKR0Nx4AMtyALuOQZisK0PswKVw
 6fGw==
X-Gm-Message-State: ANoB5plIUJ0phiyCf3OFft1st9veD717I5qgM/03WjvINd6ORFXoRcqY
 D8xytaUB45RgpU/qpWCDpcs=
X-Google-Smtp-Source: AA0mqf66UQ/cPzm/scpei0ZADYxPk+i3Qn/No/6UkC2jCIlcsceXtouj3Bjet2g2w1EWeJOYYUDNMw==
X-Received: by 2002:aa7:d314:0:b0:46c:fc3f:cf8a with SMTP id
 p20-20020aa7d314000000b0046cfc3fcf8amr9930299edq.386.1670483749509; 
 Wed, 07 Dec 2022 23:15:49 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:172d:b6f5:d270:8dd2?
 ([2a02:908:1256:79a0:172d:b6f5:d270:8dd2])
 by smtp.gmail.com with ESMTPSA id
 6-20020a170906310600b00738795e7d9bsm9344018ejx.2.2022.12.07.23.15.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Dec 2022 23:15:48 -0800 (PST)
Message-ID: <cde12875-4708-3729-f673-5fd086811552@gmail.com>
Date: Thu, 8 Dec 2022 08:15:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: make display pinning more flexible (v2)
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221207162135.3290795-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221207162135.3290795-1-alexander.deucher@amd.com>
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

Am 07.12.22 um 17:21 schrieb Alex Deucher:
> Only apply the static threshold for Stoney and Carrizo.
> This hardware has certain requirements that don't allow
> mixing of GTT and VRAM.  Newer asics do not have these
> requirements so we should be able to be more flexible
> with where buffers end up.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 919bbea2e3ac..2df55cc7e07f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1506,7 +1506,8 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
>   uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
>   					    uint32_t domain)
>   {
> -	if (domain == (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) {
> +	if ((domain == (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) &&
> +	    ((adev->asic_type == CHIP_CARRIZO) || (adev->asic_type == CHIP_STONEY))) {
>   		domain = AMDGPU_GEM_DOMAIN_VRAM;
>   		if (adev->gmc.real_vram_size <= AMDGPU_SG_THRESHOLD)
>   			domain = AMDGPU_GEM_DOMAIN_GTT;

