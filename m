Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1155FC2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 20:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D754D206E9
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 20:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IaI1o/nb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D754D206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 963686EC58;
	Fri, 13 Mar 2020 20:05:22 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E52C06EC58
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 19:55:52 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id z25so9829633qkj.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 12:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=87KqPlDMHgw97GV/6GeuCjBWLsGckmaqH6kpwHETsV8=;
 b=IaI1o/nbI8tdis4U2kskwqLiVp3tR4CtvbFz8sA47teWHxd/T5+6rm/6ewRIdNlMNG
 0qFcrsbYYRy46EZiPu9dOqWn8g1MSPdUt//XwpJkDstfCSFBcR9s8GzeyhpVhLMYMyqH
 e4J1IH2AgHUzFxDhv7qBaZ4eRP7VcZETgHSXyB/aFNpU28/xvYi6117lRd4gGfXTSfYo
 s5QHfQoIftvXr7dFPX5eXiIDE8mmykF2AKp9287JbXYoL88FgrIID9xBRWJWL181yTTJ
 iqrEkJUsIYkdTXlCVOM5TzemwgbQPUTBbIrd2sufHfgiJFUvSVxFfZTE2Tjfhkqr3HOs
 RR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=87KqPlDMHgw97GV/6GeuCjBWLsGckmaqH6kpwHETsV8=;
 b=jiYDaHxFGqUG505j7eN6ovYF+KxS4D/2+MOwNmP+n61KV67ENhw1S/1ZM+skiYfCwV
 MlfkY7qEvyW32hZ7JIzD9YWi1vgIJynH1tfIhWvwynF6zYE9r72whycxKICSP7DplBMZ
 BUqVKdD3TKAdVOkbE5QJ1dpSaWL0S0Ib1+Fxi2sspWAsdO/g+nndae6fGvOuyHyTrpOT
 jeS33GmZyHSOeuNr+pFjft6ibE46+PiacKG1/BnIfwX0E3/5+t32Tl1MHk8qd7wPWpmJ
 VHnpmT836XZRlBJ03X5SADtiTN2bFEbgmJcgvVYkqVvmMokM6yNLswnLPRffNmwfluO5
 WI9A==
X-Gm-Message-State: ANhLgQ0MRdaicbaNgh4hH+Kf1AqPcrcT8q3QsYEmk9/A//y15MuGKmUL
 g7OGO87SbcF7bQvWe3NwfMzRmQ==
X-Google-Smtp-Source: ADFU+vszdQfTs7KFiVac4pruumYRzYTRQbmBVhPe56+YVviAN87wfdAZizQ3CSLbD8AmBkwABUoNLA==
X-Received: by 2002:a37:591:: with SMTP id 139mr12437176qkf.281.1584129351908; 
 Fri, 13 Mar 2020 12:55:51 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id m92sm4067512qtd.94.2020.03.13.12.55.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 13 Mar 2020 12:55:51 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jCqPO-0004gC-St; Fri, 13 Mar 2020 16:55:50 -0300
Date: Fri, 13 Mar 2020 16:55:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Steven Price <steven.price@arm.com>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm/hmm: Simplify hmm_vma_walk_pud slightly
Message-ID: <20200313195550.GH31668@ziepe.ca>
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
X-Mailman-Approved-At: Fri, 13 Mar 2020 20:05:21 +0000
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
> On 12/03/2020 16:37, Jason Gunthorpe wrote:
> > On Thu, Mar 12, 2020 at 04:16:33PM +0000, Steven Price wrote:
> > > > Actually, while you are looking at this, do you think we should be
> > > > adding at least READ_ONCE in the pagewalk.c walk_* functions? The
> > > > multiple references of pmd, pud, etc without locking seems sketchy to
> > > > me.
> > > 
> > > I agree it seems worrying. I'm not entirely sure whether the holding of
> > > mmap_sem is sufficient,
> > 
> > I looked at this question, and at least for PMD, mmap_sem is not
> > sufficient. I didn't easilly figure it out for the other ones
> > 
> > I'm guessing if PMD is not safe then none of them are.
> > 
> > > this isn't something that I changed so I've just
> > > been hoping that it's sufficient since it seems to have been working
> > > (whether that's by chance because the compiler didn't generate multiple
> > > reads I've no idea). For walking the kernel's page tables the lack of
> > > READ_ONCE is also not great, but at least for PTDUMP we don't care too much
> > > about accuracy and it should be crash proof because there's no RCU grace
> > > period. And again the code I was replacing didn't have any special
> > > protection.
> > > 
> > > I can't see any harm in updating the code to include READ_ONCE and I'm happy
> > > to review a patch.
> > 
> > The reason I ask is because hmm's walkers often have this pattern
> > where they get the pointer and then de-ref it (again) then
> > immediately have to recheck the 'again' conditions of the walker
> > itself because the re-read may have given a different value.
> > 
> > Having the walker deref the pointer and pass the value it into the ops
> > for use rather than repeatedly de-refing an unlocked value seems like
> > a much safer design to me.
> 
> Yeah that sounds like a good idea.

I'm looking at this now.. The PUD is also changing under the read
mmap_sem - and I was able to think up some race conditiony bugs
related to this. Have some patches now..

However, I haven't been able to understand why walk_page_range()
doesn't check pud_present() or pmd_present() before calling
pmd_offset_map() or pte_offset_map().

As far as I can see a non-present entry has a swap entry encoded in
it, and thus it seems like it is a bad idea to pass a non-present
entry to the two map functions. I think those should only be called
when the entry points to the next level in the page table  (so there
is something to map?)

I see you added !present tests for the !vma case, but why only there?

Is this a bug? Do you know how it works?

Is it something that was missed when people added non-present PUD and
PMD's?

Thanks,
Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
