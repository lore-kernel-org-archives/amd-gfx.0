Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906A3C2BB1D
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 18:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D0B720716
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 18:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LBoFZXya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0B720716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C41896E134;
	Thu, 12 Mar 2020 18:08:47 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5F956EB08
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 17:17:36 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id f198so7476650qke.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=jNz3IrFgPeotxDLNaXTICEUp/RnRWRjsOnVPCR+thno=;
 b=LBoFZXyaqhI+wrfyV+JgFdECjctTdkD2NLPfW0UefrCclVuDzNLgMftJt7wePOin+m
 GYCLQTjFK9OKRcikgaMB6TZrU4/32wc7kJmLl3k66rVME286eUq+XtTdrQEXGwp+2UE9
 IoRtplyaoIatnd7VSBGe49Mk2dnK+ynNnvR5lazFHP8HlKx6vzTIyBlxxEW95/jMHfXg
 gGpybedoLh0hzhQrXvVi190UFh5WgV1YNJ3vHJFlsAwJ5dSoRNr6fV2ANfpzvh1drYj4
 Wj8xPoGeoTlu0SOfO9z/cG7aO0NaGpEx9wfMe9LoTymeqvcPxqYF5KTRttUHZB4Trrae
 m/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jNz3IrFgPeotxDLNaXTICEUp/RnRWRjsOnVPCR+thno=;
 b=gd+Extj5bZBnvuNYqDej1WFurfssvPl+TBhsySlndZkh10+ZOvC+9Orf5XZDvvt0bU
 42lwfamJJERKDDWsqKMPnxlN3qWM32V83sbz1a5OrIfI1vm9L3Neg50sY9u80/50AuwL
 SMKkcqrm8p+HHioXMxqsOP4XiLi65tyEZ1f3tW3j8DDqZqhF7RMlQsY0slZvtjJxdMvp
 oTHB0QT7y3nAG4oGZhZIavQB43KGDSjndQd23r1Bl088H+Xd3RqBUF/eKu/mHDqk+frO
 6pwOxCY/7yoIBdBQaS7LPpOLKzAJ+Hmq8ogr8+qZNpHcfk9oh+8n9BDgJuszYgRu0toY
 Dn7w==
X-Gm-Message-State: ANhLgQ2bERPTO0x9ptuLNSLDLmTMp4kbMJqVmNCOjEDR8G8nDSc1/cdg
 rWUqP6HEN4Lhs/y/G5Ntj6sUDA==
X-Google-Smtp-Source: ADFU+vtW5dsy1G4ib2/EXTBUeblL8Qau/zrPbOpFbNGasj8QDK9MzB6BcBkp4LKFA9nfntvXkIwwaA==
X-Received: by 2002:a05:620a:112c:: with SMTP id
 p12mr9067500qkk.307.1584033455959; 
 Thu, 12 Mar 2020 10:17:35 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id s49sm10076169qtc.29.2020.03.12.10.17.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 12 Mar 2020 10:17:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jCRSg-0000u8-Fq; Thu, 12 Mar 2020 14:17:34 -0300
Date: Thu, 12 Mar 2020 14:17:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] mm/hmm: Simplify hmm_vma_walk_pud slightly
Message-ID: <20200312171734.GT31668@ziepe.ca>
References: <5bd778fa-51e5-3e0c-d9bb-b38539b03c8d@arm.com>
 <20200312102813.56699-1-steven.price@arm.com>
 <20200312142749.GM31668@ziepe.ca>
 <58e296a6-d32b-bb37-28ce-ade0f784454d@arm.com>
 <20200312151113.GO31668@ziepe.ca>
 <689d3c56-3d19-4655-21f5-f9aeab3089df@arm.com>
 <20200312163734.GR31668@ziepe.ca>
 <bf9b38ae-edd5-115f-e1ca-d769872f994a@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bf9b38ae-edd5-115f-e1ca-d769872f994a@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Thu, 12 Mar 2020 18:08:46 +0000
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

On Thu, Mar 12, 2020 at 05:02:18PM +0000, Steven Price wrote:

> > Having the walker deref the pointer and pass the value it into the ops
> > for use rather than repeatedly de-refing an unlocked value seems like
> > a much safer design to me.
> 
> Yeah that sounds like a good idea.

Ok.. let see when I get this hmm & odp stuff cleared off
 
> > I also didn't quite understand why walk_pte_range() skipped locking
> > the pte in the no_vma case - I don't get why vma would be related to
> > locking here.
> 
> The no_vma case is for walking the kernel's page tables and they may have
> entries that are not backed by struct page, so there isn't (reliably) a PTE
> lock to take.

Oh, that is an interesting bit of insight..

> > I also saw that hmm open coded the pte walk, presumably for
> > performance, so I was thinking of adding some kind of pte_range()
> > callback to avoid the expensive indirect function call per pte, but
> > hmm also can't have the pmd locked...
> 
> Yeah the callback per PTE is a bit heavy because of the indirect function
> call. I'm not sure how to optimise it beyond open coding at the PMD level.
> One option would be to provide helper functions to make it a bit more
> generic.
> 
> Do you have an idea of what pte_range() would look like?

Basically just pass in the already mapped pte array just like is
already done at the tail of the pmd

The reason to do it like this is so that the common code in the walker
can correctly prove the pmd is pointing at a pte before trying to map
it.

This is complicated, and hmm at least already got it wrong when trying
to open code at the PMD level.

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
