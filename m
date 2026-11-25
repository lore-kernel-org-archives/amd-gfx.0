Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767F9606A321
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Ka8yhupc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83A9011213D;
	Thu, 26 Nov 2026 08:11:24 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 338B110E247
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 19:07:08 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-9495c633eb5so343497685a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 11:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1795633627; x=1796238427; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JisVSgs385NGuntA6erRX4QYHX+VR40SrOV715tgnK0=;
 b=Ka8yhupch/EL3Si57np+iJpXA68KmZca+yAw5qdDHAEu/2nC3v721WNKO9CXjtQwtS
 NKbi8UEkx6z3Nskb5KcHvjphKCIHVjC4y8tdLfyvClrve+fBTFm1jPefiVigsTTA+s4o
 JmD/AVQ0Qtd9CFGt2hhCGqyaVYMmyo/uB3Roj03RwF5qzGJeNTGdB8KlGK5YvBLXDMvv
 c0T+YFGuJfxCSHojpb3tTPWnwyZyc23SKNCY+173TrCFupJQmbdAGsp1BcXm9E+wNFmX
 uOBTLLF2275Vqxd2o1TtKLMJ1omjhsjXmukDODCTCgHrHl9cr/gHloboV7sKDdA0iBlA
 Ia9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795633627; x=1796238427;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JisVSgs385NGuntA6erRX4QYHX+VR40SrOV715tgnK0=;
 b=pU/YePHiXL00ubgH3boUPO6M0LQpPVsjAjo/03U/xSQyiWvZ6X7g2Iju5oQ718MGgi
 EuD5NazxWfMJ5T0+KvQwJiuT3iUBP4cyIR3rsg92iCtkcXeAOpDKz1dgrh6NNPLggdd9
 K1qqDEEalYRGPDN8CP7wTj8Jvt2JIiMIrrJA9dbIabDIAo528Zg47GTViTS35PWOC9vc
 rO16kUcU+6ZcuVI+bShb/FiZheNhxkOK84ExkIpnl8j0BP4I29zMLzr1ZDFnKBwadn5J
 pD9YGXOizRtt91TohgDO6skTCglghBagwKRFp4zFzktpdYHclip8Kqt0OC7tp+er+sRv
 eDwA==
X-Forwarded-Encrypted: i=1;
 AL+hErFP0AgOOQLDWB6mh/3ClUPh3WYTQyyJvkMgu2EH4QGECoUSik7CXj2KxcUzCJYwI7lqiQKNmzwr@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+yhzZLhiJ6uH/VLUGpeGs66Ouq5pzz7jL1L5yVWjNadFGmLc+b
 iSXq0nBEPRxsOPfOWRJjbZQP5qwL1B2FlcHL91W6ofWXR1R3yjeqEdcMJ3X+H4ECTCE=
X-Gm-Gg: AZFdTZed2zvExvuDIzXxhayOLQ/ns8UXkJNbJN7AdjynUZjPDgL16PdF4WUG2w0+GiO
 O03tbgJkSSKAGcbWYhfFpgz+iagDyeV2gotyiJCq8j0olkb809xv/rw9KQ60uJWTtFrHDd3IU+m
 3LUtqiIw2tMawjWbwwNsevVukH+MLvaRUQeA2hFtF4xUWFoLHM8gyoi2NtxEg+dWgKz2Pg+YH9/
 snSxWS/ZHYoukFQvVGePz9JvOOCEU15vuqXIYC+K8fLEA3qG8Lvj7Rzko6XAcmbLs+Apsez8Vsm
 9CUxdKViXR3Geu8pVRZXYPqVEUa/XVlRORSEuNfJQbkunVUVBnDRVGwJE7bTvYrIVVSWPEhuplR
 6b1vOFw4J0Yh8oEKKOkoi3BZ5FI2lBmvnKYjhRG5vWmBCEmgxVjUzHHyC4EeadqSLlO15kfy6sk
 ztAn2JmD1C283bUicg2F8kGSjrmZgp5OMxY1NuwdIKFHpTwzwiYLWWRyRXeRn6NAOHJxgFRc2ME
 WOndgprRxe9kK/O3iJb822C76Ox3c+QJf0qW8tWJ27wYDearNn77yiLO8Q8gBubD2q8RwJKtj/+
 DCCycnI=
X-Received: by 2002:a05:620a:4543:b0:949:65fe:b727 with SMTP id
 af79cd13be357-949ba9b99a7mr3433826285a.26.1795633626929; 
 Wed, 25 Nov 2026 11:07:06 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94a017cfb46sm339501085a.28.2026.11.25.11.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:07:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xWIKf-00000002HLZ-3ZQi;
 Wed, 25 Nov 2026 15:07:05 -0400
Date: Wed, 25 Nov 2026 15:07:05 -0400
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
Message-ID: <20261125190705.GN246011@ziepe.ca>
References: <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
 <awT8prWsj11TBdmP@nvdebian.thelocal>
 <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
 <20261124142032.GN9566@ziepe.ca>
 <7a5a2d3a-e42e-4dc0-8d22-8dd1bd249501@amd.com>
 <20261124194618.GC114530@ziepe.ca>
 <awZ_Os1pXelOGaFP@nvdebian.thelocal>
 <fb9a6b12-c134-4e40-86a5-dbcb59c0b91b@amd.com>
 <20261125155559.GL246011@ziepe.ca>
 <5fb8bb60-7d9f-49b1-899c-40a890fdc14b@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fb8bb60-7d9f-49b1-899c-40a890fdc14b@amd.com>
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:09:32 +0000
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

On Wed, Nov 25, 2026 at 07:17:51PM +0100, Christian König wrote:
> On 11/25/26 16:55, Jason Gunthorpe wrote:
> > On Wed, Nov 25, 2026 at 12:19:08PM +0100, Christian König wrote:
> >> The low level API which talks for example to the IOMMU driver for
> >> creating the information how to access the buffer is simply not the
> >> task at hand for that framework. The stuff we already handle is more
> >> than complicated enough.
> > 
> > No matter what name you give it we need something in the middle that
> > can see the phys_addr_t and the iommu_domain..
> 
> No, absolutely not. That should be given to the exporter so that the
> exporter can call the DMA API to create the DMA addresses for the
> importer.

I think I've said it many times, and I thought you agreed: NAK to
giving GPU exporter drivers an iommu domain.

> The idea here is that the importer give all the information to the
> exporter so that the exporter can do the mapping on behalves of the
> importer.

No GPU driver must touch these internal details, they must only use
standard abstracted APIs that prevent them from abusing things.

My fear of DRM drivers abusing the DMA process is equal and possibly
greater than your fear of phys_addr_t :P

We are not giving DRM a nightmare API to continue to shoot us in the
foot with.

> > The primary issue here is the exporter *direct* call to the DMA API!
> 
> Why?

Because we need things to be mapped in ways the DMA API will never
support.

DMA API will never support something like dma_buf_iommu_map(). I have
no idea at all how you expect to build this if exporters are directly
calling DMA API. It is not possible.

> > We cannot disconnect this from the DMA API, ie to use an iommu domain
> > or ualink, if exporting drivers are hardwiring calls into it.
> 
> Well the plan is to not disconnect it at all. The exporting drivers
> just says to the underlying API here is my buffer please map that
> for this importer and that result is then given back to the importer
> through the DMA API again.

DMA API will only do basic PCI DMA mappings into dma_addr_t.

It will never handle iommu_domain, it will never handle ualink/etc.

Give us a plan for those if you don't like any of these ideas.

> > Fundamentally the need is for the driver to get the phys_addr list,
> > exactly like today, and then pass it to an op which formats that into
> > the right data structure for the importer. Be it dma_addr[],
> > iommu_domain, or some ualink_addr[] - or whatever.
> 
> No, the phys_addr type should only ever been seen by the DMA API and
> not by DMA-buf.

Again, I don't care how you label things or what "library" they live
in, I can't tell if we are nitpicking names or what.

But there needs to be some kind of abstraction that takes in
phys_addr_t and makes sgt, dma_addr_t, or iommu_domain depending on
what the importer needs.

Exporters must not open code that.

Obviously DMABUF is involved here *somehow* since it is the only thing
that knows an importer even exists.

Would you be happy if we made a 'dma mapping for dmabuf' library that
did all of this and DMABUF just passes its type opaquely and drivers
just call its tightly abstracted functions?

That is the component Alistair is proposing, he just prefixed it with
dmabuf_* as the namespace because, lets be honest, only dmabuf needs
this weird looking thing.

Jason
