Return-Path: <SRS0=HxPN=NY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E472C432BE
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Sep 2021 12:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAC4860F4B
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Sep 2021 12:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EAC4860F4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F7886E527;
	Thu,  2 Sep 2021 12:56:17 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8406E89AAE;
 Thu,  2 Sep 2021 08:18:30 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1190E6736F; Thu,  2 Sep 2021 10:18:26 +0200 (CEST)
Date: Thu, 2 Sep 2021 10:18:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Christoph Hellwig <hch@lst.de>,
 "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org, rcampbell@nvidia.com,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 jgg@nvidia.com, jglisse@redhat.com, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1 03/14] mm: add iomem vma selection for memory migration
Message-ID: <20210902081826.GA16283@lst.de>
References: <20210825034828.12927-1-alex.sierra@amd.com>
 <20210825034828.12927-4-alex.sierra@amd.com> <20210825074602.GA29620@lst.de>
 <c4241eb3-07d2-c85b-0f48-cce4b8369381@amd.com>
 <a9eb2c4a-d8cc-9553-57b7-fd1622679aaa@amd.com> <20210830082800.GA6836@lst.de>
 <e40b3b79-f548-b87b-7a85-f654f25ed8dd@amd.com>
 <20210901082925.GA21961@lst.de>
 <11d64457-9d61-f82d-6c98-d68762dce85d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11d64457-9d61-f82d-6c98-d68762dce85d@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Mailman-Approved-At: Thu, 02 Sep 2021 12:56:16 +0000
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

On Wed, Sep 01, 2021 at 11:40:43AM -0400, Felix Kuehling wrote:
> >>> It looks like I'm totally misunderstanding what you are adding here
> >>> then.  Why do we need any special treatment at all for memory that
> >>> has normal struct pages and is part of the direct kernel map?
> >> The pages are like normal memory for purposes of mapping them in CPU
> >> page tables and for coherent access from the CPU.
> > That's the user page tables.  What about the kernel direct map?
> > If there is a normal kernel struct page backing there really should
> > be no need for the pgmap.
> 
> I'm not sure. The physical address ranges are in the UEFI system address
> map as special-purpose memory. Does Linux create the struct pages and
> kernel direct map for that without a pgmap call? I didn't see that last
> time I went digging through that code.

So doing some googling finds a patch from Dan that claims to hand EFI
special purpose memory to the device dax driver.  But when I try to
follow the version that got merged it looks it is treated simply as an
MMIO region to be claimed by drivers, which would not get a struct page.

Dan, did I misunderstand how E820_TYPE_SOFT_RESERVED works?

> >> From an application
> >> perspective, we want file-backed and anonymous mappings to be able to
> >> use DEVICE_PUBLIC pages with coherent CPU access. The goal is to
> >> optimize performance for GPU heavy workloads while minimizing the need
> >> to migrate data back-and-forth between system memory and device memory.
> > I don't really understand that part.  file backed pages are always
> > allocated by the file system using the pagecache helpers, that is
> > using the page allocator.  Anonymouns memory also always comes from
> > the page allocator.
> 
> I'm coming at this from my experience with DEVICE_PRIVATE. Both
> anonymous and file-backed pages should be migrateable to DEVICE_PRIVATE
> memory by the migrate_vma_* helpers for more efficient access by our
> GPU. (*) It's part of the basic premise of HMM as I understand it. I
> would expect the same thing to work for DEVICE_PUBLIC memory.

Ok, so you want to migrate to and from them.  Not use DEVICE_PUBLIC
for the actual page cache pages.  That maks a lot more sense.

> I see DEVICE_PUBLIC as an improved version of DEVICE_PRIVATE that allows
> the CPU to map the device memory coherently to minimize the need for
> migrations when CPU and GPU access the same memory concurrently or
> alternatingly. But we're not going as far as putting that memory
> entirely under the management of the Linux memory manager and VM
> subsystem. Our (and HPE's) system architects decided that this memory is
> not suitable to be used like regular NUMA system memory by the Linux
> memory manager.

So yes.  It is a Memory Mapped I/O region, which unlike the PCIe BARs
that people typically deal with is fully cache coherent.  I think this
does make more sense as a description.

But to go back to what start this discussion:  If these are memory
mapped I/O pfn_valid should generally not return true for them.

And as you already pointed out in reply to Alex we need to tighten the
selection criteria one way or another.
