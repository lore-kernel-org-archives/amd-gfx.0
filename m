Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58728D3000A
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 13:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F15C010E91F;
	Fri, 18 Oct 2024 13:39:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J+y+hv2D";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D48E410E91F
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 13:39:41 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-37d55f0cf85so1556150f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 06:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729258780; x=1729863580; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b3SApQvFVlbupOeVxBLgPfP4HsM74K5mns0tfrs8cpU=;
 b=J+y+hv2DOebIiX2zh1OxkKx/tAy0AOQSPx2qSBboSaOijOpmE9rlBDA47RCe5T69E7
 4Otb2reKa/U2YcuXicbBEJnnITen0uEncQu+rv8Q4HnTAFXIUFt3is3LtmUEFY/uXaaL
 SPrOq/ucskJ5M39IPuTlK6EViFww+vhRbh71fpZ683eCAw5fzKD6sWRfiUrbU9ejAKhw
 0xKO3IV4d+Iu/1j6NOdE72Kp7uUIE1xjcehtYL3sq9BchidrIUaiX5l6oQ4kJ9yI9/uF
 ht348eEnBLliC+BugHeGelwyC/PTw1vessmI29eD38/NpNt0YRjjOGZZqGX8eATQCeRK
 vYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729258780; x=1729863580;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b3SApQvFVlbupOeVxBLgPfP4HsM74K5mns0tfrs8cpU=;
 b=jHtD+k+G3oROHd+hh5CUiTkRKMOVnfaP5M8MCkmtx24Wn+IsoQtb1JdgR3CX9wpWoY
 yTw+Oe+7R5sND0ygVSd7AHHXkrNUg0F1x4kjXl3F5guU1SmBmHUirWe+oNY7R/cezWi5
 /i/R6i+8AbFmQaW6h5Xd4+nIe7WPbJ51qSxjVOZ+EFnSsgaKaCSQUfYAFGUAupIXZvTV
 Yj8a9uauu98QpF4IjBc1RLMefJ0DjmPyw0rKz6ObyKC9FLXhR+lejVtavJ2gkKg9IbHp
 4Okeks+d5zP3tdPZRQzSPi1umLMNmzTplm0/ORXAwNP2h0vINJ9bzphOjQB39Aqb+NkY
 v5UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbYRrdMz3ceicwYA0baZ2puXQsvpahEiWTrjDaYjhvTzKcFxan59pGIkiXaKVobH6qoTEtb4YA@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjrT16SUKiZgkXhW1e3NgTT1yKj7embOBWuRiaW/unqytH38wr
 hpVVIK1y8+3LyZEiPXmV6JvmHlNujYGRIwCQW2q6BdPHozhGrMph
X-Google-Smtp-Source: AGHT+IHFVx55/g8G0oJWzackK3HBkBh1E/IOIBTUWie7V6NeFgSzQ4xjn5Kj6T20k5SvteHy5oFixA==
X-Received: by 2002:adf:cd0c:0:b0:375:c4c7:c7ac with SMTP id
 ffacd0b85a97d-37eab710fbbmr1911114f8f.49.1729258779839; 
 Fri, 18 Oct 2024 06:39:39 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43160dc9791sm24325885e9.15.2024.10.18.06.39.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2024 06:39:39 -0700 (PDT)
Message-ID: <c7f38b09-133f-444b-897b-ab628c6ba51a@gmail.com>
Date: Fri, 18 Oct 2024 15:39:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add gpu_addr support to seq64 allocation
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com
Cc: alexander.deucher@amd.com
References: <20241018132629.190295-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20241018132629.190295-1-Arunpravin.PaneerSelvam@amd.com>
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

Am 18.10.24 um 15:26 schrieb Arunpravin Paneer Selvam:
> Add gpu address support to seq64 alloc function.

Looks good to me, but when adding interfaces you should probably have 
the user of this in the same patch set.

Regards,
Christian.

>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 10 ++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h |  3 ++-
>   2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> index e22cb2b5cd92..0defad71044c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -163,7 +163,8 @@ void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv)
>    * Returns:
>    * 0 on success or a negative error code on failure
>    */
> -int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va, u64 **cpu_addr)
> +int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va,
> +		       u64 *gpu_addr, u64 **cpu_addr)
>   {
>   	unsigned long bit_pos;
>   
> @@ -172,7 +173,12 @@ int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va, u64 **cpu_addr)
>   		return -ENOSPC;
>   
>   	__set_bit(bit_pos, adev->seq64.used);
> +
>   	*va = bit_pos * sizeof(u64) + amdgpu_seq64_get_va_base(adev);
> +
> +	if (gpu_addr)
> +		*gpu_addr = bit_pos * sizeof(u64) + adev->seq64.gpu_addr;
> +
>   	*cpu_addr = bit_pos + adev->seq64.cpu_base_addr;
>   
>   	return 0;
> @@ -233,7 +239,7 @@ int amdgpu_seq64_init(struct amdgpu_device *adev)
>   	 */
>   	r = amdgpu_bo_create_kernel(adev, AMDGPU_VA_RESERVED_SEQ64_SIZE,
>   				    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
> -				    &adev->seq64.sbo, NULL,
> +				    &adev->seq64.sbo, &adev->seq64.gpu_addr,
>   				    (void **)&adev->seq64.cpu_base_addr);
>   	if (r) {
>   		dev_warn(adev->dev, "(%d) create seq64 failed\n", r);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
> index 4203b2ab318d..26a249aaaee1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
> @@ -32,13 +32,14 @@
>   struct amdgpu_seq64 {
>   	struct amdgpu_bo *sbo;
>   	u32 num_sem;
> +	u64 gpu_addr;
>   	u64 *cpu_base_addr;
>   	DECLARE_BITMAP(used, AMDGPU_MAX_SEQ64_SLOTS);
>   };
>   
>   void amdgpu_seq64_fini(struct amdgpu_device *adev);
>   int amdgpu_seq64_init(struct amdgpu_device *adev);
> -int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *gpu_addr, u64 **cpu_addr);
> +int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va, u64 *gpu_addr, u64 **cpu_addr);
>   void amdgpu_seq64_free(struct amdgpu_device *adev, u64 gpu_addr);
>   int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		     struct amdgpu_bo_va **bo_va);

