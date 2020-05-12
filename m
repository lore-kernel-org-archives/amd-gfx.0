Return-Path: <SRS0=6vDE=62=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53C8C54E4A
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 12:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 832BA206D3
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 12:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KWGRPT0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 832BA206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37C276E90D;
	Tue, 12 May 2020 12:57:14 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 216A26E90F
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 12:57:13 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id f134so9463171wmf.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 05:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=YLwPnbDauSfAWxQ+40E6XOuXjM5jTgn5iCgXAVP6tHM=;
 b=KWGRPT0N+HWyZObFdaYwOoBDk6GmRygeG8bjF/Ab5wGAv3MXUGlO2Xf6a+9ZJ61BCM
 hxPgvmTkF+Bkvy7vlPpqhg8/t9LiQ1q0PTy/V04RetxJf4aLej2ZMhnrdUtQEP/RP/8a
 Z5PNDBOPNPemwJ32wYOyATJbIthvElXXJrGr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=YLwPnbDauSfAWxQ+40E6XOuXjM5jTgn5iCgXAVP6tHM=;
 b=hB6LZcdkS9NNpGheviQkRA9R4Wb25B8WNgkaEIAUBAOQCrv+a7S7zIDNfBd3piGxPD
 6nYt4mBGuyRcQGtHabyqa97ZHRjDnCXwdQ4kC3x72FlJwmRcdn+OhqkIhLYjZRe4MZGH
 qCkFxIbLzgyX7Kh7C1o55/ZgXY/Fvm8xORKQ45pixffLCV5wFNsuoJpjtxusnWuZH0EE
 30CN8WilwKdMvojbnXxSR2ps/BS+mZkdD3cr+zyMIOKMrUW/jIeJEHpEc7s2+1poo+C3
 NVSk6IPzlj3k34YwjXEbgxvfL8PS0JEDx+vQHWNRFTgAlAo8ZiDRh9a00XLZpeBaF4wU
 7FbA==
X-Gm-Message-State: AGi0PuYpTrOWyUBXmB9FHRAP1HNgXqz8bBnx4pz5WtA8hWbq1EPWze26
 UWfopTszwT4HUReRxrBmVpEVNA==
X-Google-Smtp-Source: APiQypJPVhngnqNHLopAtRaOF+m2sBFi2Xz4I59IV6FcrkZnjpcKLb8O72XuWRPFprkKUYDNGgj6Nw==
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr27041116wmk.18.1589288231721; 
 Tue, 12 May 2020 05:57:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id 32sm23035619wrg.19.2020.05.12.05.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 05:57:10 -0700 (PDT)
Date: Tue, 12 May 2020 14:57:08 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC 02/17] dma-fence: basic lockdep annotations
Message-ID: <20200512125708.GG206103@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@ziepe.ca>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Chris Wilson <chris@chris-wilson.co.uk>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel.vetter@intel.com>
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
 <20200512085944.222637-3-daniel.vetter@ffwll.ch>
 <20200512120952.GG26002@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200512120952.GG26002@ziepe.ca>
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
Cc: linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 intel-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Chris Wilson <chris@chris-wilson.co.uk>, linaro-mm-sig@lists.linaro.org,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 12, 2020 at 09:09:52AM -0300, Jason Gunthorpe wrote:
> On Tue, May 12, 2020 at 10:59:29AM +0200, Daniel Vetter wrote:
> > diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> > index 6802125349fb..d5c0fd2efc70 100644
> > +++ b/drivers/dma-buf/dma-fence.c
> > @@ -110,6 +110,52 @@ u64 dma_fence_context_alloc(unsigned num)
> >  }
> >  EXPORT_SYMBOL(dma_fence_context_alloc);
> >  
> > +#ifdef CONFIG_LOCKDEP
> > +struct lockdep_map	dma_fence_lockdep_map = {
> > +	.name = "dma_fence_map"
> > +};
> > +
> > +bool dma_fence_begin_signalling(void)
> > +{
> 
> Why is this global? I would have expected it to be connected to a
> single fence?

It's the same rules for all fences, since they can be shared across
drivers in various ways. Lockdep usually achieves that with a static
variable hidden in the macro, but that doesn't work if you have lots of
different ways from different drivers to create a dma_fence. Hence the
unique global one that we explicitly allocate.

We have similar stuff for the global dma_resv_lock ww_mutex class, just
there it's a bit more standardized and hidden behind a neat macro. But
really lockdep needs global lockdep_maps or it doesn't work.

> It would also be alot nicer if this was some general lockdep feature,
> not tied to dmabuf. This exact problem also strikes anyone using
> completions, for instance, and the same solution should be
> applicable??

There was:

https://lwn.net/Articles/709849/

It even got merged, and seems to have worked. Unfortunately (and I'm not
entirely clear on the reasons) it was thrown out again, so we can't use
it. That means wait_event/wake_up dependencies need to be manually
annotated, like e.g. flush_work() already is. flush_work is more or less
where I've stolen this idea from, with some adjustements and tricks on top
to make it work for dma_fence users.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
