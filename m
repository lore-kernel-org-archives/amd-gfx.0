Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140F2C0044D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 20:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF2F8206C0
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 20:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RmOqUe+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2F8206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51FD76E4CA;
	Mon, 16 Mar 2020 20:03:48 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78C7D6E4C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 19:59:25 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id t13so15351029qtn.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 12:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=EAEH/7t5ubtIMhw4ZTeVgjQSlcx5QOWTPoLF4PtWhvw=;
 b=RmOqUe+R4l5H6YpqEib1W4LfA1h1/OZym/f9ehFr0qPoTlxgBeLu6AJhJEmNnQN1Dj
 VE0p9XlPU1CSB+PhFNJXeVAL1LDo4nVZlApvnbIOxbw+r/nV9Gg6fFNKzOdwP2Rv+Tcn
 jO4CyQOKGxDjCENXESz3JqP8SloGlWtsxFs4A+S9T2ZlNyxyjePg81CckrADJ18xntlN
 aHclWcT2nw64C3P/y74znOjO+t0uMLoSAJuwol49hiClFZErw7yVlf364WCNiDmO2nJm
 W+hBIi0t5YKyy6lPGMloSf+ZExCMZJ+fh4fYcxzQVhaJT+DK5PvzuCPkceNPvN3cAj8p
 AGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=EAEH/7t5ubtIMhw4ZTeVgjQSlcx5QOWTPoLF4PtWhvw=;
 b=uD6a4PJalhsSKe8ac5nJwUSUk9eZwryXnXWbzkeQ/iaNK+4NI1MhQEdnDd4t6CF7zP
 7Zu8h3/y+qGNpR+dHD4FKSp33UWeHPGRcpS5K5ZqRSH5bBka/uU2H6hfpJPX+HVoeUTL
 J2jl5sB6kRhK5Uhl7Q7VLLMMoxmuXV2E6E7y8LhKsLRi6Y9ySrXIZU09VF9Ir9tkpEvk
 D4AigHIUJbUFem/SBVdnZEEbdTpg6ubJzid/b1EdxmEk5Nbrgx6d4m98w/HNYGAxC0iC
 C8dLzkOUP+TS7OT4gs+U2kb8ReZH4Q2GaB7FoR1f3s0SG0+8+/gz70wVHIswNKrY//jy
 vrkw==
X-Gm-Message-State: ANhLgQ2F0f3E7J8jErOJ2WTcb0B3jLBnawkB8wVpCrpULjMHeUTvHdJj
 aIpKRI3oMmnPzhmpnV4mrHU2BA==
X-Google-Smtp-Source: ADFU+vtbRUKVYcUI2Gq+ZWCB4v8nheFcrqCqLhbHdThlbs4ZekZNUobGzi4WVSGLSw/oM8Fkr1QlJA==
X-Received: by 2002:ac8:7396:: with SMTP id t22mr1961185qtp.182.1584388764690; 
 Mon, 16 Mar 2020 12:59:24 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id x22sm488565qki.54.2020.03.16.12.59.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 16 Mar 2020 12:59:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jDvtT-00078y-K3; Mon, 16 Mar 2020 16:59:23 -0300
Date: Mon, 16 Mar 2020 16:59:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/4] mm: simplify device private page handling in
 hmm_range_fault
Message-ID: <20200316195923.GA26988@ziepe.ca>
References: <20200316193216.920734-1-hch@lst.de>
 <20200316193216.920734-4-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200316193216.920734-4-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Mon, 16 Mar 2020 20:03:47 +0000
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

On Mon, Mar 16, 2020 at 08:32:15PM +0100, Christoph Hellwig wrote:
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 180e398170b0..cfad65f6a67b 100644
> +++ b/mm/hmm.c
> @@ -118,15 +118,6 @@ static inline void hmm_pte_need_fault(const struct hmm_vma_walk *hmm_vma_walk,
>  	/* We aren't ask to do anything ... */
>  	if (!(pfns & range->flags[HMM_PFN_VALID]))
>  		return;
> -	/* If this is device memory then only fault if explicitly requested */
> -	if ((cpu_flags & range->flags[HMM_PFN_DEVICE_PRIVATE])) {
> -		/* Do we fault on device memory ? */
> -		if (pfns & range->flags[HMM_PFN_DEVICE_PRIVATE]) {
> -			*write_fault = pfns & range->flags[HMM_PFN_WRITE];
> -			*fault = true;
> -		}
> -		return;
> -	}

Yes, this is an elegant solution to the input flags.

However, between patch 3 and 4 doesn't this break amd gpu as it will
return device_private pages now if not requested? Squash the two?

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
