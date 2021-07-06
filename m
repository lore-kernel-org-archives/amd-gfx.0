Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601B0C07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 16:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDC461945
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 16:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDC461945
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5F406E514;
	Tue,  6 Jul 2021 16:07:30 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EB2D6E514
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jul 2021 16:07:29 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id w74so3232641oiw.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jul 2021 09:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7/d4XeaSNsVFlRZLAg8ZLZgaOUGNlKetyWckEAHUwuk=;
 b=f8dtLu2S3sJkSa9ZSHeuZep5p+/9fucE28hhiRStm3/kTJF5pTTLjufnGsshWPsReU
 sFoXOfLWKXyR0MqHTYAI1P/1tSDs/Z+hXT0+kZeRKZQRFpopyYIqJp1KFyNWIf1sbbbh
 MoJw7B3g6qMCsyWaOODx7tdFuro/50BL7StMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7/d4XeaSNsVFlRZLAg8ZLZgaOUGNlKetyWckEAHUwuk=;
 b=gcs+55rowpBKk+pGdNPdZ+PhTOM0L8AOaUofbxIDj9F2ZCANecsRQVEurma6EGQxfR
 VhWpPFxcX1c+MdVZaZ8/uPMD3tkgw7tuDSKYn0BSBlY4ereteb9LHLDrrF/GeHW00vLf
 28bJigf21YVIRv81dtKhkUpwmZmjE6aFGnyCxeBhAxWALmEoaDgbLISsxU5zkplxnLGG
 t5UfnbNR2DfAyGap9c+Zk4dStuLA2FP+4OWBzJZMDMlkNRuWfe6+pEUhTTm5BjK0rNx+
 0jcS81yfO4fDPiL7crXANkd4nA8+UJI+q4neBRrS695eCbLH15SjHakPteZhtLHDHD5k
 TxkA==
X-Gm-Message-State: AOAM531eroNGQUx+sCkRAwVs48nXIVGm1Zq1i0CBbgSEI2HVeJyuU3gJ
 ne3LiIXVQXb7ZwWjTkSVKPbYBKLnGyPkB/Z+iCIKVA==
X-Google-Smtp-Source: ABdhPJyni2s1akvYMUuRqmzUdWsnoOqSRFuCqyMWJzwLyK6OBSwh9Okh9BIirnjonQbsC2vx54cSUlgVRGLUS1EfrOA=
X-Received: by 2002:aca:5793:: with SMTP id l141mr1008420oib.14.1625587648875; 
 Tue, 06 Jul 2021 09:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210705130314.11519-1-ogabbay@kernel.org>
 <YOQXBWpo3whVjOyh@phenom.ffwll.local>
 <CAFCwf10_rTYL2Fy6tCRVAUCf4-6_TtcWCv5gEEkGnQ0KxqMUBg@mail.gmail.com>
 <CAKMK7uEAJZUHNLreBB839BZOfnTGNU4rCx-0k55+67Nbxtdx3A@mail.gmail.com>
 <20210706142357.GN4604@ziepe.ca>
 <CAKMK7uELNzwUe+hhVWRg=Pk5Wt_vOOX922H48Kd6dTyO2PeBbg@mail.gmail.com>
 <20210706152542.GP4604@ziepe.ca>
 <CAKMK7uH7Ar6+uAOU_Sj-mf89V9WCru+66CV5bO9h-WAAv7Mgdg@mail.gmail.com>
In-Reply-To: <CAKMK7uH7Ar6+uAOU_Sj-mf89V9WCru+66CV5bO9h-WAAv7Mgdg@mail.gmail.com>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 6 Jul 2021 18:07:17 +0200
Message-ID: <CAKMK7uGvO0h7iZ3vKGe8GouESkr79y1gP1JXbfV82sRiaT-d1A@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Add p2p via dmabuf to habanalabs
To: Jason Gunthorpe <jgg@ziepe.ca>
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
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Leon Romanovsky <leonro@nvidia.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 6, 2021 at 5:49 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> On Tue, Jul 6, 2021 at 5:25 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > I'm not sure about this all or nothing approach. AFAIK DRM has the
> > worst problems with out of tree drivers right now.
>
> Well I guess someone could stand up a drivers/totally-not-gpu and just
> let the flood in. Even duplicated drivers and everything included,
> because the vendor drivers are better. Worth a shot, we've practically
> started this already, I'm just not going to help with the cleanup.

tbh I think at this point someone should just do that. Ideally with
some boundary like please don't use dma-fence or dma-buf and stuff
like that so drivers/gpu doesn't ever have to deal with the fallout.
But way too many people think that somehow you magically get the other
90% of an open accel stack if you're just friendly enough and merge
the kernel driver, so we really should just that experiment in
upstream and watch it pan out in reality.

Minimally it would be some great entertainment :-)

Also on your claim that drivers/gpu is a non-upstream disaster: I've
also learned that that for drivers/rdma there's the upstream driver,
and then there's the out-of-tree hackjob the vendor actually supports.
So seems to be about the same level of screwed up, if you ask the
vendor they tell you the upstream driver isn't a thing they care about
and it's just done for a bit of goodwill. Except if you have enormous
amounts of volume, then suddenly it's an option ... Minus the fw issue
for nvidia, upstream does support all the gpus you can buy right now
and that can run on linux with some vendor driver (aka excluding apple
M1 and ofc upcoming products from most vendors).

drivers/accel otoh is mostly out-of-tree, because aside from Greg
mergin habanalabs no one is bold enough anymore to just merge them
all. There's lots of those going around that would be ready for
picking. And they've been continously submitted to upstream over the
years, even before the entire habanalabs thing.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
