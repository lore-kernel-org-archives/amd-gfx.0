Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF42606A321
	for <amd-gfx@archiver.kernel.org>; Sat, 28 Nov 2026 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=KjexScqq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F59510E58C;
	Sat, 28 Nov 2026 09:41:13 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E03E310E9F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 12:57:56 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-5430f70c827so94725541cf.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 04:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1795784276; x=1796389076; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hpgxxji67KrMZBTg6jUjcNbfY5cNwEwJL3jB25wL4Zo=;
 b=KjexScqqkscyKiYsjpoZdFpAr1M4jNI6SevBmR42Ifv6Pw0JPnEtQNb2wrNNLlbGlE
 sw1ntC4wme31nveN/Ec8qH1WPMF+s6yWRGUSMzpKCJHWK04yUKT9HKA+rxK7kjNh8Pd3
 qK+1MfCEa6btcyYLVUluaH/g4SnLanB6tfVr/F/MjHyxyZQMWQvXDr8G1MKiRut1+F8Y
 xapfuNavcrmnQiwLMdY0fvwnlf4lMmWLkNnTNYP4kATUL9SDmqNwXSOEHwRSL0ESOu0P
 CB+kmlpntSF9xCQS1I6S7+2BceYdte8QR7XrtPGZxCNDdBsC8f9UiNAeIjCH1kF8TQLA
 G0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795784276; x=1796389076;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hpgxxji67KrMZBTg6jUjcNbfY5cNwEwJL3jB25wL4Zo=;
 b=BNUL4PvUghi3j7GULEKvPWVrgSRso9Nd9voUbYDTqTTly56A8hBqN3QSsM2dFY9eNc
 44/+29d+DZniMxbR3Cs7ZbRLcEYrHeAGrCQ7c2elVGx7sFl/QsZwCMbGEGkqqYPikY1u
 xAGdUAG5KSaDNMPeBjMFzc1BEBOcY2DEm611vmMaLW8P/7Ix8j130vHD5cQiYRVx5J6t
 NDtIJC1HKimHATAuS3ZF5rqRmofabs7oouy1NMF384SRpzo34tf75l0hF3K1LSaDM//m
 fuuZRgMVlN6eDfH5ceqUYvUG225q6LIjLbuPrY05xdjdKO00/lQPlyZ9YdrKwJQNi/sM
 5CJQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEumrCvnW2Hj+XlCkHfgFgR5UptRY7DQeZkhCt8GrkViTOLApQ6CX2pIogMuomHNPh7sZdiA/By@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/KTJNS2qt91QJKMNtGYIbSLYmXWDCFvNzmeO/IR66dKqcnuKQu
 fjHbeASc85d/wZvfQWTgLHGaYcgBsrBdJ2Rt/C5MGAJ1Q/EONmY3HSw1xQ1xRYIHs9M=
X-Gm-Gg: AZFdTZe7w0UgOxEmxhoRntg1zZlxuISBjUWaKrqKqZd+sb+zfD2rOXPoI8gMSIgulVm
 G8UwzCg6vKeuB71ynLy7PnFVKaUPDLWAduhihpk2nyzYjPgz0fLFuQ1/5YmQTVfTIrx+Lpdimwk
 iNkho993OlvFB2aA0XZwkEs+ckt8/n7/EfYgt2K7R81ApdGNe29ci1EGt+XOMAqxddVrcwmDDB4
 UGHuMNM6viyCqXhDiC8EEKDg8hR5b84cxUchRaMiHGbzOltpR8PpWR5iPeaxh4Lx6HeuyEqkw55
 NsPetNyA2m5cALMD0vfLrHrJ74uTp5t8rNNxDjl0bO2ykxR9B8BLy2uf1BTMdKPm8Z4+sz9Dfhy
 hZBEvOAl740Cbeu4f3wGGybIAN/Tv2OUmFOf5DyVcmXJPLGIz+okx6x/p24RxVcjvUKSshfG9Uw
 5sW1KzAuLg9KYmiSBPUk5m3ztP+0XxsPAu+G6Mgp3LcAKTYQi+WA0/8SLiNUXoeSD2XJLmeGstB
 Q38SKkqCHg2n3qmqxbyvpXgWFu8eWHQGDZW8fRTLa8IFTohs/WVu3S7HetaVp5xsUxAJAPI2+9p
 8Q4dpA==
X-Received: by 2002:a05:622a:48d:b0:55d:3689:913 with SMTP id
 d75a77b69052e-55d76aad14fmr455567241cf.77.1795784275571; 
 Fri, 27 Nov 2026 04:57:55 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55dbeae112bsm55627651cf.8.2026.11.27.04.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 04:57:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xWvWT-00000006hYF-3LIW;
 Fri, 27 Nov 2026 08:57:53 -0400
Date: Fri, 27 Nov 2026 08:57:53 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Dave Airlie <airlied@gmail.com>, Alistair Popple <apopple@nvidia.com>,
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
Message-ID: <20261127125753.GS246011@ziepe.ca>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-3-c0183a409bdf@nvidia.com>
 <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
 <20261123165716.GM179082@ziepe.ca>
 <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
 <awT8prWsj11TBdmP@nvdebian.thelocal>
 <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
 <CAPM=9txheaE3=fp7=n4fYh-xshxOm+Tv=eQn9wvHVAc-b1JKDQ@mail.gmail.com>
 <79d62f9a-cea8-4149-a673-7ef86942410d@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79d62f9a-cea8-4149-a673-7ef86942410d@amd.com>
X-Mailman-Approved-At: Sat, 28 Nov 2026 09:41:11 +0000
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

On Fri, Nov 27, 2026 at 09:04:15AM +0100, Christian König wrote:

> If we somehow prevent the CPU physical address from being casted to
> a struct page and/or used with vmf_insert_pfn/page/dma_map_page
> etc.. then there is not much of a problem with passing around
> physical addresses.

I already offered that in v1 of the series using limits on
EXPORT_SYMBOL and you NAK'd it too.

> > If we need to shared object backings and have clearly typed and
> > negotiated on what the backing contains then we should allow it.
> > However I mostly agree on the mapping thing, I'd want drivers to
> > negotiate and natively support whatever backings they can rather than
> > having an intermediate trying to handle the conversions Not saying the
> 
> Yes, exactly that's my concern as well. We need to avoid this middle
> layer trap.

You avoid middle layers by having reasonable subsystem helpers for
things to use to build their stuff, especially to encapsulate common
patterns. These helpers are part of the subsystem, or in a related
subysstem helper library.

In Linux terms middle layer almost always means something wrapping a
function pointer callback into a driver and enforcing specific actions
on top of that. The recommended counter is to have the driver perform
the actions with helpers and not wrapper the ops. It particularly came
from the block world where they stuck something like SCSI after the
block ops but before the driver.

It is hard to see that DMABUF is anywhere close to a middle layer.

This is also why we don't understand your remarks about
dma_buf_phys_vec_to_sgt(). Of course it belongs in dmabuf, it produces
the dmabuf spec'd mangled scatterlist that only dmabuf uses. Where
else would you put this code?

> > code doing the conversions can't be a helper, bit it shouldn't ever be
> > autoamtic or outside driver control.

I think you do want it automatic, if an exporter is new and makes,
say, a dma_addr_t[] and the importer is old and wants a sgt, why
should we be open coding anything in every driver to deal with this?

You can argue if it is automatic because the driver called a very
general helper or automatic because the helper is wrapping a callback,
but that should be a fairly minor quibble not a huge thread full of
NAKs.

Ultimately DMABUF has a fairly simple flow:
 1) Allow importer/exporter to negotiate what kind of interconnect
    they want to use (PCI, ualink, etc)
 2) Give the exporter enough information about the interconect path to
    make a placement decision
 3) Describe the exporter's buffer so any mappings/translation/etc can
    be setup for the importer
 4) Program the importers HW.

Many of these have very common patterns, like PCI GPUs always make the
same kind of VRAM placement decision in #2 based on P2P support. This
should all be in helpers under the dmabuf umbrella and not open coded.

Jason
