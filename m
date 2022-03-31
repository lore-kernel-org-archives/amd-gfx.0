Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47010C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Mar 2022 13:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 835A510F1E3;
	Thu, 31 Mar 2022 13:08:41 +0000 (UTC)
X-Greylist: delayed 605 seconds by postgrey-1.36 at gabe;
 Thu, 31 Mar 2022 09:03:51 UTC
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DE9E10F49F
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 09:03:51 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2E81268AA6; Thu, 31 Mar 2022 10:53:42 +0200 (CEST)
Date: Thu, 31 Mar 2022 10:53:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alex Sierra <alex.sierra@amd.com>
Subject: Re: [PATCH v2 1/3] mm: add vm_normal_lru_pages for LRU handled
 pages only
Message-ID: <20220331085341.GA22102@lst.de>
References: <20220330212537.12186-1-alex.sierra@amd.com>
 <20220330212537.12186-2-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330212537.12186-2-alex.sierra@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Mailman-Approved-At: Thu, 31 Mar 2022 13:08:40 +0000
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
Cc: rcampbell@nvidia.com, willy@infradead.org, david@redhat.com,
 Felix.Kuehling@amd.com, apopple@nvidia.com, amd-gfx@lists.freedesktop.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com,
 dri-devel@lists.freedesktop.org, jgg@nvidia.com, akpm@linux-foundation.org,
 linux-ext4@vger.kernel.org, hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

> -	page = vm_normal_page(vma, addr, pte);
> +	page = vm_normal_lru_page(vma, addr, pte);

Why can't this deal with ZONE_DEVICE pages?  It certainly has
nothing do with a LRU I think.  In fact being able to have
stats that count say the number of device pages here would
probably be useful at some point.

In general I find the vm_normal_lru_page vs vm_normal_page
API highly confusing.  An explicit check for zone device pages
in the dozen or so spots that care has a much better documentation
value, especially if accompanied by comments where it isn't entirely
obvious.

>  		page = follow_page(vma, addr,
> -				FOLL_GET | FOLL_MIGRATION | FOLL_REMOTE);
> +				FOLL_GET | FOLL_MIGRATION | FOLL_REMOTE | FOLL_LRU);

Overly long line here.

> +/*
> + * NOTE: Technically this should goto check_pfn label. However, page->_mapcount
> + * is never incremented for device pages that are mmap through DAX mechanism
> + * using pmem driver mounted into ext4 filesystem. When these pages are unmap,
> + * zap_pte_range is called and vm_normal_page return a valid page with
> + * page_mapcount() = 0, before page_remove_rmap is called.
> + */

Please properly indent comments.

> + * zone, as long as the pte's are present and vm_normal_lru_page() succeeds. These
>   * pages also get pinned.

Another overly long line here.
