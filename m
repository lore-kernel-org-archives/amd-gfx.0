Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F096C369C2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 12:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56B1510E02D;
	Wed, 16 Apr 2025 12:49:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FY0GN+Pp";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE3B410E02D
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 12:49:12 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so36933945e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 05:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744807751; x=1745412551; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qXuSn+1p0sNJcti3vkaWTLfmUH35xtn738k5ZAPnLDM=;
 b=FY0GN+PpN9QLVz+J6iP3y6Ih75tXv9pMhKaNgMVdLhJZtxQdGBqVEZAZNf4rjURHV+
 QJVWS4hXJCCJp4VdazfgJgtjzNRkoIAnr832HWJStXx86f9huJ/N6Q+ZCoyOgSBS/+gn
 KLZJc4cLtopCkLZM41B1PBuTj0Urk6/MDteb+eIp78LE1wdGxdhfLevkTAdLG5iy2ogH
 6fc84d+TjyyBZj21T7507xb8Tz0V3Qat5EmOyzOwEFMSeDOw9ghUA8bgX/twg57X9Gvd
 osgY6MQJBtYJFuMURiolT70Y4IsrIjoLwnn5tJZiw8BwVUcuI2U3uDLCvQ0ar3YTlIg+
 Ajvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744807751; x=1745412551;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qXuSn+1p0sNJcti3vkaWTLfmUH35xtn738k5ZAPnLDM=;
 b=ja5+E42kQ/gJlaKZkLqS2X18r8nI0JY6uyt57XRHo4TtTDkaIM0Cm7hf4sKYVtn5W8
 BLgkDnebT4Km6NSbLTbac0KdSbxqzdlwrxyI4kNcPh1f/NOEsilMXZS957JBaVr5AHaE
 EObyVk94cpGCFaA2yG2JeX4/JVkMaxximQWvYHi48FizyrbTvfCwMrS+QQtihcFHBBNR
 72s1B6EkDpof+ILBtGZcPgRsRTYi8B8GsAJyo3fujLpyAyBk+HvFJ2V3BokUiFzN3qBH
 lmmHsFe9MjtvCK7x9ORs7K0HpqjQLiMOmCSY1sYQoUQ/dZdz1JYQo2QXH3a4fvAKqNdr
 BqRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWMqLOtkg4nrrAabGI41gLX6r0YGpmQtm+7GS84nlrdx1ca7yG77anRoFHbUfo1h7oi1xE3g47@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQfGqqCoEd2Aaj7BODxxrWxhSNi2HyxrJEfJ0dcnsghvFqqJOw
 ybZhn6Mpr1Gdw8JDVvAGDXy97g/Ypv90w2jzhkqeQCEZ3jM5tok4eETpsJf0
X-Gm-Gg: ASbGncv4ZglxpeTMg0cAZxZ9NDmmTzFSzXMYvidz5ZUImlph/aZgaD2UufQM49FZAJO
 cczw/T0YH0YI8ky5tyRcNRzVJ/N4hvuAfqXDb2Hl6jTtlkk1s6w9kHZImvbHl+cuJNxvCQ1FBc2
 gN88V1Ju80ajPKQVLgXHqBFOumAPqDYPCiWwalvzHI0BDKo2Ajc3Q34uuIJWO1RxE1r3pHSzlw4
 diLw5pa1tihVrtzah0ebPeRkOqbrsyaM39vvap044dMj11jNtQvgRscQEe30sTFgWkviQxD8aFt
 e3aYfTL6w7fm4Mo9y9j19R7wFQzpacySOEHQNMbEEb0UPg6Hv0t7J7bS564PGd5g4QSXVfYggwC
 dJTrJ
X-Google-Smtp-Source: AGHT+IGhYVUZfQcXbXgawalxAEdzt6otTBoxtJWvZSD0T+H7k0ifZxyymbYjWVFEvDDRT+UPJkxk2w==
X-Received: by 2002:a05:600c:384b:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-4405d5bdb1cmr19141475e9.0.1744807750977; 
 Wed, 16 Apr 2025 05:49:10 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b4d105bsm20144515e9.11.2025.04.16.05.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 05:49:10 -0700 (PDT)
Message-ID: <0f9cb419-176f-46b2-97e5-7d89c60c679d@gmail.com>
Date: Wed, 16 Apr 2025 14:49:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Optimize DMABuf attachment with XGMI
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, yang.su2@amd.com, hao.zhou@amd.com,
 asher.song@amd.com, pak.lui@amd.com
References: <20250416044529.1147595-1-felix.kuehling@amd.com>
 <20250416044529.1147595-3-felix.kuehling@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20250416044529.1147595-3-felix.kuehling@amd.com>
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
> When peer memory is accessed through XGMI, it does not need to be visible
> in the BAR and there is no need for SG-tables or DMA mappings.
>
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index a72c17230fd37..d9284bee337ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -144,6 +144,11 @@ static void amdgpu_dma_buf_unpin(struct dma_buf_attachment *attach)
>  	amdgpu_bo_unpin(bo);
>  }
>  
> +/* Dummy SG table for XGMI attachments. It should never be dereferenced. If it
> + * is, it will be caught as a kernel oops.
> + */
> +#define SGT_DUMMY ((struct sg_table *)1)
> +

Mhm, I'm pretty sure that will blow up ugly sooner or later. On the other hand I see what you're trying to do.

But if I'm not completely mistaken it isn't necessary in the first place, see below.


>  /**
>   * amdgpu_dma_buf_map - &dma_buf_ops.map_dma_buf implementation
>   * @attach: DMA-buf attachment
> @@ -160,9 +165,11 @@ static void amdgpu_dma_buf_unpin(struct dma_buf_attachment *attach)
>  static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>  					   enum dma_data_direction dir)
>  {
> +	struct amdgpu_device *attach_adev = dma_buf_attach_adev(attach);
>  	struct dma_buf *dma_buf = attach->dmabuf;
>  	struct drm_gem_object *obj = dma_buf->priv;
>  	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
> +	bool is_xgmi = amdgpu_dmabuf_is_xgmi_accessible(attach_adev, bo);
>  	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>  	struct sg_table *sgt;
>  	long r;
> @@ -174,7 +181,8 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>  
>  		if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM &&
>  		    attach->peer2peer) {
> -			bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> +			if (!is_xgmi)
> +				bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>  			domains |= AMDGPU_GEM_DOMAIN_VRAM;
>  		}
>  		amdgpu_bo_placement_from_domain(bo, domains);
> @@ -197,6 +205,9 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>  		break;
>  
>  	case TTM_PL_VRAM:
> +		if (is_xgmi)
> +			return SGT_DUMMY;
> +


See for XGMI imported BOs we don't create a TT object, so we also never call dma_buf_map_attachment() either.

So I think we could just return an error here instead.

Regards,
Christian.

>  		r = amdgpu_vram_mgr_alloc_sgt(adev, bo->tbo.resource, 0,
>  					      bo->tbo.base.size, attach->dev,
>  					      dir, &sgt);
> @@ -228,6 +239,9 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
>  				 struct sg_table *sgt,
>  				 enum dma_data_direction dir)
>  {
> +	if (sgt == SGT_DUMMY)
> +		return;
> +
>  	if (sg_page(sgt->sgl)) {
>  		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
>  		sg_free_table(sgt);

