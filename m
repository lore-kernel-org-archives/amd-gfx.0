Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDB9CD4F49
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Sep 2023 10:09:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AB3510E648;
	Fri, 22 Sep 2023 10:09:04 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A03810E648
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Sep 2023 10:09:03 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3216ba1b01eso1879100f8f.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Sep 2023 03:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695377341; x=1695982141; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qgpeo3CyJEU2nU7Hwq940rP/Mf/8if49ANvGt3cFy5U=;
 b=LKEe+qRyXbyHRXQ8cMf7lzTboz2dhn10VoQauLUuiiJ3B1C6TGqXHFcK7ngTGO9OUZ
 rPV25g9dZN54Nr8Ra8aFhUmd8D7qvP65I1pqd61tfZbVzVZuRc60y+ZiSjGabO1x0+ZU
 B83zzFPkPijoPQlXSddSKS8kQ8qL9h4MuMcu0qbBvgf6EPCqtPEeF/JD3w/KGKXR0jmr
 XhItA/4KlBYd35x57DjWzbNx2nVNUb6gkBVSugC7ikVJmYBiQGvDn5Se3M+KrOK/dO+1
 KYw6kp7vUaje16sLlqfDMzwSk06SZdWX8MtpJ7TGVMsCmUy4TYZD/OFUUnsn2Zr4cDhA
 1lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695377341; x=1695982141;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qgpeo3CyJEU2nU7Hwq940rP/Mf/8if49ANvGt3cFy5U=;
 b=GDmiNcCdsCRyw8bxwwCQQWsqcBvqkJjPlynMfJuyRdbVfyjksn7cwuToy7ZNMFnsaw
 PUzfOXpUfaWn29085QnE/+IGLXrFv7Go5URKLbAfSn/YIra3Q0dW4dXC5fJBEEikK3qU
 rNIMbARB9OIUDbbxmNsi0OPTFGOGJ2nBMbFk6Y9Kh5hYsUlY1KYQ/18xdOojI5wVcXsY
 ujeHq+uP2yLhgyRIhqIk9JVTxOaSFhnse4oeV2RAtxM2AEkx8gCJgIHV2ON/jvKa3Mx9
 q8/OvI8GpVP3bfrs9TnbtNQny+VFD6DAsaQnoDG7mZMHFeRrSSbIvsB26WPdZDif37ym
 1QWw==
X-Gm-Message-State: AOJu0Yy4vDmWslvI6ou7VsjUi2VOFeR4obnp6txRoe2OnHxL4T2i6wza
 smUzA5+1/4LzcM4agwTuva4PrQlbybroaQ==
X-Google-Smtp-Source: AGHT+IHZBhyPXZepatHQmmBrixi0FiiP7elZ/LcCPU39roniH5cot5AqF15FaQxPtKUHrTdO4G7cyQ==
X-Received: by 2002:a5d:5049:0:b0:320:16b:167d with SMTP id
 h9-20020a5d5049000000b00320016b167dmr7073137wrt.63.1695377341564; 
 Fri, 22 Sep 2023 03:09:01 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 k17-20020a5d66d1000000b0031759e6b43fsm4053571wrw.39.2023.09.22.03.09.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 03:09:00 -0700 (PDT)
Message-ID: <7877d77d-b3fa-d218-815e-f584a0ef06f1@gmail.com>
Date: Fri, 22 Sep 2023 12:08:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/3] drm/amdgpu/gmc11: disable AGP on GC 11.5
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230921141300.415876-1-alexander.deucher@amd.com>
 <20230921141300.415876-3-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230921141300.415876-3-alexander.deucher@amd.com>
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

Am 21.09.23 um 16:13 schrieb Alex Deucher:
> AGP aperture is deprecated and no longer functional.
>
> v2: fix typo (Alex)
> v3: just skip the agp setup call
> v4: revert back to the original model
> v5: back to v3
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 0bd7de1488f2..5b457297d468 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -689,7 +689,8 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
>   
>   	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
>   	amdgpu_gmc_gart_location(adev, mc);
> -	if (!amdgpu_sriov_vf(adev))
> +	if (!amdgpu_sriov_vf(adev) ||
> +	    (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(11, 5, 0)))
>   		amdgpu_gmc_agp_location(adev, mc);
>   
>   	/* base offset of vram pages */

