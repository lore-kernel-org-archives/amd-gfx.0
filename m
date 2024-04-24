Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A141C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 06:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAAB1113823;
	Wed, 24 Apr 2024 06:14:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LIgQVqS7";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97DD4113823
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 06:14:52 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-34782453ffdso6654824f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 23:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713939291; x=1714544091; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=izrjhlHZI44AyVaVrPFTREYg+jI+AymKTpfUQnRp4jk=;
 b=LIgQVqS7wB3iCaK6BXRb7xeKi6JTxO49g2nBl4LnmsZ4Lbx27bKLUSolhu6N2wsG3v
 hIcLINatGhVPiyUM8020sZFjzSNH3/DpyGzuo0HxX5k3K2T/eYUttOivHngTWWja9Wen
 JNS7N3pEVO3PiGnPXJPI9whGdxYOusNjmYfOd/oT275x8bhTqWOhOwTqc20bYw5bAWvj
 oTi+ickNR47hrYpIrn/UXyHyiBD2Aj+l+hCeNJcClYgum5caWQgTIvXqinMzdPJgnGvM
 esg1e6gM5S3IuAmyjeMHUA0U6e3KSr8NyTJGg/b8bIkUurRnsRsSLJQ2aeZIhNMk//J7
 z4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713939291; x=1714544091;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=izrjhlHZI44AyVaVrPFTREYg+jI+AymKTpfUQnRp4jk=;
 b=XOkkD9M779mvclK3I8bvkds4S+IcpNPShIlGOeoC6SAt0G0+NaJRCvkOFBgRI7Ht3d
 h+N0gwihskHSOc1dAj+JQgcDOzliOykcwop5bO10wmUW+jzOJ1Ec86JG2J/vlY0QDxwz
 ULiwtztgpdlBUh21+58pezoWV1eDQS40lZoYuJJ0bDziI5YVugW2WEmbC8p6xcuwzh9L
 Fn5QhzYBJKx9jsTjoRZxILZGr3qQnbhdCn/HLoZ5Uy248V49wN8YfL6QIcgU8NgNKBkn
 vKk65F547d6jkBGvYvD5Bc8PtbqvjPUyj5SIbaFefQSG8KX6QgbvIVWvsREdsuAM7ULd
 ZKBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa83UFTAgc4px6HxgAEaRTSis9o2NRyU2pjSAJsR78Qls/H/SztoY/3A/dm6f8CKomSlHVhBm40oNfb8a190yPUOPnJCUHdZWCbxDdCQ==
X-Gm-Message-State: AOJu0YwuqWghkG+dvuSnHUOPJViBu31c0qRRoUTWWXA74TWGqoNkC/BY
 +Au+DMsVH62sCFbOc02M5MbS1FUFjdj72zxj7dlOD6PndwSTkaW1
X-Google-Smtp-Source: AGHT+IH4Ulc9fsEGH/zO6BhqYx+C4QiiLHrFLrgOoxXEwGlokI7JtJKQfPfy/jBeH/7e7HK9Qr1myA==
X-Received: by 2002:a5d:456f:0:b0:34a:f9a8:57d9 with SMTP id
 a15-20020a5d456f000000b0034af9a857d9mr1036960wrc.38.1713939290463; 
 Tue, 23 Apr 2024 23:14:50 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 d14-20020adfe88e000000b0034b86548582sm2754956wrm.102.2024.04.23.23.14.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 23:14:49 -0700 (PDT)
Message-ID: <ee919dfb-ca12-4dfe-8b87-435cd7c12a12@gmail.com>
Date: Wed, 24 Apr 2024 08:14:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] drm/amdgpu: Handle sg size limit for contiguous
 allocation
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com,
 Arunpravin.PaneerSelvam@amd.com
References: <20240423152900.533-1-Philip.Yang@amd.com>
 <20240423152900.533-3-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240423152900.533-3-Philip.Yang@amd.com>
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

Am 23.04.24 um 17:28 schrieb Philip Yang:
> Define macro MAX_SG_SEGMENT_SIZE 2GB, because struct scatterlist length
> is unsigned int, and some users of it cast to a signed int, so every
> segment of sg table is limited to size 2GB maximum.
>
> For contiguous VRAM allocation, don't limit the max buddy block size in
> order to get contiguous VRAM memory. To workaround the sg table segment
> size limit, allocate multiple segments if contiguous size is bigger than
> MAX_SG_SEGMENT_SIZE.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 4be8b091099a..ebffb58ea53a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -31,6 +31,8 @@
>   #include "amdgpu_atomfirmware.h"
>   #include "atom.h"
>   
> +#define AMDGPU_MAX_SG_SEGMENT_SIZE	(2UL << 30)
> +
>   struct amdgpu_vram_reservation {
>   	u64 start;
>   	u64 size;
> @@ -532,9 +534,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   
>   		BUG_ON(min_block_size < mm->chunk_size);
>   
> -		/* Limit maximum size to 2GiB due to SG table limitations */
> -		size = min(remaining_size, 2ULL << 30);
> -
> +		size = remaining_size;
>   		if ((size >= (u64)pages_per_block << PAGE_SHIFT) &&
>   				!(size & (((u64)pages_per_block << PAGE_SHIFT) - 1)))
>   			min_block_size = (u64)pages_per_block << PAGE_SHIFT;
> @@ -675,7 +675,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>   	amdgpu_res_first(res, offset, length, &cursor);
>   	while (cursor.remaining) {
>   		num_entries++;
> -		amdgpu_res_next(&cursor, cursor.size);
> +		amdgpu_res_next(&cursor, min(cursor.size, AMDGPU_MAX_SG_SEGMENT_SIZE));
>   	}
>   
>   	r = sg_alloc_table(*sgt, num_entries, GFP_KERNEL);
> @@ -695,7 +695,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>   	amdgpu_res_first(res, offset, length, &cursor);
>   	for_each_sgtable_sg((*sgt), sg, i) {
>   		phys_addr_t phys = cursor.start + adev->gmc.aper_base;
> -		size_t size = cursor.size;
> +		unsigned long size = min(cursor.size, AMDGPU_MAX_SG_SEGMENT_SIZE);
>   		dma_addr_t addr;
>   
>   		addr = dma_map_resource(dev, phys, size, dir,
> @@ -708,7 +708,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>   		sg_dma_address(sg) = addr;
>   		sg_dma_len(sg) = size;
>   
> -		amdgpu_res_next(&cursor, cursor.size);
> +		amdgpu_res_next(&cursor, size);
>   	}
>   
>   	return 0;

