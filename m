Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2927BC369BD
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 13:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99CD010E946;
	Wed, 16 Apr 2025 13:53:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="crjCsjns";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A29710E938
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 13:53:49 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so62843165e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 06:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744811628; x=1745416428; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OcEpsOQ46JdrbW+SpJzc244u7GopEbbRNbfDIbtlEdw=;
 b=crjCsjns5hyyrnd6FMLBORoCFfUMadC0zAzaJj+LqYQdqF2X3konKA/v4baRYtUM6x
 sCD9b7x8uEKGIU0p3ZTzrJfmElg2RCer8Hj07iejbxn6QDRtcsjWd8huDYnywiJTKEJv
 B9h4hIHRJRj4q7oqLqWglhffykhcUHpnR/I2ThFozeOTElnXmuXdQdbgYqM3XrW9+DKE
 lilfub8Z9JHJ8vtUfI+llRQK2K9EjyLoA82nDKZ1aR3mhPUkOwPMZljJc6GLZoLIXdCM
 g6Egsd43b0wPKg2pDTUgY06bTA4DGhKfLZdi+P5EjODc04vwMWWm1V7bilEaWEdNYG+e
 P6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744811628; x=1745416428;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OcEpsOQ46JdrbW+SpJzc244u7GopEbbRNbfDIbtlEdw=;
 b=aqQz6ArHFgHaXV7/7VXV3+T+MukXrlhSm2z69TPnTzxasn20SQptQnvn/2VxODWycV
 ULVAKTFy6ljXbqVdaiJdEPIenA7HB69lWAFTaIA7jXdtgYql52w0bPtv2mM7h0iH1OQ2
 oWy6+tCYmRGpd2vvLTJEJAS4utp+W6HU5AB3FJ3HvGZNNVz18zfNJJE00TIJiX2l71uz
 bFWHZdqLfLCsPVOO0zSb8CjIXxQhbqV2KfLVd7cZdgP90WwOWfKwlWxKtFe6tsciaVcU
 4G+AvUrjS7Vf5NFStrUAhT6/DPh9fDb21I58ixli3fMslzjenGQXKtOLLxLNTv9e1rKN
 x8Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2cnqxb5iRLLo+oQ+PmHLMy1MkRdFgz/MV8gtTSdW3Ek7mUDJdA4luWnk+TOK3p/1xEzObZiGm@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRjBWCRwVA2jobGp+mZlCFlbTH4n8bzso5/lXqkpAoQxCB8Zne
 U5Sz4Ql/Z7s7hgJsBhI+tSWfdoVttHfOyq6jwqAPfeqMpTEBSsHfISa89kBV
X-Gm-Gg: ASbGncuvb8tKH2a1spKXW73olRIwg4aL3vSIue0jgN3FO2JBxB7262URf5gsLYb9Y0c
 BYm7Clw3m1HFpZvUIn8oxudDy/V5KmAX1vCFw1lzhGmckMdJCtcwx/6j8mcAegASHZODGF796Yb
 H0X2LP6EJtBV8f385mH51sC0k+CF5gKKTFJZ+moHr0qxeew2dwN6SDzFvphEmI/0Xe3YZ9Qefay
 UnGn1MXYgcR7zrlJQ/AfjZ8KLneeMFX6xoOM+AuGmTHrvF4lkLaPkbUOhrK5yeFnNLoeH4QDU3X
 mK+0BZl3EijbOleZ0uaFkmlkCF6pda38H9l1TpTTqpvFZ2h4e+REkoGukDTkhzFjE8HQOA==
X-Google-Smtp-Source: AGHT+IHUuq794s/gU/3WsQSJUKjRqwHaBISAh1FfaThOGD7PLm1rr+PFUJKQ9K6KdIYNOTL7PKCLEg==
X-Received: by 2002:a5d:5f82:0:b0:39c:e0e:bb46 with SMTP id
 ffacd0b85a97d-39ee5b1340amr1954397f8f.4.1744811627860; 
 Wed, 16 Apr 2025 06:53:47 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae9797aasm17342066f8f.56.2025.04.16.06.53.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 06:53:47 -0700 (PDT)
Message-ID: <2f6250a4-0bd5-4433-afa4-96dfa031942f@gmail.com>
Date: Wed, 16 Apr 2025 15:53:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] drm/amdgpu: fix sdma ring test fail when resume from
 hibernation
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, emily.deng@amd.com
References: <20250414104655.336497-1-guoqing.zhang@amd.com>
 <20250414104655.336497-6-guoqing.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20250414104655.336497-6-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
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

Am 14.04.25 um 12:46 schrieb Samuel Zhang:
> gart tlb may be staled when switch to a new gpu index. this cause gpu
> fetchs wrong data from gtt memory. Flush gart tlb at the end of gmc
> resume to fix it.

Well that's complete nonsense. When the TLB contains entries after a resume than that is a major bug in the hypervisor.

Christian.

>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> Change-Id: If2a3780319f5ecf3dcb0f1c07f85151ed65f522d
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 73ac05b9a1bf..0e7957b4389a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2543,7 +2543,7 @@ static int gmc_v9_0_resume(struct amdgpu_ip_block *ip_block)
>  		return r;
>  
>  	amdgpu_vmid_reset_all(ip_block->adev);
> -
> +	amdgpu_gart_invalidate_tlb(adev);
>  	return 0;
>  }
>  

