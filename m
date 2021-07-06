Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502B9C07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 13:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5EF36192B
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 13:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5EF36192B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8104C6E47A;
	Tue,  6 Jul 2021 13:17:13 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3D556E471
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jul 2021 13:17:12 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 59-20020a9d0ac10000b0290462f0ab0800so21471203otq.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jul 2021 06:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U9D/asRW8RIRRhOKKkNY/c0bgyv3JnZBPRvStuSKb28=;
 b=cB9WV9sNtYm4EIQPRYYsOGXCyC85KX4IvPilkqi+DXH4BpSsZyGkNpW3uSI8JnhhUm
 Uoplzu3pWcmKt7UBmyg4GG/1Ehm8EZCdN1AUKXSFMtmPdYVFA4tSUwyZPyO+z/eahKfZ
 PrBc3UQ6AHFgqTPV3OhYjDG9m5j2bWR34qSio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U9D/asRW8RIRRhOKKkNY/c0bgyv3JnZBPRvStuSKb28=;
 b=DUB+7Ru7VD41/23iK15/W5wmceM1P0tEZbVyd57rKvfuvNIDdmO3Q2tzLGGVp03AJv
 QI9wYrMGql3iDUdTJftzedGZQW1teZNdQvCUQgvhLKptUumQnIvCssJepuROhxRdLeOb
 FveDO44tFIb1yytM3l+mjzsW6YEvNSW+kdYKmyVh/l3dDRabV1I0iYHJnLQqNSt4gL68
 xkU0vv8t7iZAVCUAR0B20aiDTqsI8aPP/EIgEhLvTnJGntjhvtjR+YpGjMJfFZUAX+Z5
 q8Udv6eyee1kUYGIcSl5W9/Wz/nJwvgoS/tK8LYFG08DLUN1EEUgMPSmEPxb1clCoql/
 4npw==
X-Gm-Message-State: AOAM531g9f1vsVfOzNKuoehbuFvvAQT80c7aJwN7awYRrBefK5vG0ALS
 sp0sFJOPMDWP+OSt4LpqHlGz3GA7vITzsPS2nF1E4Q==
X-Google-Smtp-Source: ABdhPJyhU38uAVUSjr8gRwHKDTIhLNjZ02bjGpdJaQ/Zri9HQUmeedc5h+sEGm5UwpWhHyQGUQa0Ps8orpOzhY8rJNs=
X-Received: by 2002:a05:6830:2366:: with SMTP id
 r6mr14854251oth.188.1625577431903; 
 Tue, 06 Jul 2021 06:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210705130314.11519-1-ogabbay@kernel.org>
 <YOQXBWpo3whVjOyh@phenom.ffwll.local>
 <20210706122110.GA18273@lst.de> <YORLTmyoXDtoM9Ta@phenom.ffwll.local>
 <CAFCwf114KEH-kO6w+nmbqKKdaGuqy3iOpHJi=5ZWqT3cgDm4Cw@mail.gmail.com>
In-Reply-To: <CAFCwf114KEH-kO6w+nmbqKKdaGuqy3iOpHJi=5ZWqT3cgDm4Cw@mail.gmail.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 6 Jul 2021 15:17:00 +0200
Message-ID: <CAKMK7uHfCbNQJwbXgLC9ibk71kVG7TBK4bfFxzX82ziSgqG9nw@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH v4 0/2] Add p2p via dmabuf to habanalabs
To: Oded Gabbay <oded.gabbay@gmail.com>
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oded Gabbay <ogabbay@kernel.org>,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@gmail.com>,
 Christoph Hellwig <hch@lst.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Leon Romanovsky <leonro@nvidia.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 6, 2021 at 2:46 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> On Tue, Jul 6, 2021 at 3:23 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Tue, Jul 06, 2021 at 02:21:10PM +0200, Christoph Hellwig wrote:
> > > On Tue, Jul 06, 2021 at 10:40:37AM +0200, Daniel Vetter wrote:
> > > > > Greg, I hope this will be good enough for you to merge this code.
> > > >
> > > > So we're officially going to use dri-devel for technical details review
> > > > and then Greg for merging so we don't have to deal with other merge
> > > > criteria dri-devel folks have?
> > > >
> > > > I don't expect anything less by now, but it does make the original claim
> > > > that drivers/misc will not step all over accelerators folks a complete
> > > > farce under the totally-not-a-gpu banner.
> > > >
> > > > This essentially means that for any other accelerator stack that doesn't
> > > > fit the dri-devel merge criteria, even if it's acting like a gpu and uses
> > > > other gpu driver stuff, you can just send it to Greg and it's good to go.
> > > >
> > > > There's quite a lot of these floating around actually (and many do have
> > > > semi-open runtimes, like habanalabs have now too, just not open enough to
> > > > be actually useful). It's going to be absolutely lovely having to explain
> > > > to these companies in background chats why habanalabs gets away with their
> > > > stack and they don't.
> > >
> > > FYI, I fully agree with Daniel here.  Habanlabs needs to open up their
> > > runtime if they want to push any additional feature in the kernel.
> > > The current situation is not sustainable.
> Well, that's like, your opinion...
>
> >
> > Before anyone replies: The runtime is open, the compiler is still closed.
> > This has become the new default for accel driver submissions, I think
> > mostly because all the interesting bits for non-3d accelerators are in the
> > accel ISA, and no longer in the runtime. So vendors are fairly happy to
> > throw in the runtime as a freebie.
> >
> > It's still incomplete, and it's still useless if you want to actually hack
> > on the driver stack.
> > -Daniel
> > --
> I don't understand what's not sustainable here.
>
> There is zero code inside the driver that communicates or interacts
> with our TPC code (TPC is the Tensor Processing Core).
> Even submitting works to the TPC is done via a generic queue
> interface. And that queue IP is common between all our engines
> (TPC/DMA/NIC). The driver provides all the specs of that queue IP,
> because the driver's code is handling that queue. But why is the TPC
> compiler code even relevant here ?

Can I use the hw how it's intended to be used without it?

If the answer is no, then essentially what you're doing with your
upstream driver is getting all the benefits of an upstream driver,
while upstream gets nothing. We can't use your stack, not as-is. Sure
we can use the queue, but we can't actually submit anything
interesting. And I'm pretty sure the point of your hw is to do more
than submit no-op packets to a queue.

This is all "I want my cake and eat it too" approach to upstreaming,
and it's totally fine attitude to have, but if you don't see why
there's maybe an different side to it then I don't get what you're
arguing. Upstream isn't free lunch for nothing.

Frankly I'm starting to assume you're arguing this all in bad faith
just because habanalabds doesn't want to actually have an open driver
stack, so any attack is good, no matter what. Which is also what
everyone else does who submits their accel driver to upstream, and
which gets us back to the starting point of this sub-thread of me
really appreciation how this will improve background discussions going
forward for everyone.

Like if the requirement for accel drivers truly is that you can submit
a dummy command to the queues then I have about 5-10 drivers at least
I could merge instantly. For something like the intel gpu driver it
would be about 50 lines of code (including all the structure boiler
plate the ioctls require)in userspace to submit a dummy queue command.
GPU and accel vendors would really love that, because it would allow
them to freeload on upstream and do essentially nothing in return.

And we'd end up with an unmaintainable disaster of a gpu or well
accelerator subsystem because there's nothing you can change or
improve because all the really useful bits of the stack are closed.
And ofc that's not any companies problem anymore, so ofc you with the
habanalabs hat on don't care and call this *extreme*.

> btw, you can today see our TPC code at
> https://github.com/HabanaAI/Habana_Custom_Kernel
> There is a link there to the TPC user guide and link to download the
> LLVM compiler.

I got stuck clicking links before I found the source for that llvm
compiler. Can you give me a direct link to the repo with sourcecode
instead please?

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
