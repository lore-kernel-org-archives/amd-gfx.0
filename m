Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3599606A684
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=gC4FdWUQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6655C10F32E;
	Tue, 24 Nov 2026 08:43:33 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEFB210E5B2
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 16:57:18 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-93f2049ea7aso262056085a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 08:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1795453038; x=1796057838; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j5i4WU3qjrhh//MRl3wcVLLT33h5NdpwdC0V5dWlBjs=;
 b=gC4FdWUQIkp8XkC2othmWWiR4p4NdW04zySqz727AbSirFysjTBiiOcNfgvyd2epdr
 oSGSRMxzVzpnc5QvF/nLjYu+K18jJzgX4dDGfokGgHPfxCGD3+CJuLgvpuHwAl/VMYqy
 VbUWspgRs7fIb4Wvq2mACbx3B+BZakc+GWKZ8sRqQ0FXXZ6Vh83Xlab+5FUyA2SzAAYs
 IPt8otyg1z3oqSzYMh/c5i267qZwlIXxZgHpT3otg3qNCsEipx0yqGamGqGVt6hS1rIW
 gmwCRCHqtm033xpEbZzEuf+o0PoJrTxs+EV93bQ9nBKdsv+S2ZuoPco8WR4HjtBCdSBN
 nkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795453038; x=1796057838;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=j5i4WU3qjrhh//MRl3wcVLLT33h5NdpwdC0V5dWlBjs=;
 b=jsbmye1SPoJXgTVlkA/Y7W0HQM+IZWoyItI5UFKGjRdrH6/O/qTgm48ZXMexI9YinX
 bt6u7kHBQzXAWEek3UgCz0Wo+Tkwh/5md7oRhYeeAFQCvOxbWVbZZObn9YrQUmzENkFF
 kytpm/H85Uy3ImPHQqhx7dfEZU8AiiDdMcHr2gJ6m2im1TyFv1v2vQ01Z7gza/91B0CS
 08n5C4tQmwjULk6EBfHibHaKW7yhcwexHwtvmPFnBbluepGTHEgXMnX49RxbUqQBmJhp
 trcwJ0OxPdEjm6D12OqveL41w/43UntgSqmrtTBuAoaxxxV65tUr1Mmq7lm27vDO+mxy
 vTTQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGBh32JrmGw+WLdAYuhXklAbZs4DzdY/lmQjLdV1fciBfffPYC++vvoVXPxFyRZXlqO/jPPJqdN@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/uNud4aKQ8lgERw01GdPkoeBlfPA8pvj53jsAgMarhAa4BQpH2
 kZ1qzzbaxjMH2plVEB4bDku6GjwMdyvCtic2G6eR9ijY0BXL0QKRL1YQ/uLpEqiWo0c=
X-Gm-Gg: AZFdTZdD72SLMyFv9n4VnEqUgKhUAB3YGUIDNl5Tpy3kl1m4UO8sXQGhb9ZhqJJH/C3
 Ii1gFo+hJoEgM0jEik7Zi1bbU93caDWre3+jNgmekfkEldWxHt6knYjPIhEIvkbCEo8TimQ/Bhj
 TUBa1lcrxjFQ/ZZJEXu5+zWkgNLrd5dGFYA3262y3KdGhO7myFmbfUefCc4n0Z58yuiHd5l4GIW
 GoJADVs+rxepuf7vL2IArW57r/mxpythaxRjxzp/N5qx2aiW34Sxuo8DHgefjABA9I7tX87GpWL
 zv4JEk+C7z3dCJLkYxySeBHByRhiH7e7XTjmwPmP7AyXAKxUA8wsQNHjpP4972tTIvi2WcCaub/
 eJRXhJYGPrMpZtUfgYBiL5acqgD8tUsGYAmO4jhZDiRSFqZX522ZTW+pmQLx9/5rkv2Du55uQ9p
 8viAEBqVMI1/kpLw+DwR9mXRF9+KjO8oGAWGDyo4jDnfldQdIKZwxJBtDnRmJ5V/Uuidlt+GG8i
 T0O9D8JOfCAIcFkITf2RdxMYYTphJAOFtSr3fbCcNMgdRVOtfChyBdCtSBlSt9eC2x8PjdC2Ixi
 TjrN94mcTCS3QDNUL7vteBsMk5kMmJ5gq+3ksHOz/wBmVh3Qhl6f9KvoKHExAJ2nE2CLCyr+TMX
 Wf57f+R2aEdoOpdWBkDTn3L71
X-Received: by 2002:a05:620a:270d:b0:949:8109:8bcd with SMTP id
 af79cd13be357-949bab6d24dmr1950593985a.77.1795453037117; 
 Mon, 23 Nov 2026 08:57:17 -0800 (PST)
Received: from ziepe.ca
 (stjhnbsu6iw-159-2-142-59.dhcp-dynamic.fibreop.nb.bellaliant.net.
 [159.2.142.59]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb031601sm844162485a.6.2026.11.23.08.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 08:57:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xVXLw-00000000woc-0Jy7;
 Mon, 23 Nov 2026 12:57:16 -0400
Date: Mon, 23 Nov 2026 12:57:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Dongwon Kim <dongwon.kim@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 Karl Mehltretter <kmehltretter@gmail.com>,
 Baolu Lu <baolu.lu@linux.intel.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 Alexey Kardashevskiy <aik@amd.com>, zhipingz@meta.com,
 treding@nvidia.com, jhubbard@nvidia.com, chaitanyak@nvidia.com,
 Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v3 03/24] dma-buf: Add the SGT DMA mapping type
Message-ID: <20261123165716.GM179082@ziepe.ca>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-3-c0183a409bdf@nvidia.com>
 <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:40:19 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 02:36:46PM +0100, Christian König wrote:
> On 11/20/26 06:55, Alistair Popple wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > The SGT (Scatter Gather Table) DMA mapping type represents the existing
> > sg_table/scatterlist based DMA mapping. For now it continues to use a
> > sg_table for map/unmap, but this will allow a future patch series to
> > convert to using a different data structure for importers without having
> > to convert all at once.
> 
> I strongly think we shouldn't have an SGT mapping type in the new DMA-buf mapping API.
> 
> Instead we should have something like either an array or an xarray
> of DMA addresses.

My plan was always to get there, but I don't think it is reasonable to
start there? There are too many places all over the place that are
just hardwired to do SGT right now.

Part of the design of this series was to allow the conversion away
from SGT to be done incrementally without breaking compatibility.

So it is effectively this:

> The framework should then either connect the SGT directly if both
> importer and export are using the "classic" interface 

And this:

> or convert
> from DMA-addr array to SGT and back if either of them are using this
> new interface.

Is something I imagined as a followup series.

As this is actually quite complicated and needs discussion exactly
what it will look like.

Jason
