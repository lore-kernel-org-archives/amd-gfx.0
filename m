Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF29EC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 15:09:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C65FD21974
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 15:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GpTji/yh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65FD21974
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F8F26E062;
	Fri, 19 Jun 2020 15:09:44 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D9306EC93
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 11:39:37 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id r22so7071498qke.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 04:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=5lQCYSoi4FC78xGjLBeogrhLOaSlungd8A2lT6c416A=;
 b=GpTji/yhJTYfywss1k5am+JyELnNZlvvM8qP/Uyg3OD7x7MqDitwSWfgM3HPj0UhUM
 CmGRkgXfDHKjJbk/G94ThGo65HoXLKpYTHWId62kC64177gtGxTII+K1ZYz1wipOiAHJ
 eNgWeTmTaG/jDKlMWG2mJATpUK5rAwHHXT5FR/exkvaSA9MSXlfn3hlOUhTW2ZxS/H4F
 HEmI2H47vtMrMdfYBePKTzq7Q28TCNQpdwQLKytMyWVDkIDxh7YsNl1xg+jdzcXMR0cI
 rZrwuwfz+8JvRuJ/hZc0oTCMz+QMnazKQOTVrKsL2AkwHyGJfWycuxP+cVSimTbDO1fJ
 9CVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5lQCYSoi4FC78xGjLBeogrhLOaSlungd8A2lT6c416A=;
 b=BiDiVbe+PpUTFtmAbZqfT3nkrzzpL02loo/lVmRmWZSiHtMtraz3V0ANuDIJCqDCHe
 Ff5BJ7p5dnrtdTOrl4sLzrKB5Vc3304B5KTTNrJV0EXVtAU2l8cUYndvSsV7teeDEvX8
 Yi6eVcoBcvqOZ8IHsbbH14q7cbdNFFDCFwvQHKdi+0uh8DaH/LgNkLOkkicpWtHvJ/RP
 +Org3uToy0zlqi5BVU89YqHgUuC101h6cf/CWIokwA6j+pQ/x3mxpJXOU+6A9IBN6/i3
 klPEBgRYASAKQngf53ROjJbOdu3dfH40YqN7gpIeMp3H3e/qSoiaP77TdCZPe2t0wAkx
 CTwQ==
X-Gm-Message-State: AOAM533zFlsqDp9uW0GNVeh+JEGsVC22xJREBNb6qyXoZLQO0M2cTcIE
 SqpTPuUBuY3yhR4PgWT/gq6bJg==
X-Google-Smtp-Source: ABdhPJyvT5Fp9eB5e8a01kFzBtsDczKSLoT1L7Q5mintxsSice/gNXkvAdcFjnB+DRsdXJvj32xdRg==
X-Received: by 2002:a37:6191:: with SMTP id v139mr2946071qkb.213.1592566776171; 
 Fri, 19 Jun 2020 04:39:36 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id o6sm6016053qtd.59.2020.06.19.04.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 04:39:35 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93) (envelope-from <jgg@ziepe.ca>)
 id 1jmFMs-00AiVa-OZ; Fri, 19 Jun 2020 08:39:34 -0300
Date: Fri, 19 Jun 2020 08:39:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep annotations
Message-ID: <20200619113934.GN6578@ziepe.ca>
References: <20200604081224.863494-5-daniel.vetter@ffwll.ch>
 <b11c2140-1b9c-9013-d9bb-9eb2c1906710@shipmail.org>
 <20200611083430.GD20149@phenom.ffwll.local>
 <20200611141515.GW6578@ziepe.ca>
 <20200616120719.GL20149@phenom.ffwll.local>
 <CAKMK7uE7DKUo9Z+yCpY+mW5gmKet8ugbF3yZNyHGqsJ=e-g_hA@mail.gmail.com>
 <20200617152835.GF6578@ziepe.ca>
 <20200618150051.GS20149@phenom.ffwll.local>
 <20200618172338.GM6578@ziepe.ca>
 <CAKMK7uEbqTu4q-amkLXyd1i8KNtLaoO2ZFoGqYiG6D0m0FKpOg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKMK7uEbqTu4q-amkLXyd1i8KNtLaoO2ZFoGqYiG6D0m0FKpOg@mail.gmail.com>
X-Mailman-Approved-At: Fri, 19 Jun 2020 15:09:43 +0000
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

On Fri, Jun 19, 2020 at 09:22:09AM +0200, Daniel Vetter wrote:
> > As I've understood GPU that means you need to show that the commands
> > associated with the buffer have completed. This is all local stuff
> > within the driver, right? Why use fence (other than it already exists)
> 
> Because that's the end-of-dma thing. And it's cross-driver for the
> above reasons, e.g.
> - device A renders some stuff. Userspace gets dma_fence A out of that
> (well sync_file or one of the other uapi interfaces, but you get the
> idea)
> - userspace (across process or just different driver) issues more
> rendering for device B, which depends upon the rendering done on
> device A. So dma_fence A is an dependency and will block this dma
> operation. Userspace (and the kernel) gets dma_fence B out of this
> - because unfortunate reasons, the same rendering on device B also
> needs a userptr buffer, which means that dma_fence B is also the one
> that the mmu_range_notifier needs to wait on before it can tell core
> mm that it can go ahead and release those pages

I was afraid you'd say this - this is complete madness for other DMA
devices to borrow the notifier hook of the first device!

What if the first device is a page faulting device and doesn't call
dma_fence??

It you are going to treat things this way then the mmu notifier really
needs to be part of the some core DMA buf, and not randomly sprinkled
in drivers

But really this is what page pinning is supposed to be used for, the
MM behavior when it blocks on a pinned page is less invasive than if
it stalls inside a mmu notifier.

You can mix it, use mmu notififers to keep track if the buffer is
still live, but when you want to trigger DMA then pin the pages and
keep them pinned until DMA is done. The pin protects things (well,
fork is still a problem)

Do not need to wait on dma_fence in notifiers.

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
