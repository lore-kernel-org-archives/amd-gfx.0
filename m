Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0091FC2BB1D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDDF7205ED
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDDF7205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 362A46E448;
	Mon, 16 Mar 2020 13:07:07 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B916E3A2;
 Mon, 16 Mar 2020 09:14:11 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8610368CEC; Mon, 16 Mar 2020 10:14:09 +0100 (CET)
Date: Mon, 16 Mar 2020 10:14:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH hmm 9/8] mm/hmm: do not check pmd_protnone twice in
 hmm_vma_handle_pmd()
Message-ID: <20200316091409.GI12439@lst.de>
References: <20200311183506.3997-1-jgg@ziepe.ca>
 <20200312193310.GA1190@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200312193310.GA1190@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Mailman-Approved-At: Mon, 16 Mar 2020 13:06:57 +0000
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

On Thu, Mar 12, 2020 at 04:33:10PM -0300, Jason Gunthorpe wrote:
> pmd_to_hmm_pfn_flags() already checks it and makes the cpu flags 0. If no
> fault is requested then the pfns should be returned with the not valid
> flags.
> 
> It should not unconditionally fault if faulting is not requested.
> 
> Fixes: 2aee09d8c116 ("mm/hmm: change hmm_vma_fault() to allow write fault on page basis")
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  mm/hmm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Bonus patch, this one got found after I made the series..

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
