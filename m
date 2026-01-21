Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FC8D26296
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 13:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B3610E7A9;
	Wed, 21 Jan 2026 13:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="dr0ExeED";
	dkim-atps=neutral
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 358FB88F94
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 13:31:52 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-502a26e8711so28381861cf.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 05:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1769002311; x=1769607111; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aX294P4TliS2B0BrPhrC1yfpgvWNBReUGID/aL6TSBE=;
 b=dr0ExeEDyi5g/bVQS07zFXkgjtpQtmdamxgvPGa+Qbt/TLE9ulnRuTb7t3D5dZVvMe
 esid7rScWII/APmsLWprvrilGK25VG4wiMFTEwMFsqLMep3Qd98RCrpTnaSSgbYketgo
 yECNYaz6dqFX5Tj1zQdBPEG5SNFI5bhclWDYpM68gS2axBR0z03aaGyCNVbdlkqUKr1V
 tJnThtjASU/QEBYtNcMV/k6T15M/jntvWQjn2HmwQucJB1AcVvEYuJDir4nE0Zxz2p73
 Qj008tDzN1BE98X79V1ittf2pcofPaCJN+M1bZJAfJ+ufY3sL+V0x07tQi3WMgPfC29C
 sCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769002311; x=1769607111;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aX294P4TliS2B0BrPhrC1yfpgvWNBReUGID/aL6TSBE=;
 b=uGTje9RgJc/br6Xne83ZxOx8TXe+GzFl0MrjYlW9yM5HEPgfGYZZsYsRdJck529jGZ
 8hQkZ+8a9zv6sIHwByTmIa/PZ3KCfG7exvHwBOrPLoi2+GFuBSTEpgW04M+G7EqZW44d
 CBxSEqwn4mqlGQoplPDTqxmDy2BUp9XWYnCMAJCODKldjQHAI4+QuPCcVqXnWPrSwvpA
 Fi3ZNrzBqKUpjgXIKqrjp2l/AE0hAf5HSq8XWqp+iRGxgZfijfKs/VQjMYKwN9Kvqfuc
 YZ4dsAaaELZ/PTczmuspEo2B4lgNLwudJRvuT+iqWVKOcFkq/zjf/MSBhL9L8PlgpjDE
 MpOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTGlK+jA69BnOldTSclYOvQIUsnl0Y7Fq8PIdb66dzWip8qzbVdLBw2YRK15dsqaGf8n1fK2j/@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyd+FMGJk+qpezAJdS1+IsNxZL1mKZmEvjcxp1MmzGrbE+0XsBY
 nl+i0uqoqlQGkQwDQeG0Ssjr2LWH3IWX77Yi8k4d5RceiF0H0FzpcDU9mIv091skYxk=
X-Gm-Gg: AZuq6aINEsolBBpur1K2DpHtt7Fpu/Dv3ZDzPMKAhrYvQvz30Ep4nRBJ8Mv5Q8JZB4s
 ithk/Lt8wvdxgOkzwh6tWgF9lAlNCUXLe0o65uhVW2sYDxerdkt2901id+zQmA34DYFNCU7XA8j
 5DmM/R+jqiOrEZpcenwPs3vwTNqhi6ifhgo8NhFFqwYlA9p+N0eaC8PGKsPw74ud2RmSwH0eilT
 bXMJYKkXg++oqzARyonhgmwotnK9xm0Pa4jJMnaTDhYsGwZ8sUafq/kvFuZiHl8Jz5OYIDxOwck
 dYtuacNE1Je0fkXtvlZcn39JbfSDgkSYx2WUyf5hFQjBE68SGL56sTSjjXwqBu9qrp1qflPaTgE
 qLJ0vRYhi50yEawM+0PmRxZf1R87I5HYoBNukcPAqj0r/KmGSo9o+chaM7ZEztX/nFCCqedpRzr
 sXl1PeAyCGH2I3oLD4wnrMOBWOipdmijwFpvExeblirp7fTJg9AoDlebrbIwKGy2DyZsyirXLWU
 tnTyQ==
X-Received: by 2002:a05:622a:1aa1:b0:4ee:2200:409e with SMTP id
 d75a77b69052e-502d82772a6mr67009251cf.4.1769002308002; 
 Wed, 21 Jan 2026 05:31:48 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1f1c1c4sm108692291cf.33.2026.01.21.05.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 05:31:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1viYJG-00000006Dbm-2x5v;
 Wed, 21 Jan 2026 09:31:46 -0400
Date: Wed, 21 Jan 2026 09:31:46 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
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
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Williamson <alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
 intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v3 6/7] vfio: Wait for dma-buf invalidation to complete
Message-ID: <20260121133146.GY961572@ziepe.ca>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
 <20260120-dmabuf-revoke-v3-6-b7e0b07b8214@nvidia.com>
 <b129f0c1-b61e-4efb-9e25-d8cdadaca1b3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b129f0c1-b61e-4efb-9e25-d8cdadaca1b3@amd.com>
X-Mailman-Approved-At: Wed, 21 Jan 2026 13:47:28 +0000
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

On Wed, Jan 21, 2026 at 10:20:51AM +0100, Christian König wrote:
> On 1/20/26 15:07, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > dma-buf invalidation is performed asynchronously by hardware, so VFIO must
> > wait until all affected objects have been fully invalidated.
> > 
> > Fixes: 5d74781ebc86 ("vfio/pci: Add dma-buf export support for MMIO regions")
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>
> 
> Please also keep in mind that the while this wait for all fences for
> correctness you also need to keep the mapping valid until
> dma_buf_unmap_attachment() was called.

Can you elaborate on this more?

I think what we want for dma_buf_attach_revocable() is the strong
guarentee that the importer stops doing all access to the memory once
this sequence is completed and the exporter can rely on it. I don't
think this works any other way.

This is already true for dynamic move capable importers, right?

For the non-revocable importers I can see the invalidate sequence is
more of an advisory thing and you can't know the access is gone until
the map is undone.

> In other words you can only redirect the DMA-addresses previously
> given out into nirvana (or a dummy memory or similar), but you still
> need to avoid re-using them for something else.

Does any driver do this? If you unload/reload a GPU driver it is
going to re-use the addresses handed out?

Jason
