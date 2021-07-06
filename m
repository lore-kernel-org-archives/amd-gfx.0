Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AD8C11F66
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 16:32:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 400C861C38
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 16:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400C861C38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 873B66E527;
	Tue,  6 Jul 2021 16:32:47 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D23D36E4FB
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jul 2021 15:25:45 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id i13so12179807plb.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jul 2021 08:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=kBvoTSBcOt78f+hoOE9oCqUZer2JVIUIWKm+LE7tBB8=;
 b=X163Xk+G02T/FYeziNGDwCPOc6BLNJpmRANJZemVrSobPquSFvpYvLg7I+/xXol03F
 kgToG/GWqTW22vdfS86rrDbHG+VIoJpV7F3ia6ZGlrrWTBFKBlA1qJfDU2QYjFMxw9bn
 18zM+SC3OK5PBTSWnVn9GnFtpVk1NhRB4WRRd6zVs3M5rR6QpNocNXBiV7EL2h8le3Ow
 jvZU/A0iyEbkwxC5Yua5tblx9J0ejeZ7v4lloFM8eg/sgExGmReJOD+eEQ6g9p7ckBea
 AQnNsdBTVeckFCBTYdf84UR54cEJl3YU8s6gAghdvxWN3OAHAx/OxyzWsnveJxZQA+4F
 K0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kBvoTSBcOt78f+hoOE9oCqUZer2JVIUIWKm+LE7tBB8=;
 b=QZaAja3mS4qWVmPBJND4j3psW3+L7rJc1m+7bYV5xBUY/Nn0aC+da6+Q/2IRtd3tHF
 sPfsPinlO4yaDanHReaKVQQ3KvAihcSaBqroP8oxBEA1tuFD1SQYxxZ3+nAbMsbBUjd2
 6IsdoG85t2oXvcdY4c94udH+i/y3ssiV+108m/O1X87URHkLv2JGVUCpylG1ge0I5iW5
 kpyxFqkpsPGfRrWF608Mv+AGc/inx04LswYmJhvkXK3s7ed4rILQI0v+f1pAUr04Xf4Q
 fC24j/3TiKDR8jwew3SXZkXqNmHfw6ICmSc5XN8uxMxXnV7TEnbOIIMqoPsDdtU44t39
 PgXQ==
X-Gm-Message-State: AOAM530y6Vjs3uPY68Unqw+37iByMK+lnwklfU+VQxXS5T7kVeEvkKeV
 nLvoWLcTEvxLjA9aerX/TGfrmA==
X-Google-Smtp-Source: ABdhPJxrcXwOAFPmP3ClDrDAEt0u9Z/9YZvGne/AXypBqtfhopbFKVCe78sZDR5N+5fl5a1I4tI3yA==
X-Received: by 2002:a17:90a:8417:: with SMTP id
 j23mr1072739pjn.210.1625585145462; 
 Tue, 06 Jul 2021 08:25:45 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id m18sm17872288pff.88.2021.07.06.08.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jul 2021 08:25:44 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1m0mxC-004SbX-Ps; Tue, 06 Jul 2021 12:25:42 -0300
Date: Tue, 6 Jul 2021 12:25:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v4 0/2] Add p2p via dmabuf to habanalabs
Message-ID: <20210706152542.GP4604@ziepe.ca>
References: <20210705130314.11519-1-ogabbay@kernel.org>
 <YOQXBWpo3whVjOyh@phenom.ffwll.local>
 <CAFCwf10_rTYL2Fy6tCRVAUCf4-6_TtcWCv5gEEkGnQ0KxqMUBg@mail.gmail.com>
 <CAKMK7uEAJZUHNLreBB839BZOfnTGNU4rCx-0k55+67Nbxtdx3A@mail.gmail.com>
 <20210706142357.GN4604@ziepe.ca>
 <CAKMK7uELNzwUe+hhVWRg=Pk5Wt_vOOX922H48Kd6dTyO2PeBbg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKMK7uELNzwUe+hhVWRg=Pk5Wt_vOOX922H48Kd6dTyO2PeBbg@mail.gmail.com>
X-Mailman-Approved-At: Tue, 06 Jul 2021 16:32:45 +0000
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

On Tue, Jul 06, 2021 at 04:39:19PM +0200, Daniel Vetter wrote:
> On Tue, Jul 6, 2021 at 4:23 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Jul 06, 2021 at 12:36:51PM +0200, Daniel Vetter wrote:
> >
> > > If that means AI companies don't want to open our their hw specs
> > > enough to allow that, so be it - all you get in that case is
> > > offloading the kernel side  of the stack for convenience, with zero
> > > long term prospects to ever make this into a cross vendor subsystem
> > > stack that does something useful.
> >
> > I don't think this is true at all - nouveau is probably the best
> > example.
> >
> > nouveau reverse engineered a userspace stack for one of these devices.
> >
> > How much further ahead would they have been by now if they had a
> > vendor supported, fully featured, open kernel driver to build the
> > userspace upon?
> 
> There is actually tons of example here, most of the arm socs have
> fully open kernel drivers, supported by the vendor (out of tree).

I choose nouveau because of this:

$ git ls-files drivers/gpu/drm/arm/ | xargs wc -l
 15039 total
$ git ls-files drivers/gpu/drm/nouveau/ | xargs wc -l
 204198 total

At 13x the size of mali this is not just some easy to wire up memory
manager and command submission. And after all that typing it still
isn't very good. The fully supported AMD vendor driver is over 3
million lines, so nouveau probably needs to grow several times.

My argument is that an in-tree open kernel driver is a big help to
reverse engineering an open userspace. Having the vendors
collaboration to build that monstrous thing can only help the end goal
of an end to end open stack.

For instance a vendor with an in-tree driver has a strong incentive to
sort out their FW licensing issues so it can be redistributed.

I'm not sure about this all or nothing approach. AFAIK DRM has the
worst problems with out of tree drivers right now.

> Where it would have helped is if this open driver would come with
> redistributable firmware, because that is right now the thing making
> nouveau reverse-engineering painful enough to be non-feasible. Well
> not the reverse-engineering, but the "shipping the result as a working
> driver stack".

I don't think much of the out of tree but open drivers. The goal must
be to get vendors in tree.

I would applaud Habana for getting an intree driver at least, even if
the userspace is not what we'd all want to see.

> I don't think the facts on the ground support your claim here, aside
> from the practical problem that nvidia is unwilling to even create an
> open driver to begin with. So there isn't anything to merge.

The internet tells me there is nvgpu, it doesn't seem to have helped.

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
