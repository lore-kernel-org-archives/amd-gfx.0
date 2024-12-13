Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A63E7717D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 10:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F1A110EF8E;
	Fri, 13 Dec 2024 10:09:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m75gWdgf";
	dkim-atps=neutral
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92CF610EF8E
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 10:09:46 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3862b364538so887210f8f.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 02:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734084585; x=1734689385; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dacGTdAVyDdao17ZX+iskHgLsX0DD3Y/nhcB3prIE/c=;
 b=m75gWdgflIO1axMEyYtfGahL9FoJUQea5x0aa2jgdHzsuAlE7CO2kih3bM8lQ3318P
 uQBd7YgeB+YYTq4IRoXuB9nhTU5q+YIfSeDopLT1zGrLKHp0U2WfL3A/rOKXbEksaFzX
 Y8oJa9fX5AN73qx1uB5tTq+lEj0s4IC1wOeUcodFhsaNl98EDrURzo7m6JZpI7dJUeT1
 0esE2MMFvwREHgTnQSO8gkZcRw8HzzZkVYaoSdgVVH5LlLhab1Pc5SFMjXsP1zGwUQHy
 4gy+6Guh7rxsczNiS8gCEGp1EksruAt7szmAwjYoXDMWQi0eTCZi/gYdTbMg11JP5Oo2
 Ic9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734084585; x=1734689385;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dacGTdAVyDdao17ZX+iskHgLsX0DD3Y/nhcB3prIE/c=;
 b=crb2zbw6Efz/XBeQ6rLtuJEPVzyIrF74Km+xZWK8Cb/2hW5dS3vj4UK4AXGjpMAs1E
 q2YVgqvFiAj4epzzfbn3cA60n4bmjqVgqGwnm5WjYZwRVlGRDu39Eph6bZEB8yAskJSc
 eU07CI+LasVPWK/eoETjuNm1XbJJMbMJR6B4XkpBl8z+ZJgGYqSqPTtDrfzr3Obve5XF
 UTgirFInWkOwTe0WbUxi/nh0ciHivXwycI/RkDB4QUtok/KEZ+oMr0ptmH8Yem9qobcS
 sYvEzj6Df/8Yd5UtpKinKcqcK2I578QOavXRA0FkhuGK0Q+v+r+/COW7Tkt3oVoGzHgJ
 E0Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/dxFRbV3N+OUpPVIxBLUjWcxtquTXu5bK/0CXl7FxABVSgu+/ukdpX+dT2gjZKo+ByP/X+doM@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxvWuU1dKGeaTckfoKoupoTl6tFcA07GawZ4dJvvCUNwpW7dk3D
 DSabO1Gnq/TLW/8w8G5ETbuembqvlBbwytoc9N4JtE7yQh38uV6w
X-Gm-Gg: ASbGncvBEtF7JgJ1d8DUuSTZR8PQVIdWBAoudE+gopvw99ZlwDB18dv1VxdCH/46b82
 KthisXG2wdH1IPssY7KK/kI5j+wWlLNXbScZeFGHU11SZuzd5dUezfuOAs/f0WFHs59kAdaBMT+
 R2YNVuaPBFLHpRSkH28GxZCRdjAVUO/PEldO6a3HSlRFkhQRwgWjmGPIxoO/sZIeSvGwa6nfcfE
 YvHZvWkf4BMtAtBPS0Rv2GECnig8UlAKqdI9cTbSRF463RwJEfaS2MQPGl66OiuDp/RlpeTiZlH
 sOq4jYZy6g==
X-Google-Smtp-Source: AGHT+IGIp7tP2pNIHADHXFBlP92YUnBhZChLJyISsUfdXA+hQL+ySCuWaWWJgRmX/V3cpReCMtbjBA==
X-Received: by 2002:a5d:4249:0:b0:386:4a16:dadb with SMTP id
 ffacd0b85a97d-387887df18amr4190029f8f.11.1734084584086; 
 Fri, 13 Dec 2024 02:09:44 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362559f9b5sm45702085e9.26.2024.12.13.02.09.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 02:09:43 -0800 (PST)
Message-ID: <6a8fe245-9430-437b-97df-021b701e6a84@gmail.com>
Date: Fri, 13 Dec 2024 11:09:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] drm/amdgpu: Add mqd for userq compute queue
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com
References: <20241212142533.2164946-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20241212142533.2164946-1-Arunpravin.PaneerSelvam@amd.com>
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

Am 12.12.24 um 15:25 schrieb Arunpravin Paneer Selvam:
> Add mqd for userq compute queue for gfx11/gfx12
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 4 ++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c    | 4 ++++
>   drivers/gpu/drm/amd/include/v11_structs.h | 4 ++--
>   drivers/gpu/drm/amd/include/v12_structs.h | 4 ++--
>   4 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 67cd42031571..b9a672c51cba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4255,6 +4255,10 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
>   
>   	mqd->cp_hqd_active = prop->hqd_active;
>   
> +	/* set UQ fenceaddress */
> +	mqd->fence_address_lo = lower_32_bits(prop->fence_address);
> +	mqd->fence_address_hi = upper_32_bits(prop->fence_address);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index d0697b0869e3..8c0a4f3a4914 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -3177,6 +3177,10 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
>   
>   	mqd->cp_hqd_active = prop->hqd_active;
>   
> +	/* set UQ fenceaddress */
> +	mqd->fence_address_lo = lower_32_bits(prop->fence_address);
> +	mqd->fence_address_hi = upper_32_bits(prop->fence_address);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/include/v11_structs.h b/drivers/gpu/drm/amd/include/v11_structs.h
> index f6d4dab849eb..3728389fc3be 100644
> --- a/drivers/gpu/drm/amd/include/v11_structs.h
> +++ b/drivers/gpu/drm/amd/include/v11_structs.h
> @@ -1118,8 +1118,8 @@ struct v11_compute_mqd {
>   	uint32_t reserved_443; // offset: 443  (0x1BB)
>   	uint32_t reserved_444; // offset: 444  (0x1BC)
>   	uint32_t reserved_445; // offset: 445  (0x1BD)
> -	uint32_t reserved_446; // offset: 446  (0x1BE)
> -	uint32_t reserved_447; // offset: 447  (0x1BF)
> +	uint32_t fence_address_lo; // offset: 446  (0x1BE)
> +	uint32_t fence_address_hi; // offset: 447  (0x1BF)
>   	uint32_t gws_0_val; // offset: 448  (0x1C0)
>   	uint32_t gws_1_val; // offset: 449  (0x1C1)
>   	uint32_t gws_2_val; // offset: 450  (0x1C2)
> diff --git a/drivers/gpu/drm/amd/include/v12_structs.h b/drivers/gpu/drm/amd/include/v12_structs.h
> index 5787c8a51b7c..03a35f8a65b0 100644
> --- a/drivers/gpu/drm/amd/include/v12_structs.h
> +++ b/drivers/gpu/drm/amd/include/v12_structs.h
> @@ -1118,8 +1118,8 @@ struct v12_compute_mqd {
>       uint32_t reserved_443; // offset: 443  (0x1BB)
>       uint32_t reserved_444; // offset: 444  (0x1BC)
>       uint32_t reserved_445; // offset: 445  (0x1BD)
> -    uint32_t reserved_446; // offset: 446  (0x1BE)
> -    uint32_t reserved_447; // offset: 447  (0x1BF)
> +    uint32_t fence_address_lo; // offset: 446  (0x1BE)
> +    uint32_t fence_address_hi; // offset: 447  (0x1BF)
>       uint32_t gws_0_val; // offset: 448  (0x1C0)
>       uint32_t gws_1_val; // offset: 449  (0x1C1)
>       uint32_t gws_2_val; // offset: 450  (0x1C2)

