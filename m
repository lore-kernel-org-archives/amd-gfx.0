Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A55C0044D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 18:37:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15C6520679
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 18:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DCjng0Ea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C6520679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF49A6E49F;
	Mon, 16 Mar 2020 18:37:02 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 743B06E49F
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 18:25:42 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id e20so15118354qto.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 11:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=iJWE8TrI0ffeC3Sw+RcRtUnbRu8X59xIzG4mlob+7fY=;
 b=DCjng0Eaj6HsbWcNiFCJF+xC8Xk9BgVsXDx62rgE7yz5SfveIj38SorIiCEOoUa7js
 Q4IVmYevLv2UGcYf/mLcOQPXQR1t+P5y4tyU7bFUWKuRBb2vNiRnjus7GrAdRYxq1kjp
 B6J4OhOvN84SzJIorUukFE1+lOLMcgI5ZzqhXw4t5UP43h7gYy64UuehQbk65HUtIw/U
 nZKwNGJHtutDw5YNRYbjC+GLSeDNDgi86fScXxkugNWCbP/7BMGRkIuJUBUekRkN0TJK
 s75Fb2QVxt7azd3VwTD3WiKDxav8shUm08cY0MvWn1oEkMv5eKiwv2dZcqpCf8thyMpe
 qlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=iJWE8TrI0ffeC3Sw+RcRtUnbRu8X59xIzG4mlob+7fY=;
 b=hpEsIFLX/ee90R6WSGcq420VM4EXSSl/RVreAVsbsKfrOePUFOsbiujnpAVKb0NhUc
 fSXUaRR+ZuJQQrgfapnoCf0qiymqTBxnRIyCbbD6BfBfYG4E1rRgAUUTRHmXKlA15ELB
 D5m8j0ayetQoD5tUeTdo27b8LaST+tvOx273qBc4LG/oXOLjnW+FnbSUAIsiT6q4ng+m
 sfxKa5X4tg58ExTWI63rfPY56c7Sm3aG4zi4uOwQuYGouyD/x9/JHbcfpvnP0jDIWzC9
 dgs/IMpsuLnNNsGQNB6SjSOSufs7D5R/8fXDspeqXZk40MOCX6P/rRCmwYgHBynvt8bR
 vI4Q==
X-Gm-Message-State: ANhLgQ0XUeFbw59/y94871uAjkWpJLZNAQQ57l16iGEnrpRIvljEESlS
 xEOYM+QnNr/wGHKN1DU3YquOLw==
X-Google-Smtp-Source: ADFU+vvfq4yHOpYtgjLPPUevf/Pne0zhXSDrRxuWoEydOpikvFwyL2cJYI4Bk8hFq8xZPBXAVYBn7A==
X-Received: by 2002:ac8:1196:: with SMTP id d22mr1498877qtj.344.1584383141614; 
 Mon, 16 Mar 2020 11:25:41 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id q24sm361232qtk.45.2020.03.16.11.25.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 16 Mar 2020 11:25:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jDuQm-0005aw-Bf; Mon, 16 Mar 2020 15:25:40 -0300
Date: Mon, 16 Mar 2020 15:25:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerome Glisse <jglisse@redhat.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Felix.Kuehling@amd.com
Subject: Re: [PATCH  hmm 0/8] Various error case bug fixes for
 hmm_range_fault()
Message-ID: <20200316182540.GA21434@ziepe.ca>
References: <20200311183506.3997-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200311183506.3997-1-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Mon, 16 Mar 2020 18:37:01 +0000
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
Cc: Philip Yang <Philip.Yang@amd.com>, John Hubbard <jhubbard@nvidia.com>,
 amd-gfx@lists.freedesktop.org, linux-mm@kvack.org,
 dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 11, 2020 at 03:34:58PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> The hmm_range_fault() flow is fairly complicated. The scheme allows the
> caller to specify if it needs a usable result for each page, or if it only
> needs the current page table status filled in. This mixture of behavior is
> useful for a caller that wants to build a 'prefetch around fault'
> algorithm.
> 
> Although we have no in-tree users of this capability, I am working on
> having RDMA ODP work in this manner, and removing these bugs from
> hmm_range_fault() is a necessary step.
> 
> The basic principles are:
> 
>  - If the caller did not ask for a VA to be valid then hmm_range_fault()
>    should not fail because of that VA
> 
>  - If 0 is returned from hmm_range_fault() then the entire pfns array
>    contains valid data
> 
>  - HMM_PFN_ERROR is set if faulting fails, or if asking for faulting
>    would fail
> 
>  - A 0 return from hmm_range_fault() does not have HMM_PFN_ERROR in any
>    VA's the caller asked to be valid
> 
> This series does not get there completely, I have a followup series
> closing some more complex cases.
> 
> I tested this series using Ralph's hmm tester he posted a while back,
> other testing would be appreciated.
> 
> Jason Gunthorpe (8):
>   mm/hmm: add missing unmaps of the ptep during hmm_vma_handle_pte()
>   mm/hmm: do not call hmm_vma_walk_hole() while holding a spinlock
>   mm/hmm: add missing pfns set to hmm_vma_walk_pmd()
>   mm/hmm: add missing call to hmm_range_need_fault() before returning
>     EFAULT
>   mm/hmm: reorganize how !pte_present is handled in hmm_vma_handle_pte()
>   mm/hmm: return -EFAULT when setting HMM_PFN_ERROR on requested valid
>     pages
>   mm/hmm: add missing call to hmm_pte_need_fault in HMM_PFN_SPECIAL
>     handling
>   mm/hmm: do not check pmd_protnone twice in hmm_vma_handle_pmd()

I moved these toward linux-next, if others have remarks or tags please
feel free to continue.

>   mm/hmm: don't free the cached pgmap while scanning

I will respin

Thank you all for the reviews!

Regards,
Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
