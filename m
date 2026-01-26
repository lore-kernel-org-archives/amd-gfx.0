Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC352D19512
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 08:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F4C610E4E7;
	Tue, 27 Jan 2026 08:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="DfSwyHQZ";
	dkim-atps=neutral
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6BC010E496
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 21:01:11 +0000 (UTC)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-89461ccc46eso89763056d6.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 13:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1769461271; x=1770066071; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Tu3uAyHuSXXXZq6VSWtVG72sHh/RWKg7/MHSYDvcONg=;
 b=DfSwyHQZmNsEGg8EpRn1mki1izenW5u61iuEqI7EItSrQEJoDT7B9jwIEUl8hqT67E
 c2uNqDBKBVshbT9w9eUB5AB7ESoz96kMHiWlFjxxF8QZE8YkD0MrT3pV/pyEI35DpMwI
 8qlLlKIhAc2XlON+51hHM7j/YfiSJwey7C3WJ+/sWl8Dee4W5ocgbuH+cQjmZiN+WsiW
 355x854O7+2SkZN2EsVMMyMHyczGKYBMB8BtAh46KP0JoXjdAytYuhLBEGz0LTpnQqI2
 2SjN3IJDKXYsL8CbY9vyVyo2WmcrcuROVnhnX8iLyvO06QlfH9jVIX9rZIXQXgx8nCyW
 bHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769461271; x=1770066071;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tu3uAyHuSXXXZq6VSWtVG72sHh/RWKg7/MHSYDvcONg=;
 b=f07Q2nfrGs64r78jLL3V9pBsqjloWCH7Wo5MvQk+LPlGTGbW6E26bpkPbxOsMR9eTB
 QbEziYNJpo7kaDfK+Viw2MHapIyZ5IpfdQf+IrdBETkuHNDgvlws/Lzns2LzUnRZy2wc
 mc9m9oCp3D3BYgMxrWuazfvPGe7h+egsxBfY0+r3GmxqS1YH7xSHO2pepc/DeWEOoaFG
 9YW1wgSpasuezIPFaz4f2iKfxwbekZWRc9/NwMNsnw3OE+CK2LbKte6IhqTpPsTmiNRE
 xbEUWkI85PQ2D/z0tFtmEZFu69R9NONbBdgOyNACyAzVLV7LrOg9GToCJpAVmlWD3bWA
 2NnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5xph8HpJub53GYl3uAFTkF2Bm6ubfPe4zkzi4TSR5ZgLRGcUIDmasBIbvLqvu+PtDpkfp5GPn@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0hXbB4kLiq8JYdT03CHlbboKm83WVLSGH4ybvFWSgwnZz2zJv
 ld+xTB+C4heOCmFlJAEKltUqUL8TLCZs/p6EiympM2+eU6nZnxc5jdYM8CfLPhI461o=
X-Gm-Gg: AZuq6aJdQdQPvmfP8GsObCwg+l8ZIePu+lGkUn4BUrDhpZ3Jw1YEjdAnV5EJ69WCMKU
 GY8UIn0nRPjCq+jdEQVNKOwf0XPGwfbVIX9EklPXcoXgvgxzGqiXVAZ1q2e96q+iplwy1JqkbS2
 FbIXPnlJLtHqJKSVRpCCD/stNYa89DJIYPVLdVDj+djcOUlzDdQD5WiH5FfSPgaJdYW9xCyiwYB
 W96U8tkY3RmIzkuNHjk5u/hChIjOIFbn/wLXuTI+mWcJbvHkhL7rTVX7f1IlP7M8dzdavvkVf+X
 OwtFTawgJseAlXKU5JK9kCFzkaUmuY2qdpqiH4kkzH0UUcgO8j189y0KefuI35764H9XfN5fZxt
 5lAtyiBGLlODMRQz0zaZYcbtW7/qg0zrPSu0DEtZeAIpNMUZTtL5c4dXhOMbTyCEU9R3pxe5TYs
 y/oWl+XePNyd4gAGTD5JDRedHD9LbU2a0Za5dzAP0fw4Au6rlVaySnS68pHA5TdomCKG0=
X-Received: by 2002:a05:6214:1cc9:b0:894:7b34:dacd with SMTP id
 6a1803df08f44-894b06f336dmr73487126d6.31.1769461270245; 
 Mon, 26 Jan 2026 13:01:10 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894918b1436sm104983856d6.35.2026.01.26.13.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:01:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vkThs-00000008z30-31vX;
 Mon, 26 Jan 2026 17:01:08 -0400
Date: Mon, 26 Jan 2026 17:01:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
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
Subject: Re: [PATCH v5 6/8] dma-buf: Add dma_buf_attach_revocable()
Message-ID: <20260126210108.GD1641016@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-6-f98fca917e96@nvidia.com>
 <aXfQ1LFNDUrfeuHf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXfQ1LFNDUrfeuHf@google.com>
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

On Mon, Jan 26, 2026 at 08:38:44PM +0000, Pranjal Shrivastava wrote:
> I noticed that Patch 5 removes the invalidate_mappings stub from 
> umem_dmabuf.c, effectively making the callback NULL for an RDMA 
> importer. Consequently, dma_buf_attach_revocable() (introduced here)
> will return false for these importers.

Yes, that is the intention.

> Since the cover letter mentions that VFIO will use
> dma_buf_attach_revocable() to prevent unbounded waits, this appears to
> effectively block paths like the VFIO-export -> RDMA-import path..

It remains usable with the ODP path and people are using that right
now.

> Given that RDMA is a significant consumer of dma-bufs, are there plans
> to implement proper revocation support in the IB/RDMA core (umem_dmabuf)? 

This depends on each HW, they need a way to implement the revoke
semantic. I can't guess what is possible, but I would hope that most
HW could at least do a revoke on a real MR.

Eg a MR rereg operation to a kernel owned empty PD is an effective
"revoke", and MR rereg is at least defined by standards so HW should
implement it.
 
> It would be good to know if there's a plan for bringing such importers
> into compliance with the new revocation semantics so they can interop
> with VFIO OR are we completely ruling out users like RDMA / IB importing
> any DMABUFs exported by VFIO?

It will be driver dependent, there is no one shot update here.

Jason
