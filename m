Return-Path: <SRS0=BBbY=NX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1DBC432BE
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Sep 2021 13:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 475B46108B
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Sep 2021 13:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 475B46108B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCDCD891F4;
	Wed,  1 Sep 2021 13:04:36 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83979891FB;
 Wed,  1 Sep 2021 08:29:29 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 711DE68AFE; Wed,  1 Sep 2021 10:29:25 +0200 (CEST)
Date: Wed, 1 Sep 2021 10:29:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Christoph Hellwig <hch@lst.de>,
 "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org, rcampbell@nvidia.com,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 jgg@nvidia.com, jglisse@redhat.com
Subject: Re: [PATCH v1 03/14] mm: add iomem vma selection for memory migration
Message-ID: <20210901082925.GA21961@lst.de>
References: <20210825034828.12927-1-alex.sierra@amd.com>
 <20210825034828.12927-4-alex.sierra@amd.com> <20210825074602.GA29620@lst.de>
 <c4241eb3-07d2-c85b-0f48-cce4b8369381@amd.com>
 <a9eb2c4a-d8cc-9553-57b7-fd1622679aaa@amd.com> <20210830082800.GA6836@lst.de>
 <e40b3b79-f548-b87b-7a85-f654f25ed8dd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e40b3b79-f548-b87b-7a85-f654f25ed8dd@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Mailman-Approved-At: Wed, 01 Sep 2021 13:04:35 +0000
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

On Mon, Aug 30, 2021 at 01:04:43PM -0400, Felix Kuehling wrote:
> >> driver code is not really involved in updating the CPU mappings. Maybe
> >> it's something we need to do in the migration helpers.
> > It looks like I'm totally misunderstanding what you are adding here
> > then.  Why do we need any special treatment at all for memory that
> > has normal struct pages and is part of the direct kernel map?
> 
> The pages are like normal memory for purposes of mapping them in CPU
> page tables and for coherent access from the CPU.

That's the user page tables.  What about the kernel direct map?
If there is a normal kernel struct page backing there really should
be no need for the pgmap.

> From an application
> perspective, we want file-backed and anonymous mappings to be able to
> use DEVICE_PUBLIC pages with coherent CPU access. The goal is to
> optimize performance for GPU heavy workloads while minimizing the need
> to migrate data back-and-forth between system memory and device memory.

I don't really understand that part.  file backed pages are always
allocated by the file system using the pagecache helpers, that is
using the page allocator.  Anonymouns memory also always comes from
the page allocator.

> The pages are special in two ways:
> 
>  1. The memory is managed not by the Linux buddy allocator, but by the
>     GPU driver's TTM memory manager

Why?

>  2. We want to migrate data in response to GPU page faults and
>     application hints using the migrate_vma helpers

Why? 
