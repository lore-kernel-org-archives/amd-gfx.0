Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B844DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Feb 2022 15:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0114F10E268;
	Wed,  2 Feb 2022 15:07:01 +0000 (UTC)
X-Greylist: delayed 525 seconds by postgrey-1.36 at gabe;
 Wed, 02 Feb 2022 15:06:43 UTC
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33DC310E268
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Feb 2022 15:06:43 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 49B1A68B05; Wed,  2 Feb 2022 15:57:52 +0100 (CET)
Date: Wed, 2 Feb 2022 15:57:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 00/10] Add MEMORY_DEVICE_COHERENT for coherent
 device memory mapping
Message-ID: <20220202145750.GA25170@lst.de>
References: <20220127030949.19396-1-alex.sierra@amd.com>
 <20220127143258.8da663659948ad1e6f0c0ea8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127143258.8da663659948ad1e6f0c0ea8@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Mailman-Approved-At: Wed, 02 Feb 2022 15:06:59 +0000
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
Cc: Alex Sierra <alex.sierra@amd.com>, rcampbell@nvidia.com,
 willy@infradead.org, Felix.Kuehling@amd.com, apopple@nvidia.com,
 amd-gfx@lists.freedesktop.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 jglisse@redhat.com, dri-devel@lists.freedesktop.org, jgg@nvidia.com,
 linux-ext4@vger.kernel.org, hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 27, 2022 at 02:32:58PM -0800, Andrew Morton wrote:
> On Wed, 26 Jan 2022 21:09:39 -0600 Alex Sierra <alex.sierra@amd.com> wrote:
> 
> > This patch series introduces MEMORY_DEVICE_COHERENT, a type of memory
> > owned by a device that can be mapped into CPU page tables like
> > MEMORY_DEVICE_GENERIC and can also be migrated like
> > MEMORY_DEVICE_PRIVATE.
> 
> Some more reviewer input appears to be desirable here.
> 
> I was going to tentatively add it to -mm and -next, but problems. 
> 5.17-rc1's mm/migrate.c:migrate_vma_check_page() is rather different
> from the tree you patched.  Please redo, refresh and resend?

I really hate adding more types with the weird one off page refcount.
We need to clean that mess up first.
