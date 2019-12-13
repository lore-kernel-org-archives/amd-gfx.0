Return-Path: <SRS0=wwPX=2D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A3AC43603
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 10:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670FE2077B
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 10:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Ap0FGuiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670FE2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA05A6E311;
	Fri, 13 Dec 2019 10:19:21 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BBA06E311
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 10:19:21 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id c9so6021958wrw.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 02:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rl6ZcpYNx9OU5/nEbfBo5yylHG5ar169zdHs7M50F4Q=;
 b=Ap0FGuiBLoc7CtJsj51ddw+Fe6G5hC9uLNn75596J5Cu1boRP8Hx4/X+SsUFptCl/Q
 4QdXTyu9jjysyr2JBOZZkONFripkTFG1nJ6Je9FXEKJyJV3CS23bW7QqwatOtTVrW34S
 /3MuLnSkpFz69g6E4iETKNuOb9eg/WRwlc/rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to:user-agent;
 bh=rl6ZcpYNx9OU5/nEbfBo5yylHG5ar169zdHs7M50F4Q=;
 b=i6l+m40o6v/M3ZF5L8cQ7/wis2JfdKiGFHQ05nyfLO39RooQV3lZqPQDDi9GWNaX5n
 pBwE/j4qtsxJQI/FwDH5Omd1vbOhNGuE1wsoPLrNSlaAMusc49KTFmCh4XXCb44ES9YA
 fLH7n1ezuI4ams1TKVSfif9e3gC5cvErPh2EkWo1qlBvKimZRTI22AlPi8gBnzHzPoq8
 ULoitmbrx4wo3DFHF++RM4C13pqpPYX8ZYX7CcOgvR+ZOvCbkB9QeqZu/aTR9uc0j/Kx
 DhiiT/h0VGIVpMbxPNmGgrLN0a/t3BmzhTV22LmNDO39JolXfMl8J5ZlsPlOSzaRhAKm
 a2dw==
X-Gm-Message-State: APjAAAVjhhf9wKrZW4Hna8x3DGuJLqaHujjMwzoMvukJAezr9M17tngU
 s39KwzNsJRTSEQavsaq6VUDAJQ==
X-Google-Smtp-Source: APXvYqyhmTb9L+Ty2qqWHWby6TsBUoPJB8m/X3BYq7Z4RTM7jDbTx/v8gsKAoFlcC2n53nTyeYCmrQ==
X-Received: by 2002:adf:fe12:: with SMTP id n18mr11521520wrr.158.1576232359891; 
 Fri, 13 Dec 2019 02:19:19 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:564b:0:7567:bb67:3d7f:f863])
 by smtp.gmail.com with ESMTPSA id x1sm9393930wru.50.2019.12.13.02.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2019 02:19:18 -0800 (PST)
Date: Fri, 13 Dec 2019 11:19:16 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [GIT PULL] Please pull hmm changes
Message-ID: <20191213101916.GD624164@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@mellanox.com>,
 Jerome Glisse <jglisse@redhat.com>,
 Ralph Campbell <rcampbell@nvidia.com>,
 David Airlie <airlied@linux.ie>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 Dan Williams <dan.j.williams@intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20191125204248.GA2485@ziepe.ca>
 <CAHk-=wiqguF5NakpL4L9XCmmYr4wY0wk__+6+wHVReF2sVVZhA@mail.gmail.com>
 <CAHk-=wiQtTsZfgTwLYgfV8Gr_0JJiboZOzVUTAgJ2xTdf5bMiw@mail.gmail.com>
 <20191203024206.GC5795@mellanox.com>
 <20191205160324.GB5819@redhat.com>
 <20191211225703.GE3434@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191211225703.GE3434@mellanox.com>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
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
Cc: Ralph Campbell <rcampbell@nvidia.com>, David Airlie <airlied@linux.ie>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Christoph Hellwig <hch@lst.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Jerome Glisse <jglisse@redhat.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 11, 2019 at 10:57:13PM +0000, Jason Gunthorpe wrote:
> On Thu, Dec 05, 2019 at 11:03:24AM -0500, Jerome Glisse wrote:
> 
> > > struct mmu_notifier_mm (ie the mm->mmu_notifier_mm)
> > >    -> mmn_mm
> > > struct mm_struct 
> > >    -> mm
> > > struct mmu_notifier (ie the user subscription to the mm_struct)
> > >    -> mn
> > > struct mmu_interval_notifier (the other kind of user subscription)
> > >    -> mni
> > 
> > What about "interval" the context should already tell people
> > it is related to mmu notifier and thus a notifier. I would
> > just remove the notifier suffix, this would match the below
> > range.
> 
> Interval could be a good replacement for mni in the mm/mmu_notififer
> file if we don't do the wholesale rename
> 
> > > I think it would be overall nicer with better names for the original
> > > structs. Perhaps:
> > > 
> > >  mmn_* - MMU notifier prefix
> > >  mmn_state <- struct mmu_notifier_mm
> > >  mmn_subscription (mmn_sub) <- struct mmu_notifier
> > >  mmn_range_subscription (mmn_range_sub) <- struct mmu_interval_notifier
> > >  mmn_invalidate_desc <- struct mmu_notifier_range
> > 
> > This looks good.
> 
> Well, lets just bite the bullet then and switch it. Do you like
> 'state'? I thought that was the weakest one

Since you're asking, here's my bikeshed. I kinda agree _state looks a bit
strange for this, what about a _link suffix in the spirit of

	struct list_head link;

The other common name is "node", but I think that's confusing in the
context of mm code. The purpose of this struct is to link everything
together (and yes it carries also some state, but the main job is to link
a mm_struct to a mmu_notifier). At least for me a _state is configuration
state for a specific object, not something that links a bunch of things
together. But I'm biased on this, since we use that pattern in drm for all
the display state tracking.

Also feel free to ignore my bikeshed :-)

Aside from this I think the proposed names are a solid improvement.
-Daniel

> 
> We could use mmnotif as the prefix, this makes the longest:
> 
>   struct mmnotif_range_subscription
> 
> Which is reasonable enough
> 
> > Maybe we can do a semantic patch to do convertion and then Linus
> > can easily apply the patch by just re-running the coccinelle.
> 
> I tried this last time I renamed everything, it was OK, but it missed
> updating the comments. So it still needs some by-hand helping.
> 
> I'll make some patches next week when I get back.
> 
> Jason
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
