Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DA1C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 17:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C67510E151;
	Thu,  9 Dec 2021 17:04:06 +0000 (UTC)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF9F489F73
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 06:52:39 +0000 (UTC)
Received: by mail-qt1-x831.google.com with SMTP id t11so4479698qtw.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Dec 2021 22:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9lZzV6uRxUvt0RqeIyM4DCy//4WwHZcCj15yKoRWKv0=;
 b=MuH7fGvI/9AD+8Jf3135+Y84ksGN91yCSTt0zoUDEqseX7B2K0YN6lCaPdgDeOMRpm
 GOe7MfuQdBr+Z4wyPuK/X3Oq+E11gqhW44bDipD/o7JNOnqwTqyXLLafarAjz6Qto1ro
 aG+jBeBbWAiByCuS0S6B9hU+pATvx85RKkpkIAQIfLRbW2qUaPcS9Uu6YIpp8W008vUj
 AvLKcneW2BuqADAMC9NC6N/Val8HXTIHMS7sQv01juWNQbBHSKaBSpUv61IEYCjx2r7c
 hWVEXyKPTi4aa/SWCsc4zb+EUhNMyK5Z6Ko/CgGa+RO3zAgIsW2+q5scXiLYdGdjXPHA
 IZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9lZzV6uRxUvt0RqeIyM4DCy//4WwHZcCj15yKoRWKv0=;
 b=p42R+yudgMiS9vNaOuiBsoCEixbwBqgCJHwonagTP64tKC//UhxREeVQOzclIZJmjj
 Ct8LHbGLYMHk8TgtmDskUnyBvq2EvN7ZUAsAWRXL7eO+ax0UUD+YsZ/9yKLWnrKei2af
 S5Ko2xvSVw2fhbb32qUfUsqcYCBYoSeayppE9m+N/DjtB9FPgwHLwQ0wOqdUdak/eOrb
 S0ckUTW8kluOHNjFWwTDv8tYqyLv6ts3fpZhK2AK0p+LZUNER7qGEs8J/nTsKugrK03D
 /S8fhW81OPrpxYRFgLwXyMmZeFdoAxlZBRsWmHoWjDuUd0GkNwWN43Ux1bqeEUDUgbFT
 avzw==
X-Gm-Message-State: AOAM530H0beO1MMZs1/hFfHHUzmqJqyJtfHdNyAI19IMQe87Jh+gXHhP
 aHTdm6mob1ZKU6p0L+X7iwJ79dfUCzgyCQ==
X-Google-Smtp-Source: ABdhPJzd7PgIaK+OliA8j4qPmgBHphO7odQ23RlPROnXGhIchmoXCBqWvKGTqHwv0CnaCCZT+fN4FA==
X-Received: by 2002:a05:622a:8d:: with SMTP id
 o13mr13208686qtw.574.1639018404025; 
 Wed, 08 Dec 2021 18:53:24 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id m1sm2800768qtk.34.2021.12.08.18.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Dec 2021 18:53:23 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mv9Yg-000zXC-FC; Wed, 08 Dec 2021 22:53:22 -0400
Date: Wed, 8 Dec 2021 22:53:22 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH v2 03/11] mm/gup: migrate PIN_LONGTERM dev coherent pages
 to system
Message-ID: <20211209025322.GE6467@ziepe.ca>
References: <20211206185251.20646-1-alex.sierra@amd.com>
 <2858338.J0npWUQLIM@nvdebian> <20211208135345.GC6467@ziepe.ca>
 <117075453.Ddeq1f3ylz@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <117075453.Ddeq1f3ylz@nvdebian>
X-Mailman-Approved-At: Thu, 09 Dec 2021 17:04:03 +0000
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
Cc: Alex Sierra <alex.sierra@amd.com>, rcampbell@nvidia.com,
 willy@infradead.org, Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com,
 dri-devel@lists.freedesktop.org, akpm@linux-foundation.org,
 linux-ext4@vger.kernel.org, hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 09, 2021 at 12:45:24PM +1100, Alistair Popple wrote:
> On Thursday, 9 December 2021 12:53:45 AM AEDT Jason Gunthorpe wrote:
> > > I think a similar problem exists for device private fault handling as well and
> > > it has been on my list of things to fix for a while. I think the solution is to
> > > call try_get_page(), except it doesn't work with device pages due to the whole
> > > refcount thing. That issue is blocking a fair bit of work now so I've started
> > > looking into it.
> > 
> > Where is this?
>  
> Nothing posted yet. I've been going through the mailing list and the old
> thread[1] to get an understanding of what is left to do. If you have any
> suggestions they would be welcome.

Oh, that

Joao's series here is the first step:

https://lore.kernel.org/linux-mm/20211202204422.26777-1-joao.m.martins@oracle.com/

I already sent a patch to remove the DRM usage of PUD/PMD -
0d979509539e ("drm/ttm: remove ttm_bo_vm_insert_huge()")

Next, someone needs to change FSDAX to have a folio covering the
ZONE_DEVICE pages before it installs a PUD or PMD. I don't know
anything about FS's to know how to do this at all.

Thus all PUD/PMD entries will point at a head page or larger of a
compound. This is important because all the existing machinery for THP
assumes 1 PUD/PMD means 1 struct page to manipulate.

Then, consolidate all the duplicated code that runs when a page is
removed from a PTE/PMD/PUD etc into a function. Figure out why the
duplications are different to make them the same (I have some rough
patches for this step)

Start with PUD and have zap on PUD call the consolidated function and
make vmf_insert_pfn_pud_prot() accept a struct page not pfn and incr
the refcount. PUD is easy because there is no THP

Then do the same to PMD without breaking the THP code

Then make the PTE also incr the refcount on insert and zap

Exterminate vma_is_special_huge() along the way, there is no such
thing as a special huge VMA without a pud/pmd_special flag so all
things installed here must be struct page and not special.

Then the patches that are already posted are applicable and we can
kill the refcount == 1 stuff. No 0 ref count pages installed in page
tables.

Once all of that is done it is fairly straightforward to remove
pud/pmd/pte_devmap entirely and the pgmap stuff from gup.c

Jason
