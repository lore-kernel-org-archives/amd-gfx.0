Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491ECC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 12:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C8E611C3
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 12:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E2C8E611C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E3B76EC3C;
	Fri, 17 Sep 2021 12:30:05 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 623E76EC40
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 12:30:04 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id q26so14900505wrc.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 05:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=ohehD+AgX2cOYuT0Vdlc+XEexxlJP7h+rPjbbPGV0JI=;
 b=R10SS4VV0BCpiZybmOMrjaWEfv3d2ZD+2k6TYKYqIZCusUIZXiqYs5rTuV6bruYLls
 zYGmlZhSOPyZgErxGr8GftAAzypBiEQnXw94kdl46vb10zeP8O7zkrXWklJipXggLivr
 Ihoa4mj+eAbhnzb6QO020N9VvyKryVDicfnPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=ohehD+AgX2cOYuT0Vdlc+XEexxlJP7h+rPjbbPGV0JI=;
 b=tZMaEl27UQ+zAwW+qW1cykYG4/JKwxI4AauF0m76V4rfhYy8Ne0ifK9q7sdVUYKnqd
 4hl4IC00qTl2bHtfkv3NElvIAd+PxthcUo15UxEeP7hIxD9DE1zJxfP0dvARTJWqbD2Z
 XTie/8h5rUe+xH3s2Iv9MQNEBeey7eM3hNASr6p9a4W7T/zF6c3qwZUwAkwGXPPV/kHs
 rF/QStma52DPQofTXm5CFyPZVJ9Az2F7O0y+pmf+HYkI1QJjstlFJRggcSCKoHjT/+uk
 V1ltAdJWu5ClFqSinK4tQP09dohq0SlFabClCyI9dm6Wss6KCzWDlwNKBHeiV+pFctQ2
 bRrg==
X-Gm-Message-State: AOAM533TLuBGOjkcdodH0cmFG+TbK0OzXLccOD5Mc3GW0oD/05jO/0Pe
 faYQICOKcwsKHHLDLIZGZqvs57V/WqNA+w==
X-Google-Smtp-Source: ABdhPJxbi7SvIHU6eF4mLO2NNjFKYkKbUTWnBTtOPShG0ZBGp4wQE5JGTFm/UZzjlZerlKL7ilx7Kg==
X-Received: by 2002:a05:6000:124b:: with SMTP id
 j11mr11906176wrx.147.1631881802837; 
 Fri, 17 Sep 2021 05:30:02 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id z6sm6483202wmp.1.2021.09.17.05.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Sep 2021 05:30:02 -0700 (PDT)
Date: Fri, 17 Sep 2021 14:30:00 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Oded Gabbay <ogabbay@kernel.org>,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Gal Pressman <galpress@amazon.com>, Yossi Leybovich <sleybo@amazon.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Doug Ledford <dledford@redhat.com>, Dave Airlie <airlied@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Leon Romanovsky <leonro@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>
Subject: Re: [PATCH v6 0/2] Add p2p via dmabuf to habanalabs
Message-ID: <YUSKSHBC9uI49wZZ@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@ziepe.ca>,
 Oded Gabbay <ogabbay@kernel.org>,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Gal Pressman <galpress@amazon.com>,
 Yossi Leybovich <sleybo@amazon.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Doug Ledford <dledford@redhat.com>, Dave Airlie <airlied@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Leon Romanovsky <leonro@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>
References: <20210912165309.98695-1-ogabbay@kernel.org>
 <YUCvNzpyC091KeaJ@phenom.ffwll.local>
 <20210914161218.GF3544071@ziepe.ca>
 <CAFCwf13322953Txr3Afa_MomuD148vnfpEog0xzW7FPWH9=6fg@mail.gmail.com>
 <YUM5JoMMK7gceuKZ@phenom.ffwll.local>
 <20210916131014.GK3544071@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916131014.GK3544071@ziepe.ca>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
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

On Thu, Sep 16, 2021 at 10:10:14AM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 16, 2021 at 02:31:34PM +0200, Daniel Vetter wrote:
> > On Wed, Sep 15, 2021 at 10:45:36AM +0300, Oded Gabbay wrote:
> > > On Tue, Sep 14, 2021 at 7:12 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Tue, Sep 14, 2021 at 04:18:31PM +0200, Daniel Vetter wrote:
> > > > > On Sun, Sep 12, 2021 at 07:53:07PM +0300, Oded Gabbay wrote:
> > > > > > Hi,
> > > > > > Re-sending this patch-set following the release of our user-space TPC
> > > > > > compiler and runtime library.
> > > > > >
> > > > > > I would appreciate a review on this.
> > > > >
> > > > > I think the big open we have is the entire revoke discussions. Having the
> > > > > option to let dma-buf hang around which map to random local memory ranges,
> > > > > without clear ownership link and a way to kill it sounds bad to me.
> > > > >
> > > > > I think there's a few options:
> > > > > - We require revoke support. But I've heard rdma really doesn't like that,
> > > > >   I guess because taking out an MR while holding the dma_resv_lock would
> > > > >   be an inversion, so can't be done. Jason, can you recap what exactly the
> > > > >   hold-up was again that makes this a no-go?
> > > >
> > > > RDMA HW can't do revoke.
> > 
> > Like why? I'm assuming when the final open handle or whatever for that MR
> > is closed, you do clean up everything? Or does that MR still stick around
> > forever too?
> 
> It is a combination of uAPI and HW specification.
> 
> revoke here means you take a MR object and tell it to stop doing DMA
> without causing the MR object to be destructed.
> 
> All the drivers can of course destruct the MR, but doing such a
> destruction without explicit synchronization with user space opens
> things up to a serious use-after potential that could be a security
> issue.
> 
> When the open handle closes the userspace is synchronized with the
> kernel and we can destruct the HW objects safely.
> 
> So, the special HW feature required is 'stop doing DMA but keep the
> object in an error state' which isn't really implemented, and doesn't
> extend very well to other object types beyond simple MRs.

Yeah revoke without destroying the MR doesn't work, and it sounds like
revoke by destroying the MR just moves the can of worms around to another
place.

> > 1. User A opens gaudi device, sets up dma-buf export
> > 
> > 2. User A registers that with RDMA, or anything else that doesn't support
> > revoke.
> > 
> > 3. User A closes gaudi device
> > 
> > 4. User B opens gaudi device, assumes that it has full control over the
> > device and uploads some secrets, which happen to end up in the dma-buf
> > region user A set up
> 
> I would expect this is blocked so long as the DMABUF exists - eg the
> DMABUF will hold a fget on the FD of #1 until the DMABUF is closed, so
> that #3 can't actually happen.
> 
> > It's not mlocked memory, it's mlocked memory and I can exfiltrate
> > it.
> 
> That's just bug, don't make buggy drivers :)

Well yeah, but given that habanalabs hand rolled this I can't just check
for the usual things we have to enforce this in drm. And generally you can
just open chardevs arbitrarily, and multiple users fighting over each
another. The troubles only start when you have private state or memory
allocations of some kind attached to the struct file (instead of the
underlying device), or something else that requires device exclusivity.
There's no standard way to do that.

Plus in many cases you really want revoke on top (can't get that here
unfortunately it seems), and the attempts to get towards a generic
revoke() just never went anywhere. So again it's all hand-rolled
per-subsystem. *insert lament about us not having done this through a
proper subsystem*

Anyway it sounds like the code takes care of that.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
