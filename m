Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA90606A325
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C1kR4FEE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD36B10F2D9;
	Tue, 27 Oct 2026 09:00:45 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDB1010F2FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 09:00:38 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so26752415e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 02:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793091637; x=1793696437; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2jomD5DW7/9LV3bB9pRNmINYfsgBDaY7HuZbct8Pf38=;
 b=C1kR4FEEO5fupSZxdiQU9BUWZrvFXwrPJHJjcdWQHEnmoNq09767RgUklw6lSyj9f0
 9wT7EB3Em1yBJGLk/QqdBH/kZSWl1zoSH8ldHNbjoRrL+cE1zcCyGDfH1fksG9bFjDxx
 wzRtG2UsHkT0LVHfpcbMdXoTyViEQzm3Voyey4Z9MhgN9v4LtCmkNArAC19ibf/cRbhz
 mtTvp/bTmJvDmexA4iPSk0PxEY3fKaTYznKDubWe1Gp03GHbAzdSqB0/0ikJ1UCLOPC5
 4TjfeQRHsN7KitxZUfC308AMvZMiWJLBpQL8WKOaCAYv5Glc5xF9qU5JwpfjKEUoMYS7
 p87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793091637; x=1793696437;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2jomD5DW7/9LV3bB9pRNmINYfsgBDaY7HuZbct8Pf38=;
 b=Ip6AdngzGTkw7ZF9nZS/FjoVnwIy/ey8eCvUu4SqA5mBz6PnBrGjisBDoo2stkiMGW
 dy78Fzei3zU32GizSOtdwWM8ONENYMdAkRXWVSnTXHMQzCNpNgte5fG/YOeD1fgyfde0
 hil1N3zoWx2trqHENni6iDFiwZjqFrUECTf2iilY3iDVOHDL+qqEI5vzn9NlHruuP2jY
 fviPCSu3vfwXrzmmY8gmUGpv/lFx5GcPBBYHJvLxMypzekDydkok/bOX4D1va3cMLdsx
 XYxmzINvLZoN2ZBllt64ONKNUO3pf5tFnF7V7Zr7glArpY64gY44O3u8yiLnRiaJUbTz
 absQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByqRorWVY3UchsCYlVii10jrdUS0bUftnUOfAIkBrHIEG7mH3uKgSpP6cVbZz36d62liGq9j5G5@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL6i5QlyUoI9we5PLWFxXc8ceW482C/OFfpEKq61OtBgwPY+58R
 iamAKe4ID9aGCSO9U71Z6b+nWjE1GdA/x6Kxg3spZ11pT6PB2acAZAis
X-Gm-Gg: AYBFou34h6aOv6YHt8T5omsUK5zqdPnAI7JuNd9+yDG+s1Hw6AYHcl4f58c6wuI1AbO
 rC2FiwC0TiUKpo2pnp5scv7ad/PtOXy7h81ob4MJp8k2wMYWNcvjkXr5Sd7FHngOp2Wfw79oz+T
 szUZB2r2Rz2dWXGqyCAugcDCes6wFPSB3NaF8vwLAQuoL2XRwLuJZlLclM+3RxH37GtaAd/EK4h
 FqHXyaYDmidV6tWYs58aL6qCX1hMx1uXRF2QIaqczPmYkgM194X6q1+1zlCL+iJwzozxriFYbKy
 k6yZERlnoTteTNwItV8+nbY5wk4oH1FoEmjLece1SZuY9tHh4Koo6aYpWH++i6+EFVIQETizRWc
 7/IrgatyFuaPC+juy9yz1BDqZA2JsriryvwajzG+sDx8MtKy7MIrAlWdYDMseBEzmDFnbHjVZ+C
 JRlcAhL8rGxregNFxVN+3m+SjAQZK4xCsg3AvWq8m7AR726Wl6WAcYpc8L5PKU/GNEVXb5Ii74w
 SNZTHYKyJngscTESWJ1GhmxzrYgfHj2npReyhAvulRypPdP96PE7+jQiSN5xfpWFu0UcQ3xzx15
 lwQed8XA
X-Received: by 2002:a05:600c:b86:b0:4a1:f68a:9736 with SMTP id
 5b1f17b1804b1-4a35acaa66fmr176313235e9.26.1793091636679; 
 Tue, 27 Oct 2026 02:00:36 -0700 (PDT)
Received: from [10.254.154.15] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a04ae28sm260164775e9.2.2026.10.27.02.00.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2026 02:00:36 -0700 (PDT)
Message-ID: <39cb8b4b-0ee3-44d2-a88d-e471002ced61@gmail.com>
Date: Tue, 27 Oct 2026 10:00:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Redirect imported dma-buf mmap request to
 exporter
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261023144813.1220394-1-xiaogang.chen@amd.com>
 <20261023144813.1220394-2-xiaogang.chen@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20261023144813.1220394-2-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 16:48, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
> 
> The imported GEM object with ttm->page_flags TTM_TT_FLAG_EXTERNAL set and
> without TTM_TT_FLAG_EXTERNAL_MAPPABLE set,is only a GPU-side handle for memory
> that belongs to the exporter. TTM refuses to build a CPU mapping from it
> because those page-table entries would point to pages drm driver does not own.
> 
> amdgpu_dma_buf_create_obj creates GEM object for foreign exported buf(not
> generated by amdgpu driver) belonging to this catagory. The pages, when GPU
> needs them, come from dma_buf_map_attachment on the exporter's scatter/gather
> table. The exporter can move or revoke that mapping through move_notify.
> A CPU page-table entry installed by the importer would keep the old PFN, and
> the importer also does not know the exporter's caching mode or whether the
> memory is CPU-visible.
> 
> This patch redirects foreign imported dma-buf mmap request to exporter. The
> CPU mapping is created by dma_buf_mmap, which points the VMA to the exporter's
> file and calls dma_buf->ops->mmap. The exporter's fault handler will fill
> page table.

We had that suggestion many times before and it is only allowed as a backward compatibility hack for a handful of DRM drivers to do this.

If the imported DMA-buf needs to be mmaped() that *must* be done either on the exporter or the DMA-buf file descriptor itself.

So absolutely clear NAK to that!

Regards,
Christian.

> 
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 4e4814caf61a..d872b4bcb5fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -369,6 +369,26 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>  static int amdgpu_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
>  {
>  	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
> +	struct dma_buf *dmabuf;
> +	int ret;
> +
> +	/*
> +	 * A foreign import (udmabuf, for example) does not own the pages.
> +	 * Point the VMA at the exporter so the later CPU fault uses its
> +	 * vm_ops. dma_buf_mmap() resets vm_pgoff and holds the dma-buf file.
> +	 * An amdgpu dma-buf stays on the TTM path below.
> +	 */
> +	dmabuf = obj->import_attach ? obj->import_attach->dmabuf : NULL;
> +	if (dmabuf && dmabuf->ops != &amdgpu_dmabuf_ops) {
> +		ret = dma_buf_mmap(dmabuf, vma, 0);
> +		if (ret)
> +			return ret;
> +
> +		/* Exporter vm_ops will not drop the mapping reference. */
> +		drm_gem_object_put(obj);
> +		return 0;
> +	}
> +
>  
>  	if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm))
>  		return -EPERM;

