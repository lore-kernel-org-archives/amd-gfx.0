Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A53C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 20:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CCF61038
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 20:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C8CCF61038
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 753836E0FC;
	Mon, 18 Oct 2021 20:01:41 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FB176EA49
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 18:26:06 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id j12so10058912qkk.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 11:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=VWav6NFcp7Imar+k++zv5L6bzbFiMGeoi4IbLNr1qXk=;
 b=iulG1Hi/BWXnGHXIUJtE3Sch4DxTtHHGjYAbR7SgfDwl3Tc6og/olLkcCwEBbB2k6G
 IfgEoidJStEKIbj2It5DifRzrECL7P9NI1viyq+lBosbBqcDaY1Cx5CKvpaCMMtwcLaK
 LJk+g8GcJQ9MYUf7YDlnJqNpxqQtZJQQNHXot+kUflb9VL1jiqaRs9roMA774Pq07G8P
 z6MQINCUTuDZeMIbiJyaMaqTsUS5Xe2aLaKTMnNU2nVECI+IUQvATxqyqgKryVcE6Odi
 UPrSa/zR8XpvPyVh6RkKVjlgDcQlRQzheAMj9zSJ3nZtedo1kmeWigT4fsV71OfsmWN0
 6Uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VWav6NFcp7Imar+k++zv5L6bzbFiMGeoi4IbLNr1qXk=;
 b=XLZYhZrHDU35SHAOhjAK3DbHu687Dsw0cHDC5aOAtg1NNtkyOZCvknpOyde6Ne7JDW
 v8yDGIiifhkersF48PU+dY+K0n540pDEsiG/8NFxTP4etez9S1jxEpvUDxmptJ+5dCfF
 xBbsLqKxeXbLP1Oh2NQNjqly9CBtRhF204K6xlo6o1cXTjebsKZzWuFQ12AsWuw3/phD
 /WfCKghmgN6BKBgSxC/z/7ZaIYUSCSHxS2febeTyKy4Qnk+dYHY4lLWhZG1ONEkHx2Q5
 TkFZgQrOm91IMM4c6JMQ0GLwedv4OrF7EhmqVIdGYJ9OgD1trAv+kgMb+Q5Z6aSKBaS4
 +E/g==
X-Gm-Message-State: AOAM532O1wC11M4PgmTMLY+EhQj6pQiMLE4KSsFVz2WP9obw5TR1f3na
 auh2f2XWBILYEEN4j8CydU1bsg==
X-Google-Smtp-Source: ABdhPJx0w5FpmLsv0LfpzJkRgNCEFvSTyhRWvN2OZSonMTzVl3H3jB0V5GZKEdNIQJ2jOwLftPxV7g==
X-Received: by 2002:a05:620a:2947:: with SMTP id
 n7mr24141155qkp.60.1634581560548; 
 Mon, 18 Oct 2021 11:26:00 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id m195sm6853505qke.73.2021.10.18.11.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Oct 2021 11:25:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mcXKh-00GLjg-2o; Mon, 18 Oct 2021 15:25:59 -0300
Date: Mon, 18 Oct 2021 15:25:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>, Alex Sierra <alex.sierra@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, Linux MM <linux-mm@kvack.org>,
 Ralph Campbell <rcampbell@nvidia.com>,
 linux-ext4 <linux-ext4@vger.kernel.org>,
 linux-xfs <linux-xfs@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Christoph Hellwig <hch@lst.de>,
 =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Linux NVDIMM <nvdimm@lists.linux.dev>,
 David Hildenbrand <david@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v1 2/2] mm: remove extra ZONE_DEVICE struct page refcount
Message-ID: <20211018182559.GC3686969@ziepe.ca>
References: <20211014153928.16805-1-alex.sierra@amd.com>
 <20211014153928.16805-3-alex.sierra@amd.com>
 <20211014170634.GV2744544@nvidia.com>
 <YWh6PL7nvh4DqXCI@casper.infradead.org>
 <CAPcyv4hBdSwdtG6Hnx9mDsRXiPMyhNH=4hDuv8JZ+U+Jj4RUWg@mail.gmail.com>
 <20211014230606.GZ2744544@nvidia.com>
 <CAPcyv4hC4qxbO46hp=XBpDaVbeh=qdY6TgvacXRprQ55Qwe-Dg@mail.gmail.com>
 <20211016154450.GJ2744544@nvidia.com>
 <CAPcyv4j0kHREAOG6_07E2foz6e4FP8D72mZXH6ivsiUBu_8c6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4j0kHREAOG6_07E2foz6e4FP8D72mZXH6ivsiUBu_8c6g@mail.gmail.com>
X-Mailman-Approved-At: Mon, 18 Oct 2021 20:01:40 +0000
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

On Sun, Oct 17, 2021 at 11:35:35AM -0700, Dan Williams wrote:

> > DAX is stuffing arrays of 4k pages into the PUD/PMDs. Aligning with
> > THP would make using normal refconting much simpler. I looked at
> > teaching the mm core to deal with page arrays - it is certainly
> > doable, but it is quite inefficient and ugly mm code.
> 
> THP does not support PUD, and neither does FSDAX, so it's only PMDs we
> need to worry about.

device-dax uses PUD, along with TTM, they are the only places. I'm not
sure TTM is a real place though.

> > So, can we fix DAX and TTM - the only uses of PUD/PMDs I could find?
> >
> > Joao has a series that does this to device-dax:
> >
> > https://lore.kernel.org/all/20210827145819.16471-1-joao.m.martins@oracle.com/
> 
> That assumes there's never any need to fracture a huge page which
> FSDAX could not support unless the filesystem was built with 2MB block
> size.

As I understand things, something like FSDAX post-folio should
generate maximal compound pages for extents in the page cache that are
physically contiguous.

A high order folio can be placed in any lower order in the page
tables, so we never have to fracture it, unless the underlying page
are moved around - which requires an unmap_mapping_range() cycle..

> > Assuming changing FSDAX is hard.. How would DAX people feel about just
> > deleting the PUD/PMD support until it can be done with compound pages?
> 
> There are end users that would notice the PMD regression, and I think
> FSDAX PMDs with proper compound page metadata is on the same order of
> work as fixing the refcount.

Hmm, I don't know.. I sketched out the refcount stuff and the code is
OK but ugly and will add a conditional to some THP cases

On the other hand, making THP unmap cases a bit slower is probably a
net win compared to making put_page a bit slower.. Considering unmap
is already quite heavy.

> > 4) Ask what the pgmap owner wants to do:
> >
> >     if (head->pgmap->deny_foll_longterm)
> >           return FAIL
> 
> The pgmap itself does not know, but the "holder" could specify this
> policy. 

Here I imagine the thing that creates the pgmap would specify the
policy it wants. In most cases the policy is tightly coupled to what
the free function in the the provided dev_pagemap_ops does..

> Which is in line with the 'dax_holder_ops' concept being introduced
> for reverse mapping support. I.e. when the FS claims the dax-device
> it can specify at that point that it wants to forbid longterm.

Which is a reasonable refinment if we think there are cases where two
nvdim users would want different things.

Anyhow, I'm wondering on a way forward. There are many balls in the
air, all linked:
 - Joao's compound page support for device_dax and more
 - Alex's DEVICE_COHERENT
 - The refcount normalization
 - Removing the pgmap test from GUP
 - Removing the need for the PUD/PMD/PTE special bit
 - Removing the need for the PUD/PMD/PTE devmap bit
 - Remove PUD/PMD vma_is_special
 - folios for fsdax
 - shootdown for fsdax

Frankly I'm leery to see more ZONE_DEVICE users crop up that depend on
the current semantics as that will only make it even harder to fix..

I think it would be good to see Joao's compound page support move
ahead..

So.. Does anyone want to work on finishing this patch series?? I can
give some guidance on how I think it should work at least

Jason
