Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2FCC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 15:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F55220775
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 15:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VYd9ml7v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F55220775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F24FE6E3E7;
	Tue, 24 Mar 2020 15:48:22 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 658116E3E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 15:47:11 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id o10so13931369qki.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 08:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=chg4nJX1BOvdGdGINxOdA9wwXdMZK9Qvm7BfIQKXrzg=;
 b=VYd9ml7v8QtZcpe4vcg3np5ER9erstBwnj20p3vty5hai3xyAkIVlpWZ46/fcVgc2F
 qtBzRlGUmV9+6yb3IBPr41+d3nO8GyGSvYtD1RGgQmJih/p5Z+0jPcPokW/HmsC9n/zI
 gnl1GBossTqOAZgiYGailtXebNocAA91+pAcDto9nEWmaf78Disd7+5hFEYKBu4Z8JyY
 qexj/Qq5jQ9iu8TRUhW0lwOu0bd/qQ9Ki8ASxtDw0GrmUiHNmvN2/N1JM/CNWxbEnwpE
 NY5W/MGME3JjfZl6KKn3zlTv96810YuY3PcDAGAT56jdWJRhkmmubBFTP+p/A4eoWzF9
 Buww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=chg4nJX1BOvdGdGINxOdA9wwXdMZK9Qvm7BfIQKXrzg=;
 b=iHxVwB83EGqTLL1MrEbKJC/kgq9Zk3E4mLvPeXcagLE7u1QUDOglQTXdg4bTttk1GN
 N9RxA9PprlUnmOiOtaFQkbhWE84xx0p2ASsdTPgJeJvWbUYsPwgdC9NVS1eAJdfiSr6N
 apvM/CM1mHMayJOHZcpdwjiBfPzeqdn7PMhiCVlM7lgL0FO9xatCGtc4j5ZAANNpK+fs
 76dlcdI0+3ZRIZuxJIn9Zik9tKzQmzW8pTPwEntsBdEqY9Gn1IiA6aeyVTMc5mKmMW9B
 hJDdVEAKV32Q8XM5GCPZs6ysYuftBPLY1gBNkcSAT0NiVRXUz1tvSaBRSJi7qL4zyX6q
 vj/A==
X-Gm-Message-State: ANhLgQ0OGtFyDami+LQmkcvYcwLRNWwKIy5a5wOAZ+a+9YhHta2vhskJ
 tlbUuwu3BmZjtc0vJif/lnN7AA==
X-Google-Smtp-Source: ADFU+vvUCi/JamBQy96zk6SSaTAFVfy03+IqbYwWkBYKcL6gmBSW32CQssk38STbHoXzwOAYDIKcxQ==
X-Received: by 2002:a37:8641:: with SMTP id i62mr26083263qkd.290.1585064830536; 
 Tue, 24 Mar 2020 08:47:10 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id t6sm5001434qkd.60.2020.03.24.08.47.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 24 Mar 2020 08:47:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jGllk-0004Yc-Jf; Tue, 24 Mar 2020 12:47:08 -0300
Date: Tue, 24 Mar 2020 12:47:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 hmm 7/9] mm/hmm: do not unconditionally set pfns when
 returning EBUSY
Message-ID: <20200324154708.GA14119@ziepe.ca>
References: <20200324011457.2817-1-jgg@ziepe.ca>
 <20200324011457.2817-8-jgg@ziepe.ca>
 <20200324073746.GF23447@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200324073746.GF23447@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Tue, 24 Mar 2020 15:48:22 +0000
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
 John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 Jerome Glisse <jglisse@redhat.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 24, 2020 at 08:37:46AM +0100, Christoph Hellwig wrote:
> On Mon, Mar 23, 2020 at 10:14:55PM -0300, Jason Gunthorpe wrote:
> >  	if (pte_none(pte)) {
> >  		required_fault = hmm_pte_need_fault(hmm_vma_walk, orig_pfn, 0);
> >  		if (required_fault)
> >  			goto fault;
> > +		*pfn = range->values[HMM_PFN_NONE];
> >  		return 0;
> >  	}
> >  
> > @@ -274,8 +274,10 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
> >  		}
> >  
> >  		required_fault = hmm_pte_need_fault(hmm_vma_walk, orig_pfn, 0);
> > -		if (!required_fault)
> > +		if (!required_fault) {
> > +			*pfn = range->values[HMM_PFN_NONE];
> >  			return 0;
> > +		}
> 
> Maybe throw in a goto hole to consolidaste the set PFN and return
> 0 cases?

Then we have goto fault and goto none both ending in returns. I
generally prefer the goto labels to have a single return

The pte_unmap() before faulting makes this routine twisty and I
haven't thought of a good way to untwist it

Thanks,
Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
