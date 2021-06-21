Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9420AC4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 13:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C0B611BD
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 13:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C0B611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6E9C6E049;
	Mon, 21 Jun 2021 13:09:03 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB4E289FDD;
 Mon, 21 Jun 2021 13:02:13 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8026600D4;
 Mon, 21 Jun 2021 13:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1624280533;
 bh=i0BoGd9phtcsE2N4w5S/NNcCyOLvsVmvubKDwfPIMew=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=N9ZvxmN6kzyMcupSt5ch1urOqDBkE0Yg6zpYbUkiJjCrqT/WAfP0GZcwtdCxyIhN5
 VJf2oNP6LasPeV9faVnguB0ItTYTqoiIi/KT6Spd+x7CVZUlDVNtQ1gqJ8z8De0PSa
 aehoznUR6BHHlVGF7/uMhhG8Rm1/YXbxpCs5Xms4=
Date: Mon, 21 Jun 2021 15:02:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v3 1/2] habanalabs: define uAPI to export FD for DMA-BUF
Message-ID: <YNCN0ulL6DQiRJaB@kroah.com>
References: <20210618123615.11456-1-ogabbay@kernel.org>
 <CAKMK7uFOfoxbD2Z5mb-qHFnUe5rObGKQ6Ygh--HSH9M=9bziGg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKMK7uFOfoxbD2Z5mb-qHFnUe5rObGKQ6Ygh--HSH9M=9bziGg@mail.gmail.com>
X-Mailman-Approved-At: Mon, 21 Jun 2021 13:09:01 +0000
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
Cc: Gal Pressman <galpress@amazon.com>, sleybo@amazon.com,
 linux-rdma <linux-rdma@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 Oded Gabbay <ogabbay@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
 Tomer Tayar <ttayar@habana.ai>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 21, 2021 at 02:28:48PM +0200, Daniel Vetter wrote:
> On Fri, Jun 18, 2021 at 2:36 PM Oded Gabbay <ogabbay@kernel.org> wrote:
> > User process might want to share the device memory with another
> > driver/device, and to allow it to access it over PCIe (P2P).
> >
> > To enable this, we utilize the dma-buf mechanism and add a dma-buf
> > exporter support, so the other driver can import the device memory and
> > access it.
> >
> > The device memory is allocated using our existing allocation uAPI,
> > where the user will get a handle that represents the allocation.
> >
> > The user will then need to call the new
> > uAPI (HL_MEM_OP_EXPORT_DMABUF_FD) and give the handle as a parameter.
> >
> > The driver will return a FD that represents the DMA-BUF object that
> > was created to match that allocation.
> >
> > Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
> > Reviewed-by: Tomer Tayar <ttayar@habana.ai>
> 
> Mission acomplished, we've gone full circle, and the totally-not-a-gpu
> driver is now trying to use gpu infrastructure. And seems to have
> gained vram meanwhile too. Next up is going to be synchronization
> using dma_fence so you can pass buffers back&forth without stalls
> among drivers.

What's wrong with other drivers using dmabufs and even dma_fence?  It's
a common problem when shuffling memory around systems, why is that
somehow only allowed for gpu drivers?

There are many users of these structures in the kernel today that are
not gpu drivers (tee, fastrpc, virtio, xen, IB, etc) as this is a common
thing that drivers want to do (throw chunks of memory around from
userspace to hardware).

I'm not trying to be a pain here, but I really do not understand why
this is a problem.  A kernel api is present, why not use it by other
in-kernel drivers?  We had the problem in the past where subsystems were
trying to create their own interfaces for the same thing, which is why
you all created the dmabuf api to help unify this.

> Also I'm wondering which is the other driver that we share buffers
> with. The gaudi stuff doesn't have real struct pages as backing
> storage, it only fills out the dma_addr_t. That tends to blow up with
> other drivers, and the only place where this is guaranteed to work is
> if you have a dynamic importer which sets the allow_peer2peer flag.
> Adding maintainers from other subsystems who might want to chime in
> here. So even aside of the big question as-is this is broken.

From what I can tell this driver is sending the buffers to other
instances of the same hardware, as that's what is on the other "end" of
the network connection.  No different from IB's use of RDMA, right?

thanks,

greg k-h
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
