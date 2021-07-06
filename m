Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575A6C07E9B
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 14:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A3B613B2
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 14:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A3B613B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B7F46E4D2;
	Tue,  6 Jul 2021 14:39:32 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 614426E4D2
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jul 2021 14:39:31 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 7-20020a9d0d070000b0290439abcef697so21786056oti.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jul 2021 07:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zm0DaryDqZq3vejGZ3jPeBiO1tR+wTWZk5xnShXCnO4=;
 b=G30UzRcjxEx6Xt1b6aM3vMaunEynpsORVhKQH6x0woz09DwXifJzfkCwSyC/RCtJF6
 0dlH0FE/N9kBHKK6ACyKzCL9AAOx7O6sYOnj6Loko6p9DlXanIsMowNmzYBNl9TxrrVf
 GOw2Y2m6AMmOya+oUGFCdCcJKjukWk6zcmTM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zm0DaryDqZq3vejGZ3jPeBiO1tR+wTWZk5xnShXCnO4=;
 b=QJPqhyeCrfis5CYny4SBSBiOTPQkMcGdgQy28z2GYJJrebiDazYOEC9OayNfy0cWwh
 Nj1vJn6Fy6D69mguOsU51VpdM7dp8Zwav/FRhySacjaiEURP6EKR/WwUsGisMtqYq5Lm
 zIvQfnGsO8++bDldN+i3OoWCaq3tTmUthW68Tb0ZA7AcPg0MWF41f9W5sgi8fHXS12BF
 R0KpeSPvRklbwKX31nhqDfEbJizAAWwEkiMv9cr7LVVVvDvDjuTGbobHuWnakk75jTRk
 HGnXkc4WzCs/MkeC6bRk/eBpwbLU/u/gC8aaSq5VbhsqeUEW9bC6q4BU3DwF19wc0CSN
 IIfg==
X-Gm-Message-State: AOAM530NOMCBtWXYHDR+nEBLZzW86kfRJmWL6xzn6UCngibxrSzAWxud
 gwMfYyCitx9SVhadlJo6MGSsDrOZ+VkRsEMfojIjjw==
X-Google-Smtp-Source: ABdhPJzgkWaB0S4HP/SYLFWoigqz0+uVa0qbfzt618JpPtslruMLA86ntCgmp9G7+R8uc+hgYBv5HiSGfZAE493M7OE=
X-Received: by 2002:a9d:27a4:: with SMTP id c33mr15519363otb.281.1625582370636; 
 Tue, 06 Jul 2021 07:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210705130314.11519-1-ogabbay@kernel.org>
 <YOQXBWpo3whVjOyh@phenom.ffwll.local>
 <CAFCwf10_rTYL2Fy6tCRVAUCf4-6_TtcWCv5gEEkGnQ0KxqMUBg@mail.gmail.com>
 <CAKMK7uEAJZUHNLreBB839BZOfnTGNU4rCx-0k55+67Nbxtdx3A@mail.gmail.com>
 <20210706142357.GN4604@ziepe.ca>
In-Reply-To: <20210706142357.GN4604@ziepe.ca>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 6 Jul 2021 16:39:19 +0200
Message-ID: <CAKMK7uELNzwUe+hhVWRg=Pk5Wt_vOOX922H48Kd6dTyO2PeBbg@mail.gmail.com>
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

On Tue, Jul 6, 2021 at 4:23 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Jul 06, 2021 at 12:36:51PM +0200, Daniel Vetter wrote:
>
> > If that means AI companies don't want to open our their hw specs
> > enough to allow that, so be it - all you get in that case is
> > offloading the kernel side  of the stack for convenience, with zero
> > long term prospects to ever make this into a cross vendor subsystem
> > stack that does something useful.
>
> I don't think this is true at all - nouveau is probably the best
> example.
>
> nouveau reverse engineered a userspace stack for one of these devices.
>
> How much further ahead would they have been by now if they had a
> vendor supported, fully featured, open kernel driver to build the
> userspace upon?

There is actually tons of example here, most of the arm socs have
fully open kernel drivers, supported by the vendor (out of tree).

The hard part is the userspace driver and all the things you're
submitting to it. We've had open kernel drivers for mail/qualcomm/...
years before any believable open implementation started existing.
Typing up the memory manager and hw submission queue handling is
comparitively trivial. Generally the kernel driver is also done last,
you bring up the userspace first, often by just directly programming
the hw from userspace. Kernel driver only gets in the way with this
stuff (nouveau is entirely developed as a userspace driver, as the
most extreme example).

This is a bit different for the display side, but nowadays those
drivers are fully in-kernel so they're all open. Well except the
nvidia one, and I've not heard of nvidia working on even an
out-of-tree open display driver, so that won't help the in-tree effort
at all.

Where it would have helped is if this open driver would come with
redistributable firmware, because that is right now the thing making
nouveau reverse-engineering painful enough to be non-feasible. Well
not the reverse-engineering, but the "shipping the result as a working
driver stack".

I don't think the facts on the ground support your claim here, aside
from the practical problem that nvidia is unwilling to even create an
open driver to begin with. So there isn't anything to merge.

> > open up your hw enough for that, I really don't see the point in
> > merging such a driver, it'll be an unmaintainable stack by anyone else
> > who's not having access to those NDA covered specs and patents and
> > everything.
>
> My perspective from RDMA is that the drivers are black boxes. I can
> hack around the interface layers but there is a lot of wild stuff in
> there that can't be understood without access to the HW documentation.

There's shipping gpu drivers with entirely reverse-engineered stacks.
And I don't mean "shipping in fedora" but "shipping in Chrome tablets
sold by OEM partners of Google". So it's very much possible, even if
the vendor is maximally stubborn about things.

> I think only HW that has open specs, like say NVMe, can really be
> properly community oriented. Otherwise we have to work in a community
> partnership with the vendor.

Well sure that's the ideal case, but most vendors in the accel space
arent interested actual partnership with the wider community. It's
"merge this kernel driver and have no further demands about anything
else". Well there are some who are on board, but it does take pretty
enormous amounts of coercion.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
