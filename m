Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D9EC2BA19
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49FA9208E4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49FA9208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F2A36E271;
	Thu, 23 Apr 2020 07:37:23 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75C8F6E135;
 Thu, 23 Apr 2020 06:10:28 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id B47E6227A81; Thu, 23 Apr 2020 08:10:23 +0200 (CEST)
Date: Thu, 23 Apr 2020 08:10:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH hmm 5/5] mm/hmm: remove the customizable pfn format
 from hmm_range_fault
Message-ID: <20200423061023.GA9856@lst.de>
References: <0-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
 <5-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
 <20200422060329.GD22366@lst.de> <20200422123911.GV26002@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200422123911.GV26002@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Mailman-Approved-At: Thu, 23 Apr 2020 07:37:22 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 linux-mm@kvack.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 intel-gfx@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 22, 2020 at 09:39:11AM -0300, Jason Gunthorpe wrote:
> > Nice callchain from hell..  Unfortunately such "code listings" tend to
> > get out of date very quickly, so I'm not sure it is worth keeping in
> > the code.  What would be really worthile is consolidating the two
> > different sets of defines (NVIF_VMM_PFNMAP_V0_ vs NVKM_VMM_PFN_)
> > to make the code a little easier to follow.
> 
> I was mainly concerned that this function is using hmm properly,
> becuase it sure looks like it is just forming the CPU physical address
> into a HW specific data. But it turns out it is just an internal data
> for some other code and the dma_map is impossibly far away
> 
> It took forever to find, I figured I'd leave a hint for the next poor
> soul that has to look at this.. 
> 
> Also, I think it shows there is no 'performance' argument here, if
> this path needs more performance the above should be cleaned
> before we abuse hmm_range_fault.
> 
> Put it in the commit message instead?

Yes, the graph itself sounds reasonable for the commit log as a point
of time information.

> > >  	npages = (range->end - range->start) >> PAGE_SHIFT;
> > >  	for (i = 0; i < npages; ++i) {
> > >  		struct page *page;
> > >  
> > > +		if (!(range->hmm_pfns[i] & HMM_PFN_VALID)) {
> > > +			ioctl_addr[i] = 0;
> > >  			continue;
> > > +		}
> > 
> > Can't we rely on the caller pre-zeroing the array?
> 
> This ends up as args.phys in nouveau_svm_fault - I didn't see a
> zeroing?
> 
> I think it makes sense that this routine fully sets the output array
> and does not assume pre-initialize

Ok.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
