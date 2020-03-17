Return-Path: <SRS0=ZDaT=5C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E388EC10F29
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2020 13:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B311B20767
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2020 13:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PtubQYZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B311B20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9BC56E157;
	Tue, 17 Mar 2020 13:50:09 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C46A6E0EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2020 12:47:58 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id m2so10700626qvu.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2020 05:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=hGKwnunGHWWeSvJ9/XCv+nR79KkE26ubf6RE0d+GYLk=;
 b=PtubQYZSU9HgtWJjpFqwEdIYwtlB49Vs3D0G3zYORKcPGhEsIfZRIiROQOxddsRvWA
 RjAy+r9b/I8P2+0SEwcZEHsGUaxQE/qlu5dpc9kPAnznApNphxMVv4h20GpK+9p67yFs
 6hjcLG3hAAH3kBZTDZzuv6MILCdugULe8uRlXsNfw2yB//OumwIf2+qafVNvyuWJVzZk
 88vQy3I7t0nW6CNqJ8Lab2RMTtgH9hmh0oi4/hZaMDTe+VWad/wJZA4Ie452V4GsyVJG
 d7MvTYBDlTMGkbCUf2QQJe9saGpyKzd5K1BGve8IZKxbN0kyWBmlJs91ikMF2jJwlaJr
 0W8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hGKwnunGHWWeSvJ9/XCv+nR79KkE26ubf6RE0d+GYLk=;
 b=JBzwCuJqjmNEMQXEwyBvrfH1NOkupJpJsZUz3/xeJx1YWb3qWwlco7ugc5evDTDQ7o
 zu2tPPQP378n9CHO3cA72UNsQdCMm7OKvXbWCA4M1im6cTVpJglYBYheUgRMa72UqOiO
 BaaCyM2zOYOzi4sYfNofMuQXCzO8FcCAevLHmaogiCy92QBKPQHO6ElmPtj/GtxmrGUp
 XwzjpF5bOXSTInGsYXdimTIuj03/vgmFn50ySmo7pgLQNQQPqrVU+qZwVvjHFMy1DzlA
 EydvrjLGC50Sgxnajkmnh6bDrmOc7sxU3EQAD6opzwycp0YR1s2fscHhkjtlfm8Frjhq
 BcDw==
X-Gm-Message-State: ANhLgQ3XXEGG+zgpDfn0Mone5yRq85CzNDj4ApaY1Msaesf0KkABSpS7
 xoS6trX4jxu12FISRlEP21vPcQ==
X-Google-Smtp-Source: ADFU+vvumVznBXG0A6Iq3xCvezlrI9LHYhCJTZJg7hVXuURUfk1WF2tONVQteVKlbjpHyfZ+mfUmNQ==
X-Received: by 2002:a0c:ecc3:: with SMTP id o3mr4832950qvq.163.1584449277445; 
 Tue, 17 Mar 2020 05:47:57 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id m65sm1863433qke.109.2020.03.17.05.47.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 17 Mar 2020 05:47:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jEBdT-0001XI-Q8; Tue, 17 Mar 2020 09:47:55 -0300
Date: Tue, 17 Mar 2020 09:47:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/4] mm: simplify device private page handling in
 hmm_range_fault
Message-ID: <20200317124755.GR20941@ziepe.ca>
References: <20200316193216.920734-1-hch@lst.de>
 <20200316193216.920734-4-hch@lst.de>
 <7256f88d-809e-4aba-3c46-a223bd8cc521@nvidia.com>
 <20200317121536.GQ20941@ziepe.ca> <20200317122445.GA11662@lst.de>
 <20200317122813.GA11866@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200317122813.GA11866@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: Ralph Campbell <rcampbell@nvidia.com>, amd-gfx@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kvm-ppc@vger.kernel.org, Bharata B Rao <bharata@linux.ibm.com>,
 linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>, Dan Williams <dan.j.williams@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 17, 2020 at 01:28:13PM +0100, Christoph Hellwig wrote:
> On Tue, Mar 17, 2020 at 01:24:45PM +0100, Christoph Hellwig wrote:
> > On Tue, Mar 17, 2020 at 09:15:36AM -0300, Jason Gunthorpe wrote:
> > > > Getting rid of HMM_PFN_DEVICE_PRIVATE seems reasonable to me since a driver can
> > > > look at the struct page but what if a driver needs to fault in a page from
> > > > another device's private memory? Should it call handle_mm_fault()?
> > > 
> > > Isn't that what this series basically does?
> > >
> > > The dev_private_owner is set to the type of pgmap the device knows how
> > > to handle, and everything else is automatically faulted for the
> > > device.
> > > 
> > > If the device does not know how to handle device_private then it sets
> > > dev_private_owner to NULL and it never gets device_private pfns.
> > > 
> > > Since the device_private pfn cannot be dma mapped, drivers must have
> > > explicit support for them.
> > 
> > No, with this series (and all actual callers before this series)
> > we never fault in device private pages.
> 
> IFF we want to fault it in we'd need something like this.  But I'd
> really prefer to see test cases for that first.

In general I think hmm_range_fault should have a mode that is the same
as get_user_pages in terms of when it returns a hard failure, and
generates faults. AFAIK, GUP will fault in this case?

I need this for making ODP use this API. ODP is the one that is highly
likely to see other driver's device_private pages and must have them
always fault to CPU.

> diff --git a/mm/hmm.c b/mm/hmm.c
> index b75b3750e03d..2884a3d11a1f 100644
> +++ b/mm/hmm.c
> @@ -276,7 +276,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
>  		if (!fault && !write_fault)
>  			return 0;
>  
> -		if (!non_swap_entry(entry))
> +		if (!non_swap_entry(entry) || is_device_private_entry(entry))
>  			goto fault;

Yes, OK,  makes sense.

I've been using v7 of Ralph's tester and it is working well - it has
DEVICE_PRIVATE support so I think it can test this flow too. Ralph are
you able?

This hunk seems trivial enough to me, can we include it now?

Thanks,
Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
