Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85208C3DA63
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jul 2024 07:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEC9589264;
	Wed, 24 Jul 2024 07:12:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e4rk/247";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1826D89264
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 07:12:24 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-368440b073bso323550f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 00:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721805143; x=1722409943; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jKoTIAT9CFpwvs3TsZrde4uPECTfWP17StYCRHF9d4o=;
 b=e4rk/247vuWr40+IpqhaRb8mJjJwNN/Lfw5BAEWvEm3qneVNcI5d06LAbw1lvWT0vP
 +yrHDM5cdjjn4AZjSvaaVoZEwtYyMLQonjPliOmo+qZwxExOrRvVzCaQNMCBf52CD4sy
 UzYNiyULM2eEnYKrvvD7C5tNKMDgKrBS6DPzC8lE/APhADe5mEzfMqVMFWSr5xXIoSR4
 WjURMQrqbk9RIhe2PTpPXUppDzaquNEAXNCgFpwHiBEodl7METYm3D8P17kY+qx7QzPE
 leZnysuivFU0wHKYZIwi8C10cIc6VcbqPqyhNnJ35IPs83Zu97dKBu5lJWep7QdG48hs
 6ggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721805143; x=1722409943;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jKoTIAT9CFpwvs3TsZrde4uPECTfWP17StYCRHF9d4o=;
 b=NWy9Q/d0HL8u2SNSPL5gEJ1aTVsBiu4tWIYPm++EfLjv3ehyLwvRTkhZUdCJXXjyx1
 zyt/MixCq/38lYRfhXpB0BLBjeQhwozhxKTNP4uomAx1PiycNCdM0snO+5uutFbZqrzd
 rYKTJOfxV9A0OSv0tGg11vTB9fzTCJnKUcmv9WL++/Dp3gnHaMsGpMcKlZj7JUry0Vc3
 CdG3ZuAf8AFGAnwEul1875FX7uKFHUv8Vc0ogThEcgwIhe8GViRGqo/KBDhWXGjhq6Kl
 KsS6eMq9ISZuReyq+TyBZfQUMFMPgI01MYgGMd+o1asyDcZFDyPgsveW3u3sA0gO+xSD
 fhMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCYZRtpztHG3NpkeFsY/r7BmhA/01Qh4Ng3wl0WJ1a5F2my1O6dO0NiODwxtHR/8fVuUy4yvcyIRPPQOh0JOGUe6dLXUP92KR5fR5QMg==
X-Gm-Message-State: AOJu0YwvOJ8THtImsVVcGOaaNfIIzMpxGNPa15Cwmz5pMV2qRvWk+eiS
 4GTeP1cIfQaCPzxjzrXXDbuUB5hEThXwPV1NwbaqWgrEbOvSITF1
X-Google-Smtp-Source: AGHT+IGb/g7Yx/cbDK93xNF4384yOUdwEIEhw1xxk2YB28JOEr8+gZH88oIfh2pDgz+oFdGrLWAuwg==
X-Received: by 2002:adf:ce0b:0:b0:362:69b3:8e4d with SMTP id
 ffacd0b85a97d-369f66f08cdmr595270f8f.25.1721805142467; 
 Wed, 24 Jul 2024 00:12:22 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868eb2esm13409252f8f.48.2024.07.24.00.12.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 00:12:22 -0700 (PDT)
Message-ID: <132a70e6-6e78-47de-82ac-c00d0964daef@gmail.com>
Date: Wed, 24 Jul 2024 09:12:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu: allow setting contiguous on non-kernel bos for
 placement
To: Dave Airlie <airlied@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20240724070204.1862904-1-airlied@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240724070204.1862904-1-airlied@gmail.com>
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

Am 24.07.24 um 09:02 schrieb Dave Airlie:
> From: Dave Airlie <airlied@redhat.com>
>
> This is a partial revert of drm/amdgpu: Modify the contiguous flags behaviour.
>
> This broke VCN AV1 decoding on radv video on GFX11.
>
> On VCN4 only the first VCN block has AV1 decode support, so the kernel has
> a hacky heurisitic to work out from the submitted IB if it's AV1.
> YOU COULD HAVE PUT A FLAG ON THE BO SUBMISSION YOU KNOW!.

And we intentionally didn't do that.

> Now in order to access the submitted IB, it has to mark it as contiguous,
> so the ioremap can work on it so the kernel can access the contents.

Stop, something is wrong here. We should be able to kmap non-contiguous BOs.

> However this buffer isn't a kernel buffer, so the new check introduced
> in the above commit, breaks the whole show. I'm not sure why vaapi
> manages to avoid this fate, but it does somehow. Anyways this restores
> the behaviour from before.

And breaks other places, so that is really not something we can do.

Regards,
Christian.

>
> Fixes: 143c51da8dba ("drm/amdgpu: Modify the contiguous flags behaviour")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 706345ea1430..b3ee952f68d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -153,8 +153,7 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>   		else
>   			places[c].flags |= TTM_PL_FLAG_TOPDOWN;
>   
> -		if (abo->tbo.type == ttm_bo_type_kernel &&
> -		    flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
> +		if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
>   			places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
>   
>   		c++;

