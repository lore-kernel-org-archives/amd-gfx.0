Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DFCD2ED14
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 08:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7765910E581;
	Tue, 20 Jan 2026 08:25:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="G2Dgl8MZ";
	dkim-atps=neutral
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E59C10E4CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 16:44:23 +0000 (UTC)
Received: by mail-qt1-f193.google.com with SMTP id
 d75a77b69052e-50150bc7731so69638981cf.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 08:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1768841062; x=1769445862; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7mLdSjko9gcpWp2LFuEj2HWiy0Q3Aa6qTfE9JkGPgsY=;
 b=G2Dgl8MZBAZs9CEZRXcDt4Y33OEHkw2ZzBP5BjvHiuSuQtB8YPPb63/EJANkEDJx7k
 Bt1raykG4k9lmMYCuY+jHI0ZTvsWwrlGPSaYJU3ib8IRAjsX6WU9VeXLsZ+d+XJd7ztR
 D6UKV1AFRSYeddCuTOY3PUinva/2NzP0pnpfTWswNvMEz/zenuleslOjxgJ3CQAIX+gE
 cOU3UZWx6mp7Mj1iJsP+BHL4afzlgmMo1HZ4YGjZdW9dRVMtQpFOtlvyDLUe8XDZpdLw
 moiCImdFbmwpApmOAzgw/xRVOoeOoCQ7Q4Prj+F4tRlktlw48tM3rzjNDm7Y+IKMbzXN
 ni3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768841062; x=1769445862;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7mLdSjko9gcpWp2LFuEj2HWiy0Q3Aa6qTfE9JkGPgsY=;
 b=rFlr8U3TBzXHyBCloj0fdKkj20PtWJBwaWH6o0uvBv7qTkcSL2snwOPUtPW5bkAU1b
 Zkd23FZ4qMIh3MctLHTenvXwpzr1wwNz7SpffkLJKHwMBRw2AMEpGkuNyvyjatWi2SNK
 C4SW+th/okzLfGYkzX0sjih0b9GUs4e/pFhRc9PEhMouBftJKSJ+fwujTP+k7J436cvX
 /SBLytHn3dGddpanEr7xXrj5Lom/aXERvUPLdQdRWpf9LhnHGtEzaqTtES3anqO01s3g
 yQulzB1LPImT6dP89Sa3YiCPGZzXy0W4CJwPRMnChow/l9P/Zd9OCi0kt7nQp4AHQriE
 ywyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs628NYuklPaYwNQVE06GhZsWZv8uTaUfbnbJn2w61YIiINpwvv7WpHc5b5LA/hZP/TpIAGmNo@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx4rjT6vW5HzHvRFq+xqU1D+3CVA6kwBWsn+HehopDzRCt54pgb
 sZURmLn7ktW4nWDIv/uaWcHe3t8vJVEC+jE9xtrYhVukOoT+SeWOvaLsJ2thOtcgK94=
X-Gm-Gg: AY/fxX5XxSIzQ1rCyi7sKELuc7NlUrn3B63DyWXtuK+wog42wYXFu/mpg2XTpktkIwf
 Ws/JTOalNEC7+R0CVSBOyzOQgnmSYby7b+IEH//OyihwD1Y133Ja/4mApG0et1/VWzAnPVaC+oG
 /AiQ88JHSQKrIRz6DWl51kLybE+hjY40dd40O23q4cK+9mnFh25ujYhwVGct6mFldiC7cICFvZb
 QbSB++KN54DqyU3lVbZFe03LBGVhY2gwaBs7ei9SDlCVZc+onPfqhIsl+B0HuBIdrByCnWW+5Rt
 GN8uFAhTZTExktR6y72hSB6xaV6uRmW/66RZC4xZS/2rsmVtvOWQZt4WJ5jNJRQBEcGieH0T6U8
 /6vnMu2hbKmZ/uDK2OEo4vwgjjQenx8EJPU7ZgNIcu/AXXc0OJ+5Cr66hPgvvVHDWwkAHFqe+Pi
 1ds8q/jQ+ZSGKzmoeehkB44QQ8tJSocFu2pl/DtyEOqPVCjGmV+EaRlXH0Xe/PqOcOQdQ=
X-Received: by 2002:ac8:7d16:0:b0:4ee:1b36:b5c2 with SMTP id
 d75a77b69052e-502a1f87eb4mr182498161cf.68.1768841062394; 
 Mon, 19 Jan 2026 08:44:22 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1ed3155sm72779401cf.19.2026.01.19.08.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 08:44:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vhsMX-00000005IKH-0ezs;
 Mon, 19 Jan 2026 12:44:21 -0400
Date: Mon, 19 Jan 2026 12:44:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dma-buf: Document revoke semantics
Message-ID: <20260119164421.GF961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
 <20260118-dmabuf-revoke-v2-2-a03bb27c0875@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260118-dmabuf-revoke-v2-2-a03bb27c0875@nvidia.com>
X-Mailman-Approved-At: Tue, 20 Jan 2026 08:25:58 +0000
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

On Sun, Jan 18, 2026 at 02:08:46PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Document a DMA-buf revoke mechanism that allows an exporter to explicitly
> invalidate ("kill") a shared buffer after it has been handed out to
> importers. Once revoked, all further CPU and device access is blocked, and
> importers consistently observe failure.
> 
> This requires both importers and exporters to honor the revoke contract.
> 
> For importers, this means implementing .invalidate_mappings() and calling
> dma_buf_pin() after the DMA‑buf is attached to verify the exporter’s support
> for revocation.
> 
> For exporters, this means implementing the .pin() callback, which checks
> the DMA‑buf attachment for a valid revoke implementation.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  include/linux/dma-buf.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index 1b397635c793..e0bc0b7119f5 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -579,6 +579,25 @@ static inline bool dma_buf_is_dynamic(struct dma_buf *dmabuf)
>  	return !!dmabuf->ops->pin;
>  }
>  
> +/**
> + * dma_buf_attachment_is_revoke - check if a DMA-buf importer implements
> + * revoke semantics.
> + * @attach: the DMA-buf attachment to check
> + *
> + * Returns true if DMA-buf importer honors revoke semantics, which is
> + * negotiated with the exporter, by making sure that importer implements
> + * .invalidate_mappings() callback and calls to dma_buf_pin() after
> + * DMA-buf attach.
> + */

I think this clarification should also have comment to
dma_buf_move_notify(). Maybe like this:

@@ -1324,7 +1324,18 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_sgt_unmap_attachment_unlocked, "DMA_BUF");
  * @dmabuf:    [in]    buffer which is moving
  *
  * Informs all attachments that they need to destroy and recreate all their
- * mappings.
+ * mappings. If the attachment is dynamic then the dynamic importer is expected
+ * to invalidate any caches it has of the mapping result and perform a new
+ * mapping request before allowing HW to do any further DMA.
+ *
+ * If the attachment is pinned then this informs the pinned importer that
+ * the underlying mapping is no longer available. Pinned importers may take
+ * this is as a permanent revocation so exporters should not trigger it
+ * lightly.
+ *
+ * For legacy pinned importers that cannot support invalidation this is a NOP.
+ * Drivers can call dma_buf_attachment_is_revoke() to determine if the
+ * importer supports this.
  */

Also it would be nice to document what Christian pointed out regarding
fences after move_notify.

> +static inline bool
> +dma_buf_attachment_is_revoke(struct dma_buf_attachment *attach)
> +{
> +	return IS_ENABLED(CONFIG_DMABUF_MOVE_NOTIFY) &&
> +	       dma_buf_is_dynamic(attach->dmabuf) &&
> +	       (attach->importer_ops &&
> +		attach->importer_ops->invalidate_mappings);
> +}

And I don't think we should use a NULL invalidate_mappings function
pointer to signal this.

It sounds like the direction is to require importers to support
move_notify, so we should not make it easy to just drop a NULL in the
ops struct to get out of the desired configuration.

I suggest defining a function
"dma_buf_unsupported_invalidate_mappings" and use
EXPORT_SYMBOL_FOR_MODULES so only RDMA can use it. Then check for that
along with NULL importer_ops to cover the two cases where it is not
allowed.

The only reason RDMA has to use dma_buf_dynamic_attach() is to set the
allow_p2p=true ..

Jason
