Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67022C1975A
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 15:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 315C72067C
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 15:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nR6jOHnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315C72067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF51B6E21B;
	Thu, 12 Mar 2020 15:11:59 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D213B89A57
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 15:11:16 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id p60so2772813qva.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=TfPq0MKSBUEoMMxdu/We2AG1PfaPZyygxsMFnWty7og=;
 b=nR6jOHnUM5YoXGhFP3+k07DnsntC+/xywZyRwpU3VDnnAMXe9oNyKt9LaXqqd9/DgX
 BWk/8DiskNev0gVHTSQA4FAxEuUmYU2GBbg6Ci1ebekkrWmjpO6MHlJmTHqIcwsrIoLN
 fuIww4eG2GsLrNAFZlZaFNkgz8byAfXPJ+BsZ9dXcGSyMBnHWAG3oQ08D46ep/vp4lAs
 w6hyx1ssjKnwH7NTO93Al4Hs1waERYYjMtyiIUejX0RboR3oRlAxSDtae77l7OH89V7g
 Buxbjk64Qwtsqxy0IrnCgY6RxdI+2bDbFkyCikrOIgUMWkIFa7SvElXw55AY9yYPeNof
 uIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TfPq0MKSBUEoMMxdu/We2AG1PfaPZyygxsMFnWty7og=;
 b=D8xBsoP0hFbZ3AiwgQDpfwPsaqx5dzdgHezk+6EOtcXcdEbr3OXAh6RLG/Ojpb0Ngh
 zQqDJLObxl8wM1loFSRLKLtr3c0vzqHRVzhHwXZ87/sNtG3kSQ6OuPg4hrXNlGiMPgYG
 ZLT3xQTUMaBWckBaTecZQkIIhVLYRx2c0YQEMH4QtObjK5InPUxYNMFGAwF9c+Jl7GqJ
 GO14dpv310sAfFBwPqQazSMWwOH1LvtprcH+W0nn00Iwtgn8OhtTSfUX9hk/eTt2iPSb
 emBrXKLbYdIw06K80pnmvCgsx08S7b//bDt8c7VZfqFOI76th4xENZkuMF97ReFgse1W
 WfVg==
X-Gm-Message-State: ANhLgQ0evqZWuiWEHbl3klQshetkxRudbQX7AlwF0pi7zH90tGqPMutp
 IQkCnGqNZhL2StRMC/q5t3amJQ==
X-Google-Smtp-Source: ADFU+vsXc20453obvlA3XsCJo8lxaMgzs3qiHWmSYfwVLrhpKBdZooziEPV1gPImfSe6apbMuNmDJw==
X-Received: by 2002:a0c:f892:: with SMTP id u18mr7789034qvn.159.1584025874739; 
 Thu, 12 Mar 2020 08:11:14 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id w4sm13785252qts.92.2020.03.12.08.11.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 12 Mar 2020 08:11:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jCPUP-0007Vd-Fj; Thu, 12 Mar 2020 12:11:13 -0300
Date: Thu, 12 Mar 2020 12:11:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] mm/hmm: Simplify hmm_vma_walk_pud slightly
Message-ID: <20200312151113.GO31668@ziepe.ca>
References: <5bd778fa-51e5-3e0c-d9bb-b38539b03c8d@arm.com>
 <20200312102813.56699-1-steven.price@arm.com>
 <20200312142749.GM31668@ziepe.ca>
 <58e296a6-d32b-bb37-28ce-ade0f784454d@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <58e296a6-d32b-bb37-28ce-ade0f784454d@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Thu, 12 Mar 2020 15:11:58 +0000
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
 John Hubbard <jhubbard@nvidia.com>,
 "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Jerome Glisse <jglisse@redhat.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 12, 2020 at 02:40:08PM +0000, Steven Price wrote:
> On 12/03/2020 14:27, Jason Gunthorpe wrote:
> > On Thu, Mar 12, 2020 at 10:28:13AM +0000, Steven Price wrote:
> > > By refactoring to deal with the !pud_huge(pud) || !pud_devmap(pud)
> > > condition early it's possible to remove the 'ret' variable and remove a
> > > level of indentation from half the function making the code easier to
> > > read.
> > > 
> > > No functional change.
> > > 
> > > Signed-off-by: Steven Price <steven.price@arm.com>
> > > Thanks to Jason's changes there were only two code paths left using
> > > the out_unlock label so it seemed like a good opportunity to
> > > refactor.
> > 
> > Yes, I made something very similar, what do you think of this:
> > 
> > https://github.com/jgunthorpe/linux/commit/93f0ed42ab3f9ceb27b58fb7c7c3ecaf60f16b36
> 
> Even better! Sorry I didn't realise you'd already done this. I just saw that
> the function was needlessly complicated after your fix, so I thought I'd do
> a drive-by cleanup since part of the mess was my fault! :)

No worries, I've got a lot of patches for hmm_range_fault right now,
just trying to organize them, test them and post them. Haven't posted
that one yet.

Actually, while you are looking at this, do you think we should be
adding at least READ_ONCE in the pagewalk.c walk_* functions? The
multiple references of pmd, pud, etc without locking seems sketchy to
me.

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
