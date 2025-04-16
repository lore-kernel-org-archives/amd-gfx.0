Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B61EC369BD
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 12:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2EC510E029;
	Wed, 16 Apr 2025 12:42:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F6fRMOvf";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FAA410E029
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 12:42:18 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-39c13fa05ebso4183330f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 05:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744807337; x=1745412137; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yu2XN8KgijTNItXy9pkNajU6M215usl0j3eUexaZeME=;
 b=F6fRMOvfGVL9inzx9u2NdvnkkzOJozsPA1yrqz0KkLq2azwyZzmCaSYtobpsyctDZ9
 kuv9F9/GnZA4cgjazzNw6U/qsJdUEH2nkKrhaAtx2h8re7OFEd/p/Mlm/hbl9tubRxhe
 M9zdOGFNe/0brmG9eST3TKNbq2TzT2uBeD58xWJ1fkFI5b36d5VmC3FK1rCDNJzKL0Ph
 /7ih2qH2ccfOlIEsRTI49ucbNOrfD4OomRQn3KLrZWqHdCuYOTKea5Iln4ttJtZYYuRi
 uYSswBdh7H6kLtK2z840Fo5EHTPvK3mUqvXHq3yn3Oan6DQSuygN1bZIqF8bpqyHgUEm
 XGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744807337; x=1745412137;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yu2XN8KgijTNItXy9pkNajU6M215usl0j3eUexaZeME=;
 b=DRpg8O50h1msQZuyXdLly6Pyio4kfNxpl91Si6Nav162oEeaRxujvFCe8JqgNbJ5gc
 fxCMKLRYnQ4dm+k1pg/CBxC+BZ586uPbGkypCPInWwkhfTKvuDwO9lGadVxTgVMWO6rR
 +tG0bG83zqvkiOBzYA9oghaXoyy9vqVqgf/doC/HT/0GzjXfOLy2WYrGOAYD9tP9+mu0
 Ox8xYz+V82pHxAbbIZVlZBLirWZ/MaDbxuasBOHn19ijm0gpgzttX8PXaCXCwoY+UMOe
 TTVg6fIOXKfAsW20EjA4eMfvYYmrBE4vaGOjjWZ3IfkDsyEdk1ikKWlSMGPSr/f5pHGg
 PadA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRh3iZKpZtKmqIORmUrIUQ8wO1a8oeA+meNLZpBGfhfO5deQdrwzEH5ZsVNQTstQyJMKPhc3Y0@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwgzBF4pQ8/IxYMbjCVrjLSLh0YHsRWXbhmFV0o4YMCyyyYD6Kn
 GHgal9HD1sNd0FHPGxf7Z0UEaNkWDS6dvY3a42A+Dq4GBoVV21XE8XYtu9IF
X-Gm-Gg: ASbGncuZnFcIQqfQrLz2klR//POwYj9md4H6TUfs9R6SAfnHu6ll+euxHF2C6FaXreX
 RZdAiKO2GIBbXIso/eHhlxsp9FeRi71jgVszaobA25N9rOfhUcB0eoNK/NvGoJ/t4t+WUOvMqN7
 E4uYRjlt58deRZBRGiqxs7C7P4vTzRH5c+WdxEjA9VGAyirgkIiQhAg1iXOQsVuxFcLAmVBJ54W
 II00k3bCi/XiRvMbvfeWA9crs0P7iJnrxCMbz8Xk+479k3pT7N10DSL6q6VBwDApejAzH6BtzHm
 eAHf+Airaul3qz2/J26xCnXwc0toBMGNAkkLNjs5GmN5LUwkKJpTW2MYDYeqO4r5R001S8PRfpE
 qml8z
X-Google-Smtp-Source: AGHT+IEVkd+P5RWILnA46PbP7Najg9guatDhReTTdRAaW7lhNQe1l6KL0tMeTxtCg69aMCmeJz1Y2Q==
X-Received: by 2002:a5d:598e:0:b0:39e:e557:7d9 with SMTP id
 ffacd0b85a97d-39ee5b12f6amr1742877f8f.5.1744807336712; 
 Wed, 16 Apr 2025 05:42:16 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39ed1652a91sm12031830f8f.75.2025.04.16.05.42.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 05:42:16 -0700 (PDT)
Message-ID: <5d4646f9-0835-4630-bf6a-c9f556dcf833@gmail.com>
Date: Wed, 16 Apr 2025 14:42:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: Allow P2P access through XGMI
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, yang.su2@amd.com, hao.zhou@amd.com,
 asher.song@amd.com, pak.lui@amd.com
References: <20250416044529.1147595-1-felix.kuehling@amd.com>
 <20250416044529.1147595-2-felix.kuehling@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20250416044529.1147595-2-felix.kuehling@amd.com>
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

Am 16.04.25 um 06:45 schrieb Felix Kuehling:
> If peer memory is accessible through XGMI, allow leaving it in VRAM
> rather than forcing its migration to GTT on DMABuf attachment.
>
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 31 ++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 9abe592968ab3..a72c17230fd37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -43,6 +43,30 @@
>  #include <linux/dma-fence-array.h>
>  #include <linux/pci-p2pdma.h>
>  
> +static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops;
> +
> +/**
> + * dma_buf_attach_adev - Helper to get adev of an attachment
> + *
> + * @attach: attachment
> + *
> + * Returns:
> + * A struct amdgpu_device * if the attaching device is an amdgpu device or
> + * partition, NULL otherwise.
> + */
> +static struct amdgpu_device *dma_buf_attach_adev(struct dma_buf_attachment *attach)
> +{
> +	if (attach->importer_ops == &amdgpu_dma_buf_attach_ops) {

Oh, that is rather clever. Going to keep that in mind.

> +		struct drm_gem_object *obj = attach->importer_priv;
> +		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
> +		struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> +
> +		return adev;

That can be simplified to just "return amdgpu_ttm_adev(bo->tbo.bdev);".

With that nit pick addressed feel free to add my rb.

Regards,
Christian.

> +	}
> +
> +	return NULL;
> +}
> +
>  /**
>   * amdgpu_dma_buf_attach - &dma_buf_ops.attach implementation
>   *
> @@ -54,11 +78,13 @@
>  static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
>  				 struct dma_buf_attachment *attach)
>  {
> +	struct amdgpu_device *attach_adev = dma_buf_attach_adev(attach);
>  	struct drm_gem_object *obj = dmabuf->priv;
>  	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
>  	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>  
> -	if (pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
> +	if (!amdgpu_dmabuf_is_xgmi_accessible(attach_adev, bo) &&
> +	    pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
>  		attach->peer2peer = false;
>  
>  	amdgpu_vm_bo_update_shared(bo);
> @@ -477,6 +503,9 @@ bool amdgpu_dmabuf_is_xgmi_accessible(struct amdgpu_device *adev,
>  	struct drm_gem_object *obj = &bo->tbo.base;
>  	struct drm_gem_object *gobj;
>  
> +	if (!adev)
> +		return false;
> +
>  	if (obj->import_attach) {
>  		struct dma_buf *dma_buf = obj->import_attach->dmabuf;
>  

