Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDCCC369BD
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 13:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0965810E92A;
	Wed, 16 Apr 2025 13:54:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YrXlFLEM";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8B9210E92A
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 13:54:42 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso66217915e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 06:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744811681; x=1745416481; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XCBV4Cl63wtmiTOvtMTg6CkY8JOlsuFIpuqFt3e3PbI=;
 b=YrXlFLEMYxZbj4RLJJxwdw7mha3uXpiYmb93dupV0IayV6M1wRu447P/fDIm5cGMpX
 vj5f7iH6aTJRqN/UcHxzp/sp8uuyLL3WUPlVaZrkvDWUcHXykY/OXJXQWDZmDuHame1U
 AXNBo0c4tl6gkgsDjiKZTes6mU2BJ7cysKAyyyy8u/8VWzq/3SKUTZEHicJamIaeWXKh
 QYWCRMKR4BY2lOK7HUasvZ3+9o9qeBvrABFe597SHMlpYPkGbBzhmkrMZBlryjBBRK9s
 rVvbqCkb1wvAjZ8+Cg5UY0ImK8IFioFXWCGgg5JCrH9oNnsgdYx/kDpARVkqmj9CMXTJ
 f0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744811681; x=1745416481;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XCBV4Cl63wtmiTOvtMTg6CkY8JOlsuFIpuqFt3e3PbI=;
 b=ZP+phWAVHMS8lXKYZ2GpfnhT4ZtjxryRuYtY6AgtmRMd6jBkKXx/xMDKvYir967bcv
 ndv3l4jFELEHPg4Hjbsj+STC3ga7ddvErBjiEcJIBtCS+EKAdfp/CkRe51SxSRNoEeH0
 3JP7ToGIceHOq2f7mBEdINb/buoImxRd+3sUa0TC5lQkF8jiNW+iW6iw3EyDdCtoTXGu
 JZ9OtczBhK0MNhiriwx0qbtQ+xpBDZ5LEo5VkTZkm9D6Km5r5n3GbGoq6FykEeobKIVq
 86F2oMaA4sXgnsauotTCMFQONPso6Tg9tv+6YlKByX+vGRkT9wgRz+bQpdf3ezkKewg8
 qNog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEvqf7FfiL3c+x35iunyvo83pSneVQio9uSPdvTtpaAK00/GnGYGTzDGtn8enxe7L3m4syPPec@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw495Sl/CtTB/ZfStbAV7pjPAsM2ujtO+22yB+iLp8gpgzmnv5c
 CBrqCrbRO0Dw76qOTEiK8U8t+Crqgwvxz/ADb36kZ+zN1IrzqF1R
X-Gm-Gg: ASbGncsiTSXJHPd24YaTSOnMW7QjEvQazC5ApwhZxMTFWL3cSJhBF+EwQs8g30E6ms6
 ymx325bul9etvqTMUVc/OOMDUcMNF0oz6WdfOicDbvHipnox6FP1LGpna2s33SgMxwjCNiBqDgS
 wGDJY0irC1OHCP21PjHia7h9yZHwpJcT79wKYUNJ8Ef1wx23tbsX51GU/aK6NBCWMiPstDNECas
 wPjfJgri/P0m7XXYJwvUx1nLRmOs4wxJ3b0/Xax/uxKjwoTiBt/8tx++a3QjueXHylhn9M4Jdri
 a91sga/ZcVTnMt5+VSmbZa+czNC1qyHkUVK/F5aSEgkn2pCqqpWpjVdRDt/Tq/X5pxGdxA==
X-Google-Smtp-Source: AGHT+IGY8HqgcGwnZq6oCDBehCz2hf7oruoDWf78yl3pkimC1s5jE/lf2ZX2ae2WN9xXLFy6UCKI+w==
X-Received: by 2002:a05:600c:82c3:b0:43d:683:8cb2 with SMTP id
 5b1f17b1804b1-4405d61c972mr21925855e9.14.1744811680840; 
 Wed, 16 Apr 2025 06:54:40 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b4c8216sm22266145e9.7.2025.04.16.06.54.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 06:54:40 -0700 (PDT)
Message-ID: <0ca1a883-4ddd-4bc5-8d58-9865a6d497b5@gmail.com>
Date: Wed, 16 Apr 2025 15:54:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expired error
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, emily.deng@amd.com
References: <20250414104655.336497-1-guoqing.zhang@amd.com>
 <20250414104655.336497-7-guoqing.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20250414104655.336497-7-guoqing.zhang@amd.com>
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
> IH is not working after switching a new gpu index for the first time.
> IH handler function need to be re-registered with kernel after switching
> to new gpu index.

Why?

Christian.

>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> Change-Id: Idece1c8fce24032fd08f5a8b6ac23793c51e56dd
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |  7 +++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 18 ++++++++++++++++--
>  3 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 19ce4da285e8..2292245a0c5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -326,7 +326,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>  	return r;
>  }
>  
> -void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
> +void amdgpu_irq_uninstall(struct amdgpu_device *adev)
>  {
>  	if (adev->irq.installed) {
>  		free_irq(adev->irq.irq, adev_to_drm(adev));
> @@ -334,7 +334,10 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
>  		if (adev->irq.msi_enabled)
>  			pci_free_irq_vectors(adev->pdev);
>  	}
> -
> +}
> +void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
> +{
> +	amdgpu_irq_uninstall(adev);
>  	amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>  	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>  	amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> index 04c0b4fa17a4..c6e6681b4f71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> @@ -123,6 +123,7 @@ extern const int node_id_to_phys_map[NODEID_MAX];
>  void amdgpu_irq_disable_all(struct amdgpu_device *adev);
>  
>  int amdgpu_irq_init(struct amdgpu_device *adev);
> +void amdgpu_irq_uninstall(struct amdgpu_device *adev);
>  void amdgpu_irq_fini_sw(struct amdgpu_device *adev);
>  void amdgpu_irq_fini_hw(struct amdgpu_device *adev);
>  int amdgpu_irq_add_id(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index faa0dd75dd6d..ef996505e4dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -643,12 +643,26 @@ static int vega20_ih_hw_fini(struct amdgpu_ip_block *ip_block)
>  
>  static int vega20_ih_suspend(struct amdgpu_ip_block *ip_block)
>  {
> -	return vega20_ih_hw_fini(ip_block);
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int r = 0;
> +
> +	r = vega20_ih_hw_fini(ip_block);
> +	amdgpu_irq_uninstall(adev);
> +	return r;
>  }
>  
>  static int vega20_ih_resume(struct amdgpu_ip_block *ip_block)
>  {
> -	return vega20_ih_hw_init(ip_block);
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int r = 0;
> +
> +	r = amdgpu_irq_init(adev);
> +	if (r) {
> +		dev_err(adev->dev, "amdgpu_irq_init failed in %s, %d\n", __func__, r);
> +		return r;
> +	}
> +	r = vega20_ih_hw_init(ip_block);
> +	return r;
>  }
>  
>  static bool vega20_ih_is_idle(struct amdgpu_ip_block *ip_block)

