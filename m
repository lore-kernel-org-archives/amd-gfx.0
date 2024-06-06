Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244CCC25B75
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 07:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B477510E1AA;
	Thu,  6 Jun 2024 07:14:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KwAZ8Tgz";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8537910E1AA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 07:14:09 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-35dc04717a1so448415f8f.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Jun 2024 00:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717658047; x=1718262847; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WfypkI0pzT42yS2Q9g7SCsGGaWy8S15KlVB/w9dfYWk=;
 b=KwAZ8TgzX//yD6oH8AkJ/49ZU4dNpZn6TOMAMXZCPV+fs7tZNkXR/8pNVp10RSVv6l
 2CGcoDD91Tjra4eAACPZA9hSp58cb9gjAy31vwjuh3wkAdoOW/YLQd9P9h84HCbw7SRR
 gTU/wuKpBKNLOAMZWDyIxEMRV6RuyUzukXOoM5ZuWXHE3xCdp/B/bzQZYuEcwJjNj9R3
 MuJjSnFbaWDmFENTi2O4S47MjlUohkV5Q4onQ5CyH0nFhcYju0KjUsscM8spkw6oao+3
 cYeDfby2amNB3VNgP/f59P5VJL4qHT4ThcbXA+5iCbLoF5JipVvA54Z/EwsluuDteBp8
 TpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717658047; x=1718262847;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WfypkI0pzT42yS2Q9g7SCsGGaWy8S15KlVB/w9dfYWk=;
 b=oWjotn05R5iIATZj2o70b2+tZza+Elw0VOQBN1wkG+VqBfLFxuVkdLP2Q4b8f/DPK2
 IiVJi8dS+3w1QRc486ltkGLvobeq12vUKqS2aJXQn4wt+902R0IHpnrDBIs1vTXWB4lF
 ETV5rrsClsB6D5eJO9+73/y+oSOAL9Tz+OjEa6LNxJ4QHszOEqePZ0qIGDeQhG9sgtas
 Ui/YjGRs/aYkI2Akyr/Nzx+Nm1cZt9O3XwGH0TIEjlgWs+vixpsS72Nlh2hVJiFSB32H
 eeL59Gln+tl9q+HHavJdHpZ9A2gVL7+6ykL+aF7DFS7yUjYa7tsz1XH/RDgJD+Y2jhmS
 Kspg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbMi7xpEC3Kz/mDoR8wG4h9SRs8wcTpYiry4Ujsc7xASwg49sLBAhEuR2dI0p5o6KvcROe0EOFKRUsJD2A3G4ImBYmef+siyxUTEo8LA==
X-Gm-Message-State: AOJu0YwB9NIg6yyI9+0afwZrvPzA2Z2uRMYLiTfY5RDLHgTNKOQjDvdx
 bq5J1lXLOs3Zln3YFATVn3wdDQXB2tAN9SKUlcQl5PjYuht/945xvYaOg2dG
X-Google-Smtp-Source: AGHT+IHmPozTJ7PbxDt9kEQrmLdkyiO5IGC78z+BqzOHayQEj2JRz6ABit6NSLYmfLYTCbTdeHnopQ==
X-Received: by 2002:a05:6000:b82:b0:354:f474:6f68 with SMTP id
 ffacd0b85a97d-35e8ef8fe88mr4023943f8f.54.1717658047295; 
 Thu, 06 Jun 2024 00:14:07 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5d29abdsm766036f8f.20.2024.06.06.00.14.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 00:14:06 -0700 (PDT)
Message-ID: <28e46920-df2b-4b0b-b67c-b3750195f2d7@gmail.com>
Date: Thu, 6 Jun 2024 09:14:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] amdgpu: don't dereference a NULL resource in sysfs
 code
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20240603084729.15135-1-pierre-eric.pelloux-prayer@amd.com>
 <20240603084729.15135-2-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240603084729.15135-2-pierre-eric.pelloux-prayer@amd.com>
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

Am 03.06.24 um 10:46 schrieb Pierre-Eric Pelloux-Prayer:
> dma_resv_trylock being successful doesn't guarantee that bo->tbo.base.resv
> is not NULL, so check its validity before using it.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Please make sure that checkpatch doesn't complain about anything.

With that done the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 63 +++++++++++-----------
>   1 file changed, 33 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 1eadcad1856d..6faeb9e4a572 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1594,36 +1594,39 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
>   	u64 size;
>   
>   	if (dma_resv_trylock(bo->tbo.base.resv)) {
> -
> -		switch (bo->tbo.resource->mem_type) {
> -		case TTM_PL_VRAM:
> -			if (amdgpu_res_cpu_visible(adev, bo->tbo.resource))
> -				placement = "VRAM VISIBLE";
> -			else
> -				placement = "VRAM";
> -			break;
> -		case TTM_PL_TT:
> -			placement = "GTT";
> -			break;
> -		case AMDGPU_PL_GDS:
> -			placement = "GDS";
> -			break;
> -		case AMDGPU_PL_GWS:
> -			placement = "GWS";
> -			break;
> -		case AMDGPU_PL_OA:
> -			placement = "OA";
> -			break;
> -		case AMDGPU_PL_PREEMPT:
> -			placement = "PREEMPTIBLE";
> -			break;
> -		case AMDGPU_PL_DOORBELL:
> -			placement = "DOORBELL";
> -			break;
> -		case TTM_PL_SYSTEM:
> -		default:
> -			placement = "CPU";
> -			break;
> +		if (!bo->tbo.resource) {
> +			placement = "NONE";
> +		} else {
> +			switch (bo->tbo.resource->mem_type) {
> +			case TTM_PL_VRAM:
> +				if (amdgpu_res_cpu_visible(adev, bo->tbo.resource))
> +					placement = "VRAM VISIBLE";
> +				else
> +					placement = "VRAM";
> +				break;
> +			case TTM_PL_TT:
> +				placement = "GTT";
> +				break;
> +			case AMDGPU_PL_GDS:
> +				placement = "GDS";
> +				break;
> +			case AMDGPU_PL_GWS:
> +				placement = "GWS";
> +				break;
> +			case AMDGPU_PL_OA:
> +				placement = "OA";
> +				break;
> +			case AMDGPU_PL_PREEMPT:
> +				placement = "PREEMPTIBLE";
> +				break;
> +			case AMDGPU_PL_DOORBELL:
> +				placement = "DOORBELL";
> +				break;
> +			case TTM_PL_SYSTEM:
> +			default:
> +				placement = "CPU";
> +				break;
> +			}
>   		}
>   		dma_resv_unlock(bo->tbo.base.resv);
>   	} else {

