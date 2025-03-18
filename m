Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2B6C282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 15:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A002B10E4A7;
	Tue, 18 Mar 2025 15:13:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="BJeV/bMa";
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FA7310E4A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 15:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=1R7pEhN3D0WbzdCM+gpFvznW0oZ+R1d8MN8BLAk/Nj0=; b=BJeV/bMahXcFcuhUKVwJoDDioe
 BgjpQxIlzDTeqLw107KTr2sY4wXI1BqgOaCQqWKpoQHOn3g02tgnis64BWB+xSVq7CvTJYTgH+p5c
 /yYtQdg2uxdAY6W7bV9EAdHYMfuqpFLoluqPc5MoHeFM8jsq4K4aR/nb4rS+fx/4fPEN7fvt7Z9ti
 1/FMm+wuPjFb4J15HytEIv9Qd3bJHbXUGg3Vhy7UFS6X+y7W9052vhn1AgOWugfKo+XIaLZ9w3hET
 KfpsIduJmzzQNLGxwLO4fWBnJV+RKJuuATisWzPCuUBxEWBcFAm2N208MfNyde8MI0+Z4u5CdwBwP
 Zhpcf4OQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tuYRw-0000000Fa2W-28Xr; Tue, 18 Mar 2025 15:01:48 +0000
Date: Tue, 18 Mar 2025 15:01:48 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Subject: Re: Where do ttm->pages come from?
Message-ID: <Z9mK3OfAxilKqJci@casper.infradead.org>
References: <Z9h54wu2Nqbf4OqF@casper.infradead.org>
 <fc78716a-c3ee-40e5-a87e-4068e362aa5c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc78716a-c3ee-40e5-a87e-4068e362aa5c@amd.com>
X-Mailman-Approved-At: Tue, 18 Mar 2025 15:13:49 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 18, 2025 at 09:37:42AM +0100, Christian König wrote:
> Hi Matthew,
> 
> you actually got your understanding exactly inverted :)

Thanks; that's very helpful!

> Amdgpu takes a look at page->mapping to make sure they are *not* coming from the call sequence starting with amdgpu_ttm_tt_set_user_pages() or be imported from another driver through DMA-buf etc...
> 
> The only pages which are allowed to pass this check are the private driver allocated ones, see this code function amdgpu_ttm_tt_populate():
> 
>         for (i = 0; i < ttm->num_pages; ++i)
>                 ttm->pages[i]->mapping = bdev->dev_mapping;
> 
> So far that has been save since nobody else should be using the address space object from our drivers inode under /dev.
> 
> But when you plan to remove page->mapping we probably have a problem here.

OK.  This makes the problem a lot more tractable.

From the MM side, we have a short-term and a long-term goal.  The
long-term goal is to reduce struct page to a single tagged pointer
called a memdesc.  Details here:

https://kernelnewbies.org/MatthewWilcox/Memdescs

In the short term, we're removing page->mapping, ->index, ->lru and
->memcg_data, leaving ->flags, ->_refcount and ->private as well as the
newly-introduced ->memdesc.

So if all you needed to do was identify which pages belong to you,
I'd suggest setting ->private to a unique value (eg bdev->dev_mapping).
But it feels like you need more than that; you need a refcount, and you
need to map pages to userspace.  Do you need to support GUP on these
pages (ie can it be the user buffer for O_DIRECT, can it be registered
with RDMA, that kind of thing), or is this memory just for userspace to
do load/store, and no fancy stuff is allowed?

At this point, I'd suggest that you allocate folios rather than pages.
That lets us continue to use folio->mapping to distinguish these pages.
There would be an opportunity to save some memory in the future by using
a slimmer control structure once we understand the new system better,
but maybe it's OK to just keep using a folio forever.

Thoughts?
