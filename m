Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAABC3601E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 14:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4B3110E48E;
	Mon,  7 Apr 2025 14:32:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jJNzVrvd";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D01EB10E48E;
 Mon,  7 Apr 2025 14:32:16 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so4110126f8f.2; 
 Mon, 07 Apr 2025 07:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744036335; x=1744641135; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sspLXphw+bUvBqQ8IAow+bkdS8OEOw0XRgjN2W/fPrY=;
 b=jJNzVrvdvbUTVP0QY5nJ0f29maniBcvBaDHcHh0YMKRXXoRy1zVt9W9xPxBuvgurm3
 /Kgvw4Op0tfFimcp/tccjIpzkujvvdVhHjJCqtg1+5p6XMn7W6RmuBocEpYC3+/1Tyxt
 ycSIlnPMWYBrybyrB9MhexjEwE6XYvM8V0btHV4QLtjagEjM+A5O4l12LTFLGk4AIxsr
 nSIQ659hsI18swHSihLgAVsF6DAgD6zjT7UU0CvLHrJbCChJ9mz9llNMKTv1iyt+FQiz
 pvGRHrKJrl8/Db7bIo465q//+iOV2eCyWEf4EOADC4oQRdy8cUxzcp4PNSwtZP21f343
 bltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744036335; x=1744641135;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sspLXphw+bUvBqQ8IAow+bkdS8OEOw0XRgjN2W/fPrY=;
 b=KRnM5T4YHYTPc9Zb2agr595ONmROMb9fsB3gf0oytfHNst7dv29HxPMcCUVB7RgqtA
 N6hcfeF+x2BQV6JUzU8ktcEFdh9JaUh4fki04xAVLQCzjBZ49jxQsTWHIebwy/a2fgo2
 dGlLBlC5vUNBIY+QBmcr/wEWKsOWqknYxk2rUdiqzhtmEaZsMqSasWTuD19mCytx7Oxd
 48/P2OQsAeeqfMpcm1gITd1nCAAl4OpFwpQz3AZavP1oHb3yC3WImERniY+kiGokQbzz
 L5cX7BobYcTkzSeHcC+Lez4a8ZlsNK1Npm3T7K3Jik/TxEZZhA4iKfBb3X5SDo4iLtDq
 kcRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO+awrNobtLMKtLfvwRhgIR5XKcopYXugB+8MEtmT2ollg3eMR2XI+7gCXeS7nXhGIiXKG3A5k@lists.freedesktop.org,
 AJvYcCVpe+Gmog3nBqUmMVm6qfAcEBUOaMuBvPo3sh8KfBHeujv4RVb7hhRt2tFSD3xu+MHtJyhG701s13c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2Rofax8J52epwJ3DNGnSCmaN/CDJzalDXstsqIZSkrdDAu9GD
 JCWHqHS9vxpUBX+iATwKbNSEYKOnrsPu18e4ZXn2q9w0x53poIrY
X-Gm-Gg: ASbGncuyi0rs7mn3MOYqaFI8jsMc+ANd56vjJFJsXGjwtMrq/Col85blrVI91JrZnlE
 mD0pJRJqcJTsFN8P2heDv4iVmRDA9me5++3ThZtTe8gfRoI6dy4d/RoM7JxXvSRXV5e4IhWIocC
 +RxE2Id75DgP8ocJRJNPARIaFbulo3+Y1qq9vcqRuAzfPxmkF0ZcCKSTXHRBSWi98Xn2Nltki6l
 sq4xuXRa0OsUEAsqB4D5L2YH3eTt64C2e0jeqV5PcgUV7R7fjNSpJk7svTvtv6dCs2+jX/TPHZv
 6s3jK7axV0saiki9RWuvZXddEdbuAi2I1TdsFR81npmfUBJLrSDlX6bD0vmELpQVHxH6KDDxIg=
 =
X-Google-Smtp-Source: AGHT+IFNhKjcgTLgsYLPmhlqMkUCkxPWbnj6cuzFcQXQlfH/tqY63ok6fsoDG3DZxFV8dfVRLwqgTQ==
X-Received: by 2002:a05:6000:1849:b0:38f:6287:6474 with SMTP id
 ffacd0b85a97d-39d6fc49319mr8067246f8f.15.1744036335147; 
 Mon, 07 Apr 2025 07:32:15 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d75ac6d66sm5964473f8f.14.2025.04.07.07.32.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 07:32:14 -0700 (PDT)
Message-ID: <a4b1190d-4d4f-4c66-9fb7-2be19d2ea3dc@gmail.com>
Date: Mon, 7 Apr 2025 16:32:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu/dma_buf: fix page_link check
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
References: <20250407141823.44504-3-matthew.auld@intel.com>
 <20250407141823.44504-4-matthew.auld@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20250407141823.44504-4-matthew.auld@intel.com>
Content-Type: text/plain; charset=UTF-8
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

Am 07.04.25 um 16:18 schrieb Matthew Auld:
> The page_link lower bits of the first sg could contain something like
> SG_END, if we are mapping a single VRAM page or contiguous blob which
> fits into one sg entry. Rather pull out the struct page, and use that in
> our check to know if we mapped struct pages vs VRAM.
>
> Fixes: f44ffd677fb3 ("drm/amdgpu: add support for exporting VRAM using DMA-buf v3")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.8+

Good point, haven't thought about that at all since we only abuse the sg table as DMA addr container.

Reviewed-by: Christian König <christian.koenig@amd.com>

Were is patch #1 from this series?

Thanks,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 9f627caedc3f..c9842a0e2a1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -184,7 +184,7 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
>  				 struct sg_table *sgt,
>  				 enum dma_data_direction dir)
>  {
> -	if (sgt->sgl->page_link) {
> +	if (sg_page(sgt->sgl)) {
>  		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
>  		sg_free_table(sgt);
>  		kfree(sgt);

