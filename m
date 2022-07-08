Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17503C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 10:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B6641128B9;
	Fri,  8 Jul 2022 10:04:08 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9297A10FE59
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 10:04:07 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id j22so10600340ejs.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jul 2022 03:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=Q+M/aEMFbHDPQCkT8ZZv7U0Vo7/0Bkkjv66I4kWglmg=;
 b=SYDZeCcWFInN8+DmZMhsvCxjiBixCEwDmdy+gEUJIil3n/HCuO7zjRC+xBJCr9uq15
 UHZplYKG4UrcP9faNpQ2oBJdPBXkf42x++F3b8y2Bj/ZV35Vjbd5e6cAVk8q81PgH3dt
 VoxPEgO52mKsPs0En80HxRLEiQGa19kNYPfIT20IRsoal6vtYI/P1smXYkiOWf1FdUtG
 5qm6mO3qwhK+OKc5hZjGsgE5ETFogxRMUhU1LJSoap1SaXcvPxAvaDDGh23H8SVmT+zP
 Ko0enzn/1k7/SoEXPwcLVxmUYk6SLAVNqxWTgEI6MyeNsA23q+mzIdZFKWfFqc+wP4hX
 wRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Q+M/aEMFbHDPQCkT8ZZv7U0Vo7/0Bkkjv66I4kWglmg=;
 b=4zqK8wfEpF1U3xBVGIqMd9sids3gxuSzhHgjI+Yt7vC9f9vxZOQ1WlqZ+lF7LCaGkC
 WVS7NcjTRjaQIie+kn6d1Tj6C1Msat2YyjsjwdPUV0lo1BBb8Z8LjcyWrMReZ3H/QkH5
 zDjblaTv67eKiNjr1G23O9PMfPW3W4ZEnYBG6GSBYpK1/+fAVx5mhZh9T26gE/87mGDj
 h5ZuR14FulxZqOt4cK4hlmRXVqMGeXsXnwc/GSU9IkEFAt6UJM5zQFQ9HXUg1VJAjFBw
 sHXLdxJasVYbVqetKPxb50NS9fVlmHBbIVwg9O1mFpnzPlIyMpeI63+Lzu5wurmu34M6
 8rsw==
X-Gm-Message-State: AJIora8S5aKzDdMuZuK8mOdlDNIH5aPZqRVjReJ3va2vFM9JdlH2VXEk
 Xmf/DISRCYycV/4dWTe8RWU=
X-Google-Smtp-Source: AGRyM1sBrvZVP1qc9U7uSvWk+cgCHojR5yTw2MlrWHjcew9QsLHMY/B4WPFv54UgVAceHbcK7l5Rjg==
X-Received: by 2002:a17:906:6a23:b0:722:e1ba:964c with SMTP id
 qw35-20020a1709066a2300b00722e1ba964cmr2659428ejc.680.1657274586114; 
 Fri, 08 Jul 2022 03:03:06 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:95df:c673:e23c:7b70?
 ([2a02:908:1256:79a0:95df:c673:e23c:7b70])
 by smtp.gmail.com with ESMTPSA id
 b18-20020a1709063cb200b0072afb23fb9esm3652672ejh.16.2022.07.08.03.03.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Jul 2022 03:03:05 -0700 (PDT)
Message-ID: <57e44bdf-9bea-4c9b-0b05-ff0b68fcf44c@gmail.com>
Date: Fri, 8 Jul 2022 12:03:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu/gmc10: adjust gart size for parts that support
 S/G display
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220707205530.899499-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220707205530.899499-1-alexander.deucher@amd.com>
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

Am 07.07.22 um 22:55 schrieb Alex Deucher:
> For GMC 10 parts which support scatter/gather display (display
> from system memory), we should allocate a larger gart size
> to better handler larger displays.  This mirrors what we already
> do for GMC 9 parts.
>
> v2: fix typo (Alex)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 25d5743ae91b..1772f006c61a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -834,10 +834,21 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
>   		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
>   
>   	/* set the gart size */
> -	if (amdgpu_gart_size == -1)
> -		adev->gmc.gart_size = 512ULL << 20;
> -	else
> +	if (amdgpu_gart_size == -1) {
> +		switch (adev->ip_versions[GC_HWIP][0]) {
> +		default:
> +			adev->gmc.gart_size = 512ULL << 20;
> +			break;
> +		case IP_VERSION(10, 3, 1):   /* DCE SG support */
> +		case IP_VERSION(10, 3, 3):   /* DCE SG support */
> +		case IP_VERSION(10, 3, 6):   /* DCE SG support */
> +		case IP_VERSION(10, 3, 7):   /* DCE SG support */
> +			adev->gmc.gart_size = 1024ULL << 20;
> +			break;
> +		}
> +	} else {
>   		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
> +	}
>   
>   	gmc_v10_0_vram_gtt_location(adev, &adev->gmc);
>   

