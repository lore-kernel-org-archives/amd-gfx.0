Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23587D62608
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 08:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B134210E932;
	Thu, 22 Jan 2026 08:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="eQZoHiu2";
	dkim-atps=neutral
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C6010E23D
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 16:02:02 +0000 (UTC)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-88a2e3bd3cdso11698136d6.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 08:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1769011321; x=1769616121; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Xk50a3DJCYgVIrcCVz4YsPwnwCkWAaxm0jVyWa00IrY=;
 b=eQZoHiu2Q4Ww0a0jkGIOITUUGhm2q/lPsRwQ9OVnzH3K4OMBZwX+5iTv8GQ6gb41uq
 fkjFTrQ+rh1J3SbpEG6nLXUaEpiVjrY6WYXQaqurA8+aDXKCx9F3B1O2D1FkJHD+PaLT
 rFZglOOwPDoSh1fqFuezGhvgPFtKG/PyNtYFkcneFZCA5x0yCIN5ED3jth6DkJGOsuNV
 ml+PyZcaM4ksze651IOcCWDTdWp9bGd3ZDeMP6ENzmNybFNAz/IQnWZ6efG2Ka8h5jY2
 Rk6EvlEzgrt1Ze7HiYzOBM7IhOe/6nuwMgUuhafD2O9b8wYtKbBNtGQGw3wiIGlh3caU
 z1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769011321; x=1769616121;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xk50a3DJCYgVIrcCVz4YsPwnwCkWAaxm0jVyWa00IrY=;
 b=Ypi5u2eIya6cqTm/lBUM0LJ9JsgvKD3iedbj1VpkjOTopkC5LyrQLI1e1WFjHU3CuW
 UDlNWBJ8Q1RGUi8G3D/MJiUdTW4eX7Cmh47Dz2WENd7XA0TC47+tlMIPVs5HRGrzAf+s
 QX9mokP8DIORsMXbaezUAEY7nAO7mXr5HuRX7FYmS5jhr6jebK8KWu6OptHC8lYoXBtq
 OCR3RatG1wmk/demIac8NavihHW97SFi+Qf8ETV6cp+Z+aoTVn6rb8DZ2VLD4tjYQ7vu
 vXXYR/zhzHOa3fU5usmMnQIOM1+hNVoKmlORD/tV7cZ1ahZqXIUKeWAs3QSpvBB3Eb7Q
 UWlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwLcuFUVnE+18t+kaeBG2RgdoRkIXtLwlGR69TChEevUmdHmIQnL265zMlTylrBajduobQzc1q@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyXT26bmI9C7l2AMSC2WwqTFw0pHGZJimyvYPdyXgIgjI+WrTOl
 FvN++KMQb0EBxzwkcZMqzZBFpdMFu2HjigQZDb/I9BjT6gWsmHlKJujISzocZ9uWEB4=
X-Gm-Gg: AZuq6aIIZJKthcYcf0xfqQrCEjUkQoPpoIRElHslSA0D++2LR13eJ4vZaMUKkgUj/DP
 MWj8e76r+sWBsdogO0G9bxsVhMA8E9742kPZO6AaUvQh9l7DrZvV4AqDhoTmZ3caljMVoUG9JLx
 +QHFm73tkPAGHlgeyHLRcQrv2hAnWmur1LoOJNUj9gSvAFBvqTsjDS4Wp07HKlEdPOa9aBnjAfu
 hDgMqQcwu0l6wFH6wA+uYsQ+uX9+hJ3DUDupGLj9xj1gwPD4ScoK/e2iIerG1OjZoIX3dZF4p75
 SyaaK+x/S+5MIMJJfcgv+Uxq0feVH/8ydIohMzhIsXfrk76G2sO3StB3IO26QogdQrB+LApd3x2
 N39vT6BttOYAqALz8uP6bhl2DaCszis6p7IuxfsIjdcUqVTMuCG+YXj7kdb0aVSi5p3NbAWbvfW
 fgieBJwKgwwe/bISZzX0sCaBOe5X8QDdnIf6QaRbLHLYisNPcwMx8l/LkpQcLtcVBc/6oMUE1WB
 Q3c3g==
X-Received: by 2002:ad4:5c4d:0:b0:88a:3861:9131 with SMTP id
 6a1803df08f44-893982737e8mr294508076d6.34.1769011302558; 
 Wed, 21 Jan 2026 08:01:42 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8946e3aee12sm27692726d6.39.2026.01.21.08.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 08:01:41 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1viaeK-00000006Es6-2jLq;
 Wed, 21 Jan 2026 12:01:40 -0400
Date: Wed, 21 Jan 2026 12:01:40 -0400
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
Message-ID: <20260121160140.GF961572@ziepe.ca>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
 <20260120-dmabuf-revoke-v3-6-b7e0b07b8214@nvidia.com>
 <b129f0c1-b61e-4efb-9e25-d8cdadaca1b3@amd.com>
 <20260121133146.GY961572@ziepe.ca>
 <b88b500c-bacc-483d-9d1a-725d4158302a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b88b500c-bacc-483d-9d1a-725d4158302a@amd.com>
X-Mailman-Approved-At: Thu, 22 Jan 2026 08:36:26 +0000
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

On Wed, Jan 21, 2026 at 04:28:17PM +0100, Christian König wrote:
> On 1/21/26 14:31, Jason Gunthorpe wrote:
> > On Wed, Jan 21, 2026 at 10:20:51AM +0100, Christian König wrote:
> >> On 1/20/26 15:07, Leon Romanovsky wrote:
> >>> From: Leon Romanovsky <leonro@nvidia.com>
> >>>
> >>> dma-buf invalidation is performed asynchronously by hardware, so VFIO must
> >>> wait until all affected objects have been fully invalidated.
> >>>
> >>> Fixes: 5d74781ebc86 ("vfio/pci: Add dma-buf export support for MMIO regions")
> >>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >>
> >> Reviewed-by: Christian König <christian.koenig@amd.com>
> >>
> >> Please also keep in mind that the while this wait for all fences for
> >> correctness you also need to keep the mapping valid until
> >> dma_buf_unmap_attachment() was called.
> > 
> > Can you elaborate on this more?
> > 
> > I think what we want for dma_buf_attach_revocable() is the strong
> > guarentee that the importer stops doing all access to the memory once
> > this sequence is completed and the exporter can rely on it. I don't
> > think this works any other way.
> > 
> > This is already true for dynamic move capable importers, right?
> 
> Not quite, no.

:(

It is kind of shocking to hear these APIs work like this with such a
loose lifetime definition. Leon can you include some of these detail
in the new comments?

> >> In other words you can only redirect the DMA-addresses previously
> >> given out into nirvana (or a dummy memory or similar), but you still
> >> need to avoid re-using them for something else.
> > 
> > Does any driver do this? If you unload/reload a GPU driver it is
> > going to re-use the addresses handed out?
> 
> I never fully read through all the source code, but if I'm not
> completely mistaken that is enforced for all GPU drivers through the
> DMA-buf and DRM layer lifetime handling and I think even in other in
> kernel frameworks like V4L, alsa etc...

> What roughly happens is that each DMA-buf mapping through a couple
> of hoops keeps a reference on the device, so even after a hotplug
> event the device can only fully go away after all housekeeping
> structures are destroyed and buffers freed.

A simple reference on the device means nothing for these kinds of
questions. It does not stop unloading and reloading a driver.

Obviously if the driver is loaded fresh it will reallocate.

To do what you are saying the DRM drivers would have to block during
driver remove until all unmaps happen.

> Background is that a lot of device still make reads even after you
> have invalidated a mapping, but then discard the result.

And they also don't insert fences to conclude that?

> So when you don't have same grace period you end up with PCI AER,
> warnings from IOMMU, random accesses to PCI BARs which just happen
> to be in the old location of something etc...

Yes, definitely. It is very important to have a definitive point in
the API where all accesses stop. While "read but discard" seems
harmless on the surface, there are corner cases where it is not OK.

Am I understanding right that these devices must finish their reads
before doing unmap?

> I would rather like to keep that semantics even for forcefully
> shootdowns since it proved to be rather reliable.

We can investigate making unmap the barrier point if this is the case.

Jason
