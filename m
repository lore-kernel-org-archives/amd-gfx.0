Return-Path: <SRS0=nR5r=LT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA06C48BC2
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jun 2021 07:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8222A6141E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jun 2021 07:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8222A6141E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39ADC6ECDC;
	Fri, 25 Jun 2021 07:28:43 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8CCC6EB86;
 Thu, 24 Jun 2021 13:22:26 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6FB1567373; Thu, 24 Jun 2021 15:22:23 +0200 (CEST)
Date: Thu, 24 Jun 2021 15:22:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [Linaro-mm-sig] [PATCH v3 1/2] habanalabs: define uAPI to
 export FD for DMA-BUF
Message-ID: <20210624132223.GA22258@lst.de>
References: <20210622160538.GT1096940@ziepe.ca>
 <d600a638-9e55-6249-b574-0986cd5cea1e@gmail.com>
 <20210623182435.GX1096940@ziepe.ca>
 <CAFCwf111O0_YB_tixzEUmaKpGAHMNvMaOes2AfMD4x68Am4Yyg@mail.gmail.com>
 <20210623185045.GY1096940@ziepe.ca>
 <CAFCwf12tW_WawFfAfrC8bgVhTRnDA7DuM+0V8w3JsUZpA2j84w@mail.gmail.com>
 <20210624053421.GA25165@lst.de>
 <9571ac7c-3a58-b013-b849-e26c3727e9b2@amd.com>
 <20210624081237.GA30289@lst.de>
 <899fe0ce-b6d7-c138-04b6-4b12405f8d93@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <899fe0ce-b6d7-c138-04b6-4b12405f8d93@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Mailman-Approved-At: Fri, 25 Jun 2021 07:28:40 +0000
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
Cc: Oded Gabbay <oded.gabbay@gmail.com>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 sleybo@amazon.com, Oded Gabbay <ogabbay@kernel.org>,
 Gal Pressman <galpress@amazon.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
 Tomer Tayar <ttayar@habana.ai>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Greg KH <gregkh@linuxfoundation.org>, Alex Deucher <alexander.deucher@amd.com>,
 Leon Romanovsky <leonro@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 24, 2021 at 11:52:47AM +0200, Christian K=F6nig wrote:
> I've already converted a bunch of the GPU drivers, but there are at least=
 6 =

> GPU still needing to be fixed and on top of that comes VA-API and a few =

> others.
>
> What are your plans for the DMA mapping subsystem?

Building a new API that allows batched DMA mapping without the scatterlist.
The main input for my use case would be bio_vecs, but I plan to make it
a little flexible, and the output would be a list of [dma_addr,len]
tuples, with the API being flexible enough to just return a single
[dma_addr,len] for the common IOMMU coalescing case.

>
>> Btw, one thing I noticed when looking over the dma-buf instances is that
>> there is a lot of duplicated code for creating a sg_table from pages,
>> and then mapping it.  It would be good if we could move toward common
>> helpers instead of duplicating that all over again.
>
> Can you give an example?

Take a look at the get_sg_table and put_sg_table helpers in udmabuf.
Those would also be useful in armda, i915, tegra, gntdev-dmabuf, mbochs
in one form or another.

Similar for variants that use a contigous regions.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
