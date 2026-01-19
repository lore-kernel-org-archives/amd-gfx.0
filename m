Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BDED2ED0F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 08:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D426810E57A;
	Tue, 20 Jan 2026 08:25:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="HFsDn4Ir";
	dkim-atps=neutral
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB82510E4DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 16:20:29 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id
 af79cd13be357-8c53198a65fso443721185a.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 08:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1768839629; x=1769444429; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8e3LOQmDLtNbqPr2ZRZYrAEb0+eSE57gTBol5BlL7sE=;
 b=HFsDn4IrZolA0+dw7D1dnQ4l+xDV2raTFFdCABhXzH5wVXyuKmY37SjxAtspPq9Or+
 96hCzkbmQakIGjhAc3Z3N2RQ1TO5l8kV3HB6B5tc0Nd91TwDKvE+z39uiU+Z41rIiGEH
 qsqMY4aWS8q1gnVeNNJmHWl2wdrTVjdtL1EqQhxXA/vO6MbG1BZxNGGXMrJpnK+1eCm8
 b0SlgCTfDuG6keYxx70LhGx7E9xxPaMsr2gxPHDrAdNMxaG17FQPVuRTYR92rdlyTZDm
 ynmPkG/8i24flf3EHFI4d6Z+Lepo9pBKCLThERDHClX2zBL29tM8U4ehGv94WnfSfuTx
 2Ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768839629; x=1769444429;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8e3LOQmDLtNbqPr2ZRZYrAEb0+eSE57gTBol5BlL7sE=;
 b=VachD5+1tLNsatGcOsGagQOwF0znejJIIcivdqWhDc33TGB2j6wB34vav5rrCChWgS
 ROGfpiYcOAAHj/vkZYctWw6l9jFIrxp/qxm/yCef/BKHWsGQsSEH2lI086dmxYp3qc4T
 O3lrFj5j/+EzTyvjZQRWbJbSrvsdi7ezyQ3+HBbT+JVEHOIo1wd3Rtvf2LdLk5h/tGaS
 28VJKvI4TKY7GgjltybKZckY8AoKHPt/dU009yCV3rwkasPlHGw9+6Xx1AAAAOmKMu8D
 oeAdks1FIwiQV71vDK8+iISEtCftlh1sQLnm2dUIZ+8x7/s8i0Rl5bIQK/bX/Pfto2Bc
 e8sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm0xp57I9l3yMxr4pAucu/KqgNmEoqaefi+r8WCYQDM9+ltg4Rr/1kwxgyrEbsBvlR/HOvK+Jr@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYL/n+R1GWVPdGrkB1XpEQfmizE0Vn2i1UPRUtE4iKVVuV1HnN
 l3saNfbkBNqnOXHKuTgPARrTJmPwDM3qceFiUGLO9799cStaUZRVDe+yR1EVHBaXwrI=
X-Gm-Gg: AY/fxX4MezM5lVh3+AkBtqo4fI8o2pgvZP6eeCMuaT2BZPJTAnnBdXlKBisshXq4fdB
 TNOK+AvVmO9D7OicnVfAAS6lP0E1ihEOkf3YyOFkkfOmCQhPDobJLF0/ha3dVhL0ydu5YgorVZa
 9BCxMXE3Ujdjh6tXS+JbDmQmMBm9TiUphoLEleTwQnM+k2n6TRxdl9KSKZVJHsW3mVMkUtfmcQC
 MYTvITZAd58dHzLodxp0BKz6G8jVZmBgAopZv8t9DUTeqLP+qBP6zasfzd+8CXslAmcWf1ePw4F
 mvHc9TethCullenDEO51ULp81QYPhYC9fXvH1R4kW6slVzJgOqB9mRthf6TBDLgDvjVuop9kJZ/
 uWuvVOL8kOY6bMma4fol10PeczLucBjR27Bsd8S0ZH9/TQtUucRqqyvK10vekjFldpntbHsUg2C
 NL9I2Qx1Sxw+FkmKinhCjX9mP6Cu53dlsnWXUWuOxiy841dpmeOmeEYDDknrDjnP8xOggy5fEu8
 VOrAA==
X-Received: by 2002:a05:620a:7102:b0:8b2:7679:4d2d with SMTP id
 af79cd13be357-8c6a6948169mr1559881085a.63.1768839628533; 
 Mon, 19 Jan 2026 08:20:28 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6af506829sm597447585a.37.2026.01.19.08.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 08:20:27 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vhrzP-00000005HvQ-0mnE;
 Mon, 19 Jan 2026 12:20:27 -0400
Date: Mon, 19 Jan 2026 12:20:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
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
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/4] dma-buf: document revoke mechanism to invalidate
 shared buffers
Message-ID: <20260119162027.GD961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
 <f115c91bbc9c6087d8b32917b9e24e3363a91f33.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f115c91bbc9c6087d8b32917b9e24e3363a91f33.camel@linux.intel.com>
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

On Sun, Jan 18, 2026 at 03:16:25PM +0100, Thomas Hellström wrote:
> > core
> > “revoked” state on the dma-buf object and a corresponding exporter-
> > triggered
> > revoke operation. Once a dma-buf is revoked, new access paths are
> > blocked so
> > that attempts to DMA-map, vmap, or mmap the buffer fail in a
> > consistent way.
> 
> This sounds like it does not match how many GPU-drivers use the
> move_notify() callback.
> 
> move_notify() would typically invalidate any device maps and any
> asynchronous part of that invalidation would be complete when the dma-
> buf's reservation object becomes idle WRT DMA_RESV_USAGE_BOOKKEEP
> fences.
> 
> However, the importer could, after obtaining the resv lock, obtain a
> new map using dma_buf_map_attachment(), and I'd assume the CPU maps
> work in the same way, I.E. move_notify() does not *permanently* revoke
> importer access.

I think this was explained a bit in this thread, but I wanted to
repeat the explanation to be really clear..

If the attachment is not pinned than calling move_notify() is as you
say. The importer should expect multiple move_notify() calls and
handle all of them. The exporter can move the location around and make
it revoked/unrevoked at will. If it is revoked then
dma_buf_map_attachment() fails, the importer could cache this and fail
DMAs until the next move_notify().

If the attachment is *pinned* then we propose to allow the importer to
revoke only and not require restoration. IOW a later move_notify()
that signals a previously failing dma_buf_map_attachment() is no
longer failing can be igmored by a pinned importer.

This at least matches what iommufd is able to do right now.

IOW, calling move_notify() on a pinned DMABUF is a special operationg
we are calling "revoke" and means that the exporter accepts that the
mapping is potentially gone from pinned importers forever. ie don't
use it lightly.

Jason
