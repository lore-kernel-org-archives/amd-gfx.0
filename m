Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A30EC4332E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 14:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B2ED20739
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 14:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IRiBcy01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2ED20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13D206E0A1;
	Fri, 20 Mar 2020 14:46:36 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 892CE6EB3E
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 13:41:11 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id v15so4903181qto.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=rSXMnA8Bh+EyZeJfpwZeazUxxET567SafNKmRBbaqJE=;
 b=IRiBcy01pez/c8Esw6ABdeGlubYq6UBTvnqE08m54TPmYJSk0iZY8NRy4Imfi9RCkq
 pgYtuxDrHqPgjM1o0KyPLUcQQOMmsp/8AwWKrGmPWY2V2zTpecXI1Hmww1TRzifRUqv1
 DX4dzAVbSR13Fo7jjIz8YUYee5enxM6pJW/X6pJz59lxOjUg+6nvHnnEaT8pcTz55OMt
 jRul4tANsV8+/6/1gFaPw67m4l9Hc++lvsRpUhKs8JRwfn579xSKiU2xI9uEr0dnW7Fr
 mnPY+dq6nTjmuQ5ZDgFDKjScE6rkcwbkGcsH6sXXBgbbcYl+h27ZHv6LeQTB09f7WjYe
 iTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rSXMnA8Bh+EyZeJfpwZeazUxxET567SafNKmRBbaqJE=;
 b=WfMvS17xRdSb/3Mt3U8Clclo1MzfAMtLUoo1pRoAOREIW88uvfDIt4sIyrOveE9r+3
 ZzbY+U6xyKWMpihPNnM6Z5in1IARO9oWnp0PIigD7scdFHY7HXulsZgURFjaZ5/OapOI
 bj1c/L2l0P2CFXN3oXmBiIokA6ligN5vBMuq/pxoEVa086G2BsRlech+fjxzXXl/OjOg
 IYMPsNQe0+W+Ed4MTblqnWc15EE8jghWm3TBBt3ndBcqGZJC0/d6Fpbpc16I8PhjqBHl
 vBBmjdqcUGfIdRhsY5bC0H5rc1OwQ9vkF3QeV543vCUBT5dvF71MiwgF7cG9MhlZc8aJ
 aaJw==
X-Gm-Message-State: ANhLgQ2Z1HSHEcD8h9xDw0KWoMJO44cxrrAMx/lH9nlAcH8jUNYUiQry
 zNpD0WzbIMEdfmROoAfLB8IzgQ==
X-Google-Smtp-Source: ADFU+vuEJLxLBoH+558rgkm+/X3kgiU5w6V/n0Oh7c+Ro7Jb1c7KonYggFNpdI58VU/1xg85hzcxdQ==
X-Received: by 2002:ac8:4782:: with SMTP id k2mr8138084qtq.1.1584711670687;
 Fri, 20 Mar 2020 06:41:10 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id p23sm4024398qkm.39.2020.03.20.06.41.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 20 Mar 2020 06:41:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jFHtd-0007xE-Gf; Fri, 20 Mar 2020 10:41:09 -0300
Date: Fri, 20 Mar 2020 10:41:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/4] mm: check the device private page owner in
 hmm_range_fault
Message-ID: <20200320134109.GA30230@ziepe.ca>
References: <20200316193216.920734-1-hch@lst.de>
 <20200316193216.920734-5-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200316193216.920734-5-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Fri, 20 Mar 2020 14:46:33 +0000
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
 Bharata B Rao <bharata@linux.ibm.com>, linux-mm@kvack.org,
 Jerome Glisse <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 16, 2020 at 08:32:16PM +0100, Christoph Hellwig wrote:
> diff --git a/mm/hmm.c b/mm/hmm.c
> index cfad65f6a67b..b75b3750e03d 100644
> +++ b/mm/hmm.c
> @@ -216,6 +216,14 @@ int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
>  		unsigned long end, uint64_t *pfns, pmd_t pmd);
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> +static inline bool hmm_is_device_private_entry(struct hmm_range *range,
> +		swp_entry_t entry)
> +{
> +	return is_device_private_entry(entry) &&
> +		device_private_entry_to_page(entry)->pgmap->owner ==
> +		range->dev_private_owner;
> +}

Thinking about this some more, does the locking work out here?

hmm_range_fault() runs with mmap_sem in read, and does not lock any of
the page table levels.

So it relies on accessing stale pte data being safe, and here we
introduce for the first time a page pointer dereference and a pgmap
dereference without any locking/refcounting.

The get_dev_pagemap() worked on the PFN and obtained a refcount, so it
created safety.

Is there some tricky reason this is safe, eg a DEVICE_PRIVATE page
cannot be removed from the vma without holding mmap_sem in write or
something?

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
