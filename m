Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CACEC4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 14:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C2A6124B
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 14:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C2A6124B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77B296E17D;
	Mon, 21 Jun 2021 14:20:40 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F3076E17D
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 14:20:39 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id d11so17509727wrm.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 07:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ec7hxlIB77SSjw/55RmOMCuUntyz8RSRzIK/yT10Dvk=;
 b=hdjFmcsB7YIei1isj+gSWLLnQe/OhKX1iiuoZJRIb0Y5ZjSRed91RUS0dHVk5ggMn5
 RvzeIUS7C6AplN/c1p38QeXspMIbu1dx50vmfj9IfhRCU0PvQxRWsAQsLAtFcnCZeVTs
 LE5yRt50lgyFPVhoGDAul329GvtCpJQZUhgyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=Ec7hxlIB77SSjw/55RmOMCuUntyz8RSRzIK/yT10Dvk=;
 b=OcNAfZHDwbi5BrjJnOR2t8A3vLu6xFy15SY8549wzVW+wc1B51FYl33XiEG6b8EbBi
 Fp3g6DuZ0+yL+jrEsNiEUR8qPuHq9czoqj1LvAIWdKNEcOXD3MzmTMGb09xClObQFpNG
 dfaER7xOD42rj/SYYiejjt9ZpsFBeQaOD8KqXvSA+v9WL1ux/p6OoKqs7YgMKvlKvyeT
 tLXHlJf8whfEWSqY1GYQmlJJfbobbCWqbdt5M17trmUKWYSup5wcH9e0SGW+deFujS5K
 e8mTiqdAxkRsJa764vgF0/gbM88UVHDOzX5cECCNPIb6Pnep6xaq4eMAgSreF9gg/U29
 iExQ==
X-Gm-Message-State: AOAM531qihzlMMH7tfkSu2zAR5y3c/KOD4IurZrASYAFdWgvdxRfroAA
 /pHy93bcjcA8kev3L2TfAluSBw==
X-Google-Smtp-Source: ABdhPJzPyUcaJgvK25ATnGRsGylqHKBhORMyjB5T83l8p03Kbo46vsfx/gdiWtoNiHUQ9xmV7GCvtQ==
X-Received: by 2002:a05:6000:12c7:: with SMTP id
 l7mr22475136wrx.161.1624285237673; 
 Mon, 21 Jun 2021 07:20:37 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id 4sm17161648wry.74.2021.06.21.07.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jun 2021 07:20:37 -0700 (PDT)
Date: Mon, 21 Jun 2021 16:20:35 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 1/2] habanalabs: define uAPI to export FD for DMA-BUF
Message-ID: <YNCgM1svqKGUhcFY@phenom.ffwll.local>
Mail-Followup-To: Greg KH <gregkh@linuxfoundation.org>,
 Oded Gabbay <ogabbay@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>,
 Doug Ledford <dledford@redhat.com>,
 "airlied@gmail.com" <airlied@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Gal Pressman <galpress@amazon.com>, sleybo@amazon.com,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Tomer Tayar <ttayar@habana.ai>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Leon Romanovsky <leonro@nvidia.com>, Christoph Hellwig <hch@lst.de>
References: <20210618123615.11456-1-ogabbay@kernel.org>
 <CAKMK7uFOfoxbD2Z5mb-qHFnUe5rObGKQ6Ygh--HSH9M=9bziGg@mail.gmail.com>
 <YNCN0ulL6DQiRJaB@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YNCN0ulL6DQiRJaB@kroah.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
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
 linux-rdma <linux-rdma@vger.kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Oded Gabbay <ogabbay@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
 Tomer Tayar <ttayar@habana.ai>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Leon Romanovsky <leonro@nvidia.com>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 21, 2021 at 03:02:10PM +0200, Greg KH wrote:
> On Mon, Jun 21, 2021 at 02:28:48PM +0200, Daniel Vetter wrote:
> > On Fri, Jun 18, 2021 at 2:36 PM Oded Gabbay <ogabbay@kernel.org> wrote:
> > > User process might want to share the device memory with another
> > > driver/device, and to allow it to access it over PCIe (P2P).
> > >
> > > To enable this, we utilize the dma-buf mechanism and add a dma-buf
> > > exporter support, so the other driver can import the device memory and
> > > access it.
> > >
> > > The device memory is allocated using our existing allocation uAPI,
> > > where the user will get a handle that represents the allocation.
> > >
> > > The user will then need to call the new
> > > uAPI (HL_MEM_OP_EXPORT_DMABUF_FD) and give the handle as a parameter.
> > >
> > > The driver will return a FD that represents the DMA-BUF object that
> > > was created to match that allocation.
> > >
> > > Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
> > > Reviewed-by: Tomer Tayar <ttayar@habana.ai>
> > 
> > Mission acomplished, we've gone full circle, and the totally-not-a-gpu
> > driver is now trying to use gpu infrastructure. And seems to have
> > gained vram meanwhile too. Next up is going to be synchronization
> > using dma_fence so you can pass buffers back&forth without stalls
> > among drivers.
> 
> What's wrong with other drivers using dmabufs and even dma_fence?  It's
> a common problem when shuffling memory around systems, why is that
> somehow only allowed for gpu drivers?
> 
> There are many users of these structures in the kernel today that are
> not gpu drivers (tee, fastrpc, virtio, xen, IB, etc) as this is a common
> thing that drivers want to do (throw chunks of memory around from
> userspace to hardware).
> 
> I'm not trying to be a pain here, but I really do not understand why
> this is a problem.  A kernel api is present, why not use it by other
> in-kernel drivers?  We had the problem in the past where subsystems were
> trying to create their own interfaces for the same thing, which is why
> you all created the dmabuf api to help unify this.

It's the same thing as ever. 90% of an accel driver are in userspace,
that's where all the fun is, that's where the big picture review needs to
happen, and we've very conveniently bypassed all that a few years back
because it was too annoying.

Once we have the full driver stack and can start reviewing it I have no
objections to totally-not-gpus using all this stuff too. But until we can
do that this is all just causing headaches.

Ofc if you assume that userspace doesn't matter then you don't care, which
is where this giantic disconnect comes from.

Also unless we're actually doing this properly there's zero incentive for
me to review the kernel code and check whether it follows the rules
correctly, so you have excellent chances that you just break the rules.
And dma_buf/fence are tricky enough that you pretty much guaranteed to
break the rules if you're not involved in the discussions. Just now we
have a big one where everyone involved (who's been doing this for 10+
years all at least) realizes we've fucked up big time.

Anyway we've had this discussion, we're not going to move anyone here at
all, so *shrug*. I'll keep seeing accelarators in drivers/misc as blantant
bypassing of review by actual accelerator pieces, you keep seing dri-devel
as ... well I dunno, people who don't know what they're talking about
maybe. Or not relevant to your totally-not-a-gpu thing.

> > Also I'm wondering which is the other driver that we share buffers
> > with. The gaudi stuff doesn't have real struct pages as backing
> > storage, it only fills out the dma_addr_t. That tends to blow up with
> > other drivers, and the only place where this is guaranteed to work is
> > if you have a dynamic importer which sets the allow_peer2peer flag.
> > Adding maintainers from other subsystems who might want to chime in
> > here. So even aside of the big question as-is this is broken.
> 
> From what I can tell this driver is sending the buffers to other
> instances of the same hardware, as that's what is on the other "end" of
> the network connection.  No different from IB's use of RDMA, right?

There's no import afaict, but maybe I missed it. Assuming I haven't missed
it the importing necessarily has to happen by some other drivers.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
