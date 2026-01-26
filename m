Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B94D2595A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 08:19:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4006D10E4E2;
	Tue, 27 Jan 2026 08:19:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="xZP3e+wm";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7377D10E493
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 20:38:54 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2a76b39587aso2715ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 12:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1769459934; x=1770064734;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=heQW4XXGxVNpbsMWtr+Uf/Qjg2mRHLgzAq6EBq5z5Gc=;
 b=xZP3e+wmixcfFD5RDGDndGp+GB2Qjl+1xoLC6Ifz0Vin6LY5oSJLBSZ06UvHnKP30V
 4fNIC9PVJ00OKGbcGBmEyx0VshrKFfhW/ZInrnwrTjMSPIUs0PPWxFORcRNBMyckLmiQ
 weCs6sNlW3W3YwIGyNA9vhRAGxMZeZHbXZGxHjT/q/lA8Qc66Yc8tw1cunWgK9YEavg+
 lIUvZCyrEF4NDvrKeIDBQRhtoPZ7IT/EoBoNUow61zFkZ2fcVc5zELpgMbDLDQ0tP6Cf
 1WbHI0A2JE4ks6asuZFoyUWYUk3tzHz33ak+1ll6bnj8dPcIys2xAynkS+PAqbFZ1cGu
 rjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769459934; x=1770064734;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=heQW4XXGxVNpbsMWtr+Uf/Qjg2mRHLgzAq6EBq5z5Gc=;
 b=g/WeosQwjAbt4eO25n2BiPG19gpAmjeEPSH85wS1KJI9L1TmKSjoTF3GATfYNFaOJP
 4f7XRf24n50jAaU11aHhB+1LL7ML/GUprd4pSYWqdJo+hp6StuWIw7pCCmoKbzbzyCce
 duA4yslRy+cf01fNSRm4nC0ZHjcx69bKYobiq2l2DAYIE7PbVQthOcpC+wGST3thEXIs
 qTmWJNTCjgYMfWqKcr5MHp+lMgrP7xXI0wFZpUyuqoA4sTOxqqaAI9yZ+bDqC1oUpnnL
 nuGWmpYZJiswlgOtaTWV3Yg1TSqHVuf3oeTUdmHO//LMbIRCzRoqC5bE+R1YdhzZvYuP
 6iWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT06tJhVHGd5hFdb31gEXCJcYWI5XCNx7hRBn2mHZR32Gy2y0KaMcO19x2KTB+BSTF2aM41gQG@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxakYPyssc/gV+slT728o7wn9xICzmyYO3BC4vRFG6F4MU6zNEX
 e7Uw+40qorEZmXI5rB58h77/xl9zo38jGAqTNfiZcTMWEnCPODWhJlLNp9zzRv1AiA==
X-Gm-Gg: AZuq6aL4QMSjkRMfvsvYLMW5cSJsUvhCNTUOjYADfByDRazcKcxbDmgaMmgsXcTQ+gn
 ZG/ElQ9ffLaWvcWemgf2J4iz4ZGi5UgM7jDAPDGobV1IfCLu4+sgmoReZhtNmwun92wSFEVehYg
 kft5d6MWc0OtUbygB+iVR4bEkPip8Ogi58Vk1xP0UScCOmJkRfb3d4wCWJoeFmW14pVdvVzCDgC
 BSKPYhqcIFgaEshKHcdigesKrMFcQinxSmyC1o5+7Y7AeWBVjqDjsI1XkCz0d0Fh2S3lewkCJPY
 sxllyEftNXl4SaFHf+/78WS8CFcbU4WmWuEHrpzCUqXFB+LnOb3O9+lZELz2ItZPvksSPSM0awF
 VN3g70r7R8SSqsk/vOSEO+7qiep3PsNF8gd9ssn6fRk8ACL139G+5L3qY3+u1i6BOm37VgvD9mK
 USsZ2IRL97+3XYZbuDXViRCOBgvXGdaCJWUED0KPYvLMHDPwuf
X-Received: by 2002:a17:903:32d2:b0:2a7:7f07:340e with SMTP id
 d9443c01a7336-2a844901809mr3288195ad.4.1769459933510; 
 Mon, 26 Jan 2026 12:38:53 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com.
 [35.187.245.222]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802fdce1fsm94536115ad.101.2026.01.26.12.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 12:38:53 -0800 (PST)
Date: Mon, 26 Jan 2026 20:38:44 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Williamson <alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
 intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v5 6/8] dma-buf: Add dma_buf_attach_revocable()
Message-ID: <aXfQ1LFNDUrfeuHf@google.com>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-6-f98fca917e96@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124-dmabuf-revoke-v5-6-f98fca917e96@nvidia.com>
X-Mailman-Approved-At: Tue, 27 Jan 2026 08:19:15 +0000
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

Hi Leon,

On Sat, Jan 24, 2026 at 09:14:18PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Some exporters need a flow to synchronously revoke access to the DMA-buf
> by importers. Once revoke is completed the importer is not permitted to
> touch the memory otherwise they may get IOMMU faults, AERs, or worse.
> 
> DMA-buf today defines a revoke flow, for both pinned and dynamic
> importers, which is broadly:
> 
> 	dma_resv_lock(dmabuf->resv, NULL);
> 	// Prevent new mappings from being established
> 	priv->revoked = true;
> 
> 	// Tell all importers to eventually unmap
> 	dma_buf_invalidate_mappings(dmabuf);
> 
> 	// Wait for any inprogress fences on the old mapping
> 	dma_resv_wait_timeout(dmabuf->resv,
> 			      DMA_RESV_USAGE_BOOKKEEP, false,
> 			      MAX_SCHEDULE_TIMEOUT);
> 	dma_resv_unlock(dmabuf->resv, NULL);
> 
> 	// Wait for all importers to complete unmap
> 	wait_for_completion(&priv->unmapped_comp);
> 
> This works well, and an importer that continues to access the DMA-buf
> after unmapping it is very buggy.
> 
> However, the final wait for unmap is effectively unbounded. Several
> importers do not support invalidate_mappings() at all and won't unmap
> until userspace triggers it.
> 
> This unbounded wait is not suitable for exporters like VFIO and RDMA tha
> need to issue revoke as part of their normal operations.
> 
> Add dma_buf_attach_revocable() to allow exporters to determine the
> difference between importers that can complete the above in bounded time,
> and those that can't. It can be called inside the exporter's attach op to
> reject incompatible importers.
> 
> Document these details about how dma_buf_invalidate_mappings() works and
> what the required sequence is to achieve a full revocation.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/dma-buf/dma-buf.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/dma-buf.h   |  9 +++------
>  2 files changed, 50 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 1629312d364a..f0e05227bda8 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -1242,13 +1242,59 @@ void dma_buf_unmap_attachment_unlocked(struct dma_buf_attachment *attach,
>  }
>  EXPORT_SYMBOL_NS_GPL(dma_buf_unmap_attachment_unlocked, "DMA_BUF");
>  
> +/**
> + * dma_buf_attach_revocable - check if a DMA-buf importer implements
> + * revoke semantics.
> + * @attach: the DMA-buf attachment to check
> + *
> + * Returns true if the DMA-buf importer can support the revoke sequence
> + * explained in dma_buf_invalidate_mappings() within bounded time. Meaning the
> + * importer implements invalidate_mappings() and ensures that unmap is called as
> + * a result.
> + */
> +bool dma_buf_attach_revocable(struct dma_buf_attachment *attach)
> +{
> +	return attach->importer_ops &&
> +	       attach->importer_ops->invalidate_mappings;
> +}
> +EXPORT_SYMBOL_NS_GPL(dma_buf_attach_revocable, "DMA_BUF");
> +

I noticed that Patch 5 removes the invalidate_mappings stub from 
umem_dmabuf.c, effectively making the callback NULL for an RDMA 
importer. Consequently, dma_buf_attach_revocable() (introduced here)
will return false for these importers.

Since the cover letter mentions that VFIO will use
dma_buf_attach_revocable() to prevent unbounded waits, this appears to
effectively block paths like the VFIO-export -> RDMA-import path..

Given that RDMA is a significant consumer of dma-bufs, are there plans
to implement proper revocation support in the IB/RDMA core (umem_dmabuf)? 

It would be good to know if there's a plan for bringing such importers
into compliance with the new revocation semantics so they can interop
with VFIO OR are we completely ruling out users like RDMA / IB importing
any DMABUFs exported by VFIO?

Thanks,
Praan
