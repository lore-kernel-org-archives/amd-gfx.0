Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA59C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 13:05:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 509B86101A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 13:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 509B86101A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A09016EA87;
	Fri, 20 Aug 2021 13:05:34 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DA966E832;
 Fri, 20 Aug 2021 05:05:09 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id F19846736F; Fri, 20 Aug 2021 07:05:04 +0200 (CEST)
Date: Fri, 20 Aug 2021 07:05:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Christoph Hellwig <hch@lst.de>, Alex Sierra <alex.sierra@amd.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org, rcampbell@nvidia.com,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 jgg@nvidia.com, jglisse@redhat.com, Roger Pau Monne <roger.pau@citrix.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v6 08/13] mm: call pgmap->ops->page_free for
 DEVICE_GENERIC pages
Message-ID: <20210820050504.GB27083@lst.de>
References: <20210813063150.2938-1-alex.sierra@amd.com>
 <20210813063150.2938-9-alex.sierra@amd.com> <20210815154047.GC32384@lst.de>
 <7a55366f-bd65-7ab9-be9e-3bfd3aea3ea1@amd.com> <20210817055031.GC4895@lst.de>
 <e5eb53f9-c52a-52e1-5fa0-bb468c0c9c85@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5eb53f9-c52a-52e1-5fa0-bb468c0c9c85@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Mailman-Approved-At: Fri, 20 Aug 2021 13:05:32 +0000
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

On Tue, Aug 17, 2021 at 11:44:54AM -0400, Felix Kuehling wrote:
> >> That's a good catch. Existing drivers shouldn't need a page_free
> >> callback if they didn't have one before. That means we need to add a
> >> NULL-pointer check in free_device_page.
> > Also the other state clearing (__ClearPageWaiters/mem_cgroup_uncharge/
> > ->mapping = NULL).
> >
> > In many ways this seems like you want to bring back the DEVICE_PUBLIC
> > pgmap type that was removed a while ago due to the lack of users
> > instead of overloading the generic type.
> 
> I think so. I'm not clear about how DEVICE_PUBLIC differed from what
> DEVICE_GENERIC is today. As I understand it, DEVICE_PUBLIC was removed
> because it was unused and also known to be broken in some ways.
> DEVICE_GENERIC seemed close enough to what we need, other than not being
> supported in the migration helpers.
> 
> Would you see benefit in re-introducing DEVICE_PUBLIC as a distinct
> memory type from DEVICE_GENERIC? What would be the benefits of making
> that distinction?

The old DEVICE_PUBLIC mostly different in that it allowed the page
to be returned from vm_normal_page, which I think was horribly buggy.

But the point is not to bring back these old semantics.  The idea
is to be able to differeniate between your new coherent on-device
memory and the existing DEVICE_GENERIC.  That is call the
code in free_devmap_managed_page that is currently only used
for device private pages also for your new public device pages without
affecting the devdax and xen use cases.
