Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33E1C4332D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 08:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B9920739
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 08:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IBIMkWJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B9920739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB92C6EAE4;
	Fri, 20 Mar 2020 08:10:43 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FE176EAAF
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 00:14:30 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id e11so5203571qkg.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2020 17:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=nvP+7glb3WoLHPLLs/r0rddcIOawD21RlTqAwhDLiqM=;
 b=IBIMkWJEumvGX8nb31UJBrjYcGu0g5u0i7eHP++QpNs0mIZt6tfWswZ99ybGL71144
 TUS8HafPlyHOZVPJc34DXy4wvD2P2SicI+yjXJMAWNdhEQeqFLO9eJmeUBTXJUcPEPUa
 tkoalhdc6qC7pqcQ5A1u1vTC8HFvVmUHui1ltpN08lYr1AjQpR35p9tw2xRS8K5B8nkY
 V1i0Xwqjekp1AhehRvyzmsWboMA5Ng9TLIT6gRikdqGksXKnNuq1O8EXy/gA3DV/5RHR
 MvlcIgxxEZsh9nImsc+4Uik71V4BCHkjU2qtXBfIbaUSIg+WCA0dBI5RrRPeZIalrdlS
 Xu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=nvP+7glb3WoLHPLLs/r0rddcIOawD21RlTqAwhDLiqM=;
 b=W20Q1khhbFgEWDOmOSScL8nq33dlDy9UTzvVcgyzhnVTUedSOXxpSH0Bu9J2+BPVS6
 wurr/avQIinc2unNnrZYlIhpu5InKHNAKBdD8s4ziQvKAglgC1Hws//QCf+uy5sf0PYK
 bCaOcXJLWCxOWrDW0yYUpahostNRn7ZDNUPGIIHlRnL0Nj8LSFTIf51yXp6OKOyafxnd
 m4K6EyfbIh5GOqFWU75pLJnk9DB72RNvDqrarMabfmrVJEMyXIE2fEGg1smCHRVm7Baj
 RQr1XBRsExDd/h7kpdprt/2Z+RGnbY/C28edCw7LQ2IAsUPXm+SWrW1xSedxJsV00tXS
 n9PQ==
X-Gm-Message-State: ANhLgQ0gZ9ea9ubKeDDHB0w289iLVdZINHYo806QJpvCJselUJxDxFrQ
 +i9kIaXQR2A+Tc+rqo6kr7q+1Q==
X-Google-Smtp-Source: ADFU+vt3JFreUrolYf7MERgEAXyQL3oYOMgyyLIC9YmuLXfqegVKOTRl/TAqFupqfqMkpNtkljckug==
X-Received: by 2002:ae9:c011:: with SMTP id u17mr5597057qkk.92.1584663269422; 
 Thu, 19 Mar 2020 17:14:29 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id n190sm2631840qkb.93.2020.03.19.17.14.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 19 Mar 2020 17:14:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jF5Iy-0002R4-Dg; Thu, 19 Mar 2020 21:14:28 -0300
Date: Thu, 19 Mar 2020 21:14:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH 3/4] mm: simplify device private page handling in
 hmm_range_fault
Message-ID: <20200320001428.GA9199@ziepe.ca>
References: <20200316193216.920734-1-hch@lst.de>
 <20200316193216.920734-4-hch@lst.de>
 <7256f88d-809e-4aba-3c46-a223bd8cc521@nvidia.com>
 <20200317121536.GQ20941@ziepe.ca> <20200317122445.GA11662@lst.de>
 <20200317122813.GA11866@lst.de> <20200317124755.GR20941@ziepe.ca>
 <20200317125955.GA12847@lst.de>
 <24fca825-3b0f-188f-bcf2-fadcf3a9f05a@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <24fca825-3b0f-188f-bcf2-fadcf3a9f05a@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Fri, 20 Mar 2020 08:10:27 +0000
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
Cc: amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kvm-ppc@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
 Jerome Glisse <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>, Bharata B Rao <bharata@linux.ibm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 17, 2020 at 04:14:31PM -0700, Ralph Campbell wrote:

> +static int dmirror_fault(struct dmirror *dmirror, unsigned long start,
> +			 unsigned long end, bool write)
> +{
> +	struct mm_struct *mm = dmirror->mm;
> +	unsigned long addr;
> +	uint64_t pfns[64];
> +	struct hmm_range range = {
> +		.notifier = &dmirror->notifier,
> +		.pfns = pfns,
> +		.flags = dmirror_hmm_flags,
> +		.values = dmirror_hmm_values,
> +		.pfn_shift = DPT_SHIFT,
> +		.pfn_flags_mask = ~(dmirror_hmm_flags[HMM_PFN_VALID] |
> +				    dmirror_hmm_flags[HMM_PFN_WRITE]),

Since pfns is not initialized pfn_flags_mask should be 0.

> +		.default_flags = dmirror_hmm_flags[HMM_PFN_VALID] |
> +				(write ? dmirror_hmm_flags[HMM_PFN_WRITE] : 0),
> +		.dev_private_owner = dmirror->mdevice,
> +	};
> +	int ret = 0;

> +static int dmirror_snapshot(struct dmirror *dmirror,
> +			    struct hmm_dmirror_cmd *cmd)
> +{
> +	struct mm_struct *mm = dmirror->mm;
> +	unsigned long start, end;
> +	unsigned long size = cmd->npages << PAGE_SHIFT;
> +	unsigned long addr;
> +	unsigned long next;
> +	uint64_t pfns[64];
> +	unsigned char perm[64];
> +	char __user *uptr;
> +	struct hmm_range range = {
> +		.pfns = pfns,
> +		.flags = dmirror_hmm_flags,
> +		.values = dmirror_hmm_values,
> +		.pfn_shift = DPT_SHIFT,
> +		.pfn_flags_mask = ~0ULL,

Same here, especially since this is snapshot

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
