Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE769C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 08:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DF9910E574;
	Wed, 10 Jan 2024 08:50:01 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F1F410E574
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 08:50:00 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40e5451c13aso8537895e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 00:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704876599; x=1705481399; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pi1mLl7CjXK+lpcfuAEBQxdfaYUV9mIx673HEV51gCo=;
 b=COvd4pByuYosfyuGzoVNrSRuTQEYDIywnJ7z2EUhqcQ9flELA2epc7X1PzP47Ccik6
 hvUVZ2RfDvYoLTxV2VmRsGMrdDgVNu7JBor0fOHZexSptehx0JiS0Xg3RtnsKU6WsPYK
 DOLd7k1MMBnyTM/hBSZPVedz6pbBcx05vubaK9oHj0UoHdYUfbddHAdUxVAm87CqO3RT
 j/ws5BHfdw9p/+aJ7OHBeFJADLh/k9z/AUXIbJRNH/eZ3VapZIdsCRuGaFYMV3X0ot2W
 sd62gFjMlBN9kX+afUyBErso8S087OlywNegNs2FN9koSUM0raZ2fGACknRNp7DYiXe/
 6unA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704876599; x=1705481399;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pi1mLl7CjXK+lpcfuAEBQxdfaYUV9mIx673HEV51gCo=;
 b=GPiWfG0WN6KzGWP/f/p0fvfOb82kXpf7z9+YXjz+YQw9ErWYRI3aKJ2Avqi4psRvAC
 HLagcZJ3CHCwqKzNysoJyALD6S8dHPOckxDNILbEHnGLSoadFL/uTx/PG5SIdlBfrs8N
 EDee9HnJA2kRncaKtyyDYl2ooKoE8IVsN73BsujCgLjrdABvT+alE1Czjs5f9AKEad3H
 0UyPPSq3JBBEV7al3hWo6nXPoj1gi9BYocBp/d27Z39NBz3EL2DZO+6zjdK3Hv13EAOS
 XY/4bzUrt5J21L3oGj4YX/0TMEZpx4v0K9lPBSbNDcSmMUC5hwgebZSpFALVqsrgevj8
 DrRw==
X-Gm-Message-State: AOJu0Yxe1SRwDsXskro5Lt2BH0XocaZ90OgOQagnmdQqq6/EH0vd0rp9
 UL/U3EC3KG7Fc7xGiKO9UiA=
X-Google-Smtp-Source: AGHT+IEh+er0QSRGal1OEopoo572DHJcJl+OlhKPpMS3aG5JPMPSmxm5CC9Eiz80TPh4yPYCZLY7cA==
X-Received: by 2002:a05:600c:331b:b0:40e:477f:3512 with SMTP id
 q27-20020a05600c331b00b0040e477f3512mr231432wmp.42.1704876598955; 
 Wed, 10 Jan 2024 00:49:58 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c430c00b0040e596320bfsm22466wme.0.2024.01.10.00.49.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 00:49:58 -0800 (PST)
Message-ID: <24b8d275-6fb4-4ebb-ab36-bbb63d1d3bf0@gmail.com>
Date: Wed, 10 Jan 2024 09:49:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: move debug options init prior to amdgpu
 device init
Content-Language: en-US
To: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240109101359.28362-1-le.ma@amd.com>
 <20240109101359.28362-3-le.ma@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240109101359.28362-3-le.ma@amd.com>
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
Cc: Lijo.Lazar@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.01.24 um 11:13 schrieb Le Ma:
> To bring debug options into effect in early initialization phase
>
> Signed-off-by: Le Ma <le.ma@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for this one and 
#1 in the series.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 3e0e39a1b5ba..b67ffc3a9a3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2234,6 +2234,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>   
>   	pci_set_drvdata(pdev, ddev);
>   
> +	amdgpu_init_debug_options(adev);
> +
>   	ret = amdgpu_driver_load_kms(adev, flags);
>   	if (ret)
>   		goto err_pci;
> @@ -2314,8 +2316,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>   			amdgpu_get_secondary_funcs(adev);
>   	}
>   
> -	amdgpu_init_debug_options(adev);
> -
>   	return 0;
>   
>   err_pci:

