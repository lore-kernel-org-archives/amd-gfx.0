Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4725CA5505
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 08:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2639810E480;
	Wed, 13 Sep 2023 08:27:18 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E37B10E480
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 08:27:16 +0000 (UTC)
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-500cfb168c6so10710382e87.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 01:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694593634; x=1695198434; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B8x+PyxeapJ29onTcTTfUALL3fK6WsA3a/PmKejf9Eo=;
 b=i5PvWq6gZkzSh+TD5I28Zjk13cl9XWD7miyJGIb+7dhnYxuS46+3ZyI2fCMWVzJ5tC
 oVhycDFU0zV6Sfy3IIuCHUodpWxi3epOVtyGap7AZQpEuZBJv8v724aM1k9fkvzEEv0l
 xHiKakgT7PHhXdGnpc1W5xcp3iPV6SdUNrnVsfMHCwSlLBqMDbiS1x0648wmXRJ6xLBV
 js7bCk/lfma2e6p+7uSI3zxXEZOQqCakbJl7OdTNtmVsdLSFtGa/EhbFIqdtxcqAeBvu
 2ejCJmJ2AG/KfE5UeY7EBvDw0ftgG3sAP5k2xNuRkFo8Gjf3wd3oH608SnP5n3viKg1D
 BC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694593634; x=1695198434;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B8x+PyxeapJ29onTcTTfUALL3fK6WsA3a/PmKejf9Eo=;
 b=axQpoPDjJGbapRZkW/gD283fQSlAwviX1/8oMfeznGmaxAkwFD74IPB8MCUQ0YwH/2
 naXyQNadMpZrTE3TKH1IVR8w6ako7HsZP6yulKR1O2fUDYSGswMU9FKq8d9j5/pPrmv/
 xaVRt6NRsEGbRCogYSPKltXiXZTPHfqw3C7AWdB+MurEKQWV2phtqYytmD1h1VL6aMjO
 FE2h/k/fduQoTZpAb1h/yKku/wj4gRDUPLmSlexICdZ0Y8c9nFqZAbfh0WN4kHWA0bo3
 wphgX6fuD0k5o17APtHr+i6R6kzU2Gf3eG1AcKtjyLftODJ7P/XoBbSl8Eru9mKPCxLR
 Saig==
X-Gm-Message-State: AOJu0Yw34ux2nbFpniBFhl3wQyqF52tjVh7KSrGwC9EYkki4fQfksOy6
 WKtKZFvGhDfayVinGfmdp3g=
X-Google-Smtp-Source: AGHT+IEuB3GxZpmXCSw7UCmyJt9R4t6EIg9mGjjI2CrKs93Lsc2u4JOaaKzHxMMhJzAYzPs2GxjYXw==
X-Received: by 2002:a19:381b:0:b0:502:d800:615c with SMTP id
 f27-20020a19381b000000b00502d800615cmr1698151lfa.27.1694593633995; 
 Wed, 13 Sep 2023 01:27:13 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 e20-20020a05600c219400b003fe1c332810sm1312520wme.33.2023.09.13.01.27.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 01:27:13 -0700 (PDT)
Message-ID: <964e53a6-de4b-c2a1-5334-afea06de93e3@gmail.com>
Date: Wed, 13 Sep 2023 10:27:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] drm/amdgpu: add VPE IP discovery info to HW IP info query
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230912212843.2807760-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230912212843.2807760-1-alexander.deucher@amd.com>
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

Am 12.09.23 um 23:28 schrieb Alex Deucher:
> Add missing IP discovery info.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index a74ea53899f6..512eb3d8eaf1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -514,6 +514,9 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   		case AMD_IP_BLOCK_TYPE_VCE:
>   			result->ip_discovery_version = adev->ip_versions[VCE_HWIP][0];
>   			break;
> +		case AMD_IP_BLOCK_TYPE_VPE:
> +			result->ip_discovery_version = adev->ip_versions[VPE_HWIP][0];
> +			break;
>   		default:
>   			result->ip_discovery_version = 0;
>   			break;

