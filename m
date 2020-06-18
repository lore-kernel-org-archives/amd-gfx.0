Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EEBC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 15:01:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 996A62073E
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 15:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NAXSbQeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996A62073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07D916EB0C;
	Thu, 18 Jun 2020 15:01:01 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A97066EB0C
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 15:00:59 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id q2so3969037wrv.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 08:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=6OXAj9s43JL1nA3AEpbYM/MO9Qwg5Ya14IpN0gZo/as=;
 b=NAXSbQeHANLe1jipR3irzjbY7yWCggcmWa6HNg2IPmITzqFGf3L5EfLt0xDSdDrG+b
 x2cMxixoM50+NeYTVtrK/kNJYHNO6fr4lE9I3N0/BlBM5groWNzwqW1H+Hm//JIuCUoA
 dlNXlF2mmmSgTTwOzqZXKvpuzoxFA0/uYDSds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=6OXAj9s43JL1nA3AEpbYM/MO9Qwg5Ya14IpN0gZo/as=;
 b=jkpiiufaaEF+QYfe0RGZaNT4FKYwXA/IK3du1ZsuPZEBUbEu3fl8TE4L4ipoy/P7ub
 NSG975HeIRihbfi3Ms7pEU9UvwN5HQqmanFAQsffC2OxXyKoOsq8d7tFIZVYRsACsLPY
 uWK3WMPqQ5vq+eGjL8H+Q5An/ZsbImSmtFl9RsSrWVIOubxI6T+fkWnBkM4jBEFbLEDm
 ZH5qMttYIbROy4bManrJC8EWyncSo9eCzvsP/tHQZYSYxCF0uPugBUl7n7tLYetMRzK9
 pu5/is7lqbcHP9LvGAv/Wno6es0xlQ5Ye8CMuGpqWQhshYS33j7y8WpmxbglzVA0+jKU
 yVfQ==
X-Gm-Message-State: AOAM53355yvURBzJEap5MEJTRm7fqqG/8re52rlAFuvpx93JNPEPSNXA
 xNSe6PDdN2a5Uo6+ZGQFvAD89g==
X-Google-Smtp-Source: ABdhPJyrsmwBwFtG4KAk31ycwBo00rNlOYG3lXCyUqre+ViPnXoXIqRRhRlofgF6zGCpK4dB5Hv+mw==
X-Received: by 2002:adf:d841:: with SMTP id k1mr4031245wrl.93.1592492454932;
 Thu, 18 Jun 2020 08:00:54 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id p7sm3878240wro.26.2020.06.18.08.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 08:00:53 -0700 (PDT)
Date: Thu, 18 Jun 2020 17:00:51 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep annotations
Message-ID: <20200618150051.GS20149@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@ziepe.ca>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m_=28Intel=29?= <thomas_os@shipmail.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Thomas Hellstrom <thomas.hellstrom@intel.com>,
 Daniel Vetter <daniel.vetter@intel.com>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Mika Kuoppala <mika.kuoppala@intel.com>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-5-daniel.vetter@ffwll.ch>
 <b11c2140-1b9c-9013-d9bb-9eb2c1906710@shipmail.org>
 <20200611083430.GD20149@phenom.ffwll.local>
 <20200611141515.GW6578@ziepe.ca>
 <20200616120719.GL20149@phenom.ffwll.local>
 <CAKMK7uE7DKUo9Z+yCpY+mW5gmKet8ugbF3yZNyHGqsJ=e-g_hA@mail.gmail.com>
 <20200617152835.GF6578@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200617152835.GF6578@ziepe.ca>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
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
Cc: linux-rdma <linux-rdma@vger.kernel.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m_=28Intel=29?= <thomas_os@shipmail.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Thomas Hellstrom <thomas.hellstrom@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Mika Kuoppala <mika.kuoppala@intel.com>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 17, 2020 at 12:28:35PM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 17, 2020 at 08:48:50AM +0200, Daniel Vetter wrote:
> 
> > Now my understanding for rdma is that if you don't have hw page fault
> > support,
> 
> The RDMA ODP feature is restartable HW page faulting just like nouveau
> has. The classical MR feature doesn't have this. Only mlx5 HW supports
> ODP today.
> 
> > It's only gpus (I think) which are in this awkward in-between spot
> > where dynamic memory management really is much wanted, but the hw
> > kinda sucks. Aside, about 10+ years ago we had a similar problem with
> > gpu hw, but for security: Many gpu didn't have any kinds of page
> > tables to isolate different clients from each another. drivers/gpu
> > fixed this by parsing&validating what userspace submitted to make sure
> > it's only every accessing its own buffers. Most gpus have become
> > reasonable nowadays and do have proper per-process pagetables (gpu
> > process, not the pasid stuff), but even today there's still some of
> > the old model left in some of the smallest SoC.
> 
> But I still don't understand why a dma fence is needed inside the GPU
> driver itself in the notifier.
> 
> Surely the GPU driver can block and release the notifier directly from
> its own command processing channel?
> 
> Why does this fence and all it entails need to leak out across
> drivers?

So 10 years ago we had this world of every gpu driver is its own bucket,
nothing leaks out to the world. But the world had a different idea how
gpus where supposed to work, with stuff like:

- laptops with a power-efficient but slow gpu integrated on the cpu die,
  and a 2nd, much faster but also more wasteful gpu seperately

- also multi-gpu rendering (but on linux we never really got around to
  enabling that, at least not for 3d rendering)

- soc just bundle IP blocks together, and very often they feel like they
  have to do their own display block (it's fairly easy and allows you to
  keep your hw engineers justified on payroll with some more patents they
  create), but anything more fancy they buy in. So from a driver
  architecture pov even a single chip soc looks like a bundle of gpus

And you want to pipeline all this because performance, so waiting in
userspace for one block to finish before you hand it ever to the other
isn't a good idea.

Hence dma_fence as a cross driver leak was created by pulling the gpu
completion tracking from the drm/ttm library for managing vram.

Now with glorious hindsight we could have come up with a different
approach, where synchronization is managed by userspace, kernel just
provides some primitives (kinda like futexes, but for gpu). And the kernel
manages residency and gpu pte wrangling entirely seperately. But:

- 10 years ago drivers/gpu was a handful of people at best

- we just finished the massive rewrite to get to a kernel memory manager
  and kernel modesetting (over 5 years after windows/macos), so appetite
  for massive rewrites was minimal.

Here we are, now with 50 more drivers built on top and an entire userspace
ecosystem that relies on all this (because yes we made dma_fence also the
building block for all the cross-process uapi, why wouldn't we).

I hope that explains a bit the history of how and why we ended up here.

Maybe I should do a plumbers talk about "How not to memory manage -
cautious tales from drivers/gpu" I think there's a lot of areas where the
conversation usually goes "wtf" ... long explanation of history and
technical reasons leading to a "oh dear". With a lot of other accelerators
and things landing might be good to have a list of things that look
tempting (because hey 2% faster) but arent worth the pain.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
