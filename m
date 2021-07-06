Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C9AC07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 13:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1149E61CA0
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 13:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1149E61CA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE5736E4BB;
	Tue,  6 Jul 2021 13:52:46 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBDA06E49D
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jul 2021 13:44:32 +0000 (UTC)
Received: by mail-qk1-x72d.google.com with SMTP id 9so1218734qkf.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jul 2021 06:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=nYMSUda7V/DmmAuzip7JbF6LIDuj8UtQ05rEhsj9lGA=;
 b=V36CzWcFqXgQrH0S61JBopqFYw86l1KRRiKJIfDMvpGLy4yCd9hRFVr0veacKuzH9C
 Zgqj20uE9eKfAWLyfKmwP+hpUiApugYVKPIUd+EFXMxS/jWvnL3mn8mSgjzu4iIFPcKJ
 45inefBONCCkx8NgDhSgPV+1arRfzXXcfRNx3yJokZyujlPZfXzS0at11zwyPuA+RpQv
 wjKe6ehncM5CybBy6YVtafHvR9nArwr4etCQhsgoD72pN8YiB6jEe/6xvn5lmExqOPcd
 l2ikCxlts7bnffEllKLPSylZMJUJm44orkIDc9OCKJTeMjFkIgoY/LXb3bYUCoqdKvKg
 KJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nYMSUda7V/DmmAuzip7JbF6LIDuj8UtQ05rEhsj9lGA=;
 b=CjgFOszszAzuMybmvLzE6Kgq+D1SrEV4SQpGIMPRhHNk8EkeBG7sPZYbk69vyo4r1X
 edCe182wyQlIdCHRqS1ibOtDIo+vpSTaK4NIbLIWVCLNo9Luc9gIPTqJi6ZmBB+6WpgP
 LJtIiRMVMcXIM/wjVig5Hbl1xsb8E/F9qPD+Nm7Sy/Zf9JIZGdlglok4peVE5EMSaH36
 2Qe7dHaAnNDDpiHEhCFhIhdV2H05T7XxePZUD5f+u2foQHV2CPUuoAnBkZHUkyA8IAPK
 dZ8l9XfyZ1TGLXOJ9zY5e03Lf8USb82MHitTAnBCwaZTBFI1nmj6BWEIMMs3ilLKXrZY
 kiWw==
X-Gm-Message-State: AOAM5322BNIOZyRqpWpVgU3dOZ1BUcdjDnwJk8apO9cfk3zs3zkCuF3b
 MAfjt923BnQHlnCvIcxuj1ICmQ==
X-Google-Smtp-Source: ABdhPJwbPsdj5abBUwRj+0D+UPcg9LktUa6esBS7MFcNQJN0mzluRvDbxhBXY3stdAxEO20KouenjQ==
X-Received: by 2002:a37:68c6:: with SMTP id
 d189mr20223444qkc.186.1625579071862; 
 Tue, 06 Jul 2021 06:44:31 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id v5sm6919384qkh.39.2021.07.06.06.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jul 2021 06:44:31 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1m0lNG-004Qag-41; Tue, 06 Jul 2021 10:44:30 -0300
Date: Tue, 6 Jul 2021 10:44:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v4 0/2] Add p2p via dmabuf to habanalabs
Message-ID: <20210706134430.GL4604@ziepe.ca>
References: <20210705130314.11519-1-ogabbay@kernel.org>
 <YOQXBWpo3whVjOyh@phenom.ffwll.local>
 <CAFCwf10_rTYL2Fy6tCRVAUCf4-6_TtcWCv5gEEkGnQ0KxqMUBg@mail.gmail.com>
 <CAKMK7uEAJZUHNLreBB839BZOfnTGNU4rCx-0k55+67Nbxtdx3A@mail.gmail.com>
 <CAKMK7uHpKFVm55O_NB=WYCsv0iUt92ZUn6eCzifH=unbhe3J8g@mail.gmail.com>
 <CAKMK7uFGr=ugyKj0H3ctbh28Jnr25vAgXPBaDBMmfErCxYVo3w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKMK7uFGr=ugyKj0H3ctbh28Jnr25vAgXPBaDBMmfErCxYVo3w@mail.gmail.com>
X-Mailman-Approved-At: Tue, 06 Jul 2021 13:52:46 +0000
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
Cc: Oded Gabbay <oded.gabbay@gmail.com>, Gal Pressman <galpress@amazon.com>,
 sleybo@amazon.com, linux-rdma <linux-rdma@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oded Gabbay <ogabbay@kernel.org>,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Doug Ledford <dledford@redhat.com>, Christoph Hellwig <hch@lst.de>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@gmail.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Leon Romanovsky <leonro@nvidia.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 06, 2021 at 02:07:16PM +0200, Daniel Vetter wrote:

> On the "rdma-core" idea, afaik rdma NIC do not have fully programmable
> cores in their hw, for which you'd need some kind of compiler to make
> use of the hardware and the interfaces the kernel provides? So not
> really compareable, but also my understanding is that rdma-core does
> actually allow you to reasonable use&drive all the hw features and
> kernel interfaces fully.

The whole HPC stack has speciality compilers of course. OpenMP, PGAS,
etc. These compilers map onto library primitives that eventually boil
down into rdma-core calls. Even the HW devices have various
programmability that are being targetted with compilers now. People
are making NIC devices with ARM cores/etc - P4 is emerging for some
packet processing tasks.

rdma-core can drive all the kernel interfaces with at least an ioctl
wrapper, and it has a test suite that tries to cover this. It does not
exercise the full HW capability, programmability, etc of every single
device.

I actually don't entirely know what everyone has built on top of
rdma-core, or how I'd try to map it the DRI ideas you are trying to
explain.

Should we ban all Intel RDMA drivers because they are shipping
proprietary Intel HPC compilers and proprietary Intel MPI which drives
their RDMA HW? Or is that OK because there are open analogs for some
of that stuff? And yes, the open versions are inferior in various
metrics.

Pragmatically what I want to see is enough RDMA common/open user space
to understand the uAPI and thus more about how the kernel driver
works. Forcing everyone into rdma-core has already prevented a number
of uAPI mistakes in drivers that would have been bad - so at least
this level really is valuable.

> So we actually want less on dri-devel, because for compute/accel chips
> we're currently happy with a vendor userspace. It just needs to be
> functional and complete, and open in its entirety.

In a sense yes: DRI doesn't insist on a single code base to act as the
kernel interface, but that is actually the thing that has brought the
most value to RDMA, IMHO.

We've certainly had some interesting successes because of this. The
first submission for AWS's EFA driver proposed to skip the rdma-core
step, which was rejected. However since EFA has been in that ecosystem
it has benefited greatly, I think.

However, in another sense no: RDMA hasn't been blocking, say Intel,
just because they have built proprietary stuff on top of our open
stack.

Honestly, I think GPU is approaching this backwards. Wayland should
have been designed to prevent proprietary userspace stacks.

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
