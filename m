Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A101BC83000
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 01:51:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E42E2082E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 01:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="f12ZywN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E42E2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FBE36EB27;
	Thu, 30 Apr 2020 01:51:19 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 096416EB1B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2020 22:41:30 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id l78so3844284qke.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2020 15:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=yBgZcrV4iWdwc8bXr1UgNLaniSphIyQASgPqncouw5A=;
 b=f12ZywN6K7/T0vh/KFA3gH3gfK1sZ3o1eqim7onv3KljZBN4EOi4bv6G5V+XbG4ut1
 QQLVUyAfs4arAjqaqFVeMkgjxNn40gaGCjoQ7o0T29H6bsy2WzWeCqi+bO3ZRddrrCIx
 ZpoSV5qQBQZnrndmt08qcR/DcYoVpUDmC5hY7V0oWPPMSFSPw5y5/KRbFoEpmjdnydS9
 baSt1dM3SYcyQ1N3yyIRPCOPHVdxSN8akC48vdq9aPEUZEPCm7Q2lckDBnXUDRGzXwp2
 4bh9Wy/0+rhTYdXvbRRxtmS5bIVA54WQzEwFvGgqOS4DEMnxOYBSpNngwveCYRtgj0jf
 jg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yBgZcrV4iWdwc8bXr1UgNLaniSphIyQASgPqncouw5A=;
 b=kxZ/1jjzL8Fta14kt6gPsneiGnKV8cjqqIGveWzjkdRwJskFNyLbab/XsYFLDGlapn
 fbU81uqxgtBfqSlDZI5CLMkJUyyVg0gx2dBcdigEYYDX8W1L4vnR2HZH715q1dVuOAQj
 /MXj1uDSuGHfvZGTyTZqSCESvYEGoSe2IKAiH/1zsQSLnkwAGkVZLdq2DqhOcAZhgx3w
 M6FnsOsopMQqszXf873QWL1p3mFPDYW8m6DmwtAbV4dPNaKwfUHSN1noHUHzWHff2LwK
 ql5kbtms9y/pKv0F95kauUMfwWGWV1Pui+jgawggLW6l5PC0CqfKbJXA+3VAaenaOB7a
 kTwQ==
X-Gm-Message-State: AGi0Pub0s42oDrQqOhZ3Z0wSieB9Lrt+pKTrEp33hBbDP4qdSn5VBBdg
 /NHbvDv5PJkq9YN2JB0WwMDMdw==
X-Google-Smtp-Source: APiQypLKqND0JKjNOfB6OKttFWw4PueCh+kW/uTm/J+/8LnYtWQ1Yu18biU6LtzJiRmM87wUIsCivg==
X-Received: by 2002:a05:620a:1305:: with SMTP id
 o5mr811497qkj.222.1588200089029; 
 Wed, 29 Apr 2020 15:41:29 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id v27sm551028qtb.35.2020.04.29.15.41.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 29 Apr 2020 15:41:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jTvOR-0000GO-Rd; Wed, 29 Apr 2020 19:41:27 -0300
Date: Wed, 29 Apr 2020 19:41:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH hmm 5/5] mm/hmm: remove the customizable pfn format from
 hmm_range_fault
Message-ID: <20200429224127.GB3824@ziepe.ca>
References: <5-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
 <ec276ac2-a346-5728-4ac6-9c9bd9ffcd41@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ec276ac2-a346-5728-4ac6-9c9bd9ffcd41@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Thu, 30 Apr 2020 01:51:18 +0000
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>, Ralph Campbell <rcampbell@nvidia.com>,
 "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
 =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 intel-gfx@lists.freedesktop.org,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 22, 2020 at 01:52:32PM -0400, Felix Kuehling wrote:
> [+Philip Yang]
> 
> Am 2020-04-21 um 8:21 p.m. schrieb Jason Gunthorpe:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> >
> > Presumably the intent here was that hmm_range_fault() could put the data
> > into some HW specific format and thus avoid some work. However, nothing
> > actually does that, and it isn't clear how anything actually could do that
> > as hmm_range_fault() provides CPU addresses which must be DMA mapped.
> >
> > Perhaps there is some special HW that does not need DMA mapping, but we
> > don't have any examples of this, and the theoretical performance win of
> > avoiding an extra scan over the pfns array doesn't seem worth the
> > complexity. Plus pfns needs to be scanned anyhow to sort out any
> > DEVICE_PRIVATE pages.
> >
> > This version replaces the uint64_t with an usigned long containing a pfn
> > and fix flags. On input flags is filled with the HMM_PFN_REQ_* values, on
> > successful output it is filled with HMM_PFN_* values, describing the state
> > of the pages.
> >
> > amdgpu is simple to convert, it doesn't use snapshot and doesn't use
> > per-page flags.
> >
> > nouveau uses only 16 hmm_pte entries at most (ie fits in a few cache
> > lines), and it sweeps over its pfns array a couple of times anyhow.
> >
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Hi Jason,
> 
> I pointed out a typo in the documentation inline. Other than that, the
> series is
> 
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> 
> I'll try to build it and run some basic tests later.

Got it, thanks! Let me know if there are problems

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
