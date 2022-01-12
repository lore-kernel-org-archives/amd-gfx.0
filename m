Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20941C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 08:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A17571126D1;
	Wed, 12 Jan 2022 08:19:05 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 263CC1126CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 08:19:04 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id k30so2673441wrd.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 00:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=9hlHhhNcRrD1oXpLeUv5znAFUV6h4qRAEEVAc9MnBUs=;
 b=Vw+nhYVx/rIFu5QB4G/OFq+6X4NEoapLEXJ9rpcGfY8+tGjnEsas6G1LMkmaVspXES
 eHyrf8ns7zCbb8f1qKEZV3gmAjAeaLCw58Fpijbl/yx8nvw42GQybzp1DdIxs2WcekVb
 iTg49E2Hg1r6NupuF/z34IUuZjgleepaMpR+VMyZX6N+9en1n4DFHlHKkIbISqWa41Zh
 cSgr58LlN8HQb/tZ+hxnMTsZB+j/k2RXkgmweCTnIbJLkZZHZzFnbG1brB+6lRvju9na
 0jEq90hsiXWmPeIaZkYt0U3CRDkxznd3KknPwJo0D3oCOOc2JJwKY98DQLY8NrBCsI3C
 7H7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=9hlHhhNcRrD1oXpLeUv5znAFUV6h4qRAEEVAc9MnBUs=;
 b=EJciQhLG32DDCwJ5X5KNPLTzf9rOIHpj6j/uifa/kKYAN3+GB78zES39dyyp7FZEno
 Xwp//A23rZuMp67vdh3t/1T+26vEpwtlPiF9+7+Pf+wiJwm6Pp/Y5845qrqMxgMNsA+V
 uRIWmyAhvi+SjiWbY2GGfs9481JT5JZE7jB/tXx0GTY01eR65VFr9rrB+Q8VVx9mPH70
 X+RsH/cQ+zObdxV4Y3WQR3DGCj58AEkBr87K2jmfweFHJvPMMzb1vnNKdrmk7iq5k8PE
 +bgiqE9Xohp8mllGHkw6nQFBmIwsTobdN+6SgU0WFqoo2Er0puVrXXqkST4s1hs2R6bj
 hzWg==
X-Gm-Message-State: AOAM532nAufTWx5+Xp+PNfXM4c23bvEoC4qgV5z1LMvsRSkoXaHI1b1K
 OecNDEv5YGzg6d82/Lsa/l7KdGxaOA4=
X-Google-Smtp-Source: ABdhPJxQjWpAKafoaJNw/Xv3KSuyKsJHpmNLtt19+T7MeuBVc8GJjg0JqH0P/VPhdg0vnLrh7aLeOA==
X-Received: by 2002:a5d:6d84:: with SMTP id l4mr7095193wrs.61.1641975542707;
 Wed, 12 Jan 2022 00:19:02 -0800 (PST)
Received: from [192.168.178.21] (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id h4sm11530038wrf.93.2022.01.12.00.19.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jan 2022 00:19:02 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: invert the logic in
 amdgpu_device_should_recover_gpu()
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220111224525.3090269-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <407754bb-188d-ab86-13fd-0326b9284ae2@gmail.com>
Date: Wed, 12 Jan 2022 09:19:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220111224525.3090269-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 11.01.22 um 23:45 schrieb Alex Deucher:
> Rather than opting into GPU recovery support, default to on, and
> opt out if it's not working on a particular GPU.  This avoids the
> need to add new asics to this list since this is a core feature.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 44 +++++++++-------------
>   1 file changed, 17 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f33e43018616..32ad50b86248 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4453,34 +4453,24 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
>   
>   	if (amdgpu_gpu_recovery == -1) {
>   		switch (adev->asic_type) {
> -		case CHIP_BONAIRE:
> -		case CHIP_HAWAII:
> -		case CHIP_TOPAZ:
> -		case CHIP_TONGA:
> -		case CHIP_FIJI:
> -		case CHIP_POLARIS10:
> -		case CHIP_POLARIS11:
> -		case CHIP_POLARIS12:
> -		case CHIP_VEGAM:
> -		case CHIP_VEGA20:
> -		case CHIP_VEGA10:
> -		case CHIP_VEGA12:
> -		case CHIP_RAVEN:
> -		case CHIP_ARCTURUS:
> -		case CHIP_RENOIR:
> -		case CHIP_NAVI10:
> -		case CHIP_NAVI14:
> -		case CHIP_NAVI12:
> -		case CHIP_SIENNA_CICHLID:
> -		case CHIP_NAVY_FLOUNDER:
> -		case CHIP_DIMGREY_CAVEFISH:
> -		case CHIP_BEIGE_GOBY:
> -		case CHIP_VANGOGH:
> -		case CHIP_ALDEBARAN:
> -		case CHIP_YELLOW_CARP:
> -			break;
> -		default:
> +#ifdef CONFIG_DRM_AMDGPU_SI
> +		case CHIP_VERDE:
> +		case CHIP_TAHITI:
> +		case CHIP_PITCAIRN:
> +		case CHIP_OLAND:
> +		case CHIP_HAINAN:
> +#endif
> +#ifdef CONFIG_DRM_AMDGPU_CIK
> +		case CHIP_KAVERI:
> +		case CHIP_KABINI:
> +		case CHIP_MULLINS:
> +#endif
> +		case CHIP_CARRIZO:
> +		case CHIP_STONEY:
> +		case CHIP_CYAN_SKILLFISH:
>   			goto disabled;
> +		default:
> +			break;
>   		}
>   	}
>   

