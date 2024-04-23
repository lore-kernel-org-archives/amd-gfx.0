Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB49C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 06:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E96710FACC;
	Tue, 23 Apr 2024 06:15:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BUx4cgAP";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16C9910FAC9
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 06:15:35 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4187c47405aso35334685e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 23:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713852933; x=1714457733; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GwFsc1lZizcJQMbg6DYMhQqtko9nysXVJasTdPi6uxw=;
 b=BUx4cgAPAiS0zmVRQOnCbAIfLe9Zf5OEglg5cbAO7G6mg4hHRB11uHWTIoNFr0dLYX
 Jid7OBpjDqygr8DvG2mLoW4zcttnecJ5wtubTfV28qmJZnXVeXQKfgErxqZUmPmM4w/V
 lzuCqvfYBuwgD7YR9nXcH5pH79MURAr6NFiz448k/6uJ2ystG8ni7WFHr2NdWOFcqyAi
 QzsSAkqq8S3cMC+ZJ2mA2OBxJlbAq7ptOOEZ95MkUQ14MNiJHzikp3OoV9IDjDSlrXdA
 SypnHvoGLPzhxK3aYF3SWdJxPojqV4gevvkUhF1yvXSkbWGekIo2QODLWdkWyoSMKj/J
 bQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713852933; x=1714457733;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GwFsc1lZizcJQMbg6DYMhQqtko9nysXVJasTdPi6uxw=;
 b=vX96ynsyaa0GEex/qyW9N0dC6H7t++Ma4PVhRgTXHEsNFz4igK90H70AGk5TUx8RbW
 CBbjE8l00hLCVnFKspo5qjcYK+LhmKifgT71oXNR1iZRWoLckR/5apyBvJrZZXsQ1ex8
 XDIziyN8PWLMVJoXOMcilthRBUOFwlLRYF0ZO+57EF47KB5AL3trrTYZtODPmwjMO0ip
 Scti0g7vr2DTLWifzrHbUy6f9QcA6RZ4ZWN8KZy5B4z1gQndbA/cfGJoq6GORErQKqy8
 hYC5NvGPdGywfT2tHUd8PibIFODn3au7GSDKW0I2RuV93k1UTNHLQRfwX/9BOrkDry7Z
 NI0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjYCU0agG+ZG8ekZojfLHupW74KExG5EW9quv5K/VfeeLUDMyWYxM3TLNK8WMRebiHLNOANlwF3eRs0bWzDNUs/ZPPTYANy8p0v2SWDg==
X-Gm-Message-State: AOJu0Yy+YAWwYV31ZOVMW/jVx4Um8wO6IOA6DFqK6V2bfDzKOEloNXSc
 heivD8P0qP1gLAT3/bNswvUlExnP3NUGRRoBYcZnooZTxSK6u3GdwCHaD0fn
X-Google-Smtp-Source: AGHT+IH6Sq9YkC8s0JzcrLlKq9gPSU6ShhjJ89YdnSTjBmc+SW4hAeIXni3QtiNarGVelceMU/88YQ==
X-Received: by 2002:a05:600c:3486:b0:41a:b56c:2929 with SMTP id
 a6-20020a05600c348600b0041ab56c2929mr683372wmq.34.1713852933119; 
 Mon, 22 Apr 2024 23:15:33 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 r15-20020a05600c458f00b0041ac56fd580sm465965wmo.31.2024.04.22.23.15.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 23:15:32 -0700 (PDT)
Message-ID: <47af9b3f-0363-4b7b-9a4b-6f1dbb092837@gmail.com>
Date: Tue, 23 Apr 2024 08:15:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: IB test encode test package change for VCN5
To: Sonny Jiang <sonny.jiang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sonny Jiang <sonjiang@amd.com>
References: <20240422195930.2429417-1-sonny.jiang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240422195930.2429417-1-sonny.jiang@amd.com>
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

Am 22.04.24 um 21:59 schrieb Sonny Jiang:
> From: Sonny Jiang <sonjiang@amd.com>
>
> VCN5 session info package interface changed
>
> Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>

Mhm, in general we should push back on FW changes which makes stuff like 
that necessary. So what is the justification?

If the FW has a good justification for it then in theory we should 
create new hw generation specific functions. But copying the whole 
function for vcn_v5_0.c is overkill as well.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index bb85772b1374..2bebdaaff533 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -851,6 +851,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>   					 struct amdgpu_ib *ib_msg,
>   					 struct dma_fence **fence)
>   {
> +	struct amdgpu_device *adev = ring->adev;
>   	unsigned int ib_size_dw = 16;
>   	struct amdgpu_job *job;
>   	struct amdgpu_ib *ib;
> @@ -882,7 +883,10 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>   	ib->ptr[ib->length_dw++] = handle;
>   	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
>   	ib->ptr[ib->length_dw++] = addr;
> -	ib->ptr[ib->length_dw++] = 0x0000000b;
> +	if (amdgpu_ip_version(adev, UVD_HWIP, 0) < IP_VERSION(5, 0, 0))
> +		ib->ptr[ib->length_dw++] = 0x0000000b;
> +	else
> +		ib->ptr[ib->length_dw++] = 0x00000000;
>   
>   	ib->ptr[ib->length_dw++] = 0x00000014;
>   	ib->ptr[ib->length_dw++] = 0x00000002; /* task info */
> @@ -918,6 +922,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   					  struct amdgpu_ib *ib_msg,
>   					  struct dma_fence **fence)
>   {
> +	struct amdgpu_device *adev = ring->adev;
>   	unsigned int ib_size_dw = 16;
>   	struct amdgpu_job *job;
>   	struct amdgpu_ib *ib;
> @@ -949,7 +954,10 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   	ib->ptr[ib->length_dw++] = handle;
>   	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
>   	ib->ptr[ib->length_dw++] = addr;
> -	ib->ptr[ib->length_dw++] = 0x0000000b;
> +	if (amdgpu_ip_version(adev, UVD_HWIP, 0) < IP_VERSION(5, 0, 0))
> +		ib->ptr[ib->length_dw++] = 0x0000000b;
> +	else
> +		ib->ptr[ib->length_dw++] = 0x00000000;
>   
>   	ib->ptr[ib->length_dw++] = 0x00000014;
>   	ib->ptr[ib->length_dw++] = 0x00000002;

