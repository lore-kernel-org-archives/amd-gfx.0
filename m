Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEEEC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 15:17:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 214C32080C
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 15:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KCSiM2dD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214C32080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA7A16E175;
	Fri, 19 Jun 2020 15:17:35 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7791C6E1AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 15:15:53 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id i16so7424937qtr.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 08:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=X2HlrHXMTsUGZp7zXkK0C6ORZXN08Rk3M03svjYzeco=;
 b=KCSiM2dDaLHttoqe1QHt/9yr2IYYTmKDtwUlr/2aAPsMXJotGdlS5LIUOCBI3nfUKr
 7H5hXjOFeIhEMM1rhPsYmLXsVGK+/URRxwB5gkdgB/VVBX1WNWiPWPxGzOXFSojm2k67
 xv0fxT++s5BYKLm5BozcojKfi5oVGvmGeiUTUYEK9kBmA8g9ZeUGElwaPjjy3Aw3zHUD
 ZgrJPkhJj7UA3fOZqK2qsLucfVZJHTCbjC1vzx8LgcH+mB7ndhuHBfDQHVam/u5lMZnQ
 /ScgOIQLnmny9xQ2AmPd/r9OS8erk86JqJJRaxVdcgDBEB/6Qu//RVN/4j5OzzqwuMzv
 jKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=X2HlrHXMTsUGZp7zXkK0C6ORZXN08Rk3M03svjYzeco=;
 b=ViPC+6QY0gfbrekUgyTfBVCbWMUF+8fVlIioyPrxJ5em97wRel8P/8y9yia7PbrWY5
 CAqViFIkxLQbJtpgZ4IrZrt8kzzlgfXjMiSh1+CLlhkWibhCMUX19StByWwqrirD3ALy
 yDe3+7znHkiKxFg0FjMLN1Jn61wYBr3EtkMx6FlvVe5v89freFgTZ7c0nVGyPcbLpRS+
 BXD0G0bRNxmmVCHz7qEOkA3YVqW1dhPz0hg8cayc1C4BrnFu/5d+wg4Xak9qWWZm/ovQ
 xRBH27zojVq6KXSatVP3JEktLGmz8fSKzxt4KJPmgYZZJ2PkSPK0eOM8pSzz/PGwq/FV
 Npgg==
X-Gm-Message-State: AOAM532RgEZgkHFZ/LlTSisF3n+aqUwa7aEBUK7dHTN5ikMMYYntWxCO
 Eh3YN7npwR3MnZVGiVurJAgZ/w==
X-Google-Smtp-Source: ABdhPJwyaHoM3658+VLpg+i0sFuo+6OU0FHPK264DOfSFcO/+Xp6yT6eiXXI1R4LmEbcaqkeIQOs/w==
X-Received: by 2002:ac8:2fb0:: with SMTP id l45mr3800795qta.260.1592579752403; 
 Fri, 19 Jun 2020 08:15:52 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id y54sm7195320qtj.28.2020.06.19.08.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 08:15:51 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93) (envelope-from <jgg@ziepe.ca>)
 id 1jmIkB-00Ap5C-Bi; Fri, 19 Jun 2020 12:15:51 -0300
Date: Fri, 19 Jun 2020 12:15:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep annotations
Message-ID: <20200619151551.GP6578@ziepe.ca>
References: <20200611083430.GD20149@phenom.ffwll.local>
 <20200611141515.GW6578@ziepe.ca>
 <20200616120719.GL20149@phenom.ffwll.local>
 <CAKMK7uE7DKUo9Z+yCpY+mW5gmKet8ugbF3yZNyHGqsJ=e-g_hA@mail.gmail.com>
 <20200617152835.GF6578@ziepe.ca>
 <20200618150051.GS20149@phenom.ffwll.local>
 <20200618172338.GM6578@ziepe.ca>
 <CAKMK7uEbqTu4q-amkLXyd1i8KNtLaoO2ZFoGqYiG6D0m0FKpOg@mail.gmail.com>
 <20200619113934.GN6578@ziepe.ca>
 <CAKMK7uE-kWA==Cko5uenMrcnopEjq42HxoDTDywzBAbHqsN13g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKMK7uE-kWA==Cko5uenMrcnopEjq42HxoDTDywzBAbHqsN13g@mail.gmail.com>
X-Mailman-Approved-At: Fri, 19 Jun 2020 15:17:34 +0000
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
 Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= <thomas_os@shipmail.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Thomas Hellstrom <thomas.hellstrom@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Mika Kuoppala <mika.kuoppala@intel.com>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 19, 2020 at 05:06:04PM +0200, Daniel Vetter wrote:
> On Fri, Jun 19, 2020 at 1:39 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Fri, Jun 19, 2020 at 09:22:09AM +0200, Daniel Vetter wrote:
> > > > As I've understood GPU that means you need to show that the commands
> > > > associated with the buffer have completed. This is all local stuff
> > > > within the driver, right? Why use fence (other than it already exists)
> > >
> > > Because that's the end-of-dma thing. And it's cross-driver for the
> > > above reasons, e.g.
> > > - device A renders some stuff. Userspace gets dma_fence A out of that
> > > (well sync_file or one of the other uapi interfaces, but you get the
> > > idea)
> > > - userspace (across process or just different driver) issues more
> > > rendering for device B, which depends upon the rendering done on
> > > device A. So dma_fence A is an dependency and will block this dma
> > > operation. Userspace (and the kernel) gets dma_fence B out of this
> > > - because unfortunate reasons, the same rendering on device B also
> > > needs a userptr buffer, which means that dma_fence B is also the one
> > > that the mmu_range_notifier needs to wait on before it can tell core
> > > mm that it can go ahead and release those pages
> >
> > I was afraid you'd say this - this is complete madness for other DMA
> > devices to borrow the notifier hook of the first device!
> 
> The first device might not even have a notifier. This is the 2nd
> device, waiting on a dma_fence of its own, but which happens to be
> queued up as a dma operation behind something else.
> 
> > What if the first device is a page faulting device and doesn't call
> > dma_fence??
> 
> Not sure what you mean with this ... even if it does page-faulting for
> some other reasons, it'll emit a dma_fence which the 2nd device can
> consume as a dependency.

At some point the pages under the buffer have to be either pinned
or protected by mmu notifier. So each and every single device doing
DMA to these pages must either pin, or use mmu notifier.

Driver A should never 'borrow' a notifier from B

If each driver controls its own lifetime of the buffers, why can't the
driver locally wait for its device to finish?

Can't the GPUs cancel work that is waiting on a DMA fence? Ie if
Driver A detects that work completed and wants to trigger a DMA fence,
but it now knows the buffer is invalidated, can't it tell driver B to
give up?

> The problem is that there's piles of other dependencies for a dma job.
> GPU doesn't just consume a single buffer each time, it consumes entire
> lists of buffers and mixes them all up in funny ways. Some of these
> buffers are userptr, entirely local to the device. Other buffers are
> just normal device driver allocations (and managed with some shrinker
> to keep them in check). And then there's the actually shared dma-buf
> with other devices. The trouble is that they're all bundled up
> together.

But why does this matter? Does the GPU itself consume some work and
then stall internally waiting for an external DMA fence?

Otherwise I would expect this dependency chain should be breakable by
aborting work waiting on fences upon invalidation (without stalling)

> > Do not need to wait on dma_fence in notifiers.
> 
> Maybe :-) The goal of this series is more to document current rules
> and make them more consistent. Fixing them if we don't like them might
> be a follow-up task, but that would likely be a pile more work. First
> we need to know what the exact shape of the problem even is.

Fair enough

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
