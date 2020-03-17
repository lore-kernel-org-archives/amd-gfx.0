Return-Path: <SRS0=ZDaT=5C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D5AC18E5B
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2020 13:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 809C120757
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2020 13:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809C120757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50E8E6E14C;
	Tue, 17 Mar 2020 13:50:09 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBF3389F43;
 Tue, 17 Mar 2020 12:32:12 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6DC3F68BFE; Tue, 17 Mar 2020 13:32:10 +0100 (CET)
Date: Tue, 17 Mar 2020 13:32:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH  hmm 8/8] mm/hmm: add missing call to
 hmm_pte_need_fault in HMM_PFN_SPECIAL handling
Message-ID: <20200317123210.GA12058@lst.de>
References: <20200311183506.3997-1-jgg@ziepe.ca>
 <20200311183506.3997-9-jgg@ziepe.ca> <20200316091347.GH12439@lst.de>
 <20200316121053.GP13183@mellanox.com> <20200316124953.GC17386@lst.de>
 <20200316130458.GQ13183@mellanox.com> <20200316131201.GA17955@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200316131201.GA17955@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Mailman-Approved-At: Tue, 17 Mar 2020 13:50:08 +0000
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
Cc: Philip Yang <Philip.Yang@amd.com>, Ralph Campbell <rcampbell@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 Jerome Glisse <jglisse@redhat.com>, amd-gfx@lists.freedesktop.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 16, 2020 at 02:12:01PM +0100, Christoph Hellwig wrote:
> On Mon, Mar 16, 2020 at 10:04:58AM -0300, Jason Gunthorpe wrote:
> > > Ok.  I had some cleanups like this based of older trees, but if you are
> > > active in this area I think I'll let you handle it.
> > 
> > You once said you wanted to loose the weird pfn flags scheme, so
> > before putting hmm_range_fault in ODP I planned to do that.
> > 
> > If you have your series someplace send me a URL and I'll look on it
> 
> I have a local branch I just started hacking on, but it is rather broken
> based on various discussions we had.  But for a basic one I'd suggest
> something like:
> 
>  - kill HMM_PFN_SPECIAL as it serves no purpose
>  - split the ->pfns array into an input flags (optional) and an output
>    pfn (mandtory) one, using new flags for the input side
>  - replace the output flags/values indirection with a bunch of values
>    encoded in the high bits of a u64, with the rest used for the pfn

Thinking out loud a bit more:

 - do we really need HMM_PFN_ERROR, or is just a return value from
   hmm_range_fault enough?
 - because if it is we don't need output flags at all, and the output
   array could be struct pages, which would make for a much easier
   to use API
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
