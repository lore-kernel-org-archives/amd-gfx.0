Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6295DC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 15:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A20720890
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 15:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="X4atcg3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A20720890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE5D66E129;
	Wed, 17 Jun 2020 15:36:36 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF8D76E96C
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 15:29:42 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id p15so1198763qvr.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 08:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=v5BdIMSU0SgDrZuQSRW4xvIrY4rZ7WnbUK5J5TOXFb0=;
 b=X4atcg3QCitKJdCOr5ja2tE2bUBLSFF91J0CzDtXnsV5WejCzsk2eajJzTjXjsFLTA
 5s+gkYE18Kz4f7uWFKMYMARjm17DhKgqFhDle7hMjPDQJSHTF3vHPDJzf/g8gfXm1XCc
 xS0VLL2kkFYRGpHsv6IKsvfpDgxixqoGb1C7eZAdpsByKmZrD/PLYevp7FEa9NQdLxHk
 yZFftabPuFhyEj1G7fMasvfilN4m93P/kXM+Vvvx/r/xyhIpvBM0x0Ha3wX71m2O7A/a
 L0H0SGP2pZKrl4si0m+rtOCOCb+j5CVmE5xryjAmjELn7Uqp0ivvBvKuiMRBNAyyx2kG
 itRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=v5BdIMSU0SgDrZuQSRW4xvIrY4rZ7WnbUK5J5TOXFb0=;
 b=mXAc+o23AIt+OaAXRzJakaPJB6b55xSytnJSrt4xe0Vf5wQEMefZCVKXiQ+GyZyA+Z
 yxzc1UJOORSAqYa6G2k3BTGs53SKbmSaNeqgQMl2byHtCRb6GFnXRjh7qoz+PigNVLnR
 ZD6GqpU0qQ7O9rJ0TsFrPUArtevedbrIieuRhESndmkpfr6ZeWe6+KBmUDEfn8MUz0rv
 qlbKroDS1c5FLGMFSmNGw9s8/oC4B0ABP9MHJqWudmVi6HWPtBOBSQfSv8xdiNV8cUaL
 V/wMiH2DYdLhChbOLN79IHr3moygdsfcfWLjfu9lrVDWqKi0XmPdX2eUJGdoOlZTmM6F
 nrxw==
X-Gm-Message-State: AOAM530RjSQBx5ufnPgchiGxMn6jbc4daeLDriDHmLlzSto0emLWTl5v
 EZYstqp8L5u/k2nsEdQhrkkFcw==
X-Google-Smtp-Source: ABdhPJyWaY8mWagCAPiiX7EhWCqcjbxUamRd5/mDpg63tRR7xxsYdOaA9ycSUwn3S5FVu3UfHzBj0g==
X-Received: by 2002:a0c:f388:: with SMTP id i8mr8163963qvk.224.1592407781973; 
 Wed, 17 Jun 2020 08:29:41 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id y13sm204954qto.23.2020.06.17.08.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 08:29:41 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93) (envelope-from <jgg@ziepe.ca>)
 id 1jla0S-009d9h-Uc; Wed, 17 Jun 2020 12:29:40 -0300
Date: Wed, 17 Jun 2020 12:29:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep annotations
Message-ID: <20200617152940.GG6578@ziepe.ca>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-5-daniel.vetter@ffwll.ch>
 <b11c2140-1b9c-9013-d9bb-9eb2c1906710@shipmail.org>
 <20200611083430.GD20149@phenom.ffwll.local>
 <20200611141515.GW6578@ziepe.ca>
 <20200616120719.GL20149@phenom.ffwll.local>
 <20200616145312.GC6578@ziepe.ca>
 <CAKMK7uER6ax1zr14xYLKqDfDZp+ycBsY9Yx7JaVkKQ849VfSPg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKMK7uER6ax1zr14xYLKqDfDZp+ycBsY9Yx7JaVkKQ849VfSPg@mail.gmail.com>
X-Mailman-Approved-At: Wed, 17 Jun 2020 15:36:35 +0000
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

On Wed, Jun 17, 2020 at 09:57:54AM +0200, Daniel Vetter wrote:

> > At the very least I think there should be some big warning that
> > dma_fence in notifiers should be avoided.
> 
> Yeah I'm working on documentation, and also the notifiers here
> hopefully make it clear it's massive pain. I think we could even make
> a hard rule that dma_fence in mmu notifier outside of drivers/gpu is a
> bug/misfeature.

Yep!
 
> Might be a good idea to add a MAINTAINERS entry with a K: regex
> pattern, so that you can catch such modifiers. We do already have such
> a pattern for dma-fence, to catch abuse. So if you want I could type
> up a documentation patch for this, get your and others acks and the
> dri-devel folks would enforce that the dma_fence_wait madness doesn't
> leak beyond drivers/gpu

It seems like the best thing
 
> Oded has agreed to remove the dma-fence usage, since they really don't
> need it (and all the baggage that comes with it), plain old completion
> is enough for their use. This use is also why I added the regex to
> MAINTAINERS, so that in the future we can catch people who try to use
> dma_fence because it looks cute and useful, and are completely
> oblivious to all the pain and headaches involved.

This is good!

Thanks,
Jason 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
