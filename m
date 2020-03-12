Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3E9C1975A
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 14:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5048820663
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 14:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="e/OtmdQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5048820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0548C6EAD4;
	Thu, 12 Mar 2020 14:37:02 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96B3F6EADE
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 14:35:23 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id f28so6470342qkk.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Tqmo4Ss6J1xwONYAXrPu9XD0oNKXjQdv9HqBeUdgnS4=;
 b=e/OtmdQOKUz3UT7x9D0c5pN1gX2+j3NRWnOIewgqqlHYYa4xrbLRa2rejJCyBjoLGd
 CtXzD+0tDlBT3FepW68JtBZW2VtUEGYpOA+hPOZcelXPvaI6IWWLIAbeK7fTaC4pvkbG
 v9VSdOuSxUyaV0AAWFUkLE1GP6kVva/fdivF/eegDmgCAd70yCoX0vixMCHg7mQYiK7I
 1x+80UnL3LG9s/Ij8yJqIu1+oWsHmzsnBZJjfocsaXZSAXlMx4Br9SGykYliXgQPmrhE
 wIf+XwI3yGiXWFLNH9kAphb+yaXJD0wSxvrO1frleWQM1j9fKg0mIbR4BAlbe55Fhxe0
 tLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Tqmo4Ss6J1xwONYAXrPu9XD0oNKXjQdv9HqBeUdgnS4=;
 b=DA6s36y/Wp69XkFT6q6dz2KzS0WpugimOP9Le7ezFo57aECUnZvcIacv2G/UDom6Fy
 AWkP83ztMPPUROjsJEGyQ5FvjiCmjwHHyby94NWcZYbx/Kx3GF1/RT/h36w54uVUQNC6
 EWFgd7PvtrhTl3sOfbu3eU4lq1Tw7MKPCQ0o+7M2tskZIXsLBGhfH3mLRn5eayw4b4//
 28t/zMmiAoCZX5TI3cZgvOeSERkAvTmMvlnYUI7Ij39dAs8pbXfhOoJ07rv6SVqv8q4J
 9rhFyimJxahKybNM7K/LlpEAaWgtKjPseF9SWvh14U8ouhcI6DGkbWPzFPfBYqCHRSoA
 xKaw==
X-Gm-Message-State: ANhLgQ0ouKdyOzD/AxBrfF7Pw9MgMUIkhGxPGVKOyQsm0zndBUpOYHeb
 l8lIBk9jA9NPFznsBl3HMnFLew==
X-Google-Smtp-Source: ADFU+vvYf2U2kHAIQUg76/wWMu87VRsHRi/YQXlzdDhQg3wFhjTOM0AZzwj/e/xzDoVeSpoHdhRj4A==
X-Received: by 2002:a05:620a:a0d:: with SMTP id
 i13mr8096034qka.333.1584023722704; 
 Thu, 12 Mar 2020 07:35:22 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id q8sm8335388qkm.73.2020.03.12.07.35.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 12 Mar 2020 07:35:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jCOvh-0006e4-Mp; Thu, 12 Mar 2020 11:35:21 -0300
Date: Thu, 12 Mar 2020 11:35:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH hmm 7/8] mm/hmm: return -EFAULT when setting
 HMM_PFN_ERROR on requested valid pages
Message-ID: <20200312143521.GN31668@ziepe.ca>
References: <20200311183506.3997-1-jgg@ziepe.ca>
 <20200311183506.3997-8-jgg@ziepe.ca>
 <910ae485-5400-3795-4353-ce4d47e3ae52@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <910ae485-5400-3795-4353-ce4d47e3ae52@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Thu, 12 Mar 2020 14:37:00 +0000
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
 Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org, linux-mm@kvack.org,
 Jerome Glisse <jglisse@redhat.com>, dri-devel@lists.freedesktop.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 11, 2020 at 06:36:47PM -0700, Ralph Campbell wrote:
> > @@ -390,8 +384,15 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
> >   			return -EBUSY;
> >   		}
> >   		return hmm_pfns_fill(start, end, range, HMM_PFN_NONE);
> > -	} else if (!pmd_present(pmd))
> > +	}
> > +
> > +	if (!pmd_present(pmd)) {
> > +		hmm_range_need_fault(hmm_vma_walk, pfns, npages, 0, &fault,
> > +				     &write_fault);
> > +		if (fault || write_fault)
> > +			return -EFAULT;
> >   		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
> 
> Shouldn't this fill with HMM_PFN_NONE instead of HMM_PFN_ERROR?
> Otherwise, when a THP is swapped out, you will get a different
> value than if a PTE is swapped out and you are prefetching/snapshotting.

If this is the case then the problem is that the return -EFAULT path
needs to do something else.. ie since the above code can't trigger
swap in, it is correct to return PFN_ERROR.

I'm completely guessing, but do we need to call pmd_to_swp_entry() and
handle things similarly to the pte? What swp_entries are valid for a
pmd?

Do you understand this better, or know how to trigger a !pmd_present
for test?

I suppose another option would be this:

	if (!pmd_present(pmd)) {
		hmm_range_need_fault(hmm_vma_walk, pfns, npages, 0, &fault,
				     &write_fault);
                /* We can't handle this. Cause the PMD to be split and
		 * handle it in the pte handler. */
		if (fault || write_fault)
 		        return 0;
  		return hmm_pfns_fill(start, end, range, HMM_PFN_NONE);
        }

Which, I think, must be correct, but inefficient?

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
